import 'dart:io';

import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/index.dart';
import 'package:fengwuxp_dart_openfeign/src/named_support.dart';
import 'package:fengwuxp_dart_openfeign/src/util/metadata_utils.dart';
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
      {UIOptions? options}) {
    final feignRequest = FeignRequest();
    final _supportRequestBody = supportRequestBody(httpMethod);
    final length = positionalArguments.length;

    for (var i = 0; i < length; i++) {
      final parameter = parametersMetadata[i];
      final metadata = parameter.metadata;
      var simpleName = parameter.simpleName;
      var required = false;
      var argument = positionalArguments[i];

      if (metadata.isEmpty) {
        if (_supportRequestBody) {
          _margeData(feignRequest.body, simpleName, data: argument);
        } else {
          _margeData(feignRequest.queryParams, simpleName, data: argument);
        }
      } else {
        final meta = metadata[0];
        if (meta is Named) {
          // 使用命名对象中的名称
          simpleName = meta.name ?? simpleName;
          required = meta.required;
        } else if (meta is RequestBody) {
          required = meta.required;
        }
        var isFile = argument is File;
        // 是否需要使用formData提交
        var useFormData = isRequestParam(meta) && _supportRequestBody;
        // 是否需要使用RequestBody
        var useRequestBody = isRequestBody(meta);
        if (isRequestParam(meta) && !_supportRequestBody) {
          // 是查询参数 且不支持RequestBody(Get 请求)
          _margeData(feignRequest.queryParams, simpleName,
              data: argument ?? (meta as RequestParam).defaultValue, required: required);
        } else if (isQueryMap(meta)) {
          // 查询参数对象
          _margeData(feignRequest.queryParams, simpleName, data: argument);
        } else if (meta is RequestHeader) {
          feignRequest.headers[simpleName] = argument ?? meta.defaultValue;
        } else if (isRequestPart(meta) || isFile) {
          // TODO 文件处理
          feignRequest.files[simpleName] = argument;
        } else if (isCookieValue(meta)) {
          // TODO 提交cookie
        } else if (isPathVariable(meta)) {
          feignRequest.pathVariables.add(argument);
        } else if (useRequestBody || useFormData) {
          /// 支持 request body，如果是被 [RequestParam] 标记过的参数，优先使用 body 传递
          _margeData(feignRequest.body, simpleName, data: argument, required: required);
          if (useRequestBody) {
            // 有[RequestBody]注解，则默认使用json传递数据
            feignRequest.headers[HttpHeaders.contentTypeHeader] = HttpMediaType.APPLICATION_JSON_UTF8;
          }
        } else {
          // TODO 其他情况
          _margeData(feignRequest.body, simpleName, data: argument);
        }

        if (useFormData && feignRequest.headers[HttpHeaders.contentTypeHeader] == null) {
          // 使用表单提交数据
          feignRequest.headers[HttpHeaders.contentTypeHeader] = HttpMediaType.FORM_DATA;
        }
      }
    }

    return feignRequest;
  }

  /// [target]     请求体
  /// [propName]   在请求体属性名称
  /// [data]       提交的数据内容
  /// [required]       是否必填
  void _margeData(Map<String, dynamic> target, String propName, {dynamic data, bool required: false}) {
    if (data == null) {
      if (required) {
        throw new ArgumentError("参数：$propName，不能为null");
      }
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
      data.forEach((key, value) {
        target[key] = value;
      });
    } else if (data is JsonSerializableObject) {
      target.addAll(data.toMap());
    }
  }
}
