import 'dart:io';

import 'package:fengwuxp_dart_openfeign/src/http/converter/http_message_converter.dart';
import 'package:fengwuxp_dart_openfeign/src/http/http_output_message.dart';
import 'package:fengwuxp_dart_openfeign/src/util/encoding_utils.dart';

abstract class AbstractHttpMessageConverter<T> implements HttpMessageConverter<T> {
  /// 基础数据类型
  static const List<Type> base_types = [String, bool, num];

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

  void writeBody(String? value, ContentType mediaType, HttpOutputMessage outputMessage) {
    if (value == null) {
      return;
    }
    outputMessage.body.add(getContentTypeEncoding(mediaType).encode(value));
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
