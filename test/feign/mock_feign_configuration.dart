import 'package:fengwuxp_dart_basic/index.dart';
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

class MockFeignConfiguration implements FeignConfiguration {
  FeignClientExecutorFactory feignClientExecutorFactory;

  RestOperations restTemplate;

  /// get url resolver
  RequestURLResolver requestURLResolver;

  RequestHeaderResolver requestHeaderResolver;

  RequestParamsResolver requestParamsResolver;

  List<FeignClientExecutorInterceptor> feignClientExecutorInterceptors;

  List<HttpMessageConverter> messageConverters;

  ApiSignatureStrategy apiSignatureStrategy;

  MockFeignConfiguration() {
    this.feignClientExecutorFactory = DefaultFeignClientExecutorFactory();
    this.requestURLResolver = RestfulRequestURLResolver();
    this.requestHeaderResolver = DefaultRequestHeaderResolver();
    this.requestParamsResolver = DefaultRequestParamsResolver();
    var messageConverters = [new BuiltValueHttpMessageConverter(new BuiltJsonSerializers(serializers))];
    this.messageConverters = messageConverters;
    this.feignClientExecutorInterceptors = [];
    this.restTemplate = new RestTemplate(
        messageConverters: messageConverters, interceptors: [RoutingClientHttpRequestInterceptor('https://www.baidu.com')]);
  }
}
