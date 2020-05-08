import 'package:fengwuxp_dart_openfeign/index.dart';

import 'feign_client_executor_interceptor_registration.dart';
import 'interceptor_registry.dart';

class FeignClientInterceptorRegistry implements InterceptorRegistry {
  final List<FeignClientExecutorInterceptorRegistration> feignClientExecutorInterceptorRegistrations = [];

  FeignClientExecutorInterceptorRegistration addInterceptor(interceptor) {
    final feignClientExecutorInterceptorRegistration = FeignClientExecutorInterceptorRegistration(interceptor);
    this.feignClientExecutorInterceptorRegistrations.add(feignClientExecutorInterceptorRegistration);
    return feignClientExecutorInterceptorRegistration;
  }

  List<FeignClientExecutorInterceptor> getInterceptors<FeignClientExecutorInterceptor>() {
    return registrationToInterceptors<FeignClientExecutorInterceptor>(this.feignClientExecutorInterceptorRegistrations);
  }
}
