import 'dart:ffi';
import 'dart:io';

import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_openfeign/src/client/clinet_http_response.dart';
import 'package:fengwuxp_dart_openfeign/src/client/response_extractor.dart';
import 'package:fengwuxp_dart_openfeign/src/http/response_entity.dart';
import 'package:flutter/cupertino.dart';

/// Interface specifying a basic set of RESTful operations.
/// Implemented by [RestTemplate]. Not often used directly, but a useful
/// option to enhance testability, as it can easily be mocked or stubbed.
abstract class RestOperations {
  // GET

  /// Retrieve a representation by doing a GET on the specified URL.
  /// The response (if any) is converted and returned.
  /// <p>URI Template variables are expanded using the given URI variables, if any.
  /// [url] the Url
  /// [pathVariables] String or num of List,  the variables to expand the template
  /// [queryParams]  Strong or num of Map value, the variables to expand the template
  /// return [T]
  Future<T> getForObject<T>(String url, Serializer<T> responseType,
      {Map<String, dynamic> queryParams, List<dynamic> pathVariables});

  ///  Retrieve a representation by doing a GET on the URL .
  ///  The response is converted and stored in an [ClientHttpResponse].
  /// [url] the Url
  /// [pathVariables] String or num of List,  the variables to expand the template
  /// [queryParams]  Strong or num of Map value, the variables to expand the template
  /// return [ClientHttpResponse]
  Future<ResponseEntity<T>> getForEntity<T>(String url,
      {Serializer<T> responseType, Map<String, dynamic> queryParams, List<dynamic> pathVariables});

  // HEAD

  /// Retrieve all headers of the resource specified by the URI template.
  /// <p>URI Template variables are expanded using the given URI variables, if any.
  /// [url] the Url
  /// [pathVariables] String or num of List,  the variables to expand the template
  /// [queryParams]  Strong or num of Map value, the variables to expand the template
  /// return http response headers
  Future<HttpHeaders> headForHeaders(String url, {Map<String, dynamic> queryParams, List<dynamic> pathVariables});

  // POST

  /// Create a new resource by POSTing the given object to the URI template,
  /// and returns the representation found in the response.
  /// <p>URI Template variables are expanded using the given URI variables, if any.
  /// <p>The {@code request} parameter can be a {@link HttpEntity} in order to
  /// add additional HTTP headers to the request.
  /// <p>The body of the entity, or {@code request} itself, can be a
  /// {@link org.springframework.util.MultiValueMap MultiValueMap} to create a multipart request.
  /// The values in the {@code MultiValueMap} can be any Object representing the body of the part,
  /// or an {@link org.springframework.http.HttpEntity HttpEntity} representing a part with body
  /// and headers.
  /// [url] the URL
  /// [request]  the Object to be POSTed (may be {@code null})
  /// [responseType] responseType the type of the return value
  /// [pathVariables]  the variables to expand the template
  /// [queryParams]  the variables to expand the template
  /// return [T]
  Future<T> postForObject<T>(String url, dynamic request, Serializer<T> responseType,
      {Map<String, dynamic> queryParams, List<dynamic> pathVariables});

  /// Create a new resource by POSTing the given object to the URI template,
  /// and returns the representation found in the response.
  /// <p>URI Template variables are expanded using the given URI variables, if any.
  /// <p>The {@code request} parameter can be a {@link HttpEntity} in order to
  /// add additional HTTP headers to the request.
  /// <p>The body of the entity, or {@code request} itself, can be a
  /// {@link org.springframework.util.MultiValueMap MultiValueMap} to create a multipart request.
  /// The values in the {@code MultiValueMap} can be any Object representing the body of the part,
  /// or an {@link org.springframework.http.HttpEntity HttpEntity} representing a part with body
  /// and headers.
  /// [url] the URL
  /// [request]  the Object to be POSTed (may be {@code null})
  /// [responseType] responseType the type of the return value
  /// [pathVariables]  the variables to expand the template
  /// [queryParams]  the variables to expand the template
  /// return [ClientHttpResponse]
  Future<ResponseEntity<T>> postForEntity<T>(String url, dynamic request,
      {Serializer<T> responseType, Map<String, dynamic> queryParams, List<dynamic> pathVariables});

  /// Create or update a resource by PUTting the given object to the URI.
  /// <p>URI Template variables are expanded using the given URI variables, if any.
  /// <p>The {@code request} parameter can be a {@link HttpRequest} in order to
  /// add additional HTTP headers to the request.
  Future<Void> put(String url, @required dynamic request,
      {Map<String, dynamic> queryParams, List<dynamic> pathVariables});

  /// Update a resource by PATCHing the given object to the URI template,
  /// and return the representation found in the response.
  /// <p>URI Template variables are expanded using the given URI variables, if any.
  /// <p>The {@code request} parameter can be a {@link HttpEntity} in order to
  /// add additional HTTP headers to the request.
  /// <p><b>NOTE: The standard JDK HTTP library does not support HTTP PATCH.
  /// You need to use the Apache HttpComponents or OkHttp request factory.</b>
  /// [url] the URL
  /// [request]  the Object to be POSTed (may be {@code null})
  /// [responseType] responseType the type of the return value
  /// [pathVariables]  the variables to expand the template
  /// [queryParams]  the variables to expand the template
  /// return [T]
  Future<T> patchForObject<T>(String url, dynamic request, Serializer<T> responseType,
      {Map<String, dynamic> queryParams, List<dynamic> pathVariables});

  /// Delete the resources at the specified URI.
  /// <p>URI Template variables are expanded using the given URI variables, if any.
  /// [url] the URL
  /// [pathVariables]  the variables to expand the template
  Future<Void> delete(String url, {Map<String, dynamic> queryParams, List<dynamic> pathVariables});

  /// Return the value of the Allow header for the given URI.
  /// <p>URI Template variables are expanded using the given map.
  Future<Set<String>> optionsForAllow(String url, {Map<String, dynamic> queryParams, List<dynamic> pathVariables});

  /// Execute the HTTP method to the given URI template, preparing the request with the
  /// [url] the URL
  /// [request]  request body
  /// [responseExtractor] responseType the type of the return value
  /// [pathVariables]  the variables to expand the template
  /// [queryParams]  the variables to expand the template
  Future<T> execute<T>(String url, String method, ResponseExtractor<T> responseExtractor,
      {dynamic request, Map<String, dynamic> queryParams, List<Object> pathVariables});
}
