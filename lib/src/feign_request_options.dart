import 'client/response_extractor.dart';

abstract class FeignRequestId {
  /// 单次http请求的id，用于贯穿整个http请求的过程
  /// 在这个过程中可以通过该id获取到请求的上下文内容
  /// {@see HttpRequestGenerator}
  String get requestId;

  set requestId(String value);
}

abstract class FeignRequestBaseOptions implements FeignRequestId {
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

abstract class UIOptions {
  /// 是否使用统一的提示
  ///  默认：true
  bool useUnifiedToast;

  /// 是否使用进度条,如果该值为false 则不会使用统一的提示
  /// 默认：true
  bool useProgressBar;
}

abstract class DataOptions {
  /// 使用统一响应转换
  ///  默认：true
  bool useUnifiedTransformResponse;

  /// 是否过滤提交数据中的 空字符串，null的数据，数值类型的NaN
  bool filterNoneValue;

  /// 响应数据抓取
  ResponseExtractor responseExtractor;
}

class FeignRequestOptions implements FeignRequestBaseOptions, DataOptions {
  String requestId;

  /// external query parameters
  /// value is boolean | number | string | Date |  Array<boolean | string | number | Date>
  Map<String, dynamic> queryParams;

  /// request body
  Map<String, dynamic> body;

  // 上传的文件
//  Map<String, dynamic> files;

  ///  external request headers
  ///  support '{xxx}' expression，Data can be obtained from request body or query data
  ///  []
  Map<String, String> headers;

  List<dynamic> pathVariables;

  /// 使用统一响应转换
  ///  默认：true
  bool useUnifiedTransformResponse;

  /// 是否过滤提交数据中的 空字符串，null的数据，数值类型的NaN
  bool filterNoneValue;

  /// 响应数据抓取
  ResponseExtractor responseExtractor;

  /// enable gzip
  bool enabledGzip = false;

  FeignRequestOptions(
      {this.requestId,
      this.queryParams,
      this.body,
      this.headers,
      this.pathVariables,
      this.useUnifiedTransformResponse,
      this.filterNoneValue,
      this.responseExtractor,
      this.enabledGzip});
}
