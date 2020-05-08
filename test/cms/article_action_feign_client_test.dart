import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/src/configuration/feign_configuration_registry.dart';
import 'package:fengwuxp_dart_openfeign/src/http/response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

import '../built/serializers.dart';
import '../feign/mock_feign_configuration.dart';
import 'article_action_feign_client.dart';
import 'article_action_feign_client_test.reflectable.dart';
import 'enums/article_action_type.dart';
import 'info/article_action_info.dart';
import 'info/page_article_action_info.dart';
import 'req/find_article_actions_req.dart';
import 'resp/api_resp.dart';
import 'resp/page_info.dart';

void main() {
  initializeReflectable();
  var builtJsonSerializers = BuiltJsonSerializers(serializers);

  /// 日志打印
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('[${rec.loggerName}]:[${rec.level}]] ${rec.level.name}: ${rec.time}: ${rec.message}');
    if (rec.error != null && rec.stackTrace != null) {
      print('${rec.error}: ${rec.stackTrace}');
    }
  });

  test("test article action feign client,not generic", () async {
    registryFeignConfiguration(MockFeignConfiguration());
    await articleActionFeignClient
        .query(FindArticleActionsReq((b) => b
          ..articleId = 1
          ..sourceCode = "2"))
        .then((data) {
      print("$data");
    }).catchError((error) {
      print("===>${error.body["message"]}");
    }, test: (error) {
      return error is ResponseEntity;
    }).catchError((error) {
      print("==请求错误=>${error}");
    }, test: (error) {
      return error is ApiResp;
    });
  });

  test("test article action feign client,generic", () async {
    registryFeignConfiguration(MockFeignConfiguration());
    await articleActionFeignClient
        .query2(FindArticleActionsReq((b) => b
          ..articleId = 1
          ..sourceCode = "2"))
        .then((data) {
      print("$data");
    }).catchError((error) {
      print("===>${error.body["message"]}");
    }, test: (error) {
      return error is ResponseEntity;
    }).catchError((error) {
      print("==请求错误=>${error}");
    }, test: (error) {
      return error is ApiResp;
    });
  });

  test("test dateTiem type", () {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(1588085452402);
    print("==毫秒 dateTime==> ${dateTime}");
    var dateTime_2 = DateTime.fromMicrosecondsSinceEpoch(1588085452402 * 1000);
    print("==微秒 dateTime_2==> ${dateTime_2}");
  });

  test("test generic type serializable ", () {
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
          ..actionType = ArticleActionType.COLLECTION
          ..crateTime = DateTime.utc(2020, 04, 27, 11, 22, 33, 44))
      ]);
      return builder;
    });
    var specifiedType = FullType(PageInfo, [FullType(ArticleActionInfo)]);
    var serializer = PageInfo.serializer;

    var result1 =
        builtJsonSerializers.toJson(articleActions, serializer: PageInfo.serializer, specifiedType: specifiedType);
    print("==result1==>$result1");
    var result2 =
        (serializer as StructuredSerializer).serialize(serializers, articleActions, specifiedType: specifiedType);
    print("====>$result2");
    var result3 = articleActions.toJson();
    print("====>$result3");

    var jsonText = '''
    {
  "total": 1,
  "records": [
    {
      "id": 1,
      "articleId": 1,
      "actionType": "LIKE",
      "sourceCode": "2",
      "crateTime": 1587986553044000
    }
  ],
  "querySize": 10,
  "queryPage": 1,
  "queryType": "QUERY_RESULT"
}
    
    ''';
    var result4 =
        builtJsonSerializers.parseObject(jsonText, serializer: PageInfo.serializer, specifiedType: specifiedType);
    print("==result4==>$result4");
    var result5 = builtJsonSerializers.parseObject(jsonText, serializer: PageArticleActionInfo.serializer);
    print("==去泛型 result5==>$result5");

    var jsonText2 = '''
    {
  "total": 1,
  "records": [
    {
      "articleId": 1,
      "sourceCode": "2"
    }
  ],
  "querySize": 10,
  "queryPage": 1,
  "queryType": "QUERY_RESULT"
}
    
    ''';
    var result6 = builtJsonSerializers.parseObject(jsonText2,
        serializer: PageInfo.serializer, specifiedType: FullType(PageInfo, [FullType(FindArticleActionsReq)]));
    print("==result6==>$result6");
  });

  test("test list json parse object", () {
    var jsonText1 = '''
           [
               { 
                  "id": 1,
                  "articleId": 1,
                  "actionType": "1",
                  "sourceCode": "2",
                  "crateTime": 1587986553044000
               }
           ]
       ''';
    var result1 =
        builtJsonSerializers.parseObject(jsonText1, specifiedType: FullType(BuiltList, [FullType(ArticleActionInfo)]));
    print("==result1==>$result1");

    var jsonText2 = '''
           {
            "item1" : { 
                  "id": 1,
                  "articleId": 1,
                  "actionType": "1",
                  "sourceCode": "2",
                  "crateTime": 1587986553044000
               }
           }
       ''';
    var result2 = builtJsonSerializers.parseObject(jsonText2,
        specifiedType: FullType(BuiltMap, [FullType(String), FullType(ArticleActionInfo)]));
    print("==result2==>$result2");
  });

  test("tset list json parse primitive ", () {
    var jsonText1 = '''
           [
             1,
             2,
             3
           ]
       ''';
    var result1 = builtJsonSerializers.parseObject(jsonText1);
    print("==result1==>$result1");

    var jsonText2 = '''
           {
            "1" : "2"
           }
       ''';
    var result2 = builtJsonSerializers.parseObject(jsonText2,
        specifiedType: FullType(BuiltMap, [FullType(num), FullType(String)]));
    print("==result2==>$result2");
    Map<num, String> map = {1: "2"};
    var result3 = map[1];
//    var result3=builtJsonSerializers.toJson(map);
    print("==result3==>$result3");
  });
}
