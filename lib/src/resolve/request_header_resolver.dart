import 'package:fengwuxp_dart_openfeign/src/annotations/feign_client.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/request_mapping.dart';
import 'package:fengwuxp_dart_openfeign/src/client/uri_template_handler.dart';
import 'package:fengwuxp_dart_openfeign/src/constant/feign_constant_var.dart';



abstract class RequestHeaderResolver {
  /// 从标记在类和方法上的 [FeignClient]和[RequestMapping]来解析url
  /// 并且尝试设置 Content-Type;
  /// param [methodRequestMapping]  标记在方法上的 [RequestMapping] 元数据
  /// param [headers]
  /// param [data]
  /// return new headers
  Map<String, String> resolve(RequestMapping methodRequestMapping,
      Map<String, String> headers, Map<String, dynamic> data);
}

class DefaultRequestHeaderResolver implements RequestHeaderResolver {


 const DefaultRequestHeaderResolver();

  @override
  Map<String, String> resolve(RequestMapping methodRequestMapping,
      Map<String, String> headers, Map<String, dynamic> data) {
    final configHeaders = methodRequestMapping.headers;
    final produces = methodRequestMapping.produces;

    if (configHeaders != null) {
      configHeaders.forEach((key, val) {
        headers[key] = replacePathVariableValue(val, data);
      });
    }
    if (produces != null) {
      headers[CONTENT_TYPE_NAME] = produces[0];
    }
    return headers;
  }

}
