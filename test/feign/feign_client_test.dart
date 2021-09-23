@TestOn('vm')
import 'package:fengwuxp_dart_openfeign/src/configuration/feign_configuration_registry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../built/req/query_hello_req.dart';
import '../http/utils.dart';
import 'feign_client_test.reflectable.dart';
import 'hello_feign_client.dart';
import 'mock_feign_configuration.dart';

void main() {
  setUp(startServer);

  tearDown(stopServer);
  initializeReflectable();
  test("test feign", () async {

    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url =
    Uri.http("test.migustord.com", '/api/article_action/query', {'q': '{http}'});

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;
      print('Number of books about http: $jsonResponse.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

//     registryFeignConfiguration(MockFeignConfiguration());
//     var helloFeignClient = HelloFeignClient();
//
//     /// 运行时泛型检查
// //    var result = await helloFeignClient.getHello("name", 1);
// //    print("==${result}==>");
//     var hello = QueryHelloReq((b) => b
//       ..id = 1
//       ..date = "2"
//       ..dateGmt = "3"
//       ..type = "4"
//       ..link = "5");
//
//     await helloFeignClient.putDataTest(hello);

    // 返回Object
   // helloFeignClient.queryHello(hello).then((data) {
   //   print("===reslt 2===>  $data");
   // });

   // helloFeignClient.getTest("name", BuiltList([1]));
  });
}
