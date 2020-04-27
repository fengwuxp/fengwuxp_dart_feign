import 'package:fengwuxp_dart_basic/index.dart';

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
      if (normalizeUrlRegExp.hasMatch(group)) {
        var replaceFirst = group.replaceFirst("//", "/");
        return replaceFirst;
      }
    }
    return '/';
  });
}

final _match_api_module = RegExp("^@(.+?)\/", multiLine: true);

final Map<String, String> _ROUTE_CACHE = {};

/// 根据 {@see [routeMapping]} 的配置进行url合并
/// @param url               请求的url  格式 @模块名称/uri==>  例如：'@default/api/xxx/test'
/// @param [routeMapping]    路由配置
//String routing(String url, Map<String, String> routeMapping) {
//  if (isHttpUrl(url)) {
//    //uri
//    return normalizeUrl(url);
//  }
//  if (!url.startsWith("@")) {
//    throw new Exception("illegal routing url -> $url");
//  }
//  var realUrl = _ROUTE_CACHE[url];
//  if (realUrl != null) {
//    return realUrl;
//  }
//////抓取api模块名称并且进行替换
//  realUrl = url.replaceFirstMapped(_match_api_module, (match) {
//    var groupCount = match.groupCount;
//
//    for (var i = 0; i < groupCount; i++) {
//      var group = match.group(i);
//      var domain = routeMapping[group.substring(1, group.length - 1)];
//      if (domain == null) {
//        return "";
//      }
//      return domain.endsWith("/") ? domain : "$domain/";
//    }
//    return "";
//  });
//  realUrl = normalizeUrl(realUrl);
//  _ROUTE_CACHE[url] = realUrl;
//  return realUrl;
//}

/// 根据 {@see [routeMapping]} 的配置进行url合并
/// @param url               请求的url  格式 @模块名称/uri==>  例如：'@default/api/xxx/test'
/// @param [routeMapping]    路由配置
Uri routing(Uri url, Map<String, String> routeMapping) {
  if (StringUtils.hasText(url.scheme)) {
    return url;
  }
  var path = url.path;
  if (!path.startsWith("@")) {
    throw new Exception("illegal routing url -> $url");
  }
  var realUrl = _ROUTE_CACHE[path];
  if (realUrl == null) {
    ////抓取api模块名称并且进行替换
    realUrl = path.replaceFirstMapped(_match_api_module, (match) {
      var groupCount = match.groupCount;

      for (var i = 0; i < groupCount; i++) {
        var group = match.group(i);
        var domain = routeMapping[group.substring(1, group.length - 1)];
        if (domain == null) {
          return "";
        }
        return domain.endsWith("/") ? domain : "$domain/";
      }
      return "";
    });
    realUrl = normalizeUrl(realUrl);
    _ROUTE_CACHE[path] = realUrl;
  }
  var uri = StringUtils.hasText(url.query) ? "${realUrl}?${url.query}" : realUrl;
  return Uri.parse(uri);
}
