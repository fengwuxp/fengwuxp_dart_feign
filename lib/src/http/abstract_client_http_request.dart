import 'dart:async';

import 'package:fengwuxp_dart_openfeign/index.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client_http_request.dart';
import 'package:fengwuxp_dart_openfeign/src/http/converter/http_message_converter.dart';
import 'package:fengwuxp_dart_openfeign/src/http/http_request_context.dart';

abstract class AbstractClientHttpRequest extends DefaultHttpRequestContext implements ClientHttpRequest {
  Uri url;

  final String method;

  final int timeout;

  final dynamic requestBody;

  final Map<String, String> headers;

  /// The controller for [sink], from which [BaseRequest] will read data for
  /// [finalize].
  final StreamController<List<int>> _controller;

  AbstractClientHttpRequest(Uri url, String method,
      {int? timeout,
      dynamic? requestBody,
      Map<String, String>? headers,
      List<HttpMessageConverter>? httpMessageConverters,
      HttpRequestContext? context})
      : this.url = url,
        this.method = method,
        this.timeout = timeout ?? 10000,
        this.requestBody = requestBody,
        this.headers = headers ?? {},
        this._controller = StreamController<List<int>>(sync: true),
        super(context?.attributes);

  @override
  void uri(Uri uri) {
    this.url = uri;
  }

  @override
  StreamController<List<int>> get body => _controller;
}
