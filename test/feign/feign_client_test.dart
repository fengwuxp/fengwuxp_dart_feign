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
  test("test http", () async {

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
  });
}
