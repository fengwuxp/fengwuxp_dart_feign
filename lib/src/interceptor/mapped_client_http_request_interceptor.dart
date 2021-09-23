import 'package:fengwuxp_dart_openfeign/src/client/client_http_request_interceptor.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client_http_request.dart';
import 'package:fengwuxp_dart_openfeign/src/interceptor/mapped_interceptor.dart';

class MappedClientHttpRequestInterceptor extends MappedInterceptor implements ClientHttpRequestInterceptor {
  final ClientHttpRequestInterceptor _clientInterceptor;

  MappedClientHttpRequestInterceptor(ClientHttpRequestInterceptor clientHttpRequestInterceptor,
      {List<String> includePatterns = const [],
      List<String> excludePatterns = const [],
      List<String> includeMethods = const [],
      List<String> excludeMethods = const [],
      List<List<String>> includeHeaders = const [],
      List<List<String>> excludeHeaders = const []})
      : this._clientInterceptor = clientHttpRequestInterceptor,
        super(
            includePatterns: includePatterns,
            excludePatterns: excludePatterns,
            includeMethods: includeMethods,
            excludeMethods: excludeMethods,
            includeHeaders: includeHeaders,
            excludeHeaders: excludeHeaders);

  @override
  Future<ClientHttpRequest> interceptor(ClientHttpRequest request) {
    return this._clientInterceptor.interceptor(request);
  }
}
