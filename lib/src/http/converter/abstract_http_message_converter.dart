import 'dart:convert';
import 'dart:io';

import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client/utils.dart';
import 'package:fengwuxp_dart_openfeign/src/http/http_input_message.dart';
import 'package:fengwuxp_dart_openfeign/src/http/http_output_message.dart';

import 'http_message_converter.dart';

abstract class AbstractHttpMessageConverter<T> implements HttpMessageConverter<T> {
  List<ContentType> _supportedMediaTypes;

  AbstractHttpMessageConverter(this._supportedMediaTypes);

  bool canRead(ContentType mediaType, {Serializer serializer}) {
    return _matchContentType(mediaType);
  }

  bool canWrite(ContentType mediaType, {Serializer serializer}) {
    return _matchContentType(mediaType);
  }

  List<ContentType> getSupportedMediaTypes() {
    return this._supportedMediaTypes;
  }

  Future<E> read<E>(HttpInputMessage inputMessage, {Serializer<E> serializer, FullType specifiedType}) {}

  Encoding getEncoding(ContentType contentType) {
    if (contentType == null || !contentType.parameters.containsKey('charset')) {
      return utf8;
    }
    return requiredEncodingForCharset(contentType.parameters["charset"]);
  }

  void writeBody(String value, ContentType mediaType, HttpOutputMessage outputMessage) {
    if (value == null) {
      return;
    }
    var bytes = this.getEncoding(mediaType).encode(value);
    outputMessage.body.add(bytes);
    outputMessage.addContentLength(bytes.length);
  }

  bool _matchContentType(ContentType mediaType) {
    return this._supportedMediaTypes.any((item) {
      return item.value == mediaType.value;
    });
  }
}

abstract class AbstractGenericHttpMessageConverter<T> extends AbstractHttpMessageConverter<T>
    implements GenericHttpMessageConverter<T> {
  AbstractGenericHttpMessageConverter(List<ContentType> supportedMediaTypes) : super(supportedMediaTypes);
}
