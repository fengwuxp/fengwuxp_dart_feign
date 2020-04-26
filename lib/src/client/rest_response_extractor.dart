import 'dart:io';

import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/src/client/clinet_http_response.dart';
import 'package:fengwuxp_dart_openfeign/src/client/message_body_client_http_response_wrapper.dart';
import 'package:fengwuxp_dart_openfeign/src/client/response_extractor.dart';
import 'package:fengwuxp_dart_openfeign/src/http/converter/http_message_converter.dart';
import 'package:fengwuxp_dart_openfeign/src/http/response_entity.dart';

import 'clinet_http_response.dart';

class HttpMessageConverterExtractor<T> implements ResponseExtractor<T> {
  List<HttpMessageConverter> _messageConverters;

  Serializer<T> _responseType;

  HttpMessageConverterExtractor(this._messageConverters, this._responseType);

  factory(List<HttpMessageConverter> messageConverters, [Serializer<T> responseType]) {
    return new HttpMessageConverterExtractor(messageConverters, responseType);
  }

  Future<T> extractData(ClientHttpResponse response, {Serializer serializer}) async {
    var responseWrapper = MessageBodyClientHttpResponseWrapper(response);
    if (!responseWrapper.hasMessageBody()) {
      return Future.value(null);
    }
    if (await responseWrapper.hasEmptyMessageBody()) {
      return Future.value(null);
    }

    final contentType = response.headers.contentType;
    for (HttpMessageConverter messageConverter in this._messageConverters) {
      if (messageConverter is GenericHttpMessageConverter) {
        if (messageConverter.canRead(contentType, serializer: serializer)) {
          return messageConverter.read<T>(response, serializer: serializer);
        }
      }
      if (this._responseType != null) {
        if (messageConverter.canRead(contentType, serializer: this._responseType)) {
          return messageConverter.read<T>(response, serializer: this._responseType);
        }
      }
    }
  }
}

class ResponseEntityResponseExtractor<T> implements ResponseExtractor<ResponseEntity<T>> {
  HttpMessageConverterExtractor<T> _delegate;

  ResponseEntityResponseExtractor([List<HttpMessageConverter> messageConverters, Serializer<T> responseType]) {
    if (messageConverters != null && messageConverters.isNotEmpty) {
      this._delegate = HttpMessageConverterExtractor(messageConverters, responseType);
    } else {
      this._delegate = null;
    }
  }

  factory([List<HttpMessageConverter> messageConverters, Serializer<T> responseType]) {
    return new ResponseEntityResponseExtractor(messageConverters, responseType);
  }

  Future<ResponseEntity<T>> extractData(ClientHttpResponse response, {Serializer serializer}) async {
    if (this._delegate != null) {
      T body = await this._delegate.extractData(response);
      return ResponseEntity<T>(response.statusCode, response.headers, body, response.statusText);
    } else {
      return ResponseEntity<T>(response.statusCode, response.headers, null, response.statusText);
    }
  }
}

class HeadResponseExtractor implements ResponseExtractor<HttpHeaders> {
  const HeadResponseExtractor();

  /// Extract data from the given {@code ClientHttpResponse} and return it.
  Future<HttpHeaders> extractData(ClientHttpResponse response, {Serializer serializer}) {
    return Future.value(response.headers);
  }
}

class OptionsForAllowResponseExtractor implements ResponseExtractor<Set<String>> {

  HeadResponseExtractor _headResponseExtractor = HeadResponseExtractor();

  factory() {
    return new OptionsForAllowResponseExtractor();
  }

  @override
  Future<Set<String>> extractData(ClientHttpResponse response, {Serializer serializer}) async {
    var headers = await this._headResponseExtractor.extractData(response, serializer: serializer);
    if (headers == null) {
      return Future.value(Set.from([]));
    }
    var header = headers.value("Access-Control-Allow-Methods");
    if (!StringUtils.hasText(header)) {
      return Future.value(Set.from([]));
    }
    return Future.value(Set.from(header.split(",")));
  }
}
