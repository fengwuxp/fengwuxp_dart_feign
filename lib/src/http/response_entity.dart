import 'dart:io';

class ResponseEntity<T> {
  num _statusCode;

  Map<String, String> _headers;

  String _reasonPhrase;

  T body;

  ResponseEntity(this._statusCode, this._headers, T body, this._reasonPhrase); // http status code

  factory(
    num statusCode,
    Map<String, String> headers,
    T body,
    String statusText,
  ) {
    return new ResponseEntity(statusCode, headers, body, statusText);
  }

  num get statusCode => _statusCode;

  ///  http status text
  String get reasonPhrase => _reasonPhrase;

  //  request is success
  bool get ok => this.statusCode >= 200 && this.statusCode < 300;

  // http response headers
  Map<String, String> get headers => _headers;
}
