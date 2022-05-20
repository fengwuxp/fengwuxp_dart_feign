import 'dart:io';

import 'package:fengwuxp_dart_openfeign/src/http/http_input_message.dart';
import 'package:fengwuxp_dart_openfeign/src/util/encoding_utils.dart';

// The payload object used to make the HTTP request
abstract class ClientHttpResponse implements HttpInputMessage {

  String? _responseBody;

  // http status code
  int get statusCode;

  ///  http status text
  String get reasonPhrase;

  //  request is success
  bool get ok => this.statusCode >= 200 && this.statusCode < 300;

  @override
  Future<String> bodyAsString() {
    if (this._responseBody != null) {
      return Future.value(this._responseBody);
    }
    final contentType = ContentType.parse(this.headers[HttpHeaders.contentTypeHeader] as String);
    return getContentTypeEncoding(contentType).decodeStream(this.body).then((value) {
      this._responseBody = value;
      return value;
    });
  }
}
