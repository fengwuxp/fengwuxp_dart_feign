#### 快速开始

##### 接入方式

- 依赖 [fengwuxp_openfeign_boot](./build) ，可以参考 [example](./example)
```yaml
  fengwuxp_dart_basic:
    git: https://github.com/fengwuxp/fengwuxp_dart_basic.git
  fengwuxp_openfeign_boot:
    git: https://github.com/fengwuxp/fengwuxp_dart_feign.git
    path: boot
```

- 编写接口模板
```dart
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

/// 接口：POST
@Feign
@FeignClient(
  value: '/article_action',
)
class ArticleActionFeignClient extends FeignProxyClient {
  ArticleActionFeignClient() : super() {}

  /// 1:接口方法：GET
  /// 2:ArticleAction
  /// 3:返回值在java中的类型为：ApiResp
  /// 4:返回值在java中的类型为：Pagination
  /// 5:返回值在java中的类型为：ArticleActionInfo
  @GetMapping(
    value: '/query',
  )
  Future<PageInfo<ArticleActionInfo>> query(QueryArticleActionReq req, [UIOptions? feignOptions]) {
    return this.delegateInvoke<PageInfo<ArticleActionInfo>>(
        "query",
        [
          req,
        ],
        feignOptions: feignOptions,
        serializer: BuiltValueSerializable(specifiedType: FullType(PageInfo, [FullType(ArticleActionInfo)])));
  }

  /// 1:接口方法：POST
  /// 2:ArticleAction
  /// 3:返回值在java中的类型为：ApiResp
  /// 4:返回值在java中的类型为：Long
  @PostMapping(
    value: '/create',
  )
  Future<int> create(AddArticleActionReq req, [UIOptions? feignOptions]) {
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
  Future<ArticleActionInfo> detail(@PathVariable() int id, [UIOptions? feignOptions]) {
    return this.delegateInvoke<ArticleActionInfo>(
        "detail",
        [
          id,
        ],
        feignOptions: feignOptions,
        serializer: BuiltValueSerializable(serializeType: ArticleActionInfo,));
  }

  /// 1:接口方法：PUT
  /// 2:ArticleAction
  /// 3:返回值在java中的类型为：ApiResp
  /// 4:返回值在java中的类型为：Void
  @PutMapping(
    value: '/edit',
  )
  Future<void> edit(EditArticleActionReq req, [UIOptions? feignOptions]) {
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
  Future<void> delete(DeleteArticleActionReq req, [UIOptions? feignOptions]) {
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


```

- 提供自动生成 api 工具 [common-codegen](https://github.com/fengwuxp/common-codegen) 暂时只支持 java 服务端代码

- 在 sdk 目录增加 build.yaml, 内容如下（目录不一样的话请自行调整）。
```yaml
targets:
  $default:
    builders:
      reflectable:
        generate_for:
          - lib/src/feign/**_client.dart
        options:
          formatted: true
```

- 使用 build 命令生成 sdk 需要的 .g.dart 和 .reflectable.dart 依赖
```shell
// 生成项目目录下的文件
flutter packages pub run build_runner build --delete-conflicting-outputs

/// 生成测试用例下的文件
flutter packages pub run build_runner build test --delete-conflicting-outputs

```

- 初始化 sdk
```dart
 FeignInitializer.form(new ExampleFeignConfigurationRegistry(), BuiltJsonSerializers(serializers))
      .businessResponseExtractor((responseBody) {
        // 判断响应是否成功
        final resp = jsonDecode(responseBody);
        if (resp["code"] != 0) {
          // 只返回响应中的 data，具体看接口中方法返回值的定义
          return Future.error(resp.data);
        }
        return Future.value(resp);
      })
      .apiSignatureStrategy(md5signatureStrategy)
      .initialize();
```
