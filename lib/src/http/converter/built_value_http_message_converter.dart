import 'dart:async';
import 'dart:io';

import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/src/client/response_extractor.dart';
import 'package:fengwuxp_dart_openfeign/src/http/converter/abstract_http_message_converter.dart';
import 'package:fengwuxp_dart_openfeign/src/http/http_input_message.dart';
import 'package:logging/logging.dart';

import '../http_output_message.dart';

/// 基于built value 的http message converter
/// 用于写入和读取 Content-Type 为[ContentType.json]的数据
class BuiltValueHttpMessageConverter extends AbstractGenericHttpMessageConverter {
  static const String _TAG = "BuiltValueHttpMessageConverter";

  // TODO 兼容个别服务器
  @deprecated
  static final ContentType _text_json = new ContentType("text", "json", charset: "utf-8");

  static final _log = Logger(_TAG);

  final BuiltJsonSerializers _builtJsonSerializers;

  final BusinessResponseExtractor _businessResponseExtractor;

  BuiltValueHttpMessageConverter(
      BuiltJsonSerializers builtJsonSerializers, BusinessResponseExtractor? businessResponseExtractor)
      : this._builtJsonSerializers = builtJsonSerializers,
        this._businessResponseExtractor = businessResponseExtractor ?? noneBusinessResponseExtractor,
        super([ContentType.json, _text_json]);

  factory(BuiltJsonSerializers builtJsonSerializers, {BusinessResponseExtractor? businessResponseExtractor}) {
    return new BuiltValueHttpMessageConverter(builtJsonSerializers, businessResponseExtractor);
  }

  Future<E> read<E>(HttpInputMessage inputMessage, ContentType mediaType,
      {Type? serializeType, FullType specifiedType = FullType.unspecified}) {
    return getEncoding(mediaType).decodeStream(inputMessage.body).catchError((error) {
      if (_log.isLoggable(Level.FINER)) {
        _log.finer("read data error ==> $error");
      }
      return Future.error(error, (error as Error).stackTrace);
    }).then((responseBody) {
      if (_log.isLoggable(Level.FINER)) {
        _log.finer("read http response body ==> $responseBody");
      }

      return this._businessResponseExtractor(responseBody).then((result) {
        return _resolveExtractorResult(result, specifiedType, serializeType);
      });
    });
  }

  _resolveExtractorResult(result, FullType specifiedType, Type? serializeType) {
    if (result == null) {
      // 可能是返回 void TODO 增加类型判断
      return null;
    }
    if (specifiedType.root == String || serializeType == String) {
      // 结果类型为字符串直接返回
      return result;
    }
    return this._builtJsonSerializers.parseObject(result, resultType: serializeType, specifiedType: specifiedType);
  }

  @override
  Future<void> write(data, ContentType mediaType, HttpOutputMessage outputMessage) {
    final text = this._builtJsonSerializers.toJson(data);
    if (_log.isLoggable(Level.FINER)) {
      _log.finer("write data ==> $text");
    }
    super.writeBody(text, ContentType.json, outputMessage);
    return Future.value();
  }
}
