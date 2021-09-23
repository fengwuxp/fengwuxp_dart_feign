import 'dart:io';

import 'package:fengwuxp_dart_openfeign/src/http/client_http_response.dart';
import 'package:http/http.dart';

class MessageBodyClientHttpResponseWrapper implements ClientHttpResponse {

  final ClientHttpResponse _delegate;

  const MessageBodyClientHttpResponseWrapper(this._delegate);

  bool hasMessageBody() {
    final statusCode = this.statusCode;
    if (statusCode <= 100 || statusCode == HttpStatus.noContent || statusCode == HttpStatus.notModified) {
      return false;
    }

    final contentLength = this.headers[HttpHeaders.contentLengthHeader];
    if (contentLength != null && int.parse(contentLength) == 0) {
      return false;
    }
    return true;
  }

  @override
  Map<String, String> get headers => this._delegate.headers;

  @override
  num get statusCode => this._delegate.statusCode;

  @override
  String get reasonPhrase => this._delegate.reasonPhrase;

  @override
  ByteStream get body => this._delegate.body;

  @override
  bool get ok => this._delegate.ok;
}
