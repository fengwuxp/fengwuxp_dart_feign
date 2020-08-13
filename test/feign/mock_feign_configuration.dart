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
import 'package:fengwuxp_dart_openfeign/src/http/response_entity.dart';
import 'package:fengwuxp_dart_openfeign/src/resolve/request_header_resolver.dart';
import 'package:fengwuxp_dart_openfeign/src/resolve/request_params_resolver.dart';
import 'package:fengwuxp_dart_openfeign/src/resolve/request_url_resolve.dart';
import 'package:fengwuxp_dart_openfeign/src/signature/api_signature_strategy.dart';
import 'package:fengwuxp_dart_openfeign/src/ui/unified_failure_toast_executor_interceptor.dart';

import '../built/serializers.dart';
import '../cms/resp/api_resp.dart';

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

  List<ClientHttpRequestInterceptor> clientHttpRequestInterceptors;

  AuthenticationBroadcaster authenticationBroadcaster;

  MockFeignConfiguration() {
    this.feignClientExecutorFactory = DefaultFeignClientExecutorFactory();
    this.requestURLResolver = RestfulRequestURLResolver();
    this.requestHeaderResolver = DefaultRequestHeaderResolver();
    this.requestParamsResolver = DefaultRequestParamsResolver();
    var messageConverters = [new BuiltValueHttpMessageConverter(new BuiltJsonSerializers(serializers), null)];
    this.messageConverters = messageConverters;
    this.feignClientExecutorInterceptors = [
      new UnifiedFailureToastExecutorInterceptor((data, BuiltValueSerializable serializer) {
        var body = data;
        if (data is ResponseEntity) {
          body = data.body;
        }
        if (body == null) {
          return null;
        }
        return ApiResp.formJsonBySerializer(body);
      }, (result) {
        print("==========>$result");
        return Future.value();
      })
    ];
    this.restTemplate = new RestTemplate(
        messageConverters: messageConverters,
        interceptors: [RoutingClientHttpRequestInterceptor('http://localhost:8090/api/')]);
  }
}
