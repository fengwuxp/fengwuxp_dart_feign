import 'http_message.dart';

/// Represents an HTTP request message, consisting of
/// [HttpRequest.getUri]
/// [HttpRequest.getMethod]
abstract class HttpRequest implements HttpMessage{

   /// Return the HTTP method of the request as a String value.
   /// @return the HTTP method as a plain String
  String getMethod();

  /// Return the URI of the request (including a query string if any,
  /// but only if it is well-formed for a URI representation).
  /// @return the URI of the request (never {@code null})
  Uri getUri();
}
