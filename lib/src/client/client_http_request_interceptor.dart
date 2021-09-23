import '../http/client_http_request.dart';

abstract class ClientHttpRequestInterceptor {

  Future<ClientHttpRequest> interceptor(ClientHttpRequest request);
}
