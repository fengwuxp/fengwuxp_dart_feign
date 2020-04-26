import 'package:fengwuxp_dart_openfeign/src/configuration/feign_configuration.dart';
import 'package:reflectable/reflectable.dart';

const DEFAULT_MODULE = "default";

/// target Class
/// 用来标记api 所属的模块 不同服务模块的api接口可能入口地址不同
class FeignClient extends Reflectable {
  /// unique feign client name
  final String name;

  /// part of url
  final String value;

  /// 请求不同模块的服务端是可以用该属性标记 然后使用 RequestRouter进行统一处理
  /// if startWith '@', use routeing, see [DEFAULT_MODULE]
  final String apiModule;

  /// an absolute URL or resolvable hostname (the protocol is optional)
  final String url;

  /// default null
  /// independent configuration
  final FeignConfiguration configuration;

  const FeignClient(
      {this.apiModule = DEFAULT_MODULE,
      this.name,
      this.value,
      this.url,
      this.configuration })
      : super(
            metadataCapability,
            invokingCapability,
            declarationsCapability,
            typeRelationsCapability,
            instanceInvokeCapability,
            newInstanceCapability);
}
// feign reflectable
const FEIGN_REFLECT_ABLE = FeignClient();
