// Copyright (c) 2015, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:fengwuxp_dart_openfeign/src/built/date_time_serializer.dart';

import '../cms/enums/article_action_type.dart';
import '../cms/info/article_action_info.dart';
import '../cms/info/page_article_action_info.dart';
import '../cms/req/find_article_actions_req.dart';
import '../cms/resp/api_resp.dart';
import '../cms/resp/page_info.dart';
import 'data_model.dart';
import 'hello/hello.dart';
import 'hello/title.dart';
import 'req/query_hello_req.dart';

part 'serializers.g.dart';

/// Example of how to use built_value serialization.
///
/// Declare a top level [Serializers] field called serializers. Annotate it
/// with [SerializersFor] and provide a `const` `List` of types you want to
/// be serializable.
///
/// The built_value code generator will provide the implementation. It will
/// contain serializers for all the types asked for explicitly plus all the
/// types needed transitively via fields.
///
/// You usually only need to do this once per project.
@SerializersFor(const [
  Hello,
  QueryHelloReq,
  Chat,
  ListUsers,
  ListUsersResponse,
  Login,
  LoginResponse,
  ShowChat,
  Status,
  Welcome,
  PageInfo,
  ArticleActionInfo,
  FindArticleActionsReq,
  PageArticleActionInfo,
  ArticleActionType,
  ApiResp
])
//const FullType(PageInfo,[FullType(ArticleActionInfo)],(){
//return PageInfo<ArticleActionInfo>;
final Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(PageInfo, [FullType(ArticleActionInfo)]),
        () => PageInfoBuilder<ArticleActionInfo>())
      ..addBuilderFactory(
        const FullType(PageInfo, [FullType(FindArticleActionsReq)]),
        () => PageInfoBuilder<FindArticleActionsReq>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltMap, [FullType(String), FullType(ArticleActionInfo)]),
        () => MapBuilder<String, ArticleActionInfo>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltMap, [FullType(num), FullType(String)]),
        () => MapBuilder<num, String>(),
      )
      ..addBuilderFactory(const FullType(BuiltList, const [const FullType(FindArticleActionsReq)]),
          () => new ListBuilder<FindArticleActionsReq>())
      ..addPlugin(StandardJsonPlugin())
      ..add(DateTimeMillisecondsSerializer()))
    .build();
