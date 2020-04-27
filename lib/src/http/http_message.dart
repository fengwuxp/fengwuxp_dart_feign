import 'dart:io';

/// Represents the base interface for HTTP request and response messages.
/// Consists of [Map<String,String], retrievable via {@link #getHeaders()}.
abstract class HttpMessage {
  /// Return the headers of this message.
  /// @return a corresponding [HttpHeaders] object (never {@code null})
  Map<String, String> get headers;
}
