import 'package:fengwuxp_dart_openfeign/index.dart';

import 'interceptor_registration.dart';

class FeignClientExecutorInterceptorRegistration extends InterceptorRegistration {
  FeignClientExecutorInterceptorRegistration(FeignClientExecutorInterceptor clientInterceptor)
      : super(clientInterceptor);

  MappedFeignClientExecutorInterceptor getInterceptor() {
    return MappedFeignClientExecutorInterceptor(this.interceptor,
        includePatterns: this.includePatterns,
        excludePatterns: this.excludePatterns,
        includeMethods: this.includeMethods,
        excludeMethods: this.excludeMethods,
        includeHeaders: this.includeHeaders,
        excludeHeaders: this.excludeHeaders);
  }
}
