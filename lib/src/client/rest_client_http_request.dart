import 'dart:io';

import 'package:fengwuxp_dart_openfeign/index.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client/streamed_request.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client_http_request.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client_http_response.dart';
import 'package:fengwuxp_dart_openfeign/src/http/converter/http_message_converter.dart';
import 'package:fengwuxp_dart_openfeign/src/utils/metadata_utils.dart';
import 'package:logging/logging.dart';

class RestClientHttpRequest implements ClientHttpRequest {
  static const String _TAG = "RestClientHttpRequest";
  static var _log = Logger(_TAG);

  Uri _url;

  String _method;

  Map<String, String> _headers;

  List<HttpMessageConverter> _messageConverters;

  dynamic _requestBody;

  int _timeout;

  RestClientHttpRequest(
    Uri url,
    String method,
    List<HttpMessageConverter> messageConverters, {
    int timeout,
    dynamic requestBody,
    Map<String, String> headers = const {},
  }) {
    this._url = url;
    this._method = method;
    this._timeout = timeout ?? -1;
    this._messageConverters = messageConverters == null ? [] : messageConverters;
    this._requestBody = requestBody;
    this._headers = headers;
  }

  @override
  Future<ClientHttpResponse> send() async {
    var request = StreamedRequest(method: method, url: url);
    if (headers != null) {
      request.headers.addAll(headers);
    }
    _log.finer("请求方法：${request.method} 请求url:${request.url} 请求体：${request.body} 请求头：${request.headers}");
    if (supportRequestBody(request.method)) {
      final contentType = ContentType.parse(request.headers[HttpHeaders.contentTypeHeader]);
      for (HttpMessageConverter messageConverter in this._messageConverters) {
        if (messageConverter.canWrite(contentType)) {
          await messageConverter.write(_requestBody, contentType, request);
        }
      }
    }
    // 移除掉请求id
    removeRequestId(request.headers);

    request.body.close();
    return request.send();
  }

  @override
  void uri(Uri uri) {
    this._url = uri;
  }

  @override
  Uri get url => _url;

  @override
  // TODO: implement timeout
  int get timeout => this._timeout;

  @override
  // TODO: implement method
  String get method => _method;

  @override
  Map<String, String> get headers => _headers;
}
