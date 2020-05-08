import 'package:fengwuxp_openfeign_example/src/example_feign_configuration_registry.dart';
import 'package:fengwuxp_openfeign_example/src/feign/article_action_type.dart';
import 'package:fengwuxp_openfeign_example/src/feign/clients/article_action_feign_client.dart';
import 'package:fengwuxp_openfeign_example/src/feign/clients/article_action_feign_client.reflectable.dart';
import 'package:fengwuxp_openfeign_example/src/feign/req/add_article_action_req.dart';
import 'package:fengwuxp_openfeign_example/src/feign/req/delete_article_action_req.dart';
import 'package:fengwuxp_openfeign_example/src/feign/req/edit_article_action_req.dart';
import 'package:fengwuxp_openfeign_example/src/feign/req/query_article_action_req.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fengwuxp_openfeign_boot/index.dart';

void main() {
  feignInitializer(new ExampleFeignConfigurationRegistry());

  test("feign client test 01, query api ", () async {
    await articleActionFeignClient.query(QueryArticleActionReq((b) => b.id = 1)).then((result) {
      print("==result=>  $result");
    });
  });

  test("feign client test 02, create api ", () async {
    var req = AddArticleActionReq((b) => b
      ..actionType = ArticleActionType.COLLECTION
      ..articleId = 1
      ..sourceCode = "33"
      ..ip = "192.168.9.0");

    await articleActionFeignClient.create(req).then((result) {
      print("==result=>  $result");
    });
  });

  test("feign client test 03, delete api ", () async {
    var req = DeleteArticleActionReq((b) => b..id = 1);
    await articleActionFeignClient.delete(req).then((_) {
      print("==result=>  删除成功");
    }).catchError((error) {
      print("==删除 error=>  $error");
    });
  });

  test("feign client test 04, path variable api ", () async {
    await articleActionFeignClient.detail(1).then((result) {
      print("==result=>  $result");
    });
  });

  test("feign client test 05, edit api ", () async {
    await articleActionFeignClient
        .edit(EditArticleActionReq((b) => b
          ..id = 1
          ..sourceCode = "3"))
        .then((_) {
      print("==编辑成功=>  ");
    });
  });
}
