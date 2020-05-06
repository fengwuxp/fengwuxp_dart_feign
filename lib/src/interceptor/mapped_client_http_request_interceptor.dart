import 'package:fengwuxp_dart_openfeign/src/client/client_http_request_interceptor.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client_http_request.dart';
import 'package:fengwuxp_dart_openfeign/src/interceptor/mapped_interceptor.dart';

class MappedClientHttpRequestInterceptor extends MappedInterceptor implements ClientHttpRequestInterceptor {
  ClientHttpRequestInterceptor _clientInterceptor;

  MappedClientHttpRequestInterceptor(ClientHttpRequestInterceptor clientHttpRequestInterceptor,
      {List<String> includePatterns,
      List<String> excludePatterns,
      List<String> includeMethods,
      List<String> excludeMethods,
      List<List<String>> includeHeaders,
      List<List<String>> excludeHeaders})
      : super(
            includePatterns: includePatterns,
            excludePatterns: excludePatterns,
            includeMethods: includeMethods,
            excludeMethods: excludeMethods,
            includeHeaders: includeHeaders,
            excludeHeaders: excludeHeaders) {
    this._clientInterceptor = clientHttpRequestInterceptor;
  }

  Future<void> interceptor(ClientHttpRequest request) {
    return this._clientInterceptor.interceptor(request);
  }
}
