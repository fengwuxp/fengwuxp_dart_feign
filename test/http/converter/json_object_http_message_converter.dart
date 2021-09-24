import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/src/http/converter/http_message_converter.dart';
import 'package:fengwuxp_dart_openfeign/src/http/http_input_message.dart';
import 'package:fengwuxp_dart_openfeign/src/http/http_output_message.dart';

import '../../built/serializers.dart';

class JsonObjectHttpMessageConverter implements HttpMessageConverter<JsonSerializableObject> {
  bool canRead(ContentType mediaType, {Type? serializeType}) {
    return true;
  }

  bool canWrite(ContentType mediaType, {Type? serializeType}) {
    return true;
  }

  List<ContentType> getSupportedMediaTypes() {
    return [];
  }

  Future<E> read<E>(HttpInputMessage inputMessage,ContentType mediaType,
      {Type? serializeType, FullType specifiedType = FullType.unspecified}) {
    final body = inputMessage.body;
    return utf8.decodeStream(body).then((data) {
      var builtJsonSerializers = BuiltJsonSerializers(serializers);
      var deserializeWith =
          builtJsonSerializers.parseObject(data, resultType: serializeType, specifiedType: specifiedType);
      return deserializeWith;
    });
  }

  Future<void> write(JsonSerializableObject data, ContentType mediaType, HttpOutputMessage outputMessage) {
    outputMessage.body.add(data.toJson().codeUnits);
    return Future.value();
  }
}
