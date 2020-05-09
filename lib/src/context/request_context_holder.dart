import 'package:fengwuxp_dart_openfeign/index.dart';
import 'package:fengwuxp_dart_openfeign/src/constant/feign_constant_var.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client_http_request.dart';
import 'package:fengwuxp_dart_openfeign/src/utils/metadata_utils.dart';
import 'package:reflectable/reflectable.dart';

// mapping option cache
/// @key request id or url and method
/// @value MethodMirror
final Map<String, MethodMirror> _MAPPING_CACHE = Map.from({});

/// 设置上下文
/// [requestId]          请求上下文id  {@see appendRequestContextId}
/// [context]
void setRequestContext(String requestId, MethodMirror context) {
  _MAPPING_CACHE[requestId] = context;
}

/// 移除上下文
/// @param requestId   请求上下文id  {@see appendRequestContextId}
void removeRequestContext(String requestId) {
  _MAPPING_CACHE.remove(requestId);
}

MethodMirror getFeignClientMethodConfiguration(String requestId) {
  return _MAPPING_CACHE[requestId];
}

// 自增长的request context id序列
var _REQUEST_NUM = 0;

/// 添加请求上下文的Id
/// @param feignRequestOptions
/// @return string  request context id
String appendRequestContextId(FeignRequest feignRequestOptions) {
  var requestId = "${_REQUEST_NUM++}";
  feignRequestOptions.requestId = requestId;
  feignRequestOptions.headers[REQUEST_ID_HEADER_NAME] = requestId;
  return requestId;
}

// 获取请求id
String getRequestId(Map<String, String> headers) {
  return headers[REQUEST_ID_HEADER_NAME];
}

// 移除请求id
void removeRequestId(Map<String, String> headers) {
  headers.remove(REQUEST_ID_HEADER_NAME);
}

/// 通过请求上下文id 获取FeignClientMethodConfig
/// @param req
/// {@link REQUEST_NUM}
/// {@link appendRequestContextId}
/// {@link REQUEST_ID_HEADER_NAME}
/// {@link FeignClientMethodConfig}
RequestMapping getRequestMappingByRequest(ClientHttpRequest req) {
  var headers = req.headers;
  if (headers == null) {
    return null;
  }
  var methodMirror = getFeignClientMethodConfiguration(headers[REQUEST_ID_HEADER_NAME]);
  if (methodMirror == null) {
    return null;
  }
  return findRequestMapping(methodMirror.metadata);
}
