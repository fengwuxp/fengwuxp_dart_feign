import 'package:fengwuxp_dart_openfeign/src/annotations/feign_client.dart';
import 'package:fengwuxp_dart_openfeign/src/configuration/feign_configuration.dart';

import 'feign_configuration.dart';

//typedef R Func0<R>();
//
///// Lazy evaluates function and returns cached result on each call.
//Func0<R> memo0<R>(Func0<R> func) {
//  R prevResult;
//  bool isInitial = true;
//  return (() {
//    if (!isInitial) {
//      return prevResult;
//    } else {
//      prevResult = func();
//      isInitial = false;
//      return prevResult;
//    }
//  });
//}

FeignConfiguration _DEFAULT_CONFIGE = null;

/// get  feign configuration
/// if [feignClient] is null return default
FeignConfiguration getFeignConfiguration({FeignClient feignClient}) {
  // TODO 合并配置信息
  if (feignClient.configuration != null) {
    if (feignClient.configuration != null) {
      return feignClient.configuration;
    }
  }
  return _DEFAULT_CONFIGE;
}

/// set default feign Configuration
void setDefaultFeignConfiguration(
  FeignConfiguration configuration,
) {
//  if (configuration is CacheCapableSupport) {
//    configuration.getRestTemplate();
//  }
  _DEFAULT_CONFIGE = configuration;
}
