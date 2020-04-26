import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/src/client/rest_operations.dart';
import 'package:fengwuxp_dart_openfeign/src/client/rest_template.dart';
import 'package:fengwuxp_dart_openfeign/src/configuration/feign_configuration.dart';
import 'package:fengwuxp_dart_openfeign/src/executor/default_feign_client_executor_factory.dart';
import 'package:fengwuxp_dart_openfeign/src/executor/feign_client_executor_factory.dart';
import 'package:fengwuxp_dart_openfeign/src/executor/feign_client_executor_interceptor.dart';
import 'package:fengwuxp_dart_openfeign/src/http/converter/http_message_converter.dart';
import 'package:fengwuxp_dart_openfeign/src/resolve/request_header_resolver.dart';
import 'package:fengwuxp_dart_openfeign/src/resolve/request_params_resolver.dart';
import 'package:fengwuxp_dart_openfeign/src/resolve/request_url_resolve.dart';
import 'package:fengwuxp_dart_openfeign/src/signature/api_signature_strategy.dart';
import '../built/serializers.dart';

class MockFeignConfiguration implements FeignConfiguration {
  final FeignClientExecutorFactory feignClientExecutorFactory;

  final RestOperations restTemplate;

  /// get url resolver
  final RequestURLResolver requestURLResolver;

  final RequestHeaderResolver requestHeaderResolver;

  final RequestParamsResolver requestParamsResolver;

  final List<FeignClientExecutorInterceptor> feignClientExecutorInterceptors;

  final List<HttpMessageConverter> messageConverters;

  final BuiltJsonSerializers builtSerializers;

  final ApiSignatureStrategy apiSignatureStrategy;

  const MockFeignConfiguration(
      {this.feignClientExecutorFactory = const DefaultFeignClientExecutorFactory(),
      this.restTemplate = const RestTemplate(),
      this.requestURLResolver = const RestfulRequestURLResolver(),
      this.requestHeaderResolver = const DefaultRequestHeaderResolver(),
      this.requestParamsResolver = const DefaultRequestParamsResolver(),
      this.feignClientExecutorInterceptors = const [],
      this.builtSerializers,
      this.messageConverters,
      this.apiSignatureStrategy});
}
