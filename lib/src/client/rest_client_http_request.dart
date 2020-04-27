import 'dart:io';

import 'package:fengwuxp_dart_openfeign/src/http/client/streamed_request.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client_http_request.dart';
import 'package:fengwuxp_dart_openfeign/src/http/clinet_http_response.dart';
import 'package:fengwuxp_dart_openfeign/src/http/converter/http_message_converter.dart';
import 'package:fengwuxp_dart_openfeign/src/utils/metadata_utils.dart';

class RestClientHttpRequest implements ClientHttpRequest {
  Uri _url;

  String _method;

  Map<String, String> _headers;

  List<HttpMessageConverter> _messageConverters;
  dynamic _requestBody;

  RestClientHttpRequest(
    Uri url,
    String method,
    List<HttpMessageConverter> messageConverters, {
    dynamic requestBody,
    Map<String, String> headers = const {},
  }) {
    this._url = url;
    this._method = method;
    this._messageConverters = messageConverters == null ? [] : messageConverters;
    this._requestBody = requestBody;
    this._headers = headers;
  }

  @override
  Future<ClientHttpResponse> send() async {
    var request = StreamedRequest(method, url);
    if (headers != null) {
      request.headers.addAll(headers);
    }
    if (supportRequestBody(request.method)) {
      final contentType = ContentType.parse(request.headers[HttpHeaders.contentTypeHeader]);
      for (HttpMessageConverter messageConverter in this._messageConverters) {
        if (messageConverter.canWrite(contentType)) {
          await messageConverter.write(_requestBody, contentType, request);
        }
      }
    }
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
  // TODO: implement method
  String get method => _method;

  @override
  Map<String, String> get headers => _headers;
}
