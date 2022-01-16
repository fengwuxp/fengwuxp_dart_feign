import 'dart:ffi';
import 'dart:io';

import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/src/client/message_body_client_http_response_wrapper.dart';
import 'package:fengwuxp_dart_openfeign/src/client/response_extractor.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client_http_response.dart';
import 'package:fengwuxp_dart_openfeign/src/http/converter/http_message_converter.dart';
import 'package:fengwuxp_dart_openfeign/src/http/response_entity.dart';

class HttpMessageConverterExtractor<T> implements ResponseExtractor<T> {
  List<HttpMessageConverter> _messageConverters;

  Type? _responseType;

  FullType _specifiedType;

  HttpMessageConverterExtractor._(this._messageConverters, this._responseType, this._specifiedType);

  factory HttpMessageConverterExtractor(List<HttpMessageConverter> messageConverters,
      {Type? responseType, FullType specifiedType = FullType.unspecified}) {
    return HttpMessageConverterExtractor._(messageConverters, responseType, specifiedType);
  }

  Future<T?> extractData(ClientHttpResponse response,
      {Type? serializeType, FullType specifiedType = FullType.unspecified}) async {
    final responseWrapper = MessageBodyClientHttpResponseWrapper(response);
    if (!responseWrapper.hasMessageBody()) {
      return Future.value();
    }

    final contentType = ContentType.parse(response.headers[HttpHeaders.contentTypeHeader] as String);
    for (HttpMessageConverter messageConverter in this._messageConverters) {
      final _serializeType = this._responseType ?? serializeType;
      if (messageConverter.canRead(contentType, serializeType: _serializeType)) {
        return messageConverter.read<T>(response, contentType,
            serializeType: _serializeType, specifiedType: this._specifiedType);
      }
    }
    return Future.error(new Exception("not match http message converter can read contentType = $contentType"));
  }
}

class ResponseEntityResponseExtractor<T> implements ResponseExtractor<ResponseEntity<T>> {
  final HttpMessageConverterExtractor<T> _delegate;

  ResponseEntityResponseExtractor(List<HttpMessageConverter> messageConverters, Type? responseType,
      [FullType specifiedType = FullType.unspecified])
      : this._delegate =
            HttpMessageConverterExtractor(messageConverters, responseType: responseType, specifiedType: specifiedType);

  factory([List<HttpMessageConverter>? messageConverters, Type? responseType]) {
    return new ResponseEntityResponseExtractor(messageConverters ?? [], responseType);
  }

  Future<ResponseEntity<T>> extractData(ClientHttpResponse response,
      {Type? serializeType, FullType specifiedType = FullType.unspecified}) async {
    T? body = await this._delegate.extractData(response);
    return ResponseEntity<T>(response.statusCode, response.headers, body as T, response.reasonPhrase);
  }
}

class HeadResponseExtractor implements ResponseExtractor<Map<String, String>> {
  const HeadResponseExtractor();

  /// Extract data from the given {@code ClientHttpResponse} and return it.
  Future<Map<String, String>> extractData(ClientHttpResponse response,
      {Type? serializeType, FullType specifiedType = FullType.unspecified}) {
    return Future.value(response.headers);
  }
}

class OptionsForAllowResponseExtractor implements ResponseExtractor<Set<String>> {
  HeadResponseExtractor _headResponseExtractor = HeadResponseExtractor();

  factory() {
    return new OptionsForAllowResponseExtractor();
  }

  @override
  Future<Set<String>> extractData(ClientHttpResponse response,
      {Type? serializeType, FullType specifiedType = FullType.unspecified}) async {
    final headers = await this._headResponseExtractor.extractData(response, serializeType: serializeType);
    // "Access-Control-Allow-Methods"
    final header = headers["Access-Control-Allow-Methods"] as String;
    if (!StringUtils.hasText(header)) {
      return Future.value(Set.from([]));
    }
    return Future.value(Set.from(header.split(",")));
  }
}

class NoneResponseExtractor implements ResponseExtractor<ClientHttpResponse> {
  @override
  Future<ClientHttpResponse?> extractData(ClientHttpResponse response,
      {Type? serializeType, specifiedType = FullType.unspecified}) {
    return Future.value(response);
  }
}

class VoidResponseExtractor implements ResponseExtractor<Void> {
  @override
  Future<Void?> extractData(ClientHttpResponse response, {Type? serializeType, specifiedType = FullType.unspecified}) {
    return Future.value();
  }
}
