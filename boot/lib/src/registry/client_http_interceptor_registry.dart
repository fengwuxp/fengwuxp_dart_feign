import 'package:fengwuxp_dart_openfeign/index.dart';

import 'client_http_interceptor_registration.dart';
import 'interceptor_registry.dart';

class ClientHttpInterceptorRegistry implements InterceptorRegistry {

  final List<ClientHttpInterceptorRegistration> clientHttpInterceptorRegistrations = [];


  ClientHttpInterceptorRegistration addInterceptor(interceptor) {
    final clientHttpInterceptorRegistration = ClientHttpInterceptorRegistration(interceptor);
    this.clientHttpInterceptorRegistrations.add(clientHttpInterceptorRegistration);
    return clientHttpInterceptorRegistration;
  }

  List<ClientHttpRequestInterceptor> getInterceptors<ClientHttpRequestInterceptor>() {
    return registrationToInterceptors<ClientHttpRequestInterceptor>(this.clientHttpInterceptorRegistrations);
  }
}
