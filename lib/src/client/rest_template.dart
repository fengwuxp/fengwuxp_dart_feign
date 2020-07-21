import 'dart:io';

import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/src/client/client_http_request_interceptor.dart';
import 'package:fengwuxp_dart_openfeign/src/client/default_url_template_handler.dart';
import 'package:fengwuxp_dart_openfeign/src/client/rest_client_http_request.dart';
import 'package:fengwuxp_dart_openfeign/src/client/rest_response_extractor.dart';
import 'package:fengwuxp_dart_openfeign/src/client/uri_template_handler.dart';
import 'package:fengwuxp_dart_openfeign/src/constant/http/http_media_type.dart';
import 'package:fengwuxp_dart_openfeign/src/constant/http/http_method.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client_http_request.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client_http_response.dart';
import 'package:fengwuxp_dart_openfeign/src/http/converter/http_message_converter.dart';
import 'package:fengwuxp_dart_openfeign/src/http/response_entity.dart';

import 'response_extractor.dart';
import 'rest_operations.dart';

class RestTemplate implements RestOperations {
  final String defaultProduce;

  final UriTemplateHandler uriTemplateHandler;

  final List<HttpMessageConverter> messageConverters;

  final List<ClientHttpRequestInterceptor> interceptors;

  const RestTemplate({
    this.defaultProduce = HttpMediaType.FORM_DATA,
    this.uriTemplateHandler = const DefaultUriTemplateHandler(),
    this.messageConverters = const [],
    this.interceptors = const [],
  }); // GET

  @override
  Future<T> getForObject<T>(String url, Serializer<T> responseType,
      {Map<String, dynamic> queryParams, List<dynamic> pathVariables, Map<String, String> headers, int timeout}) {
    return this.execute(url, HttpMethod.GET, this._httpMessageConverterExtractor<T>(responseType),
        queryParams: queryParams, pathVariables: pathVariables, headers: headers, timeout: timeout);
  }

  @override
  Future<ResponseEntity<T>> getForEntity<T>(String url,
      {Serializer<T> responseType,
      Map<String, dynamic> queryParams,
      List<dynamic> pathVariables,
      Map<String, String> headers,
      int timeout}) {
    return this.execute(url, HttpMethod.GET, this._responseEntityResponseExtractor(responseType),
        queryParams: queryParams, pathVariables: pathVariables, headers: headers, timeout: timeout);
  }

  // HEAD

  @override
  Future<Map<String, String>> headForHeaders(String url,
      {Map<String, dynamic> queryParams, List<dynamic> pathVariables, Map<String, String> headers, int timeout}) {
    return this.execute(url, HttpMethod.HEAD, this._headResponseExtractor(),
        queryParams: queryParams, pathVariables: pathVariables, headers: headers, timeout: timeout);
  }

  // POST

  @override
  Future<T> postForObject<T>(String url, dynamic request, Serializer<T> responseType,
      {Map<String, dynamic> queryParams, List<dynamic> pathVariables, Map<String, String> headers, int timeout}) {
    return this.execute(url, HttpMethod.POST, this._httpMessageConverterExtractor<T>(responseType),
        queryParams: queryParams, pathVariables: pathVariables, headers: headers, timeout: timeout);
  }

  @override
  Future<ResponseEntity<T>> postForEntity<T>(String url, dynamic request,
      {Serializer<T> responseType,
      Map<String, dynamic> queryParams,
      List<dynamic> pathVariables,
      Map<String, String> headers,
      int timeout}) {
    return this.execute(url, HttpMethod.POST, this._responseEntityResponseExtractor(responseType),
        queryParams: queryParams, pathVariables: pathVariables, headers: headers, timeout: timeout);
  }

  @override
  Future<void> put(String url, dynamic request,
      {Map<String, dynamic> queryParams, List<dynamic> pathVariables, Map<String, String> headers, int timeout}) {
    return this.execute(url, HttpMethod.PUT, null,
        queryParams: queryParams, pathVariables: pathVariables, headers: headers, timeout: timeout);
  }

  @override
  Future<T> patchForObject<T>(String url, dynamic request, Serializer<T> responseType,
      {Map<String, dynamic> queryParams, List<dynamic> pathVariables, Map<String, String> headers, int timeout}) {
    return this.execute(url, HttpMethod.PATCH, this._httpMessageConverterExtractor(responseType),
        queryParams: queryParams, pathVariables: pathVariables, headers: headers, timeout: timeout);
  }

  @override
  Future<void> delete(String url,
      {Map<String, dynamic> queryParams, List<dynamic> pathVariables, Map<String, String> headers, int timeout}) {
    return this.execute(url, HttpMethod.DELETE, null,
        queryParams: queryParams, pathVariables: pathVariables, headers: headers, timeout: timeout);
  }

  @override
  Future<Set<String>> optionsForAllow(String url,
      {Map<String, dynamic> queryParams, List<dynamic> pathVariables, int timeout}) async {
    return this.execute(url, HttpMethod.DELETE, OptionsForAllowResponseExtractor(),
        queryParams: queryParams, pathVariables: pathVariables, timeout: timeout);
  }

  @override
  Future<T> execute<T>(String url, String method, ResponseExtractor<T> responseExtractor,
      {dynamic request,
      Map<String, dynamic> queryParams,
      List<Object> pathVariables,
      int timeout,
      Map<String, String> headers = const {}}) async {
    // 处理url， 查询参数
    var uri = uriTemplateHandler.expand(url, queryParams: queryParams, pathVariables: pathVariables);
    var requestHttpHeaders = Map.of(headers);
    if (!StringUtils.hasText(requestHttpHeaders[HttpHeaders.contentTypeHeader])) {
      requestHttpHeaders[HttpHeaders.contentTypeHeader] = this.defaultProduce;
    }

    var clientHttpRequest = RestClientHttpRequest(uri, method, messageConverters,
        requestBody: request, headers: requestHttpHeaders, timeout: timeout);
    // 处理请求体
    ClientHttpResponse clientHttpResponse;
    try {
      await this._preHandleInterceptor(clientHttpRequest);
      clientHttpResponse = await clientHttpRequest.send();
    } catch (e) {
      // 请求异常处理
      throw e;
    }

    if (responseExtractor != null) {
      try {
        var result = await responseExtractor.extractData(clientHttpResponse);
        if (clientHttpResponse.ok) {
          return result;
        } else {
          // http error response
          return Future.error(ResponseEntity(
              clientHttpResponse.statusCode, clientHttpResponse.headers, result, clientHttpResponse.reasonPhrase));
        }
      } catch (e) {
        return Future.error(e);
      }
    }
    return Future.value(clientHttpResponse as T);
  }

  void _preHandleInterceptor(ClientHttpRequest clientHttpRequest) async {
    final interceptors = this.interceptors;
    if (interceptors == null) {
      return;
    }
    final length = interceptors.length;
    for (int i = 0; i < length; i++) {
      await interceptors[i].interceptor(clientHttpRequest);
    }
  }

  HttpMessageConverterExtractor<T> _httpMessageConverterExtractor<T>(Serializer<T> responseType) {
    return HttpMessageConverterExtractor<T>(this.messageConverters, responseType: responseType);
  }

  ResponseEntityResponseExtractor<T> _responseEntityResponseExtractor<T>(Serializer<T> responseType) {
    return ResponseEntityResponseExtractor<T>(this.messageConverters, responseType);
  }

  HeadResponseExtractor _headResponseExtractor<T>() {
    return HeadResponseExtractor();
  }
}
