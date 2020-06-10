import 'package:fengwuxp_dart_openfeign/src/executor/feign_client_executor_interceptor.dart';

import '../feign_request_options.dart';
import 'mapped_interceptor.dart';

class MappedFeignClientExecutorInterceptor extends MappedInterceptor implements FeignClientExecutorInterceptor {
  FeignClientExecutorInterceptor _feignClientExecutorInterceptor;

  MappedFeignClientExecutorInterceptor(FeignClientExecutorInterceptor feignClientExecutorInterceptor,
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
    this._feignClientExecutorInterceptor = feignClientExecutorInterceptor;
  }

  preHandle(FeignBaseRequest request, UIOptions uiOptions) {
    return this._feignClientExecutorInterceptor.preHandle(request, uiOptions);
  }

  postHandle<E>(FeignBaseRequest request, UIOptions uiOptions, response,{BuiltValueSerializable serializer}) {
    return this._feignClientExecutorInterceptor.postHandle<E>(request, uiOptions, response,serializer: serializer);
  }

  postError<E>(FeignBaseRequest request, UIOptions uiOptions, response,{BuiltValueSerializable serializer}) {
    return this._feignClientExecutorInterceptor.postError<E>(request, uiOptions, response,serializer: serializer);
  }
}
