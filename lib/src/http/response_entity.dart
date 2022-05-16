import 'dart:convert';

import 'package:fengwuxp_dart_openfeign/src/http/client_http_response.dart';

class ResponseEntity<T> {
  int _statusCode;

  Map<String, String> _headers;

  T _body;

  String _reasonPhrase;

  ResponseEntity(this._statusCode, this._headers, this._body, this._reasonPhrase); // http status code

  static ResponseEntity<T> of<T>(
    int statusCode,
    Map<String, String> headers,
    T body,
    String statusText,
  ) {
    return ResponseEntity(statusCode, headers, body, statusText);
  }

  int get statusCode => _statusCode;

  ///  http status text
  String get reasonPhrase => _reasonPhrase;

  T get body => _body;

  //  request is success
  bool get ok => this.statusCode >= 200 && this.statusCode < 300;

  // http response headers
  Map<String, String> get headers => _headers;
}

class StringResponseEntity extends ResponseEntity<String> {
  StringResponseEntity(int status, Map<String, String> headers, String body, String reasonPhrase)
      : super(status, headers, body, reasonPhrase);

  json() {
    return jsonDecode(this.body);
  }
}
