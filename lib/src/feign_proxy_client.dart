import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/src/constant/feign_constant_var.dart';
import 'package:reflectable/reflectable.dart';

import 'annotations/feign_client.dart';
import 'configuration/feign_configuration_registry.dart';
import 'feign_request_options.dart';

/// [FeignProxyClient]
abstract class FeignProxyClient {
  @override
  Future noSuchMethod(Invocation invocation) {
    //获取当前调用方法的名称
    String methodName = parseSymbolName(invocation.memberName);
    return this._executorInvoke(methodName, invocation.positionalArguments, invocation.namedArguments);
  }

  /// 委托执行请求
  /// param [T] use convert type
  /// [methodName] 方法名称
  Future<T> delegateInvoke<T>(String methodName, List<Object> positionalArguments,
      {UIOptions feignOptions, BuiltValueSerializable serializer}) async {
    return _executorInvoke(methodName, positionalArguments, {
      Symbol(FEIGN_OPTIONS_PARAMETER_NAME): feignOptions,
      Symbol(FEIGN_SERIALIZER_PARAMETER_NAME): serializer,
    }).then((result) {
      return Future<T>.value(result);
    });
  }

  // 内部的执行请求
  Future<T> _executorInvoke<T>(
      String methodName, List<Object> positionalArguments, Map<Symbol, dynamic> namedArguments) {
    /// 反射得到元数据
    final Type targetType = this.runtimeType;
    ClassMirror classMirror = Feign.reflectType(targetType);

    /// 获取配置
    final feignConfiguration = getFeignConfiguration(targetType);
    // 代理的执行器
    final feignClientExecutor =
        feignConfiguration.feignClientExecutorFactory.factory(classMirror, targetType, feignConfiguration);
    return feignClientExecutor.invoke(methodName, positionalArguments, namedArguments);
  }
}
