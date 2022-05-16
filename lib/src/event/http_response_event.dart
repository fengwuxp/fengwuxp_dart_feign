import 'dart:io';

import 'package:fengwuxp_dart_openfeign/index.dart';
import 'package:fengwuxp_dart_openfeign/src/feign_request_options.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client_http_response.dart';



abstract class HttpResponseEventPublisher {
  publishEvent(FeignRequest request, StringResponseEntity entity, UIOptions options);
}

typedef HttpResponseEventHandler = void Function(FeignRequest request, StringResponseEntity entity, UIOptions options);

abstract class HttpResponseEventHandlerSupplier {
  List<HttpResponseEventHandler> getHandlers(int status);
}

abstract class HttpResponseEventListener extends HttpResponseEventHandlerSupplier {
  /// 回调指定的的 http status handler
  void onEvent(int status, HttpResponseEventHandler handler);

  /// 移除监听
  void removeListen(int status, HttpResponseEventHandler? handler);
}

abstract class SmartHttpResponseEventListener extends HttpResponseEventListener {
  ///  所有非 2xx 响应都会回调
  void onError(HttpResponseEventHandler handler);

  void removeErrorListen(HttpResponseEventHandler handler);

  /// [HttpStatus.found]
  void onFound(HttpResponseEventHandler handler);

  /// [HttpStatus.unauthorized]
  void onUnAuthorized(HttpResponseEventHandler handler);

  /// [HttpStatus.forbidden]
  void onForbidden(HttpResponseEventHandler handler);
}
