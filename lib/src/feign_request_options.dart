import 'package:built_value/serializer.dart';

import 'client/response_extractor.dart';

abstract class FeignRequestId {
  /// 单次http请求的id，用于贯穿整个http请求的过程
  /// 在这个过程中可以通过该id获取到请求的上下文内容
  /// {@see HttpRequestGenerator}
  String get requestId;

  set requestId(String value);
}

abstract class FeignBaseRequest implements FeignRequestId {
  /// external query parameters
  /// value is boolean | number | string | Date |  Array<boolean | string | number | Date>
  Map<String, dynamic> queryParams;

  /// request body
  Map<String, dynamic> body;

  ///  external request headers
  ///  support '{xxx}' expression，Data can be obtained from request body or query data
  ///  []
  Map<String, String> headers;

  List<Object> pathVariables;
}

class FeignRequest implements FeignBaseRequest {
  String requestId;

  /// external query parameters
  /// value is boolean | number | string | Date |  Array<boolean | string | number | Date>
  Map<String, dynamic> queryParams;

  /// request body
  Map<String, dynamic> body;

  // 上传的文件
  Map<String, dynamic> files;

  ///  external request headers
  ///  support '{xxx}' expression，Data can be obtained from request body or query data
  ///  []
  Map<String, String> headers;

  List<dynamic> pathVariables;

  FeignRequest({this.requestId, this.queryParams, this.body, this.headers, this.pathVariables});

  @override
  String toString() {
    return "requestId:$requestId,body:$body,headers:$headers,queryParams:$queryParams ";
  }
}

class DataOptions {
  /// 使用统一响应转换
  ///  默认：true
  final bool useUnifiedTransformResponse;

  /// 是否过滤提交数据中的 空字符串，null的数据，数值类型的NaN
  final bool filterNoneValue;

  /// 响应数据抓取
  final ResponseExtractor responseExtractor;

  /// enable gzip
  final bool enabledGzip;

  const DataOptions(
      {bool useUnifiedTransformResponse, bool filterNoneValue, ResponseExtractor responseExtractor, bool enabledGzip})
      : this.useUnifiedTransformResponse = useUnifiedTransformResponse ?? true,
        this.filterNoneValue = filterNoneValue ?? true,
        this.responseExtractor = responseExtractor,
        this.enabledGzip = enabledGzip ?? false;
}

class UIOptions extends DataOptions {
  /// 是否使用统一的提示
  ///  默认：true
  final bool useUnifiedToast;

  /// 是否使用进度条,如果该值为false 则不会使用统一的提示
  /// 默认：true
  final bool useProgressBar;

  final int timeout;

  UIOptions(
      {bool useUnifiedToast,
      bool useProgressBar,
      bool useUnifiedTransformResponse,
      bool filterNoneValue,
      ResponseExtractor responseExtractor,
      bool enabledGzip,
      int timeout})
      : this.useUnifiedToast = useUnifiedToast ?? true,
        this.useProgressBar = useProgressBar ?? true,
        this.timeout = timeout ?? -1,
        super(
            useUnifiedTransformResponse: useUnifiedTransformResponse,
            filterNoneValue: filterNoneValue,
            responseExtractor: responseExtractor,
            enabledGzip: enabledGzip);
}

class BuiltValueSerializable<T> {
  final Serializer<T> serializer;
  final FullType specifiedType;

  const BuiltValueSerializable({this.serializer, this.specifiedType});
}
