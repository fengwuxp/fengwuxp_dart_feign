import 'package:built_collection/built_collection.dart';
import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/src/configuration/feign_configuration_registry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../built/serializers.dart';
import '../feign/mock_feign_configuration.dart';
import 'article_action_feign_client.dart';
import 'article_action_feign_client_test.reflectable.dart';
import 'info/article_action_info.dart';
import 'req/find_article_actions_req.dart';
import 'resp/page_info.dart';

void main() {
  initializeReflectable();

  test("test generic type serizable ", () {
    var articleActions = PageInfo<ArticleActionInfo>((b) {
      var builder = b
        ..total = 1
        ..queryPage = 1
        ..querySize = 10
        ..queryType = "QUERY_RESULT";
      builder.records = ListBuilder<ArticleActionInfo>([
        ArticleActionInfo((ab) => ab
          ..id = 1
          ..sourceCode = "2"
          ..articleId = 1
          ..actionType = "1"
          ..crateTime = DateTime.utc(2020, 04, 27, 11, 22, 33, 44))
      ]);
      return builder;
    });
    var builtJsonSerializers = new BuiltJsonSerializers(serializers);
    var json = builtJsonSerializers.toJson(articleActions, PageInfo.serializer);
    print("$json");
    var parseObject = builtJsonSerializers.parseObject(json,PageInfo.serializer);

    print("$parseObject");

  });

  test("test article action feign client", () async {
    registryFeignConfiguration(MockFeignConfiguration());
    var result = await articleActionFeignClient.query(FindArticleActionsReq((b) => b
      ..id = 1
      ..sourceCode = "2"));
    print("$result");
  });
}
