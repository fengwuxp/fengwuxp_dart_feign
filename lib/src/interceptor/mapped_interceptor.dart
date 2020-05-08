import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/src/constant/http/http_method.dart';

// use match interceptor is execute
abstract class MappedInterceptor {
  List<String> _includePatterns;
  List<String> _excludePatterns;

  List<String> _includeMethods;
  List<String> _excludeMethods;

  /// HttpHeader {
  ///    name: string;
  ///    value: string
  ///}
  List<_HttpHeader> _includeHeaders;
  List<_HttpHeader> _excludeHeaders;

  PathMatcher _pathMatcher = SimplePathMatcher();

  MappedInterceptor(
      {List<String> includePatterns,
      List<String> excludePatterns,
      List<String> includeMethods,
      List<String> excludeMethods,
      List<List<String>> includeHeaders,
      List<List<String>> excludeHeaders}) {
    this._includePatterns = includePatterns ?? [];
    this._excludePatterns = excludePatterns ?? [];
    this._includeMethods = includeMethods ?? [];
    this._excludeMethods = excludeMethods ?? [];
    this._includeHeaders = this._converterHeaders(includeHeaders) ?? [];
    this._excludeHeaders = this._converterHeaders(excludeHeaders) ?? [];
  }

// Determine a match for the given lookup path.
// @param req
// @return {@code true} if the interceptor applies to the given request path or http methods or http headers
  bool matches({String url, String httpMethod, headers}) {
    if (!this.matchesUrl(url)) {
      return false;
    }
    if (!this.matchesMethod(httpMethod)) {
      return false;
    }
    if (!this.matchesHeaders(headers)) {
      return false;
    }

    return true;
  }

  /// Determine a match for the given lookup path.
  /// @param [lookupPath] the current request path
  /// @param [pathMatcher] a path matcher for path pattern matching
  /// @return {@code true} if the interceptor applies to the given request path
  bool matchesUrl(String lookupPath, [PathMatcher pathMatcher]) {
    var pathMatcherToUse = this._pathMatcher;
    if (pathMatcher != null) {
      pathMatcherToUse = pathMatcher;
    }
    var excludePatterns = this._excludePatterns;
    var includePatterns = this._includePatterns;
    return this._doMatch<String>(lookupPath.split("?")[0], includePatterns, excludePatterns, (pattern, path) {
      return pathMatcherToUse.match(pattern, path);
    });
  }

  /// Determine a match for the given http method
  /// [httpMethod] [HttpMethod]
  bool matchesMethod(String httpMethod) {
    return this._doMatch<String>(httpMethod, this._includeMethods, this._excludeMethods, (pattern, matchSource) {
      return pattern == matchSource;
    });
  }

  ///  Determine a match for the given request headers
  ///  [headers]
  bool matchesHeaders(Map<String, String> headers) {
    if (headers == null) {
      return true;
    }
    return this._doMatch<_HttpHeader>(headers, this._includeHeaders, this._excludeHeaders, (pattern, matchSource) {
      var name = pattern.name;
      var value = pattern.value;
      var needMatchValue = value != null;
      var headerValue = matchSource[name];

      if (needMatchValue) {
        return headerValue == value;
      }
      return headerValue != null;
    });
  }

  bool _doMatch<T>(matchSource, List includes, List excludes, bool predicate(T pattern, matchSource)) {
    if (excludes != null) {
      var isMatch = excludes.any((pattern) => predicate(pattern, matchSource));
      if (isMatch) {
        return false;
      }
    }
    if (includes == null || includes.length == 0) {
      return true;
    }
    var isMatch = includes.any((pattern) => predicate(pattern, matchSource));
    if (isMatch) {
      return true;
    }

    return false;
  }

  List<_HttpHeader> _converterHeaders(List<List<String>> headers) {
    if (headers == null) {
      return null;
    }
    return List.of(headers.map((items) {
      return _HttpHeader(items.first, items[1] ?? null);
    }));
  }
}

class _HttpHeader {
  final String name;
  final String value;

  _HttpHeader(this.name, this.value);
}
