import 'dart:async';
import 'dart:io';

import 'package:fengwuxp_dart_openfeign/index.dart';
import 'package:fengwuxp_dart_openfeign/src/http/abstract_client_http_request.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client_http_response.dart';
import 'package:fengwuxp_dart_openfeign/src/http/converter/http_message_converter.dart';
import 'package:fengwuxp_dart_openfeign/src/http/http_client_exception.dart';
import 'package:fengwuxp_dart_openfeign/src/http/http_request_context.dart';
import 'package:fengwuxp_dart_openfeign/src/http/streamed_client_http_response.dart';
import 'package:fengwuxp_dart_openfeign/src/util/metadata_utils.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';

class RestClientHttpRequest extends AbstractClientHttpRequest {
  static const String _TAG = "RestClientHttpRequest";

  static final _log = Logger(_TAG);

  final List<HttpMessageConverter> httpMessageConverters;

  RestClientHttpRequest(Uri url, String method,
      {int? timeout,
      dynamic? requestBody,
      Map<String, String>? headers,
      List<HttpMessageConverter>? httpMessageConverters,
      HttpRequestContext? context})
      : this.httpMessageConverters = httpMessageConverters ?? [],
        super(url, method, timeout: timeout, requestBody: requestBody, headers: headers, context: context);

  @override
  Future<ClientHttpResponse> send() async {
    if (_log.isLoggable(Level.FINER)) {
      _log.finer("请求方法：${this.method} 请求url:${this.url} 请求头：${this.headers} 请求体：${this.requestBody}");
    }

    final request = Request(method, url);
    request.headers.addAll(headers);
    if (supportRequestBody(this.method)) {
      await _writeRequestBody(request);
    }

    return request
        .send()
        //TODO 超时处理
        // .timeout(Duration(milliseconds: timeout))
        .then((response) => new StreamedClientHttpResponse(response))
        .onError(
            (error, stackTrace) => Future.error(new HttpClientException(error.toString(), this, error), stackTrace));
  }

  Future<void> _writeRequestBody(Request request) async {
    final List<int> requestBytes = [];
    this.body.stream.listen(requestBytes.addAll);
    final contentType = ContentType.parse(this.headers[HttpHeaders.contentTypeHeader] as String);
    for (HttpMessageConverter messageConverter in this.httpMessageConverters) {
      if (messageConverter.canWrite(contentType)) {
        await messageConverter.write(requestBody, contentType, this);
      }
    }
    request.bodyBytes = requestBytes;
  }
}
