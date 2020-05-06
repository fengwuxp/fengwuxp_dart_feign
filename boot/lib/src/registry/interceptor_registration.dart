abstract class InterceptorRegistration {


  List<String> _includePatterns = [];

  List<String> _excludePatterns = [];

  List<String> _includeMethods = [];

  List<String> _excludeMethods = [];

  List<List<String>> _includeHeaders = [];

  List<List<String>> _excludeHeaders = [];

  final Object interceptor;

  InterceptorRegistration(this.interceptor);

  addPathPatterns(List<String> patterns) {
    this._includePatterns.addAll(patterns);
    return this;
  }

  excludePathPatterns(List<String> patterns) {
    this._excludePatterns.addAll(patterns);
    return this;
  }

  addHttpMethods(List<String> patterns) {
    this._includeMethods.addAll(patterns);
    return this;
  }

  excludeHttpMethods(List<String> patterns) {
    this._excludeMethods.addAll(patterns);
    return this;
  }

  /// [headers]
  addHeadersPatterns(List<List<String>> headers) {
    this._includeHeaders.addAll(headers);
    return this;
  }

  excludeHeadersPatterns(List<List<String>> headers) {
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
