/// 保存当前请求的上下文信息
abstract class HttpRequestContext {
  /// Return all attributes of this request.
  Map<String, dynamic> get attributes;

  void putAttribute(String name, value);

  dynamic getAttribute(String name);
}

class DefaultHttpRequestContext implements HttpRequestContext {
  final Map<String, dynamic> attributes;

  DefaultHttpRequestContext(Map<String, dynamic>? attributes) : this.attributes = attributes ?? {};

  static DefaultHttpRequestContext form(HttpRequestContext context) {
    return new DefaultHttpRequestContext(context.attributes);
  }

  @override
  void putAttribute(String name, value) {
    this.attributes[name] = value;
  }

  @override
  getAttribute(String name) {
    return this.attributes[name];
  }
}
