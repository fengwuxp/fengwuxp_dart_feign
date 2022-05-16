import 'dart:io';

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
import 'package:fengwuxp_dart_openfeign/src/http/http_request_context.dart';
import 'package:fengwuxp_dart_openfeign/src/http/response_entity.dart';
import 'package:fengwuxp_dart_openfeign/src/util/metadata_utils.dart';

import 'response_extractor.dart';
import 'rest_operations.dart';

class RestTemplate implements RestOperations {
  final String defaultProduce;

  final UriTemplateHandler uriTemplateHandler;

  final List<HttpMessageConverter> httpMessageConverters;

  final List<ClientHttpRequestInterceptor> interceptors;

  const RestTemplate({
    this.defaultProduce = HttpMediaType.FORM_DATA,
    this.uriTemplateHandler = const DefaultUriTemplateHandler(),
    this.httpMessageConverters = const [],
    this.interceptors = const [],
  });

  /// GET
  @override
  Future<T> getForObject<T>(String url, Type responseType,
      {Map<String, dynamic>? queryParams,
      List<dynamic>? pathVariables,
      Map<String, String>? headers,
      int? timeout,
      HttpRequestContext? context}) {
    return this.execute(url, HttpMethod.GET, this._httpMessageConverterExtractor<T>(responseType),
        queryParams: queryParams, pathVariables: pathVariables, headers: headers, timeout: timeout, context: context);
  }

  @override
  Future<ResponseEntity<T>> getForEntity<T>(String url,
      {Type? responseType,
      Map<String, dynamic>? queryParams,
      List<dynamic>? pathVariables,
      Map<String, String>? headers,
      int? timeout,
      HttpRequestContext? context}) {
    return this.execute(url, HttpMethod.GET, this._responseEntityResponseExtractor(responseType),
        queryParams: queryParams, pathVariables: pathVariables, headers: headers, timeout: timeout, context: context);
  }

  /// HEAD

  @override
  Future<Map<String, String>> headForHeaders(String url,
      {Map<String, dynamic>? queryParams,
      List<dynamic>? pathVariables,
      Map<String, String>? headers,
      int? timeout,
      HttpRequestContext? context}) {
    return this.execute(url, HttpMethod.HEAD, this._headResponseExtractor(),
        queryParams: queryParams, pathVariables: pathVariables, headers: headers, timeout: timeout, context: context);
  }

  /// POST

  @override
  Future<T> postForObject<T>(String url, dynamic request, Type responseType,
      {Map<String, dynamic>? queryParams,
      List<dynamic>? pathVariables,
      Map<String, String>? headers,
      int? timeout,
      HttpRequestContext? context}) {
    return this.execute(url, HttpMethod.POST, this._httpMessageConverterExtractor<T>(responseType),
        queryParams: queryParams, pathVariables: pathVariables, headers: headers, timeout: timeout, context: context);
  }

  @override
  Future<ResponseEntity<T>> postForEntity<T>(String url, dynamic request,
      {Type? responseType,
      Map<String, dynamic>? queryParams,
      List<dynamic>? pathVariables,
      Map<String, String>? headers,
      int? timeout,
      HttpRequestContext? context}) {
    return this.execute(url, HttpMethod.POST, this._responseEntityResponseExtractor(responseType),
        queryParams: queryParams, pathVariables: pathVariables, headers: headers, timeout: timeout, context: context);
  }

  @override
  Future<void> put(String url, dynamic request,
      {Map<String, dynamic>? queryParams,
      List<dynamic>? pathVariables,
      Map<String, String>? headers,
      int? timeout,
      HttpRequestContext? context}) {
    return this.execute(url, HttpMethod.PUT, new VoidResponseExtractor(),
        queryParams: queryParams, pathVariables: pathVariables, headers: headers, timeout: timeout, context: context);
  }

  @override
  Future<T> patchForObject<T>(String url, dynamic request,
      {Type? responseType,
      Map<String, dynamic>? queryParams,
      List<dynamic>? pathVariables,
      Map<String, String>? headers,
      int? timeout,
      HttpRequestContext? context}) {
    return this.execute(url, HttpMethod.PATCH, this._httpMessageConverterExtractor(responseType),
        queryParams: queryParams, pathVariables: pathVariables, headers: headers, timeout: timeout, context: context);
  }

  @override
  Future<void> delete(String url,
      {Map<String, dynamic>? queryParams,
      List<dynamic>? pathVariables,
      Map<String, String>? headers,
      int? timeout,
      HttpRequestContext? context}) {
    return this.execute(url, HttpMethod.DELETE, new VoidResponseExtractor(),
        queryParams: queryParams, pathVariables: pathVariables, headers: headers, timeout: timeout, context: context);
  }

  @override
  Future<Set<String>> optionsForAllow(String url,
      {Map<String, dynamic>? queryParams,
      List<dynamic>? pathVariables,
      Map<String, String>? headers,
      int? timeout,
      HttpRequestContext? context}) async {
    return this.execute(url, HttpMethod.DELETE, OptionsForAllowResponseExtractor(),
        queryParams: queryParams, pathVariables: pathVariables, timeout: timeout, context: context);
  }

  @override
  Future<T> execute<T>(String url, String method, ResponseExtractor<T> responseExtractor,
      {dynamic request,
      Map<String, dynamic>? queryParams,
      List<dynamic>? pathVariables,
      Map<String, String>? headers,
      int? timeout,
      HttpRequestContext? context}) async {
    // 处理url， 查询参数
    final uri = uriTemplateHandler.expand(url, queryParams: queryParams ?? {}, pathVariables: pathVariables ?? []);
    final Map<String, String> requestHeaders = Map.of(headers ?? {});
    if (supportRequestBody(method) && !StringUtils.hasText(requestHeaders[HttpHeaders.contentTypeHeader])) {
      requestHeaders[HttpHeaders.contentTypeHeader] = this.defaultProduce;
    }

    final clientHttpRequest = RestClientHttpRequest(uri, method,
        timeout: timeout,
        requestBody: request,
        headers: requestHeaders,
        httpMessageConverters: httpMessageConverters,
        context: context);
    // 处理请求体
    ClientHttpResponse clientHttpResponse;
    try {
      await this._preHandleInterceptor(clientHttpRequest);
      clientHttpResponse = await clientHttpRequest.send();
    } catch (e) {
      // 请求异常处理
      throw e;
    }

    try {
      final result = await responseExtractor.extractData(clientHttpResponse) as T;
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

  Future<void> _preHandleInterceptor(ClientHttpRequest clientHttpRequest) async {
    final interceptors = this.interceptors;
    final length = interceptors.length;
    for (int i = 0; i < length; i++) {
      await interceptors[i].interceptor(clientHttpRequest);
    }
    return Future.value();
  }

  HttpMessageConverterExtractor<T> _httpMessageConverterExtractor<T>(Type? responseType) {
    return HttpMessageConverterExtractor<T>(this.httpMessageConverters, responseType: responseType);
  }

  ResponseEntityResponseExtractor<T> _responseEntityResponseExtractor<T>(Type? responseType) {
    return ResponseEntityResponseExtractor<T>(this.httpMessageConverters, responseType);
  }

  HeadResponseExtractor _headResponseExtractor<T>() {
    return HeadResponseExtractor();
  }
}
