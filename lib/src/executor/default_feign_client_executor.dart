import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';
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
import 'package:fengwuxp_dart_openfeign/src/util/metadata_utils.dart';
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

  DefaultFeignClientExecutor(this.classMirror, this.targetType, this.feignConfiguration)
      : this._feignClient = findMetadata(classMirror.metadata, FeignClient);

  @override
  Future invoke(String methodName, List<dynamic> positionalArguments,
      [Map<Symbol, dynamic> namedArguments = const {}]) async {
    if (_log.isLoggable(Level.FINER)) {
      _log.finer("proxy invoke $methodName");
    }

    final feignConfiguration = this.feignConfiguration;
    // 获取声明列表
    final classMirror = this.classMirror;
    final Map<String, DeclarationMirror> declarations = classMirror.declarations;
    final MethodMirror methodMirror = declarations[methodName] as MethodMirror;
    final methodMetadata = methodMirror.metadata;
    final requestMapping = findRequestMapping(methodMetadata) as RequestMapping;
    final parameters = methodMirror.parameters;

    /// 解析参数
    final requestParamsResolver = feignConfiguration.requestParamsResolver;
    var uiOptions = namedArguments[Symbol(FEIGN_OPTIONS_PARAMETER_NAME)];
    if (uiOptions == null) {
      uiOptions = UIOptions();
    }
    FeignRequest request =
        requestParamsResolver.resolve(positionalArguments, parameters, requestMapping.method, options: uiOptions);

    /// 解析url
    final requestURLResolver = feignConfiguration.requestURLResolver;
    final String requestUrl =
        requestURLResolver.resolve(this._feignClient, requestMapping, classMirror.simpleName, methodName);

    /// 解析请求头
    final requestHeaderResolver = feignConfiguration.requestHeaderResolver;
    requestHeaderResolver.resolve(requestMapping, request.headers, request.queryParams);
    final requestSupportRequestBody = supportRequestBody(requestMapping.method);
    if (requestSupportRequestBody) {
      requestHeaderResolver.resolve(requestMapping, request.headers, request.body);
    }

    /// TODO 解析 cookie
    var responseExtractor = uiOptions.responseExtractor;
    final serializer = namedArguments[Symbol(FEIGN_SERIALIZER_PARAMETER_NAME)];
    if (responseExtractor == null) {
      // get response extractor
      responseExtractor = this._responseExtractor(requestMapping.method, serializer?.serializeType,
          specifiedType: serializer?.specifiedType ?? FullType.unspecified);
    }

    setFeignMethodMirror(request, methodMirror);
    setRequestFeignConfiguration(request, this.feignConfiguration);

    /// 处理签名
    final apiSignatureStrategy = feignConfiguration.apiSignatureStrategy;
    if (apiSignatureStrategy != null) {
      final signature = findSignature(methodMetadata) as Signature;
      // handle api signature
      apiSignatureStrategy.sign(signature.fields, request);
    }

    /// 执行拦截器
    request = await this._preHandle(request, uiOptions, requestUrl, requestMapping);

    final defaultQueryParams = requestMapping.params;
    if (requestMapping.params.isNotEmpty) {
      //  处理默认的查询参数
      defaultQueryParams.forEach((queryString) {
        request.queryParams.addAll(QueryStringParser.parse(queryString));
      });
    }

    /// 发起请求
    final restTemplate = feignConfiguration.restTemplate;
    var response;
    try {
      if (_log.isLoggable(Level.FINER)) {
        _log.finer("send http request ==> $requestUrl");
      }
      response = await restTemplate.execute(requestUrl, requestMapping.method, responseExtractor,
          request: request.body,
          queryParams: request.queryParams,
          pathVariables: request.pathVariables,
          headers: request.headers,
          timeout: uiOptions.timeout,
          context: request);
    } catch (error) {
      // 请求失败或异常
      final result = await this._postHandleError(request, uiOptions, requestUrl, requestMapping, error, serializer);
      if (error is Error) {
        return Future.error(result, error.stackTrace);
      }
      return Future.error(result);
    }

    return this._postHandle(request, uiOptions, requestUrl, requestMapping, response, serializer);
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
      response, BuiltValueSerializable? serializer) async {
    return this._executeInterceptor<FeignBaseRequest, dynamic>(request, uiOptions, url, requestMapping, response,
        (FeignClientExecutorInterceptor<FeignBaseRequest> interceptor) {
      return interceptor.postHandle(request, uiOptions, response, serializer: serializer);
    });
  }

  /// 拦截器后置错误处理
  Future _postHandleError(FeignBaseRequest request, UIOptions uiOptions, String url, RequestMapping requestMapping,
      error, BuiltValueSerializable? serializer) async {
    return this._executeInterceptor<FeignBaseRequest, Object>(request, uiOptions, url, requestMapping, error, (
        [FeignClientExecutorInterceptor<FeignBaseRequest>? interceptor]) {
      if (interceptor == null) {
        return Future.error(error);
      }
      return interceptor.postError(request, uiOptions, error, serializer: serializer);
    }, true);
  }

  Future<dynamic> _executeInterceptor<T extends FeignBaseRequest, R>(FeignBaseRequest request, UIOptions uiOptions,
      String url, RequestMapping requestMapping, R defaultValue, ExecuteInterceptor<T> execute,
      [bool needTry = false]) async {
    final interceptors = this.feignConfiguration.feignClientExecutorInterceptors;
    var result = defaultValue, len = interceptors.length, index = 0;
    while (index < len) {
      var feignClientExecutorInterceptor = interceptors[index];
      FeignClientExecutorInterceptor? interceptor =
          this._getInterceptor(feignClientExecutorInterceptor, url, request.headers, requestMapping);
      if (interceptor != null) {
        if (needTry) {
          try {
            result = await execute(interceptor as FeignClientExecutorInterceptor<T>);
          } catch (error) {
            return error;
          }
        } else {
          result = await execute(interceptor as FeignClientExecutorInterceptor<T>);
        }
      }
      index++;
    }
    return result;
  }

  FeignClientExecutorInterceptor? _getInterceptor(FeignClientExecutorInterceptor feignClientExecutorInterceptor,
      String url, Map<String, String> headers, RequestMapping requestMapping) {
    if (feignClientExecutorInterceptor is MappedFeignClientExecutorInterceptor) {
      if (feignClientExecutorInterceptor.matches(url, requestMapping.method, headers: headers)) {
        return feignClientExecutorInterceptor;
      }
      return null;
    }
    return feignClientExecutorInterceptor;
  }

  // build [ResponseExtractor]
  ResponseExtractor _responseExtractor<T>(String httpMethod, Type? serializeType,
      {FullType specifiedType = FullType.unspecified}) {
    if (httpMethod == HttpMethod.OPTIONS) {
      return OptionsForAllowResponseExtractor();
    }
    if (httpMethod == HttpMethod.HEAD) {
      return HeadResponseExtractor();
    }
    if (specifiedType.root == ResponseEntity) {
      return ResponseEntityResponseExtractor(feignConfiguration.httpMessageConverters, serializeType);
    } else {
      return HttpMessageConverterExtractor(feignConfiguration.httpMessageConverters,
          responseType: serializeType, specifiedType: specifiedType);
    }
  }
}
