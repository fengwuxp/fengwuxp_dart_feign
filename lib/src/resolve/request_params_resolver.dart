import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/src/utils/metadata_utils.dart';
import 'package:reflectable/reflectable.dart';

import '../feign_request_options.dart';

/// 解析请求参数 将参数按照 查询参数、请求头、请求体、cookie等区分开来
/// [positionalArguments] 参数
/// [parametersMetadata]    参数描述元数据
/// [httpMethod]    请求方法
/// [produce]       请求的 [HttpMediaType]
//typedef RequestParamsResolver = FeignRequestOptions Function(
//    List positionalArguments,
//    List<ParameterMirror> parametersMetadata,
//    String httpMethod,
//    {FeignRequestOptions options});

abstract class RequestParamsResolver {
  FeignRequestOptions resolve(List positionalArguments, List<ParameterMirror> parametersMetadata, String httpMethod,
      {FeignRequestOptions options});
}

class DefaultRequestParamsResolver implements RequestParamsResolver {
  const DefaultRequestParamsResolver();

  @override
  FeignRequestOptions resolve(List positionalArguments, List<ParameterMirror> parametersMetadata, String httpMethod,
      {FeignRequestOptions options}) {
    var result = FeignRequestOptions(queryParams: {}, body: {}, headers: {}, pathVariables: []);
    if (options != null) {
      if (options.queryParams != null) {
        result.queryParams.addAll(options.queryParams);
      }
      if (options.body != null) {
        result.body.addAll(options.body);
      }
      if (options.headers != null) {
        result.headers.addAll(options.headers);
      }
    }

    var length = positionalArguments.length;
    for (var i = 0; i < length; i++) {
      var parameter = parametersMetadata[i];
      var metadata = parameter.metadata;
      var simpleName = parameter.simpleName;
      var argument = positionalArguments[i];
      if (metadata == null || metadata.isEmpty) {
        if (supportRequestBody(httpMethod)) {
          _margeData(result.body, simpleName, metadata, argument);
        } else {
          _margeData(result.queryParams, simpleName, metadata, argument);
        }
      } else {
        var meta = metadata[0];
        if (isQueryParam(meta)) {
          _margeData(result.body, simpleName, metadata, argument);
        } else if (isRequestHeader(meta)) {
          result.headers[simpleName] = argument;
        } else if (isRequestPart(meta)) {
          result.body[simpleName] = argument;
        } else if (isCookieValue(meta)) {
        } else if (isPathVariable(meta)) {
          result.pathVariables.add(argument);
        } else {}
      }
    }

    return result;
  }

  /// [target]
  /// [propName]
  /// [metadata]
  /// [data]
  void _margeData(Map<String, dynamic> target, String propName, metadata, data) {
    if (data == null) {
      return;
    }
    if (isSimpleType(data)) {
      target[propName] = data;
    } else if (data is Iterable) {
      var length = data.length;
      if (length == 0) {
        return;
      }
      target[propName] = data;
    } else if (data is Map) {
      target.addAll(data);
    } else if (data is JsonSerializableObject) {
      target.addAll(data.toMap());
    }
  }
}
