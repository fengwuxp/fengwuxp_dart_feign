import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/feign_client.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/request_mapping.dart';

abstract class RequestURLResolver {
  /// 从标记在类和方法上的 [FeignClient]和[RequestMapping]来解析url
  /// param [feignClient] 标记在声明为FeignClient类上的元数据
  /// param [methodRequestMapping]  标记在方法上的 [RequestMapping] 元数据
  /// param [className]
  /// param [methodName]
  String resolve(FeignClient feignClient, RequestMapping methodRequestMapping, String className, String methodName);
}

/// 遵循restful风格的url解析
class RestfulRequestURLResolver implements RequestURLResolver {
  const RestfulRequestURLResolver();

  @override
  String resolve(FeignClient feignClient, RequestMapping methodRequestMapping, String className, String methodName) {
    //生成 例如 @member/member/queryMember 或 @default/member/{memberId}
    return "${_getApiUriByFeignClient(feignClient, className)}${_getApiUriByFeignClientMethod(methodRequestMapping, methodName)}";
  }
}

String _getApiUriByFeignClient(
  FeignClient feignClient,
  String className,
) {
  final url = feignClient.url;
  if (StringUtils.hasText(url)) {
    return url;
  }
  final apiModule = feignClient.apiModule;
  final value = StringUtils.hasText(feignClient.value) ? feignClient.value : className;
  return "@${apiModule}${value.startsWith("/") ? value : "/" + value}";
}

String _getApiUriByFeignClientMethod(RequestMapping methodRequestMapping, String methodName) {
  var value = "";
  if (methodRequestMapping != null && methodRequestMapping.value != null) {
    value = methodRequestMapping.value;
  }
  if (!StringUtils.hasText(value)) {
    return value;
  }

  return value.startsWith("/") ? value : "/${value}";
}
