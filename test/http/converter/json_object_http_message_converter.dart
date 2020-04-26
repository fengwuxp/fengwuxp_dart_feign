import 'dart:async';
import 'dart:io';

import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/src/http/converter/http_message_converter.dart';
import 'package:fengwuxp_dart_openfeign/src/http/http_input_message.dart';
import 'package:fengwuxp_dart_openfeign/src/http/http_output_message.dart';

import '../../built/serializers.dart';

class JsonObjectHttpMessageConverter implements HttpMessageConverter<JsonSerializableObject> {
  bool canRead(ContentType mediaType, {Serializer serializer}) {
    return true;
  }

  bool canWrite(ContentType mediaType, {Serializer serializer}) {
    return true;
  }

  List<ContentType> getSupportedMediaTypes() {
    return [];
  }

  Future<E> read<E>(HttpInputMessage inputMessage, {Serializer<E> serializer}) {
    var body = inputMessage.body;

    return body.stream
        .transform(StreamTransformer<List<int>, String>.fromHandlers(
          handleData: (List<int> data, EventSink sink) {
            // 操作数据后，转换为 double 类型
            var event = new String.fromCharCodes(data);
            sink.add(event);
          },
          handleError: (error, stacktrace, sink) {
            sink.addError('wrong: $error');
          },
          handleDone: (sink) {
            sink.close();
          },
        ))
        .first
        .then((data) {
      var builtJsonSerializers = BuiltJsonSerializers(serializers);
      var deserializeWith = builtJsonSerializers.parseObject(data, serializer);
      return deserializeWith;
    });
  }

  write(JsonSerializableObject data, ContentType mediaType, HttpOutputMessage outputMessage) {
    outputMessage.body.add(data.toJson());
  }
}
