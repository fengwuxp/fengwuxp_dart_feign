import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/index.dart';

import './article_action_feign_client.reflectable.dart';
import '../article_action_type.dart';
import '../info/article_action_info.dart';
import '../model/api_base_query_req.dart';
import '../model/page_info.dart';
import '../query_sort_type.dart';
import '../query_type.dart';
import '../req/add_article_action_req.dart';
import '../req/delete_article_action_req.dart';
import '../req/edit_article_action_req.dart';
import '../req/query_article_action_req.dart';
import '../serializers.dart';

void main() {
  initializeReflectable();
}

/// 接口：POST
@Feign
@FeignClient(
  value: '/article_action',
)
class ArticleActionFeignClient extends FeignProxyClient {
  ArticleActionFeignClient() : super() {
    main();
  }

  /// 1:接口方法：GET
  /// 2:ArticleAction
  /// 3:返回值在java中的类型为：ApiResp
  /// 4:返回值在java中的类型为：Pagination
  /// 5:返回值在java中的类型为：ArticleActionInfo
  @GetMapping(
    value: '/query',
  )
  Future<PageInfo<ArticleActionInfo>> query(QueryArticleActionReq req, [UIOptions feignOptions]) {
    return this.delegateInvoke<PageInfo<ArticleActionInfo>>(
        "query",
        [
          req,
        ],
        feignOptions: feignOptions,
        serializer: BuiltValueSerializable(
            serializer: PageInfo.serializer, specifiedType: FullType(PageInfo, [FullType(ArticleActionInfo)])));
  }

  /// 1:接口方法：POST
  /// 2:ArticleAction
  /// 3:返回值在java中的类型为：ApiResp
  /// 4:返回值在java中的类型为：Long
  @PostMapping(
    value: '/create',
  )
  Future<int> create(AddArticleActionReq req, [UIOptions feignOptions]) {
    return this.delegateInvoke<int>(
      "create",
      [
        req,
      ],
      feignOptions: feignOptions,
    );
  }

  /// 1:接口方法：GET
  /// 2:ArticleAction
  /// 3:返回值在java中的类型为：ApiResp
  /// 4:返回值在java中的类型为：ArticleActionInfo
  @GetMapping(
    value: '/{id}',
  )
  Future<ArticleActionInfo> detail(@PathVariable() int id, [UIOptions feignOptions]) {
    return this.delegateInvoke<ArticleActionInfo>(
        "detail",
        [
          id,
        ],
        feignOptions: feignOptions,
        serializer: BuiltValueSerializable(
          serializer: ArticleActionInfo.serializer,
        ));
  }

  /// 1:接口方法：PUT
  /// 2:ArticleAction
  /// 3:返回值在java中的类型为：ApiResp
  /// 4:返回值在java中的类型为：Void
  @PutMapping(
    value: '/edit',
  )
  Future<void> edit(EditArticleActionReq req, [UIOptions feignOptions]) {
    return this.delegateInvoke<void>(
      "edit",
      [
        req,
      ],
      feignOptions: feignOptions,
    );
  }

  /// 1:接口方法：GET
  /// 2:ArticleAction
  /// 3:返回值在java中的类型为：ApiResp
  /// 4:返回值在java中的类型为：Void
  @GetMapping(
    value: '/delete',
  )
  Future<void> delete(DeleteArticleActionReq req, [UIOptions feignOptions]) {
    return this.delegateInvoke<void>(
      "delete",
      [
        req,
      ],
      feignOptions: feignOptions,
    );
  }
}

final articleActionFeignClient = ArticleActionFeignClient();
