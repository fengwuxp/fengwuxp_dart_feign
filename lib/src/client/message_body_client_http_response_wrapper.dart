import 'dart:async';
import 'dart:io';

import 'package:fengwuxp_dart_openfeign/src/client/clinet_http_response.dart';

class MessageBodyClientHttpResponseWrapper implements ClientHttpResponse {
  final ClientHttpResponse _response;

  const MessageBodyClientHttpResponseWrapper(this._response);

  bool hasMessageBody() {
    var statusCode = this.statusCode;
    if (statusCode == null ||
        statusCode <= 100 ||
        statusCode == HttpStatus.noContent ||
        statusCode == HttpStatus.notModified) {
      return false;
    }

    if (this.headers.contentLength == 0) {
      return false;
    }
    return true;
  }

  Future<bool> hasEmptyMessageBody() {
    var body = this.body;
    if (body == null) {
      return Future.value(true);
    }
    return body.stream.length.then((len) {
      return len == 0;
    });
  }

  @override
  HttpHeaders get headers => this._response.headers;

  @override
  num get statusCode => this._response.statusCode;

  @override
  String get statusText => this._response.statusText;

  @override
  StreamController get body => this._response.body;

  @override
  bool get ok => this._response.ok;
}
