import 'package:fengwuxp_dart_openfeign/src/configuration/feign_configuration.dart';
import 'package:reflectable/reflectable.dart';

import 'feign_client_executor.dart';

abstract class FeignClientExecutorFactory {

  /// use get feign client
  /// if executor is exist,return in cache
  /// if not exist, crate
  /// [typeMirror]
  /// [clientType]
  /// [configuration]
  FeignClientExecutor factory(TypeMirror typeMirror,Type clientType,FeignConfiguration configuration);
}
