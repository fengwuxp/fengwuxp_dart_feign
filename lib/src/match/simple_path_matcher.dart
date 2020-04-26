
import 'package:fengwuxp_dart_openfeign/src/match/path_matcher.dart';

const DEFAULT_PATH_SEPARATOR = '/';

class SimplePathMatcher implements PathMatcher {
  // combine: (pattern1, pattern2) => string;
  // extractPathWithinPattern: (pattern: string, path: string) => string;
  // extractUriTemplateVariables: (pattern: string, path: string) => Map<String, String>;

  final String _pathSeparator;

  const SimplePathMatcher([this._pathSeparator = DEFAULT_PATH_SEPARATOR]);

  @override
  bool isPattern(String path) {
    return (path.indexOf('*') != -1 || path.indexOf('?') != -1);
  }

  @override
  bool match(String pattern, String path) {
    return this._doMatch(pattern, path, true);
  }

  bool matchStart(String pattern, String path) {
    return this._doMatch(pattern, path, false);
  }

  _doMatch(String pattern, String path, bool fullMatch) {
    if (pattern.startsWith("**")) {
      pattern = "**${pattern}";
    }
    var endWithWildcard = pattern.endsWith("**");
    var pathSeparator = this._pathSeparator;
    var endWithSeparator = pattern.endsWith(pathSeparator);

    var strings = pattern.split(pathSeparator).where((str) {
      return str.trim().length > 0;
    }).toList();
    String regExpString = this._getRegExpString(strings, endWithSeparator);
    regExpString = regExpString.replaceAll(
        new RegExp("$pathSeparator$pathSeparator", dotAll: true),
        pathSeparator);
    if (!endWithWildcard) {
      regExpString = "$regExpString\$";
    }
    var regExp = new RegExp(regExpString, dotAll: fullMatch);
    return regExp.hasMatch(path);
  }

  /// 获取正则表达式的字符串
  String _getRegExpString(List<String> strings, endWithSeparator) {
    final pathSeparator = this._pathSeparator;
    var results = [];
    var length = strings.length;
    for (var i = 0; i < length; i++) {
      var str = strings[i];
      if (str == "**") {
        // 匹配任意字符
        results.add("(.*?)");
      } else if (!endWithSeparator && i == length - 1) {
        results.add("$pathSeparator$str");
      } else {
        results.add("$pathSeparator$str$pathSeparator");
      }
    }
    return results.join("");
  }
}
