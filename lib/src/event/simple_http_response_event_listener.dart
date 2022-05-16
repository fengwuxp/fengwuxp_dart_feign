import 'dart:io';

import 'package:fengwuxp_dart_openfeign/src/event/http_response_event.dart';

class SimpleHttpResponseEventListener implements SmartHttpResponseEventListener {
  final List<HttpResponseEventHandler> _errorsHandlers = [];
  final Map<String, List<HttpResponseEventHandler>> _handleCaches = {};

  @override
  List<HttpResponseEventHandler> getHandlers(int status) {
    if (status >= HttpStatus.ok && status < HttpStatus.multipleChoices) {
      return this._getHandlers(status);
    }
    return [...this._getHandlers(status), ..._errorsHandlers];
  }

  List<HttpResponseEventHandler> _getHandlers(int status) {
    return this._handleCaches[status.toString()] ?? [];
  }

  @override
  void onError(HttpResponseEventHandler handler) {
    this._errorsHandlers.add(handler);
  }

  @override
  void onEvent(int status, HttpResponseEventHandler handler) {
    List<HttpResponseEventHandler> handles = this._getHandlers(status);
    handles.add(handler);
    this._handleCaches[status.toString()] = handles;
  }

  @override
  void removeListen(int status, HttpResponseEventHandler? handler) {
    if (handler == null) {
      this._handleCaches[status.toString()] = [];
    } else {
      this._getHandlers(status).remove(handler);
      this.removeErrorListen(handler);
    }
  }

  @override
  void onForbidden(HttpResponseEventHandler handler) {
    this.onEvent(HttpStatus.forbidden, handler);
  }

  @override
  void onFound(HttpResponseEventHandler handler) {
    this.onEvent(HttpStatus.found, handler);
  }

  @override
  void onUnAuthorized(HttpResponseEventHandler handler) {
    this.onEvent(HttpStatus.unauthorized, handler);
  }

  @override
  void removeErrorListen(HttpResponseEventHandler handler) {
    this._errorsHandlers.remove(handler);
  }
}
