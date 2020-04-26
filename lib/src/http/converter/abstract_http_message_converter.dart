import 'dart:io';

import 'package:built_value/serializer.dart';

import 'http_message_converter.dart';

abstract class AbstractHttpMessageConverter<T> implements HttpMessageConverter<T> {
  List<ContentType> _supportedMediaTypes;

  AbstractHttpMessageConverter(this._supportedMediaTypes);

  bool canRead(ContentType mediaType, {Serializer serializer}) {
    return this._supportedMediaTypes.any((item) {
      return item.value == mediaType.value;
    });
  }

  bool canWrite(ContentType mediaType, {Serializer serializer}) {
    return this.canRead(mediaType, serializer: serializer);
  }

  List<ContentType> getSupportedMediaTypes() {
    return this._supportedMediaTypes;
  }
}

abstract class AbstractGenericHttpMessageConverter<T> extends AbstractHttpMessageConverter<T>
    implements GenericHttpMessageConverter<T> {
  AbstractGenericHttpMessageConverter(List<ContentType> supportedMediaTypes) : super(supportedMediaTypes);
}
