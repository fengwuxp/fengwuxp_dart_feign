import 'package:fengwuxp_openfeign_example/src/example_feign_configuration_registry.dart';
import 'package:fengwuxp_openfeign_example/src/feign/article_action_type.dart';
import 'package:fengwuxp_openfeign_example/src/feign/clients/article_action_feign_client.dart';
import 'package:fengwuxp_openfeign_example/src/feign/clients/article_action_feign_client.reflectable.dart';
import 'package:fengwuxp_openfeign_example/src/feign/req/add_article_action_req.dart';
import 'package:fengwuxp_openfeign_example/src/feign/req/query_article_action_req.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fengwuxp_openfeign_boot/index.dart';

void main() {
  initializeReflectable();
  feignInitializer(new ExampleFeignConfigurationRegistry());

  test("feign client test 01, query api ", () async {
    await articleActionFeignClient.query(QueryArticleActionReq((b) => b.id = 1)).then((result) {
      print("==result=>  $result");
    });
  });

  test("feign client test 02, create api ", () async {
    await articleActionFeignClient
        .create(AddArticleActionReq((b) => b
          ..actionType = ArticleActionType.COLLECTION
          ..articleId = 1
          ..sourceCode = "33"
          ..ip = "192.168.9.0"))
        .then((result) {
      print("==result=>  $result");
    });
  });
}
