import 'package:fengwuxp_dart_openfeign/src/http/http_message.dart';

import 'client/byte_stream.dart';

/// Represents an HTTP input message, consisting of {@linkplain [HttpMessage.getHeaders()] headers}
/// and a readable {@linkplain #getBody() body}.
///
/// <p>Typically implemented by an HTTP request handle on the server side,
/// or an HTTP response handle on the client side.

abstract class HttpInputMessage implements HttpMessage {
  /// Return the body of the message as an input stream.
  /// @return the input stream body (never {@code null})
  /// @throws IOException in case of I/O errors
  ByteStream get stream;
}
