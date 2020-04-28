import 'package:fengwuxp_dart_openfeign/src/http/client/client_exception.dart';
import 'package:fengwuxp_dart_openfeign/src/http/clinet_http_response.dart';
import 'package:fengwuxp_dart_openfeign/src/http/response_entity.dart';

import '../feign_request_options.dart';

/// Only executed in feign client
/// [FeignClientExecutor#invoke]
abstract class FeignClientExecutorInterceptor<T extends FeignRequestBaseOptions> {
  /// in request before invoke
  Future<T> preHandle(T options);

  /// in request after invoke
  /// [options]
  /// [response]
  Future postHandle<E>(T options, ResponseEntity<E> response);

  /// in request failure invoke
  /// [options]
  /// [exception]
  Future postError<E>(T options, ClientException exception);
}
