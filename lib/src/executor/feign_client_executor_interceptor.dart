import 'package:fengwuxp_dart_openfeign/src/http/client/client_exception.dart';

import '../feign_request_options.dart';

/// Only executed in feign client
/// [FeignClientExecutor#invoke]
abstract class FeignClientExecutorInterceptor<T extends FeignBaseRequest> {
  /// in request before invoke
  Future<T> preHandle(T request, UIOptions uiOptions);

  /// in request after invoke
  /// only in http statusCode is [200 ,300) invoke
  /// [request]
  /// [response]
  Future postHandle<E>(T request, UIOptions uiOptions, E response, {BuiltValueSerializable serializer});

  /// in request exception or failure invoke
  /// [request]
  /// [error] [ClientException] or other data
  Future postError<E>(T request, UIOptions uiOptions, error, {BuiltValueSerializable serializer});
}

/// execute interceptor
/// [interceptor] Allow empty
typedef Future ExecuteInterceptor<T extends FeignBaseRequest>(FeignClientExecutorInterceptor<T> interceptor);
