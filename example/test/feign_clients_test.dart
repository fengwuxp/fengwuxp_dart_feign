import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_openfeign_boot/index.dart';
import 'package:fengwuxp_openfeign_example/src/example_feign_configuration_registry.dart';
import 'package:fengwuxp_openfeign_example/src/feign/article_action_type.dart';
import 'package:fengwuxp_openfeign_example/src/feign/clients/article_action_feign_client.dart';
import 'package:fengwuxp_openfeign_example/src/feign/clients/example_cms_feign_client.dart';
import 'package:fengwuxp_openfeign_example/src/feign/req/add_article_action_req.dart';
import 'package:fengwuxp_openfeign_example/src/feign/req/delete_article_action_req.dart';
import 'package:fengwuxp_openfeign_example/src/feign/req/edit_article_action_req.dart';
import 'package:fengwuxp_openfeign_example/src/feign/req/query_article_action_req.dart';
import 'package:fengwuxp_openfeign_example/src/feign/serializers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

void main() {
  var md5signatureStrategy = Md5SignatureStrategy("app", "2aecdd9db7d816462e2232632c90f8fa", "mock");
  feignInitializer(new ExampleFeignConfigurationRegistry(), BuiltJsonSerializers(serializers),
      apiSignatureStrategy: md5signatureStrategy);

  /// 日志打印
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('[${rec.loggerName}]:[${rec.level}]] ${rec.level.name}: ${rec.time}: ${rec.message}');
    if (rec.error != null && rec.stackTrace != null) {
      print('${rec.error}: ${rec.stackTrace}');
    }
  });

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

  /// ==========复杂的集合嵌套=========>

  test("feign client test 06", () async {
    await exampleCmsFeignClient.getNums(1).then((result) {
      print("==get num=>  $result");
    });
  });

  test("feign client test 07", () async {
    await exampleCmsFeignClient.getMap().then((result) {
      print("==get map=>  $result");
    });
  });

  test("feign client test 08", () async {
    await exampleCmsFeignClient.getMap2().then((result) {
      print("==get map 2=>  $result");
    });
  });

  test("feign client test 09", () async {
    await exampleCmsFeignClient.getMaps(100).then((result) {
      print("==get maps=>  $result");
    });
  });
}
