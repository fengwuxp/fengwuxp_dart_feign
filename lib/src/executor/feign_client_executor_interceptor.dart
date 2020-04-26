import 'package:fengwuxp_dart_openfeign/src/client/clinet_http_response.dart';

import '../feign_request_options.dart';

/// Only executed in feign client
/// [FeignClientExecutor#invoke]
abstract class FeignClientExecutorInterceptor<T extends FeignRequestBaseOptions> {
  /// in request before invoke
  Future<T> preHandle(T options);

  /// in request after invoke
  /// [options]
  /// [response]
  Future postHandle<E>(T options, E response);

  /// in request failure invoke
  /// [options]
  /// [response]
  Future postError<E>(T options, ClientHttpResponse response);
}
