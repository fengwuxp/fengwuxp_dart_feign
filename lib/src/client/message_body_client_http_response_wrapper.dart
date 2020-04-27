import 'dart:async';
import 'dart:io';

import 'package:fengwuxp_dart_openfeign/src/http/client/byte_stream.dart';
import 'package:fengwuxp_dart_openfeign/src/http/clinet_http_response.dart';

class MessageBodyClientHttpResponseWrapper implements ClientHttpResponse {

  final ClientHttpResponse _response;

  const MessageBodyClientHttpResponseWrapper(this._response);

  factory(){

  }

  bool hasMessageBody() {
    var statusCode = this.statusCode;
    if (statusCode == null ||
        statusCode <= 100 ||
        statusCode == HttpStatus.noContent ||
        statusCode == HttpStatus.notModified) {
      return false;
    }

    if (int.parse(this.headers[HttpHeaders.contentLengthHeader]) == 0) {
      return false;
    }
    return true;
  }

  Future<bool> hasEmptyMessageBody() {
    var body = this.stream;
    if (body == null) {
      return Future.value(true);
    }
    return body.length.then((len) {
      return len == 0;
    });
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
