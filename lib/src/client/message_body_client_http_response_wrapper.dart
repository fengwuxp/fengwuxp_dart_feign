import 'dart:io';

import 'package:fengwuxp_dart_openfeign/src/http/client_http_response.dart';

class MessageBodyClientHttpResponseWrapper extends ClientHttpResponse {
  final ClientHttpResponse _delegate;

  MessageBodyClientHttpResponseWrapper(this._delegate);

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
  int get statusCode => this._delegate.statusCode;

  @override
  String get reasonPhrase => this._delegate.reasonPhrase;

  @override
  Stream<List<int>> get body => this._delegate.body;

  @override
  bool get ok => this._delegate.ok;

  @override
  Future<String> bodyAsString() {
    return _delegate.bodyAsString();
  }
}
