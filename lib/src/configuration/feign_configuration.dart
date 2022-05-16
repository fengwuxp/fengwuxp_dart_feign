import 'package:fengwuxp_dart_openfeign/src/cache_capable_support.dart';
import 'package:fengwuxp_dart_openfeign/src/client/client_http_request_interceptor.dart';
import 'package:fengwuxp_dart_openfeign/src/client/rest_operations.dart';
import 'package:fengwuxp_dart_openfeign/src/event/http_response_event.dart';
import 'package:fengwuxp_dart_openfeign/src/executor/feign_client_executor_factory.dart';
import 'package:fengwuxp_dart_openfeign/src/executor/feign_client_executor_interceptor.dart';
import 'package:fengwuxp_dart_openfeign/src/http/converter/http_message_converter.dart';
import 'package:fengwuxp_dart_openfeign/src/resolve/request_header_resolver.dart';
import 'package:fengwuxp_dart_openfeign/src/resolve/request_params_resolver.dart';
import 'package:fengwuxp_dart_openfeign/src/resolve/request_url_resolve.dart';
import 'package:fengwuxp_dart_openfeign/src/signature/api_signature_strategy.dart';

abstract class FeignConfiguration extends CacheCapableSupport {
  FeignClientExecutorFactory get feignClientExecutorFactory;

  RestOperations get restTemplate;

  /// get url resolver
  RequestURLResolver get requestURLResolver;

  RequestParamsResolver get requestParamsResolver;

  RequestHeaderResolver get requestHeaderResolver;

  List<HttpMessageConverter> get httpMessageConverters;

  ApiSignatureStrategy? get apiSignatureStrategy;

  List<ClientHttpRequestInterceptor> get clientHttpRequestInterceptors;

  List<FeignClientExecutorInterceptor> get feignClientExecutorInterceptors;

  HttpResponseEventPublisher get httpResponseEventPublisher;

  SmartHttpResponseEventListener get httpResponseEventListener;
}
