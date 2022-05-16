import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/index.dart';

import 'feign_configuration_registry.dart';
import 'registry/client_http_interceptor_registry.dart';
import 'registry/feign_client_interceptor_registry.dart';

class FeignInitializer {
  final FeignConfigurationRegistry registry;

  final BuiltJsonSerializers builtJsonSerializers;

  String _defaultProduce = HttpMediaType.FORM_DATA;

  FeignClientExecutorFactory _feignClientExecutorFactory = DefaultFeignClientExecutorFactory();

  RestOperations? _restTemplate;

  RequestURLResolver _requestURLResolver = RestfulRequestURLResolver();

  RequestParamsResolver _requestParamsResolver = DefaultRequestParamsResolver();

  RequestHeaderResolver _requestHeaderResolver = new DefaultRequestHeaderResolver();

  SmartHttpResponseEventListener _smartHttpResponseEventListener = SimpleHttpResponseEventListener();

  HttpResponseEventPublisher? _httpResponseEventPublisher;

  ApiSignatureStrategy? _apiSignatureStrategy;

  BusinessResponseExtractor? _businessResponseExtractor;

  FeignInitializer(this.registry, this.builtJsonSerializers);

  static FeignInitializer form(FeignConfigurationRegistry registry, BuiltJsonSerializers builtJsonSerializers) {
    return new FeignInitializer(registry, builtJsonSerializers);
  }

  FeignInitializer feignClientExecutorFactory(FeignClientExecutorFactory feignClientExecutorFactory) {
    this._feignClientExecutorFactory = feignClientExecutorFactory;
    return this;
  }

  FeignInitializer defaultProduce(String defaultProduce) {
    this._defaultProduce = defaultProduce;
    return this;
  }

  FeignInitializer requestURLResolver(RequestURLResolver requestURLResolver) {
    this._requestURLResolver = requestURLResolver;
    return this;
  }

  FeignInitializer requestParamsResolver(RequestParamsResolver requestParamsResolver) {
    this._requestParamsResolver = requestParamsResolver;
    return this;
  }

  FeignInitializer requestHeaderResolver(RequestHeaderResolver requestHeaderResolver) {
    this._requestHeaderResolver = requestHeaderResolver;
    return this;
  }

  FeignInitializer smartHttpResponseEventListener(SmartHttpResponseEventListener listener) {
    this._smartHttpResponseEventListener = listener;
    return this;
  }

  FeignInitializer httpResponseEventPublisher(HttpResponseEventPublisher publisher) {
    this._httpResponseEventPublisher = publisher;
    return this;
  }

  FeignInitializer apiSignatureStrategy(ApiSignatureStrategy apiSignatureStrategy) {
    this._apiSignatureStrategy = apiSignatureStrategy;
    return this;
  }

  FeignInitializer businessResponseExtractor(BusinessResponseExtractor businessResponseExtractor) {
    this._businessResponseExtractor = businessResponseExtractor;
    return this;
  }

  FeignConfiguration initialize() {
    final configuration = _buildConfiguration();
    registryFeignConfiguration(configuration);
    return configuration;
  }

  _FeignConfigurationBoot _buildConfiguration() {
    final List<ClientHttpRequestInterceptor> clientHttpRequestInterceptors = _configureClientRequestInterceptors();
    final List<HttpMessageConverter> httpMessageConverters = _configureHttpMessageConverts();
    final httpResponseEventPublisher =
        this._httpResponseEventPublisher ?? SimpleHttpResponseEventPublisher(this._smartHttpResponseEventListener);
    return new _FeignConfigurationBoot(
        _feignClientExecutorFactory,
        _buildRestOperations(clientHttpRequestInterceptors, httpMessageConverters),
        _requestURLResolver,
        _requestParamsResolver,
        _requestHeaderResolver,
        _smartHttpResponseEventListener,
        httpResponseEventPublisher,
        clientHttpRequestInterceptors,
        _configureFeignRequestInterceptors(),
        httpMessageConverters,
        _apiSignatureStrategy);
  }

  RestOperations _buildRestOperations(List<ClientHttpRequestInterceptor> clientHttpRequestInterceptors,
      List<HttpMessageConverter> httpMessageConverters) {
    return _restTemplate ??
        new RestTemplate(
            defaultProduce: _defaultProduce,
            interceptors: clientHttpRequestInterceptors,
            httpMessageConverters: httpMessageConverters);
  }

  List<HttpMessageConverter> _configureHttpMessageConverts() {
    final List<HttpMessageConverter> result = [
      FormDataHttpMessageConverter(),
      BuiltValueHttpMessageConverter(builtJsonSerializers, _businessResponseExtractor),
    ];
    registry.registryMessageConverters(result);
    return result;
  }

  /// init interceptor
  List<ClientHttpRequestInterceptor> _configureClientRequestInterceptors() {
    final clientHttpInterceptorRegistry = ClientHttpInterceptorRegistry();
    registry.registryClientHttpRequestInterceptors(clientHttpInterceptorRegistry);
    return clientHttpInterceptorRegistry.getInterceptors();
  }

  List<FeignClientExecutorInterceptor> _configureFeignRequestInterceptors() {
    final feignClientInterceptorRegistry = FeignClientInterceptorRegistry();
    registry.registryFeignClientExecutorInterceptors(feignClientInterceptorRegistry);
    return feignClientInterceptorRegistry.getInterceptors();
  }
}

class _FeignConfigurationBoot implements FeignConfiguration {
  final FeignClientExecutorFactory feignClientExecutorFactory;

  final RestOperations restTemplate;

  final RequestURLResolver requestURLResolver;

  final RequestParamsResolver requestParamsResolver;

  final RequestHeaderResolver requestHeaderResolver;

  final SmartHttpResponseEventListener httpResponseEventListener;

  final HttpResponseEventPublisher httpResponseEventPublisher;

  final List<ClientHttpRequestInterceptor> clientHttpRequestInterceptors;

  final List<FeignClientExecutorInterceptor> feignClientExecutorInterceptors;

  final List<HttpMessageConverter> httpMessageConverters;

  final ApiSignatureStrategy? apiSignatureStrategy;

  _FeignConfigurationBoot(
      this.feignClientExecutorFactory,
      this.restTemplate,
      this.requestURLResolver,
      this.requestParamsResolver,
      this.requestHeaderResolver,
      this.httpResponseEventListener,
      this.httpResponseEventPublisher,
      this.clientHttpRequestInterceptors,
      this.feignClientExecutorInterceptors,
      this.httpMessageConverters,
      this.apiSignatureStrategy);
}
