import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_openfeign/index.dart';

import 'info/article_action_info.dart';
import 'info/page_article_action_info.dart';
import 'req/find_article_actions_req.dart';
import 'resp/page_info.dart';

/// 查询文章交互
//@Feign
@FeignClient(value: "/article_action")
class ArticleActionFeignClient extends FeignProxyClient {
  ArticleActionFeignClient._();

  @GetMapping(value: "/query")
  Future<PageArticleActionInfo> query(FindArticleActionsReq req, [UIOptions feignOptions]) {
    return this.delegateInvoke<PageArticleActionInfo>("query", [req],
        feignOptions: feignOptions, serializer: BuiltValueSerializable(serializer: PageArticleActionInfo.serializer));
  }

  @GetMapping(value: "/query")
  Future<PageInfo<ArticleActionInfo>> query2(FindArticleActionsReq req, [UIOptions feignOptions]) {
    return this
        .delegateInvoke<PageInfo<ArticleActionInfo>>("query2", [req],
            feignOptions: feignOptions,
            serializer: BuiltValueSerializable(
                serializer: PageInfo.serializer, specifiedType: FullType(PageInfo, [FullType(ArticleActionInfo)])));

  }
}

final articleActionFeignClient = ArticleActionFeignClient._();
