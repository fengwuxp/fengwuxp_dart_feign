import 'dart:io';

import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/src/client/default_url_template_handler.dart';
import 'package:fengwuxp_dart_openfeign/src/client/uri_template_handler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// grab shaped like example '1{abc}2ll3{efg}' string  ==> abc, efg
  RegExp grabUrlPathVariable = new RegExp('{(.+?)}', dotAll: true);
  test("uri template test", () {
    var uriTemplate = "http://test.com/{a}/{b}";
    const queryParams = {'a': 1, 'b': 2};
    const pathVariables = ["m", "22"];
    var url1 = replacePathVariableValue(uriTemplate, pathVariables);
    print("result 1==> ${url1}");
    var url2 = replacePathVariableValue(uriTemplate, queryParams);
    print("result 2 ==> ${url2}");
  });

  test("query string parser", () {

    var value2 = ContentType.json.value;



    var result = QueryStringParser.parse("a=1&b=2&c=3&c=4&d=true&h=&c&e&");
    print(result);
    var queryParams = Map.from(result);
    queryParams["e"] = "";
    queryParams["c"].add("");
    print(QueryStringParser.stringify(result));
  });

  var defaultUrlTemplateHandler = new DefaultUriTemplateHandler();

  test("uri template test 2", () {
    var uriTemplate = "http://test.com/{a}/{b}?k=2&c=";
    const queryParams = {'a': 1, 'b': 2};
    const pathVariables = ["m", "22"];
    var url1 = defaultUrlTemplateHandler.expand(uriTemplate,
        queryParams: queryParams, pathVariables: pathVariables);
    print("result 1==> ${url1}");
  });
}
