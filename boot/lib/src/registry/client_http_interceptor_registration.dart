import 'package:fengwuxp_dart_openfeign/index.dart';

import 'interceptor_registration.dart';

class ClientHttpInterceptorRegistration extends InterceptorRegistration {

  ClientHttpInterceptorRegistration(ClientHttpRequestInterceptor clientInterceptor) : super(clientInterceptor);

  MappedClientHttpRequestInterceptor getInterceptor() {
    return new MappedClientHttpRequestInterceptor(this.interceptor,
        includePatterns: this.includePatterns,
        excludePatterns: this.excludePatterns,
        includeMethods: this.includeMethods,
        excludeMethods: this.excludeMethods,
        includeHeaders: this.includeHeaders,
        excludeHeaders: this.excludeHeaders);
  }
}
