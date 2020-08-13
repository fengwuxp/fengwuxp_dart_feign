import 'dart:async';
import 'dart:io';

import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/src/client/response_extractor.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client_http_response.dart';
import 'package:fengwuxp_dart_openfeign/src/http/converter/abstract_http_message_converter.dart';
import 'package:fengwuxp_dart_openfeign/src/http/http_input_message.dart';
import 'package:logging/logging.dart';

import '../http_output_message.dart';

/// 基于built value 的http message converter
/// 用于写入和读取 Content-Type 为[ContentType.json]的数据
class BuiltValueHttpMessageConverter extends AbstractGenericHttpMessageConverter {
  static const String _TAG = "BuiltValueHttpMessageConverter";
  static var _log = Logger(_TAG);

  BuiltJsonSerializers _builtJsonSerializers;

  BusinessResponseExtractor _businessResponseExtractor;

  BuiltValueHttpMessageConverter(
      BuiltJsonSerializers builtJsonSerializers, BusinessResponseExtractor businessResponseExtractor)
      : super([ContentType.json]) {
    this._builtJsonSerializers = builtJsonSerializers;
    this._businessResponseExtractor = businessResponseExtractor ?? noneBusinessResponseExtractor;
  }

  factory(BuiltJsonSerializers builtJsonSerializers, {BusinessResponseExtractor businessResponseExtractor}) {
    return new BuiltValueHttpMessageConverter(builtJsonSerializers, businessResponseExtractor);
  }

  Future<E> read<E>(HttpInputMessage inputMessage, {Serializer<E> serializer, FullType specifiedType}) {
    return inputMessage.stream.bytesToString().catchError((e) {
      _log.finer("read data error ==> $e");
      return Future.error(e);
    }).then((responseBody) {
      _log.finer("read http response body ==> $responseBody");
      if (inputMessage is ClientHttpResponse) {
        if (!inputMessage.ok) {
          // http error
//          return Future.error(responseBody);
          return responseBody as dynamic;
        }
      }
      return this._businessResponseExtractor(responseBody).then((value) {
        return this._builtJsonSerializers.parseObject(value, serializer: serializer, specifiedType: specifiedType);
      });
    });
  }

  @override
  Future write(data, ContentType mediaType, HttpOutputMessage outputMessage) {
    final text = this._builtJsonSerializers.toJson(data);
    _log.finer("write data ==> $text");
    super.writeBody(text, ContentType.json, outputMessage);
  }
}
