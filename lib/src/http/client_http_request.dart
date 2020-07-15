import 'client_http_response.dart';
import 'http_message.dart';

///  Represents a client-side HTTP request.
abstract class ClientHttpRequest implements HttpMessage {
  /// Return the HTTP method of the request as a String value.
  /// @return the HTTP method as a plain String
  String get method;

  /// Return the URI of the request (including a query string if any,
  /// but only if it is well-formed for a URI representation).
  /// @return the URI of the request (never {@code null})
  Uri get url;

  /// Execute this request, resulting in a {@link [ClientHttpResponse]} that can be read.
  /// @return the response result of the execution
  /// @throws IOException in case of I/O errors
  Future<ClientHttpResponse> send();

  ///  Timeout in milliseconds for request send data and receive data
  /// default -1， timeout<=0  meanings no timeout limit.
  int get timeout;

  // replace uri
  void uri(Uri uri) {}
}
