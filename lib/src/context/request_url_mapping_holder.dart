import 'package:fengwuxp_dart_openfeign/src/constant/feign_constant_var.dart';

bool isHttpUrl(url) {
  return RegExp("^(http|https)").hasMatch(url);
}

// 匹配除了第一个http:// 后面的双斜杠
final _doubleSlashesRegExp = RegExp("((?!:).|^)\/{2,}", dotAll: true);

/// Remove duplicate slashes if not preceded by a protocol
/// @param [url]
String normalizeUrl(String url) {
  return url.replaceAllMapped(_doubleSlashesRegExp, (match) {
    var normalizeUrlRegExp = RegExp("^(?!\/)", dotAll: true);
    var groupCount = match.groupCount;
    for (var i = 0; i < groupCount; i++) {
      var group = match.group(i);
      if (normalizeUrlRegExp.hasMatch(group as String)) {
        var replaceFirst = group.replaceFirst("//", "/");
        return replaceFirst;
      }
    }
    return '/';
  });
}

/// 根据 {@see [routeMapping]} 的配置进行url合并
/// @param url               请求的url  格式 lb://{serviceId}/uri==>  例如：'lb://test-app/api/xxx/test'
/// @param [routeMapping]    路由配置
Uri routing(Uri url, Map<String, String> routeMapping) {
  if (url.scheme.toLowerCase() != "lb") {
    return url;
  }

  final serviceId = url.host;
  final serviceUri = routeMapping[serviceId];
  final result = url.hasQuery ? "$serviceUri${url.path}?${url.query}" : "$serviceUri${url.path}";
  return Uri.parse(normalizeUrl(result));
}
