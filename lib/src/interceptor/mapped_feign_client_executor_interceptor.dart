import 'package:fengwuxp_dart_openfeign/src/executor/feign_client_executor_interceptor.dart';

import '../feign_request_options.dart';
import 'mapped_interceptor.dart';

class MappedFeignClientExecutorInterceptor<T extends FeignRequestBaseOptions> extends MappedInterceptor
    implements FeignClientExecutorInterceptor<T> {
  FeignClientExecutorInterceptor<T> _feignClientExecutorInterceptor;

  MappedFeignClientExecutorInterceptor(FeignClientExecutorInterceptor<T> feignClientExecutorInterceptor,
      {List<String> includePatterns,
      List<String> excludePatterns,
      List<String> includeMethods,
      List<String> excludeMethods,
      List<Map<String, String>> includeHeaders,
      List<Map<String, String>> excludeHeaders})
      : super(
            includePatterns: includePatterns,
            excludePatterns: excludePatterns,
            includeMethods: includeMethods,
            excludeMethods: excludeMethods,
            includeHeaders: includeHeaders,
            excludeHeaders: excludeHeaders) {
    this._feignClientExecutorInterceptor = feignClientExecutorInterceptor;
  }

  preHandle(T options) {
    return this._feignClientExecutorInterceptor.preHandle(options);
  }

  postHandle<E>(T options, response) {
    return this._feignClientExecutorInterceptor.postHandle<E>(options, response);
  }

  postError<E>(T options, response) {
    return this._feignClientExecutorInterceptor.postError<E>(options, response);
  }
}
