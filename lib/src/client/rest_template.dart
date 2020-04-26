import 'dart:ffi';
import 'dart:io';

import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_openfeign/src/client/default_url_template_handler.dart';
import 'package:fengwuxp_dart_openfeign/src/client/rest_response_extractor.dart';
import 'package:fengwuxp_dart_openfeign/src/client/uri_template_handler.dart';
import 'package:fengwuxp_dart_openfeign/src/constant/http/http_method.dart';
import 'package:fengwuxp_dart_openfeign/src/http/converter/http_message_converter.dart';
import 'package:fengwuxp_dart_openfeign/src/http/response_entity.dart';
import 'package:meta/meta.dart';

import 'response_extractor.dart';
import 'rest_operations.dart';

class RestTemplate implements RestOperations {
  final UriTemplateHandler uriTemplateHandler;

  final List<HttpMessageConverter> messageConverters;

  const RestTemplate({
    this.uriTemplateHandler = const DefaultUriTemplateHandler(),
    this.messageConverters,
  }); // GET

  @override
  Future<T> getForObject<T>(String url, Serializer<T> responseType,
      {Map<String, dynamic> queryParams, List<dynamic> pathVariables}) {
    return this.execute(url, HttpMethod.GET, this._httpMessageConverterExtractor<T>(responseType));
  }

  @override
  Future<ResponseEntity<T>> getForEntity<T>(String url,
      {Serializer<T> responseType, Map<String, dynamic> queryParams, List<dynamic> pathVariables}) {
    return this.execute(url, HttpMethod.GET, this._responseEntityResponseExtractor(responseType),
        queryParams: queryParams, pathVariables: pathVariables);
  }

  // HEAD

  @override
  Future<HttpHeaders> headForHeaders(String url, {Map<String, dynamic> queryParams, List<dynamic> pathVariables}) {
    return this.execute(url, HttpMethod.HEAD, this._headResponseExtractor(),
        queryParams: queryParams, pathVariables: pathVariables);
  }

  // POST

  @override
  Future<T> postForObject<T>(String url, dynamic request, Serializer<T> responseType,
      {Map<String, dynamic> queryParams, List<dynamic> pathVariables}) {
    return this.execute(url, HttpMethod.POST, this._httpMessageConverterExtractor<T>(responseType),
        queryParams: queryParams, pathVariables: pathVariables);
  }

  @override
  Future<ResponseEntity<T>> postForEntity<T>(String url, dynamic request,
      {Serializer<T> responseType, Map<String, dynamic> queryParams, List<dynamic> pathVariables}) {
    return this.execute(url, HttpMethod.POST, this._responseEntityResponseExtractor(responseType),
        queryParams: queryParams, pathVariables: pathVariables);
  }

  @override
  Future<Void> put(@required String url, dynamic request,
      {Map<String, dynamic> queryParams, List<dynamic> pathVariables}) {
    return this.execute(url, HttpMethod.PUT, null, queryParams: queryParams, pathVariables: pathVariables);
  }

  @override
  Future<T> patchForObject<T>(String url, dynamic request, Serializer<T> responseType,
      {Map<String, dynamic> queryParams, List<dynamic> pathVariables}) {
    return this.execute(url, HttpMethod.PATCH, this._httpMessageConverterExtractor(responseType),
        queryParams: queryParams, pathVariables: pathVariables);
  }

  @override
  Future<Void> delete(String url, {Map<String, dynamic> queryParams, List<dynamic> pathVariables}) {
    return this.execute(url, HttpMethod.DELETE, null, queryParams: queryParams, pathVariables: pathVariables);
  }

  @override
  Future<Set<String>> optionsForAllow(String url,
      {Map<String, dynamic> queryParams, List<dynamic> pathVariables}) async {
    return this.execute(url, HttpMethod.DELETE, OptionsForAllowResponseExtractor(),
        queryParams: queryParams, pathVariables: pathVariables);
  }

  @override
  Future<T> execute<T>(String url, String method, ResponseExtractor<T> responseExtractor,
      {dynamic request, Map<String, dynamic> queryParams, List<Object> pathVariables}) {

    var uri = uriTemplateHandler.expand(url, queryParams: queryParams, pathVariables: pathVariables);

    //

    return responseExtractor != null ? responseExtractor.extractData(null) : null;
  }

  HttpMessageConverterExtractor<T> _httpMessageConverterExtractor<T>(Serializer<T> responseType) {
    return HttpMessageConverterExtractor<T>(this.messageConverters, responseType);
  }

  ResponseEntityResponseExtractor<T> _responseEntityResponseExtractor<T>(Serializer<T> responseType) {
    return ResponseEntityResponseExtractor<T>(this.messageConverters, responseType);
  }

  HeadResponseExtractor _headResponseExtractor<T>() {
    return HeadResponseExtractor();
  }
}
