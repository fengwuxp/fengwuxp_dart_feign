import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/feign_client.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/request_mapping.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/signature.dart';
import 'package:fengwuxp_dart_openfeign/src/client/response_extractor.dart';
import 'package:fengwuxp_dart_openfeign/src/client/rest_response_extractor.dart';
import 'package:fengwuxp_dart_openfeign/src/configuration/feign_configuration.dart';
import 'package:fengwuxp_dart_openfeign/src/constant/feign_constant_var.dart';
import 'package:fengwuxp_dart_openfeign/src/constant/http/http_method.dart';
import 'package:fengwuxp_dart_openfeign/src/context/request_context_holder.dart';
import 'package:fengwuxp_dart_openfeign/src/http/response_entity.dart';
import 'package:fengwuxp_dart_openfeign/src/interceptor/mapped_feign_client_executor_interceptor.dart';
import 'package:fengwuxp_dart_openfeign/src/utils/metadata_utils.dart';
import 'package:logging/logging.dart';
import 'package:reflectable/reflectable.dart';

import '../feign_request_options.dart';
import 'feign_client_executor.dart';
import 'feign_client_executor_interceptor.dart';

class DefaultFeignClientExecutor implements FeignClientExecutor {
  static const String _TAG = "DefaultFeignClientExecutor";
  static var _log = Logger(_TAG);

  /// proxy feign client type
  final Type targetType;

  //  proxy feign client type reflect mirror
  final ClassMirror classMirror;

  final FeignConfiguration feignConfiguration;

  FeignClient _feignClient;

  DefaultFeignClientExecutor(this.classMirror, this.targetType, this.feignConfiguration) {
    this._initFeignClient();
  }

  @override
  Future invoke(String methodName, List<Object> positionalArguments, [Map<Symbol, dynamic> namedArguments]) async {
    _log.finer("proxy invoke $methodName");

    final feignConfiguration = this.feignConfiguration;
    //获取声明列表
    final classMirror = this.classMirror;
    final Map<String, DeclarationMirror> declarations = classMirror.declarations;
    final MethodMirror methodMirror = declarations[methodName];
    final methodMetadata = methodMirror.metadata;
    final requestMapping = findRequestMapping(methodMetadata) as RequestMapping;
    final parameters = methodMirror.parameters;

    /// 解析参数
    final requestParamsResolver = feignConfiguration.requestParamsResolver;
    var uiOptions = namedArguments[FEIGN_OPTIONS_PARAMETER_NAME] as UIOptions;
    if (uiOptions == null) {
      uiOptions = UIOptions();
    }
    FeignRequest feignRequest =
        requestParamsResolver.resolve(positionalArguments, parameters, requestMapping.method, options: uiOptions);

    /// 解析url
    final requestURLResolver = feignConfiguration.requestURLResolver;
    final String requestUrl =
        requestURLResolver.resolve(this._feignClient, requestMapping, classMirror.simpleName, methodName);

    /// 解析请求头
    var requestHeaderResolver = feignConfiguration.requestHeaderResolver;
    requestHeaderResolver.resolve(requestMapping, feignRequest.headers, feignRequest.queryParams);
    var requestSupportRequestBody = supportRequestBody(requestMapping.method);
    if (requestSupportRequestBody == null) {
      requestHeaderResolver.resolve(requestMapping, feignRequest.headers, feignRequest.body);
    }

    /// TODO 解析cookie

    var responseExtractor = uiOptions.responseExtractor;
    var serializer = namedArguments[Symbol(FEIGN_SERIALIZER_PARAMETER_NAME)] as BuiltValueSerializable;
    if (responseExtractor == null) {
      // get response extractor
      responseExtractor = this
          ._responseExtractor(requestMapping.method, serializer?.serializer, specifiedType: serializer?.specifiedType);
    }

    ///  设置请求上下文ID
    final requestId = appendRequestContextId(feignRequest);
    setRequestContext(requestId, methodMirror);

    /// 处理签名
    final apiSignatureStrategy = feignConfiguration.apiSignatureStrategy;
    if (apiSignatureStrategy != null) {
      final signature = findSignature(methodMetadata) as Signature;
      // handle api signature
      apiSignatureStrategy.sign(signature?.fields, feignRequest);
    }

    /// 执行拦截器
    feignRequest = await this._preHandle(feignRequest, uiOptions, requestUrl, requestMapping);

    /// 发起请求
    final restTemplate = feignConfiguration.restTemplate;
    var response;
    try {
      _log.finer("send http request ==> $requestUrl");
      response = await restTemplate.execute(requestUrl, requestMapping.method, responseExtractor,
          request: feignRequest.body,
          queryParams: feignRequest.queryParams,
          pathVariables: feignRequest.pathVariables,
          headers: feignRequest.headers,
          timeout: uiOptions.timeout);
    } catch (error) {
      // 请求失败或异常
      var result = await this._postHandleError(feignRequest, uiOptions, requestUrl, requestMapping, error, serializer);
      return Future.error(result);
    }

    return this._postHandle(feignRequest, uiOptions, requestUrl, requestMapping, response, serializer);
  }

  /// 前置拦截器
  Future _preHandle(FeignRequest request, UIOptions uiOptions, String url, RequestMapping requestMapping) async {
    return this
        ._executeInterceptor<FeignBaseRequest, FeignBaseRequest>(request, uiOptions, url, requestMapping, request,
            (FeignClientExecutorInterceptor<FeignBaseRequest> interceptor) {
      return interceptor.preHandle(request, uiOptions);
    });
  }

  /// 拦截器后置处理
  Future<dynamic> _postHandle(FeignRequest request, UIOptions uiOptions, String url, RequestMapping requestMapping,
      response, BuiltValueSerializable serializer) async {
    return this._executeInterceptor<FeignBaseRequest, dynamic>(request, uiOptions, url, requestMapping, response,
        (FeignClientExecutorInterceptor<FeignBaseRequest> interceptor) {
      return interceptor.postHandle(request, uiOptions, response, serializer: serializer);
    });
  }

  /// 拦截器后置错误处理
  Future _postHandleError(FeignBaseRequest request, UIOptions uiOptions, String url, RequestMapping requestMapping,
      error, BuiltValueSerializable serializer) async {
    return this._executeInterceptor<FeignBaseRequest, Object>(request, uiOptions, url, requestMapping, error, (
        [FeignClientExecutorInterceptor<FeignBaseRequest> interceptor]) {
      if (interceptor == null) {
        return Future.error(error);
      }
      return interceptor.postError(request, uiOptions, error, serializer: serializer);
    }, true);
  }

  Future _executeInterceptor<T extends FeignBaseRequest, R>(FeignBaseRequest request, UIOptions uiOptions, String url,
      RequestMapping requestMapping, R defaultValue, ExecuteInterceptor<T> execute,
      [bool needTry = false]) async {
    final feignClientExecutorInterceptors = this.feignConfiguration.feignClientExecutorInterceptors;
    if (feignClientExecutorInterceptors == null) {
      return defaultValue;
    }
    var result = defaultValue, len = feignClientExecutorInterceptors.length, index = 0;
    while (index < len) {
      var feignClientExecutorInterceptor = feignClientExecutorInterceptors[index];
      var interceptor = this._getInterceptor(feignClientExecutorInterceptor, url, request.headers, requestMapping);
      if (interceptor != null) {
        if (needTry) {
          try {
            result = await execute(interceptor);
          } catch (e) {
            result = e;
          }
        } else {
          result = await execute(interceptor);
        }
      }
      index++;
    }
    return result;
  }

  FeignClientExecutorInterceptor _getInterceptor(FeignClientExecutorInterceptor feignClientExecutorInterceptor,
      String url, Map<String, String> headers, RequestMapping requestMapping) {
    if (feignClientExecutorInterceptor is MappedFeignClientExecutorInterceptor) {
      var isMatch =
          feignClientExecutorInterceptor.matches(url: url, httpMethod: requestMapping.method, headers: headers);
      if (!isMatch) {
        return null;
      }
      return feignClientExecutorInterceptor;
    }
    return feignClientExecutorInterceptor;
  }

  // build [ResponseExtractor]
  ResponseExtractor _responseExtractor<T>(String httpMethod, Serializer<T> serializer, {FullType specifiedType}) {
    if (httpMethod == HttpMethod.OPTIONS) {
      return OptionsForAllowResponseExtractor();
    }
    if (httpMethod == HttpMethod.HEAD) {
      return HeadResponseExtractor();
    }
//    if (serializer == null) {
//      return null;
//    }
    if (specifiedType != null && specifiedType.root == ResponseEntity) {
      return ResponseEntityResponseExtractor(feignConfiguration.messageConverters, serializer);
    } else {
      return HttpMessageConverterExtractor(feignConfiguration.messageConverters,
          responseType: serializer, specifiedType: specifiedType);
    }
  }

  /// 初始化
  void _initFeignClient() {
    var feignClientMeta = findMetadata(this.classMirror.metadata, FeignClient);
    this._feignClient = feignClientMeta;
  }
}
