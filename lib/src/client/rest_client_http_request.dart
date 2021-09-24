import 'dart:async';
import 'dart:io';

import 'package:fengwuxp_dart_openfeign/index.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client_http_request.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client_http_response.dart';
import 'package:fengwuxp_dart_openfeign/src/http/converter/http_message_converter.dart';
import 'package:fengwuxp_dart_openfeign/src/http/http_client_exception.dart';
import 'package:fengwuxp_dart_openfeign/src/http/http_request_context.dart';
import 'package:fengwuxp_dart_openfeign/src/http/streamed_client_http_response.dart';
import 'package:fengwuxp_dart_openfeign/src/utils/metadata_utils.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';

class RestClientHttpRequest extends AbstractHttpRequestContext implements ClientHttpRequest {
  static const String _TAG = "RestClientHttpRequest";

  static final _log = Logger(_TAG);

  Uri url;

  final String method;

  final int timeout;

  final dynamic requestBody;

  final Map<String, String> headers;

  final List<HttpMessageConverter> messageConverters;

  /// The controller for [sink], from which [BaseRequest] will read data for
  /// [finalize].
  final StreamController<List<int>> _controller;

  RestClientHttpRequest(Uri url, String method, int? timeout, dynamic? requestBody, Map<String, String>? headers,
      List<HttpMessageConverter>? messageConverters,
      {Map<String, dynamic>? attributes})
      : this.url = url,
        this.method = method,
        this.timeout = timeout ?? 10000,
        this.requestBody = requestBody,
        this.headers = headers ?? {},
        this.messageConverters = messageConverters ?? [],
        this._controller = StreamController<List<int>>(sync: true),
        super(attributes);

  @override
  Future<ClientHttpResponse> send() async {
    if (_log.isLoggable(Level.FINER)) {
      _log.finer("请求方法：${this.method} 请求url:${this.url} 请求头：${this.headers} 请求体：${this.requestBody}");
    }
    final request = Request(method, url);
    request.headers.addAll(headers);
    if (supportRequestBody(this.method)) {
      List<int> requestBytes = [];
      this._controller.stream.listen(requestBytes.addAll);
      final contentType = ContentType.parse(this.headers[HttpHeaders.contentTypeHeader] as String);
      for (HttpMessageConverter messageConverter in this.messageConverters) {
        if (messageConverter.canWrite(contentType)) {
          await messageConverter.write(requestBody, contentType, this);
        }
      }
      request.bodyBytes = requestBytes;
    }

    return request.send().then((response) => new StreamedClientHttpResponse(response)).onError((error, stackTrace) {
      return Future.error(new HttpClientException(error.toString(), this, error), stackTrace);
    });
  }

  @override
  void uri(Uri uri) {
    this.url = uri;
  }

  @override
  StreamSink<List<int>> get body => _controller;
}
