import 'package:fengwuxp_dart_openfeign/src/http/client/client_exception.dart';
import 'package:fengwuxp_dart_openfeign/src/http/clinet_http_response.dart';
import 'package:fengwuxp_dart_openfeign/src/http/response_entity.dart';

import '../feign_request_options.dart';

/// Only executed in feign client
/// [FeignClientExecutor#invoke]
abstract class FeignClientExecutorInterceptor<T extends FeignBaseRequest> {
  /// in request before invoke
  Future<T> preHandle(T request, UIOptions uiOptions);

  /// in request after invoke
  /// [request]
  /// [response]
  Future postHandle<E>(T request, UIOptions uiOptions, ResponseEntity<E> response);

  /// in request failure invoke
  /// [request]
  /// [exception]
  Future postError<E>(T request, UIOptions uiOptions, ClientException exception);
}

/// execute interceptor
/// [interceptor] Allow empty
typedef Future ExecuteInterceptor<T extends FeignBaseRequest>(FeignClientExecutorInterceptor<T> interceptor);
