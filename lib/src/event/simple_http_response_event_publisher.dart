import 'package:fengwuxp_dart_openfeign/src/feign_request_options.dart';
import 'package:fengwuxp_dart_openfeign/src/http/response_entity.dart';

import 'http_response_event.dart';

class SimpleHttpResponseEventPublisher implements HttpResponseEventPublisher {
  final HttpResponseEventHandlerSupplier _eventHandlerSupplier;

  SimpleHttpResponseEventPublisher(this._eventHandlerSupplier);

  @override
  publishEvent(FeignRequest request, StringResponseEntity entity, UIOptions options) {
    this._eventHandlerSupplier.getHandlers(entity.statusCode).forEach((handler) {
      handler(request, entity, options);
    });
  }
}
