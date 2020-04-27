import 'dart:async';

import 'package:fengwuxp_dart_openfeign/src/http/http_message.dart';

/// Represents an HTTP output message, consisting of {@linkplain [HttpMessage.getHeaders()] headers}
/// and a writable {@linkplain #getBody() body}.
abstract class HttpOutputMessage implements HttpMessage {
  /// Return the body of the message as an output stream.
  /// @return the output stream body (never {@code null})
  /// @throws IOException in case of I/O errors
  StreamController<List<int>> get body;

  /// Append content length
  void addContentLength(int length);
}
