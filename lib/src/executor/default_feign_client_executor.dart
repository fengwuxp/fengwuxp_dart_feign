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
import 'package:fengwuxp_dart_openfeign/src/http/client/client_exception.dart';
import 'package:fengwuxp_dart_openfeign/src/http/response_entity.dart';
import 'package:fengwuxp_dart_openfeign/src/interceptor/mapped_feign_client_executor_interceptor.dart';
import 'package:fengwuxp_dart_openfeign/src/utils/metadata_utils.dart';
import 'package:reflectable/reflectable.dart';

import '../feign_request_options.dart';
import 'feign_client_executor.dart';
import 'feign_client_executor_interceptor.dart';

class DefaultFeignClientExecutor implements FeignClientExecutor {
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
    final feignConfiguration = this.feignConfiguration;

    //获取声明列表
    final classMirror = this.classMirror;
    final Map<String, DeclarationMirror> map = classMirror.declarations;
    final MethodMirror methodMirror = map[methodName];
    final classMetadata = methodMirror.metadata;
    final requestMapping = findRequestMapping(classMetadata) as RequestMapping;
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

    /// 处理签名
    final apiSignatureStrategy = feignConfiguration.apiSignatureStrategy;
    if (apiSignatureStrategy != null) {
      final signature = findMetadata(classMetadata, Signature) as Signature;
      // handle api signature
      apiSignatureStrategy.sign(signature.fields, feignRequest);
    }
    var responseExtractor = uiOptions.responseExtractor;
    if (responseExtractor == null) {
      // get response extractor
      var serializer = namedArguments[Symbol(FEIGN_SERIALIZER_PARAMETER_NAME)] as BuiltValueSerializable;
      responseExtractor = this
          ._responseExtractor(requestMapping.method, serializer.serializer, specifiedType: serializer.specifiedType);
    }

    ///  设置请求上下文ID
    final requestId = appendRequestContextId(feignRequest);
    setRequestContext(requestId, methodMirror);

    /// 执行拦截器
    feignRequest = await this._preHandle(feignRequest, uiOptions, requestUrl, requestMapping);

    /// 发起请求
    final restTemplate = feignConfiguration.restTemplate;
    var response;
    try {
      response = await restTemplate.execute(requestUrl, requestMapping.method, responseExtractor,
          request: feignRequest.body,
          queryParams: feignRequest.queryParams,
          pathVariables: feignRequest.pathVariables,
          timeout: uiOptions.timeout);
    } catch (exception) {
      var result = await this._postHandleError(feignRequest, uiOptions, requestUrl, requestMapping, exception);
      return Future.error(result);
    }
    return this._postHandle(feignRequest, uiOptions, requestUrl, requestMapping, response);
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
  Future<dynamic> _postHandle(
      FeignRequest request, UIOptions uiOptions, String url, RequestMapping requestMapping, response) async {
    return this._executeInterceptor<FeignBaseRequest, dynamic>(request, uiOptions, url, requestMapping, response,
        (FeignClientExecutorInterceptor<FeignBaseRequest> interceptor) {
      return interceptor.postHandle(request, uiOptions, response);
    });
  }

  /// 拦截器后置错误处理
  Future _postHandleError(FeignBaseRequest request, UIOptions uiOptions, String url, RequestMapping requestMapping,
      ClientException exception) async {
    return this
        ._executeInterceptor<FeignBaseRequest, ClientException>(request, uiOptions, url, requestMapping, exception, (
            [FeignClientExecutorInterceptor<FeignBaseRequest> interceptor]) {
      if (interceptor == null) {
        return Future.error(exception);
      }
      return interceptor.postError(request, uiOptions, exception);
    });
  }

  Future _executeInterceptor<T extends FeignBaseRequest, R>(FeignBaseRequest request, UIOptions uiOptions, String url,
      RequestMapping requestMapping, R defaultValue, ExecuteInterceptor<T> execute) async {
    final feignClientExecutorInterceptors = this.feignConfiguration.feignClientExecutorInterceptors;
    if (feignClientExecutorInterceptors == null) {
      return defaultValue;
    }
    var result = defaultValue, len = feignClientExecutorInterceptors.length, index = 0;
    while (index < len) {
      var feignClientExecutorInterceptor = feignClientExecutorInterceptors[index];
      var interceptor = this._getInterceptor(feignClientExecutorInterceptor, url, request.headers, requestMapping);
      if (interceptor != null) {
        result = await execute(interceptor);
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

  // build ResponseExtractor
  ResponseExtractor _responseExtractor<T>(String httpMethod, Serializer<T> serializer, {FullType specifiedType}) {
    if (specifiedType == null) {
      specifiedType = FullType(ResponseEntity);
    }
    if (httpMethod == HttpMethod.OPTIONS) {
      return OptionsForAllowResponseExtractor();
    }
    if (httpMethod == HttpMethod.HEAD) {
      return HeadResponseExtractor();
    }
    if (serializer == null) {
      return null;
    }
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
