//  Defines methods for expanding a URI template with variables.
// handle url queryParams and uri ables
abstract class UriTemplateHandler {
  /// Expand the given URI template with a map of URI variables.
  /// [uriTemplate]
  Uri expand(String uriTemplate, {Map<String, dynamic> queryParams, List<Object> pathVariables});
}

/// grab shaped like example '1{abc}2ll3{efg}' string  ==> {abc}, {efg}
RegExp grabUrlPathVariable = new RegExp('{(.+?)}', dotAll: true);

/// 替换url的路径参数
/// [uriTemplate]
/// [pathVariables] Map or List
String replacePathVariableValue(String uriTemplate, pathVariables) {
  if (pathVariables == null) {
    return uriTemplate;
  }
  num index = 0;
  return uriTemplate.replaceAllMapped(grabUrlPathVariable, (Match match) {
    var text;
    num i = 0;
    while ((text = match.group(i)) != null) {
      String replaceText;
      if (pathVariables is List) {
        replaceText = pathVariables[index].toString();
        index++;
      } else {
        text = text.substring(1, text.length - 1);
        replaceText = pathVariables[text].toString();
      }
      i++;
      return replaceText;
    }
    return '';
  });
}
