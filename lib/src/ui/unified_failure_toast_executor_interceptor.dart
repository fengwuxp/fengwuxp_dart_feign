import 'dart:io';

import 'package:fengwuxp_dart_openfeign/src/executor/feign_client_executor_interceptor.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client/client_exception.dart';
import 'package:fengwuxp_dart_openfeign/src/http/response_entity.dart';

import '../feign_request_options.dart';

typedef void UnifiedFailureToast(ResponseEntity response);

//  unified transform failure toast
class UnifiedFailureToastExecutorInterceptor<T extends FeignBaseRequest> implements FeignClientExecutorInterceptor<T> {


  Future<T> preHandle(T request, UIOptions uiOptions) async {
    return request;
  }

  /// in request after invoke
  /// [options]
  /// [response]
  Future postHandle<E>(T request, UIOptions uiOptions, ResponseEntity<E> response) async {
    if (response.ok) {
      return response.body;
    }
    if (HttpStatus.unauthorized == response.statusCode) {
      // 需要登录
      _tryHandleUnAuthorized(response);
    }
    return Future.error(response);
  }

  /// in request failure invoke
  /// [options]
  /// [exception]
  Future postError<E>(T options, UIOptions uiOptions, ClientException exception) {
    if (exception is ClientTimeOutException) {
      return Future.error(ResponseEntity(HttpStatus.gatewayTimeout, {}, null, "client timeout exception"));
    }
    return Future.error(exception);
  }

  _tryHandleUnAuthorized(ResponseEntity response) {}
}
