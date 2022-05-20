import 'dart:io';

import 'package:fengwuxp_dart_openfeign/src/http/client_http_response.dart';
import 'package:fengwuxp_dart_openfeign/src/util/encoding_utils.dart';
import 'package:http/http.dart';

class StreamedClientHttpResponse extends ClientHttpResponse {
  final StreamedResponse _response;

  StreamedClientHttpResponse(this._response);

  @override
  Map<String, String> get headers => this._response.headers;

  @override
  int get statusCode => this._response.statusCode;

  @override
  String get reasonPhrase => this._response.reasonPhrase ?? "unknown error";

  @override
  Stream<List<int>> get body => this._response.stream;

  Future<String> bodyAsString() {
    final contentType = ContentType.parse(this.headers[HttpHeaders.contentTypeHeader] as String);
    return getContentTypeEncoding(contentType).decodeStream(this.body);
  }
}
