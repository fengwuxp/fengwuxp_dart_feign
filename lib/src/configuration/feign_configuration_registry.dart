import 'package:fengwuxp_dart_openfeign/src/annotations/feign_client.dart';
import 'package:fengwuxp_dart_openfeign/src/configuration/feign_configuration.dart';

import 'feign_configuration.dart';

final Map<Type, FeignConfiguration> _CONFIGURATION_CACHE = {};

/// get  feign configuration
/// if [feignType] is null return default
FeignConfiguration getFeignConfiguration([Type feignType = FeignClient]) {
  // TODO 合并配置信息
  var configuration = _CONFIGURATION_CACHE[feignType];
  if (configuration == null) {
    configuration = _CONFIGURATION_CACHE[FeignClient];
  }
  return configuration;
}

void registryFeignConfiguration(FeignConfiguration configuration, {Type feignType = FeignClient}) {
  _CONFIGURATION_CACHE.putIfAbsent(feignType, () => configuration);
}
