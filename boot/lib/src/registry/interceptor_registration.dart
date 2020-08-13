

/// 拦截器注册器
abstract class InterceptorRegistration {
  List<String> _includePatterns = [];

  List<String> _excludePatterns = [];

  List<String> _includeMethods = [];

  List<String> _excludeMethods = [];

  List<List<String>> _includeHeaders = [];

  List<List<String>> _excludeHeaders = [];

  final Object interceptor;

  InterceptorRegistration(this.interceptor);

  InterceptorRegistration addPathPatterns(List<String> patterns) {
    this._includePatterns.addAll(patterns);
    return this;
  }

  InterceptorRegistration excludePathPatterns(List<String> patterns) {
    this._excludePatterns.addAll(patterns);
    return this;
  }

  InterceptorRegistration addHttpMethods(List<String> patterns) {
    this._includeMethods.addAll(patterns);
    return this;
  }

  InterceptorRegistration excludeHttpMethods(List<String> patterns) {
    this._excludeMethods.addAll(patterns);
    return this;
  }

  /// [headers]
  InterceptorRegistration addHeadersPatterns(List<List<String>> headers) {
    this._includeHeaders.addAll(headers);
    return this;
  }

  InterceptorRegistration excludeHeadersPatterns(List<List<String>> headers) {
    this._excludeHeaders.addAll(headers);
    return this;
  }

  Object getInterceptor() {
    throw UnsupportedError("need sub class override");
  }

  List<List<String>> get excludeHeaders => _excludeHeaders;

  List<List<String>> get includeHeaders => _includeHeaders;

  List<String> get excludeMethods => _excludeMethods;

  List<String> get includeMethods => _includeMethods;

  List<String> get excludePatterns => _excludePatterns;

  List<String> get includePatterns => _includePatterns;
}
