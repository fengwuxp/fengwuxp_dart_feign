import 'dart:collection';

import 'package:fengwuxp_dart_openfeign/src/configuration/feign_configuration.dart';
import 'package:fengwuxp_dart_openfeign/src/executor/default_feign_client_executor.dart';
import 'package:fengwuxp_dart_openfeign/src/executor/feign_client_executor_factory.dart';
import 'package:reflectable/reflectable.dart';

import 'feign_client_executor.dart';

class DefaultFeignClientExecutorFactory implements FeignClientExecutorFactory {
  static final Map<Type, FeignClientExecutor> _FEIGN_CLIENT_EXECUTOR_CACHE = HashMap();

  const DefaultFeignClientExecutorFactory();

  /// use get feign client
  /// if executor is exist,return in cache
  /// if not exist, crate
  /// [clientType]
  @override
  FeignClientExecutor factory(TypeMirror typedefMirror, Type clientType, FeignConfiguration configuration) {
    var feignCache = DefaultFeignClientExecutorFactory._FEIGN_CLIENT_EXECUTOR_CACHE;

    var executor = feignCache[clientType];

    if (executor == null) {
      executor = new DefaultFeignClientExecutor(typedefMirror, clientType, configuration);
      feignCache[clientType] = executor;
    }

    return executor;
  }
}
