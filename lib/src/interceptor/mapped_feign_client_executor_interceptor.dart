import 'package:fengwuxp_dart_openfeign/src/executor/feign_client_executor_interceptor.dart';

import '../feign_request_options.dart';
import 'mapped_interceptor.dart';

class MappedFeignClientExecutorInterceptor extends MappedInterceptor implements FeignClientExecutorInterceptor {
  FeignClientExecutorInterceptor _feignClientExecutorInterceptor;

  MappedFeignClientExecutorInterceptor(FeignClientExecutorInterceptor feignClientExecutorInterceptor,
      {List<String> includePatterns = const [],
      List<String> excludePatterns = const [],
      List<String> includeMethods = const [],
      List<String> excludeMethods = const [],
      List<List<String>> includeHeaders = const [],
      List<List<String>> excludeHeaders = const []})
      : this._feignClientExecutorInterceptor = feignClientExecutorInterceptor,
        super(
            includePatterns: includePatterns,
            excludePatterns: excludePatterns,
            includeMethods: includeMethods,
            excludeMethods: excludeMethods,
            includeHeaders: includeHeaders,
            excludeHeaders: excludeHeaders);

  preHandle(FeignBaseRequest request, UIOptions uiOptions) {
    return this._feignClientExecutorInterceptor.preHandle(request, uiOptions);
  }

  postHandle<E>(FeignBaseRequest request, UIOptions uiOptions, response, {BuiltValueSerializable? serializer}) {
    return this._feignClientExecutorInterceptor.postHandle<E>(request, uiOptions, response, serializer: serializer);
  }

  postError(FeignBaseRequest request, UIOptions uiOptions, response, {BuiltValueSerializable? serializer}) {
    return this._feignClientExecutorInterceptor.postError(request, uiOptions, response, serializer: serializer);
  }
}
