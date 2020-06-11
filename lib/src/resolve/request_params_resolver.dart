import 'dart:io';

import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/index.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client/multipart_file.dart';
import 'package:fengwuxp_dart_openfeign/src/named_support.dart';
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
  FeignRequest resolve(List positionalArguments, List<ParameterMirror> parametersMetadata, String httpMethod,
      {UIOptions options});
}

class DefaultRequestParamsResolver implements RequestParamsResolver {
  const DefaultRequestParamsResolver();

  @override
  FeignRequest resolve(List positionalArguments, List<ParameterMirror> parametersMetadata, String httpMethod,
      {UIOptions options}) {
    var result = FeignRequest(queryParams: {}, body: {}, headers: {}, pathVariables: []);
    var _supportRequestBody = supportRequestBody(httpMethod);
    var length = positionalArguments.length;

    for (var i = 0; i < length; i++) {
      var parameter = parametersMetadata[i];
      var metadata = parameter.metadata;
      var simpleName = parameter.simpleName;
      var argument = positionalArguments[i];

      if (metadata == null || metadata.isEmpty) {
        if (_supportRequestBody) {
          _margeData(result.body, simpleName, metadata, argument);
        } else {
          _margeData(result.queryParams, simpleName, metadata, argument);
        }
      } else {
        var meta = metadata[0];
        if (meta is Named) {
          // 使用命名对象中的名称
          simpleName = meta.name ?? simpleName;
        }
        var isFile = argument is File;
        // 是否需要使用formData提交
        var useFormData = isRequestParam(meta) && _supportRequestBody;

        if (isRequestParam(meta) && !_supportRequestBody) {
          // 是查询参数 且不支持RequestBody(Get 请求)
          _margeData(result.queryParams, simpleName, metadata, argument);
        } else if (isQueryMap(meta)) {
          // 查询参数对象
          _margeData(result.queryParams, simpleName, metadata, argument);
        } else if (isRequestHeader(meta)) {
          result.headers[simpleName] = argument;
        } else if (isRequestPart(meta) || isFile) {
          if (argument is String) {
            // 文件路径
            result.files[simpleName] = MultipartFile.fromPath(simpleName, argument);
          } else if (isFile) {
            result.files[simpleName] = MultipartFile.fromBytes(simpleName, argument.readAsBytesSync());
          }
          // 文件上传
          result.headers[HttpHeaders.contentTypeHeader] = HttpMediaType.MULTIPART_FORM_DATA;
        } else if (isCookieValue(meta)) {
          //TODO 提交cookie
        } else if (isPathVariable(meta)) {
          result.pathVariables.add(argument);
        } else if (isRequestBody(metadata) || useFormData) {
          // request body，如果是被 RequestParam 标记过的参数，优先使用 body 传递
          _margeData(result.body, simpleName, metadata, argument);
        } else {
          // TODO
          _margeData(result.body, simpleName, metadata, argument);
        }

        if (useFormData && result.headers[HttpHeaders.contentTypeHeader] == null) {
          result.headers[HttpHeaders.contentTypeHeader] = HttpMediaType.FORM_DATA;
        }
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
      if (data.isEmpty) {
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
