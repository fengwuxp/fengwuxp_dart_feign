import 'package:fengwuxp_dart_openfeign/src/http/http_message.dart';

//// Represents an HTTP request message, consisting of
/// {@linkplain #getMethod() method} and {@linkplain #getURI() uri}.
abstract class HttpRequest extends HttpMessage {
  /// Return the HTTP method of the request as a String value.
  /// @return the HTTP method as a plain String
  String get method;

  /// Return the URI of the request (including a query string if any,
  /// but only if it is well-formed for a URI representation).
  /// @return the URI of the request (never {@code null})
  Uri get url;

  ///  Timeout in milliseconds for request send data and receive data
  /// default -1， timeout<=0  meanings no timeout limit.
  int get timeout;

  // replace uri
  void uri(Uri uri) {}
}
