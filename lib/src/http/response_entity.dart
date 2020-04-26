import 'dart:io';

class ResponseEntity<T> {
  num _statusCode;

  HttpHeaders _headers;

  String _statusText;

  T body;

  ResponseEntity(this._statusCode, this._headers, T body, this._statusText); // http status code

  factory(
    num statusCode,
    HttpHeaders headers,
    T body,
    String statusText,
  ) {
    return new ResponseEntity(statusCode, headers, body, statusText);
  }

  num get statusCode => _statusCode;

  ///  http status text
  String get statusText => _statusText;

  //  request is success
  bool get ok => this.statusCode >= 200 && this.statusCode < 300;

  // http response headers
  HttpHeaders get headers => _headers;
}
