import 'package:fengwuxp_dart_openfeign/src/annotations/feign_client.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/request_mapping.dart';
import 'package:fengwuxp_dart_openfeign/src/feign_proxy_client.dart';
import 'package:fengwuxp_dart_openfeign/src/feign_request_options.dart';

import 'info/page_article_action_info.dart';
import 'req/find_article_actions_req.dart';

/// 查询文章交互
@FeignClient(value: "/article_action")
class ArticleActionFeignClient extends FeignProxyClient {
  @GetMapping(value: "/query")
  Future<PageArticleActionInfo> query(FindArticleActionsReq req, [UIOptions feignOptions]) {
    return this.delegateInvoke<PageArticleActionInfo>("query", [req],
        feignOptions: feignOptions, serializer: BuiltValueSerializable(serializer: PageArticleActionInfo.serializer));
  }
}

final articleActionFeignClient = ArticleActionFeignClient();
