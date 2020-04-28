import 'dart:async';
import 'dart:io';

import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/src/http/converter/abstract_http_message_converter.dart';
import 'package:fengwuxp_dart_openfeign/src/http/http_input_message.dart';
import 'package:logging/logging.dart';

import '../http_output_message.dart';

/// 基于built value 的http message converter
class BuiltValueHttpMessageConverter extends AbstractGenericHttpMessageConverter {
  static const String _TAG = "BuiltValueHttpMessageConverter";
  static var _log = Logger(_TAG);

  BuiltJsonSerializers _builtJsonSerializers;

  BuiltValueHttpMessageConverter(BuiltJsonSerializers builtJsonSerializers) : super([ContentType.json]) {
    this._builtJsonSerializers = builtJsonSerializers;
  }

  factory(BuiltJsonSerializers builtJsonSerializers) {
    return new BuiltValueHttpMessageConverter(builtJsonSerializers);
  }

  Future<E> read<E>(HttpInputMessage inputMessage, {Serializer<E> serializer, FullType specifiedType}) {
    return inputMessage.stream.bytesToString().then((data) {
      _log.finer("read data ==> $data");
      return this._builtJsonSerializers.parseObject(data, serializer: serializer, specifiedType: specifiedType);
    });
  }

  @override
  Future write(data, ContentType mediaType, HttpOutputMessage outputMessage) {
    final text = this._builtJsonSerializers.toJson(data);
    _log.finer("write data ==> $text");
    final codeUnits = text.codeUnits;
    outputMessage.body.add(codeUnits);
    outputMessage.addContentLength(codeUnits.length);
    return Future.value();
  }
}
