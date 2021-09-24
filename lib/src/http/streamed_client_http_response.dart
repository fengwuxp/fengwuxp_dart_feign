import 'package:fengwuxp_dart_openfeign/src/http/client_http_response.dart';
import 'package:http/http.dart';

class StreamedClientHttpResponse implements ClientHttpResponse {
  final StreamedResponse _response;

  const StreamedClientHttpResponse(this._response);

  @override
  Map<String, String> get headers => this._response.headers;

  @override
  num get statusCode => this._response.statusCode;

  @override
  String get reasonPhrase => this._response.reasonPhrase ?? "unknown error";

  @override
  Stream<List<int>> get body => this._response.stream;

  @override
  bool get ok => this.statusCode >= 200 && this.statusCode < 400;
}
