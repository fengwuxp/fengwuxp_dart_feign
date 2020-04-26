// http media type
abstract class HttpMediaType {
  // 表单
  static const FORM_DATA = "application/x-www-form-urlencoded";

  // 文件上传
  static const MULTIPART_FORM_DATA = "multipart/form-data";

  // json
  static const APPLICATION_JSON = "application/json";

  // JSON_UTF_8
  static const APPLICATION_JSON_UTF8 = "application/json;charset=UTF-8";

  // text
  static const TEXT = "text/plain";

  // html
  static const HTML = "text/html";

  // 流
  static const APPLICATION_STREAM = "application/octet-stream";
}
