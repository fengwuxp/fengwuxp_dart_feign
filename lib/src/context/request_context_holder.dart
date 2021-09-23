import 'package:fengwuxp_dart_openfeign/index.dart';
import 'package:fengwuxp_dart_openfeign/src/constant/feign_constant_var.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client_http_request.dart';
import 'package:fengwuxp_dart_openfeign/src/http/http_request_context.dart';
import 'package:fengwuxp_dart_openfeign/src/utils/metadata_utils.dart';

const _REQUEST_METHOD_MIRROR_ATTRIBUTE_NAME = "requestMethodMirror";

void setFeignMethodMirror(HttpRequestContext context, methodMirror) {
  context.putAttribute(_REQUEST_METHOD_MIRROR_ATTRIBUTE_NAME, methodMirror);
}

/// 从请求上下文中获取 FeignClientMethodConfig
RequestMapping? getRequestMappingByRequest(HttpRequestContext context) {
  final methodMirror = context.getAttribute(_REQUEST_METHOD_MIRROR_ATTRIBUTE_NAME);
  return findRequestMapping(methodMirror?.metadata);
}
