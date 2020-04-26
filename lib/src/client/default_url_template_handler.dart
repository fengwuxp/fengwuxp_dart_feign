import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/src/client/uri_template_handler.dart';

class DefaultUriTemplateHandler implements UriTemplateHandler {
  const DefaultUriTemplateHandler();

  @override
  Uri expand(String uriTemplate, {Map<String, dynamic> queryParams, List<Object> pathVariables}) {
    if (pathVariables != null && pathVariables.length > 0) {
      uriTemplate = replacePathVariableValue(uriTemplate, pathVariables);
    }

    if (queryParams == null || queryParams.length == 0) {
      return Uri.parse(uriTemplate);
    }

    // 加入查询参数
    var hasQueryString = uriTemplate.contains(QueryStringParser.QUERY_TRING_SEP);
    if (hasQueryString) {
      var urls = uriTemplate.split(QueryStringParser.QUERY_TRING_SEP);
      var map = QueryStringParser.parse(urls[1]);
      map.addAll(queryParams);
      queryParams = map;
      uriTemplate = urls[0];
    }
    var queryString = QueryStringParser.stringify(queryParams);
    StringBuffer url = new StringBuffer();
    if (uriTemplate.endsWith(QueryStringParser.SEP)) {
      // 以 & 结尾
      url.write(uriTemplate);
      url.write(queryString);
    } else {
      if (hasQueryString) {
        url.write(uriTemplate);
        url.write(QueryStringParser.SEP);
        url.write(queryString);
      } else {
        url.write(uriTemplate);
        url.write(QueryStringParser.QUERY_TRING_SEP);
        url.write(queryString);
      }
    }
    return Uri.parse(url.toString());
  }
}
