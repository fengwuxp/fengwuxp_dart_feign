import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/index.dart';

import 'feign_configuration_registry.dart';
import 'registry/client_http_interceptor_registry.dart';
import 'registry/feign_client_interceptor_registry.dart';

class FeignConfigurationBoot implements FeignConfiguration {
  FeignClientExecutorFactory _feignClientExecutorFactory;

  RestOperations _restTemplate;

  RequestURLResolver _requestURLResolver;

  RequestParamsResolver _requestParamsResolver;

  RequestHeaderResolver _requestHeaderResolver;

  List<ClientHttpRequestInterceptor> _clientHttpRequestInterceptors;

  List<FeignClientExecutorInterceptor> _feignClientExecutorInterceptors;

  List<HttpMessageConverter> _httpMessageConverters;

  ApiSignatureStrategy _apiSignatureStrategy;

  AuthenticationBroadcaster _authenticationBroadcaster;

  FeignConfigurationBoot(FeignConfigurationRegistry registry, BuiltJsonSerializers builtJsonSerializers,
      {FeignClientExecutorFactory feignClientExecutorFactory,
      String defaultProduce = HttpMediaType.FORM_DATA,
      RestOperations restOperations,
      RequestURLResolver requestURLResolver,
      BusinessResponseExtractor businessResponseExtractor,
      RequestParamsResolver requestParamsResolver,
      RequestHeaderResolver requestHeaderResolver,
      ApiSignatureStrategy apiSignatureStrategy,
      AuthenticationBroadcaster authenticationBroadcaster}) {
    this._feignClientExecutorFactory = feignClientExecutorFactory ?? DefaultFeignClientExecutorFactory();
    this._initInterceptor(registry);
    this._initMessageConverts(registry, builtJsonSerializers, businessResponseExtractor);
    this._restTemplate = restOperations ??
        new RestTemplate(
            defaultProduce: defaultProduce,
            interceptors: this._clientHttpRequestInterceptors,
            messageConverters: this._httpMessageConverters);
    this._requestURLResolver = requestURLResolver ?? RestfulRequestURLResolver();
    this._requestParamsResolver = requestParamsResolver ?? DefaultRequestParamsResolver();
    this._requestHeaderResolver = requestHeaderResolver ?? DefaultRequestHeaderResolver();

    this._authenticationBroadcaster = authenticationBroadcaster;
    this._apiSignatureStrategy = apiSignatureStrategy;
  }

  /// init interceptor
  void _initInterceptor(FeignConfigurationRegistry registry) {
    final clientHttpInterceptorRegistry = ClientHttpInterceptorRegistry();
    registry.registryClientHttpRequestInterceptors(clientHttpInterceptorRegistry);
    this._clientHttpRequestInterceptors = clientHttpInterceptorRegistry.getInterceptors();

    final feignClientInterceptorRegistry = FeignClientInterceptorRegistry();
    registry.registryFeignClientExecutorInterceptors(feignClientInterceptorRegistry);
    this._feignClientExecutorInterceptors = feignClientInterceptorRegistry.getInterceptors();
  }

  void _initMessageConverts(FeignConfigurationRegistry registry, BuiltJsonSerializers builtJsonSerializers,
      BusinessResponseExtractor businessResponseExtractor) {
    final List<HttpMessageConverter> list = [
      FormDataHttpMessageConverter(),
      BuiltValueHttpMessageConverter(builtJsonSerializers, businessResponseExtractor),
    ];
    registry.registryMessageConverters(list);
    this._httpMessageConverters = list;
  }

  @override
  FeignClientExecutorFactory get feignClientExecutorFactory => this._feignClientExecutorFactory;

  @override
  RestOperations get restTemplate => this._restTemplate;

  @override
  RequestURLResolver get requestURLResolver => this._requestURLResolver;

  @override
  RequestParamsResolver get requestParamsResolver => this._requestParamsResolver;

  @override
  RequestHeaderResolver get requestHeaderResolver => this._requestHeaderResolver;

  @override
  List<HttpMessageConverter> get messageConverters => this._httpMessageConverters;

  @override
  ApiSignatureStrategy get apiSignatureStrategy => this._apiSignatureStrategy;

  @override
  List<ClientHttpRequestInterceptor> get clientHttpRequestInterceptors => this._clientHttpRequestInterceptors;

  @override
  List<FeignClientExecutorInterceptor> get feignClientExecutorInterceptors => this._feignClientExecutorInterceptors;

  @override
  AuthenticationBroadcaster get authenticationBroadcaster => this._authenticationBroadcaster;
}
