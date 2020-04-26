import 'dart:async';
import 'dart:io';

import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/src/http/converter/abstract_http_message_converter.dart';
import 'package:fengwuxp_dart_openfeign/src/http/http_input_message.dart';

import '../http_output_message.dart';

class BuiltValueHttpMessageConverter extends AbstractGenericHttpMessageConverter {
  BuiltJsonSerializers _builtJsonSerializers;

  BuiltValueHttpMessageConverter(Serializers serializers) : super([ContentType.json]) {
    this._builtJsonSerializers = BuiltJsonSerializers(serializers);
  }

  factory(Serializers serializers) {
    return new BuiltValueHttpMessageConverter(serializers);
  }

  Future<E> read<E>(HttpInputMessage inputMessage, {Serializer<E> serializer}) {
    return inputMessage.body.stream
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
      return this._builtJsonSerializers.parseObject(data, serializer);
    });
  }

  @override
  void write(data, ContentType mediaType, HttpOutputMessage outputMessage) {
    outputMessage.body.add(this._builtJsonSerializers.toJson(data));
  }
}
