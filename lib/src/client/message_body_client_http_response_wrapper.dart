import 'dart:io';

import 'package:fengwuxp_dart_openfeign/src/http/client/byte_stream.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client_http_response.dart';

class MessageBodyClientHttpResponseWrapper implements ClientHttpResponse {
  final ClientHttpResponse _response;

  const MessageBodyClientHttpResponseWrapper(this._response);

  factory() {}

  bool hasMessageBody() {
    var statusCode = this.statusCode;
    if (statusCode == null ||
        statusCode <= 100 ||
        statusCode == HttpStatus.noContent ||
        statusCode == HttpStatus.notModified) {
      return false;
    }

    var contentLength = this.headers[HttpHeaders.contentLengthHeader];
    if (contentLength !=null && int.parse(contentLength) == 0) {
      return false;
    }
    return true;
  }

  bool hasEmptyMessageBody() {
    return this.stream == null;
  }

  @override
  Map<String, String> get headers => this._response.headers;

  @override
  num get statusCode => this._response.statusCode;

  @override
  String get reasonPhrase => this._response.reasonPhrase;

  @override
  ByteStream get stream => this._response.stream;

  @override
  bool get ok => this._response.ok;
}
