import 'package:fengwuxp_dart_openfeign/src/http/http_input_message.dart';

// The payload object used to make the HTTP request
abstract class ClientHttpResponse implements HttpInputMessage {
  // http status code
  num get statusCode;

  ///  http status text
  String get reasonPhrase;

  //  request is success
  bool get ok => this.statusCode >= 200 && this.statusCode < 300;
}
