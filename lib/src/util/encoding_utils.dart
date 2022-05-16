import 'dart:convert';
import 'dart:io';

Encoding getContentTypeEncoding(ContentType mediaType) {
  final charset = mediaType.parameters["charset"] ?? "utf-8";
  return _requiredEncodingForCharset(charset);
}

/// Returns the [Encoding] that corresponds to [charset].
/// Throws a [FormatException] if no [Encoding] was found that corresponds to
/// [charset].
/// [charset] may not be null.
Encoding _requiredEncodingForCharset(String charset) =>
    Encoding.getByName(charset) ?? (throw FormatException('Unsupported encoding "$charset".'));
