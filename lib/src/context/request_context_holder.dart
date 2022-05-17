import 'package:fengwuxp_dart_openfeign/src/annotations/request_mapping.dart';
import 'package:fengwuxp_dart_openfeign/src/configuration/feign_configuration.dart';
import 'package:fengwuxp_dart_openfeign/src/http/http_request_context.dart';
import 'package:fengwuxp_dart_openfeign/src/util/metadata_utils.dart';

const _REQUEST_METHOD_MIRROR_ATTRIBUTE_NAME = "requestMethodMirror";

const _REQUEST_FEIGN_CONFIG_ATTRIBUTE_NAME = "requestFeignConfig";

void setFeignMethodMirror(HttpRequestContext context, methodMirror) {
  context.putAttribute(_REQUEST_METHOD_MIRROR_ATTRIBUTE_NAME, methodMirror);
}

void setRequestFeignConfiguration(HttpRequestContext context, FeignConfiguration configuration) {
  context.putAttribute(_REQUEST_FEIGN_CONFIG_ATTRIBUTE_NAME, configuration);
}

/// 从请求上下文中获取 FeignClientMethodConfig
RequestMapping? getRequestMappingByRequest(HttpRequestContext context) {
  final methodMirror = context.getAttribute(_REQUEST_METHOD_MIRROR_ATTRIBUTE_NAME);
  return findRequestMapping(methodMirror?.metadata);
}

/// 从请求上下文中获取 FeignConfiguration
FeignConfiguration? getRequestFeignConfiguration(HttpRequestContext context) {
  return context.getAttribute(_REQUEST_FEIGN_CONFIG_ATTRIBUTE_NAME);
}
