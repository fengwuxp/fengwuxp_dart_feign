import '../http/client_http_request.dart';

abstract class ClientHttpRequestInterceptor {

  Future<void> interceptor(ClientHttpRequest request);
}
