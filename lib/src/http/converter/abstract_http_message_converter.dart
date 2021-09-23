import 'dart:convert';
import 'dart:io';

import 'package:fengwuxp_dart_openfeign/src/http/http_output_message.dart';
import 'package:http/src/utils.dart';

import 'http_message_converter.dart';

abstract class AbstractHttpMessageConverter<T> implements HttpMessageConverter<T> {
  List<ContentType> _supportedMediaTypes;

  AbstractHttpMessageConverter(this._supportedMediaTypes);

  bool canRead(ContentType mediaType, {Type? serializeType}) {
    return _matchContentType(mediaType);
  }

  bool canWrite(ContentType mediaType, {Type? serializeType}) {
    return _matchContentType(mediaType);
  }

  List<ContentType> getSupportedMediaTypes() {
    return this._supportedMediaTypes;
  }

  Encoding getEncoding(ContentType contentType) {
    final charset = contentType.parameters["charset"] ?? "utf-8";
    return requiredEncodingForCharset(charset);
  }

  void writeBody(String? value, ContentType mediaType, HttpOutputMessage outputMessage) {
    if (value == null) {
      return;
    }
    var bytes = this.getEncoding(mediaType).encode(value);
    outputMessage.body.add(bytes);
  }

  bool _matchContentType(ContentType mediaType) {
    return this._supportedMediaTypes.any((item) {
      return item.value == mediaType.value;
    });
  }

  /// Returns the [Encoding] that corresponds to [charset].
  ///
  /// Throws a [FormatException] if no [Encoding] was found that corresponds to
  /// [charset].
  ///
  /// [charset] may not be null.
// Encoding requiredEncodingForCharset(String charset) => Encoding.getByName(charset) ??
//         (throw FormatException('Unsupported encoding "$charset".'));
}

abstract class AbstractGenericHttpMessageConverter<T> extends AbstractHttpMessageConverter<T>
    implements GenericHttpMessageConverter<T> {
  AbstractGenericHttpMessageConverter(List<ContentType> supportedMediaTypes) : super(supportedMediaTypes);
}
