import 'dart:async';
import 'dart:io';

import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/src/http/converter/http_message_converter.dart';
import 'package:fengwuxp_dart_openfeign/src/http/http_input_message.dart';
import 'package:fengwuxp_dart_openfeign/src/http/http_output_message.dart';

import '../../built/serializers.dart';

class JsonObjectHttpMessageConverter implements HttpMessageConverter<JsonSerializableObject> {
  bool canRead(ContentType mediaType, {Type serializeType}) {
    return true;
  }

  bool canWrite(ContentType mediaType, {Type serializeType}) {
    return true;
  }

  List<ContentType> getSupportedMediaTypes() {
    return [];
  }

  Future<E> read<E>(HttpInputMessage inputMessage, {Type serializeType, FullType specifiedType}) {
    var body = inputMessage.stream;
    return body.bytesToString().then((data) {
      var builtJsonSerializers = BuiltJsonSerializers(serializers);
      var deserializeWith =
          builtJsonSerializers.parseObject(data, resultType: serializeType, specifiedType: specifiedType);
      return deserializeWith;
    });
  }

  write(JsonSerializableObject data, ContentType mediaType, HttpOutputMessage outputMessage) {
    outputMessage.body.add(data.toJson().codeUnits);
  }
}
