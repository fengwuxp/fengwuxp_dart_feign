import 'package:fengwuxp_dart_openfeign/src/feign_request_options.dart';

import 'http_response_event.dart';

class SimpleHttpResponseEventPublisher implements HttpResponseEventPublisher {
  final HttpResponseEventHandlerSupplier _eventHandlerSupplier;

  SimpleHttpResponseEventPublisher(this._eventHandlerSupplier);

  @override
  publishEvent(FeignRequest request, UIOptions options, entity, int statusCode) {
    this._eventHandlerSupplier.getHandlers(statusCode).forEach((handler) {
      handler(request, options, entity);
    });
  }
}
