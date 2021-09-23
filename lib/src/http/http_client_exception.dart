import 'package:fengwuxp_dart_openfeign/src/http/client_http_request.dart';

/// An exception caused by an error in a pkg/http client.
class HttpClientException implements Exception {
  /// error message
  final String message;

  ///  request object
  final ClientHttpRequest request;

  final Object? cause;

  HttpClientException(this.message, this.request, this.cause);

  factory(String message, ClientHttpRequest request) {
    HttpClientException(message, request, null);
  }

  @override
  String toString() => message;
}

/// request timeout exception
class ClientTimeOutException extends HttpClientException {
  ClientTimeOutException(String message, ClientHttpRequest request, Object? cause) : super(message, request, cause);

  factory(String message, ClientHttpRequest request) {
    ClientTimeOutException(message, request, null);
  }
}
