import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_openfeign/src/http/http_request_context.dart';

import 'client/response_extractor.dart';

abstract class FeignBaseRequest extends DefaultHttpRequestContext {
  /// external query parameters
  /// value is boolean | number | string | Date |  Array<boolean | string | number | Date>
  final Map<String, dynamic> queryParams;

  /// request body
  final Map<String, dynamic> body;

  ///  external request headers
  ///  support '{xxx}' expression，Data can be obtained from request body or query data
  ///  []
  final Map<String, String> headers;

  final List<dynamic> pathVariables;

  FeignBaseRequest(
      {Map<String, dynamic>? queryParams,
      Map<String, dynamic>? body,
      Map<String, String>? headers,
      List<dynamic>? pathVariables,
      Map<String, dynamic>? attributes})
      : this.queryParams = queryParams ?? {},
        this.body = body ?? {},
        this.headers = headers ?? {},
        this.pathVariables = pathVariables ?? [],
        super(attributes);
}

class FeignRequest extends FeignBaseRequest {
  // 上传的文件
  final Map<String, dynamic> files;

  FeignRequest(
      {Map<String, dynamic>? files,
      Map<String, dynamic>? queryParams,
      Map<String, dynamic>? body,
      Map<String, String>? headers,
      List<dynamic>? pathVariables,
      Map<String, dynamic>? attributes})
      : this.files = files ?? {},
        super(
            queryParams: queryParams,
            body: body,
            headers: headers,
            pathVariables: pathVariables,
            attributes: attributes);

  @override
  String toString() {
    return "body:$body,headers:$headers,queryParams:$queryParams ";
  }
}

class DataOptions {
  /// 使用统一响应转换
  ///  默认：true
  final bool useUnifiedTransformResponse;

  /// 是否过滤提交数据中的 空字符串，null的数据，数值类型的NaN
  final bool filterNoneValue;

  /// 响应数据抓取
  final ResponseExtractor? responseExtractor;

  /// enable gzip
  final bool enabledGzip;

  const DataOptions(
      {bool useUnifiedTransformResponse = true,
      bool filterNoneValue = true,
      ResponseExtractor? responseExtractor,
      bool enabledGzip = false})
      : this.useUnifiedTransformResponse = useUnifiedTransformResponse,
        this.filterNoneValue = filterNoneValue,
        this.responseExtractor = responseExtractor,
        this.enabledGzip = enabledGzip;
}

class UIOptions extends DataOptions {
  /// 是否使用统一的提示
  ///  默认：true
  final bool useUnifiedToast;

  /// 是否使用进度条,如果该值为false 则不会使用统一的提示
  /// 默认：true
  final bool useProgressBar;

  final int timeout;

  UIOptions({
    bool useUnifiedToast = true,
    bool useProgressBar = true,
    int timeout = -1,
    bool useUnifiedTransformResponse = true,
    bool filterNoneValue = true,
    ResponseExtractor? responseExtractor,
    bool enabledGzip = false,
  })  : this.useUnifiedToast = useUnifiedToast,
        this.useProgressBar = useProgressBar,
        this.timeout = timeout,
        super(
            useUnifiedTransformResponse: useUnifiedTransformResponse,
            filterNoneValue: filterNoneValue,
            responseExtractor: responseExtractor,
            enabledGzip: enabledGzip);
}

class BuiltValueSerializable {
  final Type? serializeType;

  final FullType? specifiedType;

  BuiltValueSerializable({this.serializeType, this.specifiedType});
}
