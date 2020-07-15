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

  Serializer<T> _responseType;

  FullType _specifiedType;

  HttpMessageConverterExtractor._(this._messageConverters, this._responseType, this._specifiedType);

  factory HttpMessageConverterExtractor(List<HttpMessageConverter> messageConverters,
      {Serializer<T> responseType, FullType specifiedType}) {
    return HttpMessageConverterExtractor._(messageConverters, responseType, specifiedType ?? FullType.unspecified);
  }

  Future<T> extractData(ClientHttpResponse response, {Serializer serializer, FullType specifiedType}) async {
    var responseWrapper = MessageBodyClientHttpResponseWrapper(response);
    if (!responseWrapper.hasMessageBody() || responseWrapper.hasEmptyMessageBody()) {
      return Future.value(null);
    }

    final contentType = ContentType.parse(response.headers[HttpHeaders.contentTypeHeader]);
    for (HttpMessageConverter messageConverter in this._messageConverters) {
      if (this._responseType != null) {
        if (messageConverter.canRead(contentType, serializer: this._responseType)) {
          return messageConverter.read<T>(response,
              serializer: this._responseType, specifiedType: this._specifiedType ?? specifiedType);
        }
      }
      if (messageConverter is GenericHttpMessageConverter) {
        if (messageConverter.canRead(contentType, serializer: serializer)) {
          return messageConverter.read<T>(response,
              serializer: serializer, specifiedType: this._specifiedType ?? specifiedType);
        }
      }
    }
  }
}

class ResponseEntityResponseExtractor<T> implements ResponseExtractor<ResponseEntity<T>> {
  HttpMessageConverterExtractor<T> _delegate;

  ResponseEntityResponseExtractor(
      [List<HttpMessageConverter> messageConverters, Serializer<T> responseType, FullType specifiedType]) {
    if (messageConverters != null && messageConverters.isNotEmpty) {
      this._delegate =
          HttpMessageConverterExtractor(messageConverters, responseType: responseType, specifiedType: specifiedType);
    } else {
      this._delegate = null;
    }
  }

  factory([List<HttpMessageConverter> messageConverters, Serializer<T> responseType]) {
    return new ResponseEntityResponseExtractor(messageConverters, responseType);
  }

  Future<ResponseEntity<T>> extractData(ClientHttpResponse response,
      {Serializer serializer, FullType specifiedType}) async {
    if (this._delegate != null) {
      T body = await this._delegate.extractData(response);
      return ResponseEntity<T>(response.statusCode, response.headers, body, response.reasonPhrase);
    } else {
      return ResponseEntity<T>(response.statusCode, response.headers, null, response.reasonPhrase);
    }
  }
}

class HeadResponseExtractor implements ResponseExtractor<Map<String, String>> {
  const HeadResponseExtractor();

  /// Extract data from the given {@code ClientHttpResponse} and return it.
  Future<Map<String, String>> extractData(ClientHttpResponse response,
      {Serializer serializer, FullType specifiedType}) {
    return Future.value(response.headers);
  }
}

class OptionsForAllowResponseExtractor implements ResponseExtractor<Set<String>> {
  HeadResponseExtractor _headResponseExtractor = HeadResponseExtractor();

  factory() {
    return new OptionsForAllowResponseExtractor();
  }

  @override
  Future<Set<String>> extractData(ClientHttpResponse response, {Serializer serializer, FullType specifiedType}) async {
    var headers = await this._headResponseExtractor.extractData(response, serializer: serializer);
    if (headers == null) {
      return Future.value(Set.from([]));
    }
    // "Access-Control-Allow-Methods"
    var header = headers["Access-Control-Allow-Methods"];
    if (!StringUtils.hasText(header)) {
      return Future.value(Set.from([]));
    }
    return Future.value(Set.from(header.split(",")));
  }
}
