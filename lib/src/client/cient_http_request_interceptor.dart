import 'dart:ffi';
import '../http/client_http_request.dart';

abstract class ClientHttpRequestInterceptor {

  Future<Void> interceptor(ClientHttpRequest request);
}
