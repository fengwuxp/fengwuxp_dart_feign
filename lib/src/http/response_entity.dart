class ResponseEntity<T> {
  num _statusCode;

  Map<String, String> _headers;

  String _reasonPhrase;

  T _body;

  ResponseEntity._(this._statusCode, this._headers, this._body, this._reasonPhrase); // http status code

  factory ResponseEntity(
    num statusCode,
    Map<String, String> headers,
    T body,
    String statusText,
  ) {
    return ResponseEntity._(statusCode, headers, body, statusText);
  }

  num get statusCode => _statusCode;

  ///  http status text
  String get reasonPhrase => _reasonPhrase;

  T get body => _body;

  //  request is success
  bool get ok => this.statusCode >= 200 && this.statusCode < 300;

  // http response headers
  Map<String, String> get headers => _headers;
}
