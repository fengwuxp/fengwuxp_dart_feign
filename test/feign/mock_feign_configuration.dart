import 'dart:convert';

import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/index.dart';
import 'package:fengwuxp_dart_openfeign/src/client/rest_operations.dart';
import 'package:fengwuxp_dart_openfeign/src/client/rest_template.dart';
import 'package:fengwuxp_dart_openfeign/src/client/routing_client_http_request_interceptor.dart';
import 'package:fengwuxp_dart_openfeign/src/configuration/feign_configuration.dart';
import 'package:fengwuxp_dart_openfeign/src/executor/default_feign_client_executor_factory.dart';
import 'package:fengwuxp_dart_openfeign/src/executor/feign_client_executor_factory.dart';
import 'package:fengwuxp_dart_openfeign/src/executor/feign_client_executor_interceptor.dart';
import 'package:fengwuxp_dart_openfeign/src/http/converter/built_value_http_message_converter.dart';
import 'package:fengwuxp_dart_openfeign/src/http/converter/http_message_converter.dart';
import 'package:fengwuxp_dart_openfeign/src/resolve/request_header_resolver.dart';
import 'package:fengwuxp_dart_openfeign/src/resolve/request_params_resolver.dart';
import 'package:fengwuxp_dart_openfeign/src/resolve/request_url_resolve.dart';
import 'package:fengwuxp_dart_openfeign/src/signature/api_signature_strategy.dart';

import '../built/serializers.dart';

final simpleHttpResponseEventListener = SimpleHttpResponseEventListener();

class MockFeignConfiguration implements FeignConfiguration {
  FeignClientExecutorFactory feignClientExecutorFactory;

  RestOperations restTemplate;

  /// get url resolver
  RequestURLResolver requestURLResolver;

  RequestHeaderResolver requestHeaderResolver;

  RequestParamsResolver requestParamsResolver;

  List<FeignClientExecutorInterceptor> feignClientExecutorInterceptors;

  List<HttpMessageConverter> httpMessageConverters;

  ApiSignatureStrategy? apiSignatureStrategy;

  List<ClientHttpRequestInterceptor> clientHttpRequestInterceptors;

  @override
  // TODO: implement httpResponseEventListener
  SmartHttpResponseEventListener httpResponseEventListener;

  @override
  // TODO: implement httpResponseEventPublisher
  HttpResponseEventPublisher httpResponseEventPublisher;

  MockFeignConfiguration()
      : this.feignClientExecutorFactory = DefaultFeignClientExecutorFactory(),
        this.requestURLResolver = RestfulRequestURLResolver(),
        this.requestHeaderResolver = DefaultRequestHeaderResolver(),
        this.requestParamsResolver = DefaultRequestParamsResolver(),
        this.httpResponseEventListener = simpleHttpResponseEventListener,
        this.httpResponseEventPublisher = new SimpleHttpResponseEventPublisher(simpleHttpResponseEventListener),
        this.httpMessageConverters = [
          new BuiltValueHttpMessageConverter(new BuiltJsonSerializers(serializers), (responseBody) {
            final resp = jsonDecode(responseBody);
            if (resp["code"] != 0) {
              return Future.error(resp);
            }
            return Future.value(resp);
          })
        ],
        this.clientHttpRequestInterceptors = [],
        this.feignClientExecutorInterceptors = [HttpErrorResponseEventPublisherExecutorInterceptor.of()],
        this.restTemplate = new RestTemplate(
            httpMessageConverters: [new BuiltValueHttpMessageConverter(new BuiltJsonSerializers(serializers), null)],
            interceptors: [RoutingClientHttpRequestInterceptor.form('http://localhost:8080/api/')]);
}
