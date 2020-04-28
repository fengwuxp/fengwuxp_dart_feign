import 'package:fengwuxp_dart_openfeign/src/executor/feign_client_executor_interceptor.dart';

import '../feign_request_options.dart';
import 'mapped_interceptor.dart';

class MappedFeignClientExecutorInterceptor<T extends FeignBaseRequest> extends MappedInterceptor
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

  preHandle(T request, UIOptions uiOptions) {
    return this._feignClientExecutorInterceptor.preHandle(request, uiOptions);
  }

  postHandle<E>(T request, UIOptions uiOptions, response) {
    return this._feignClientExecutorInterceptor.postHandle<E>(request, uiOptions, response);
  }

  postError<E>(T request, UIOptions uiOptions, response) {
    return this._feignClientExecutorInterceptor.postError<E>(request, uiOptions, response);
  }
}
