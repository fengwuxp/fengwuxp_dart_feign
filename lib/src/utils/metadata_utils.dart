import 'package:built_value/built_value.dart';
import 'package:fengwuxp_dart_openfeign/index.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/cookie_value.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/path_variable.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/request_body.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/request_header.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/request_mapping.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/request_param.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/request_part.dart';
import 'package:fengwuxp_dart_openfeign/src/constant/http/http_method.dart';

/// 请求方法[method是否支持RequestBody
bool supportRequestBody(String method) {
  if (method != HttpMethod.POST && method != HttpMethod.PUT && method != HttpMethod.PATCH) {
    return false;
  }
  return true;
}

// find type == [metaType] metadata
findMetadata(metadata, Type metaType) {
  return metadata.firstWhere((meta) => meta.runtimeType == metaType);
}

/// find [Signature]
findSignature(List metadata) {
  return metadata.firstWhere((meta) => meta is Signature, orElse: () => Signature(null));
}

// find RequestMapping
findRequestMapping(List metadata) {
  return metadata.firstWhere((meta) => meta is RequestMapping);
}

// 是否为请求体
isRequestBody(metadata) {
  return metadata.runtimeType == RequestBody;
}

// 是否为RequestParam
isRequestParam(metadata) {
  return metadata.runtimeType == RequestParam;
}

// is queryMap
isQueryMap(metadata) {
  return metadata.runtimeType == QueryMap;
}

// 是否为请求头
isRequestHeader(metadata) {
  return metadata.runtimeType == RequestHeader;
}

// 是否为文件对象
isRequestPart(metadata) {
  return metadata.runtimeType == RequestPart;
}

// 是否为路径参数
isPathVariable(metadata) {
  return metadata.runtimeType == PathVariable;
}

// 是否为cookie value
isCookieValue(metadata) {
  return metadata.runtimeType == CookieValue;
}

isSimpleType(data) {
  return data is String || data is num || data is bool;
}

// 是否为集合类型
isCollection(data) {
  return isList(data) || isMap(data) || isSet(data);
}

isList(data) => data is List;

isMap(data) => data is Map;

isSet(data) => data is Set;

isBuiltType(data) => data is Built;

isBuiltEnumType(data) => data is EnumClass;
