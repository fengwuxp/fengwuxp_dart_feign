import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/index.dart';

import 'registry/client_http_interceptor_registry.dart';
import 'registry/feign_client_interceptor_registry.dart';

 class FeignConfigurationRegistry {


  void registryMessageConverters(List<HttpMessageConverter> registry){}

  void registryClientHttpRequestInterceptors(ClientHttpInterceptorRegistry registry){}

  void registryFeignClientExecutorInterceptors(FeignClientInterceptorRegistry registry){}
}
