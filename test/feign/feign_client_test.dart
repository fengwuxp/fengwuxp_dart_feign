import 'package:built_collection/built_collection.dart';
import 'package:fengwuxp_dart_openfeign/src/configuration/feign_configuration_registry.dart';
import 'package:fengwuxp_dart_openfeign/src/feign_request_options.dart';
import 'package:test/test.dart';

import '../built/hello/hello.dart';
import '../built/hello/title.dart';
import '../built/req/query_hello_req.dart';
import 'feign_client_test.reflectable.dart';
import 'hello_feign_client.dart';
import 'mock_feign_configuration.dart';
import '../built/serializers.dart';

void main() {
  initializeReflectable();
  test("test feign", () {
    setDefaultFeignConfiguration(MockFeignConfiguration());
    var helloFeignClient = HelloFeignClient();

    /// 运行时泛型检查
    helloFeignClient.getHello("test", 1, FeignRequestOptions(queryParams: {})).then((data) {
      print("===reslt 1===>  $data");
    }).catchError((error) {
      print("===erro  1r===>  $error");
    });

    var hello = QueryHelloReq((b) => b
      ..id = 1
      ..date = "2"
      ..dateGmt = "3"
      ..type = "4"
      ..link = "5");

    /// 返回Object
    helloFeignClient.queryHello(hello).then((data) {
      print("===reslt 2===>  $data");
    }).catchError((error) {
      print("===error 2===>  $error");
    });
  });
}
