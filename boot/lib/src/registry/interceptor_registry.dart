import 'interceptor_registration.dart';

abstract class InterceptorRegistry {

  InterceptorRegistration addInterceptor( interceptor);

  List<T> getInterceptors<T>();
}

List<T>  registrationToInterceptors<T>(List<InterceptorRegistration> interceptorRegistrations) {
  return interceptorRegistrations.map((item) {
    return item.getInterceptor();
  });
}
