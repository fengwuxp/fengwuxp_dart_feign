import 'interceptor_registration.dart';


/// 拦截器注册中心
abstract class InterceptorRegistry {
  InterceptorRegistration addInterceptor(interceptor);

  List<T> getInterceptors<T>();
}

List<T> registrationToInterceptors<T>(List<InterceptorRegistration> interceptorRegistrations) {
  return List.of(interceptorRegistrations.map((item) {
    return item.getInterceptor() as T;
  }));
}
