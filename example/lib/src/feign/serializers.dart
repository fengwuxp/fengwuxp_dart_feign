// Copyright (c) 2015, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:fengwuxp_dart_openfeign/src/built/date_time_serializer.dart';
import 'package:fengwuxp_openfeign_example/src/feign/model/api_resp.dart';

import './req/edit_article_action_req.dart';
import './req/add_article_action_req.dart';
import './article_action_type.dart';
import './query_type.dart';
import './query_sort_type.dart';
import './req/query_article_action_req.dart';
import './model/api_base_query_req.dart';
import './model/page_info.dart';
import './req/delete_article_action_req.dart';
import './info/article_action_info.dart';

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
  EditArticleActionReq,
  AddArticleActionReq,
  ArticleActionType,
  QueryType,
  QuerySortType,
  QueryArticleActionReq,
  ApiBaseQueryReq,
  PageInfo,
  DeleteArticleActionReq,
  ArticleActionInfo,
  ApiResp
])
final Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
          const FullType(PageInfo, [FullType(ArticleActionInfo)]), () => PageInfoBuilder<ArticleActionInfo>())
      ..addBuilderFactory(
          const FullType(BuiltList, [FullType(ArticleActionInfo)]), () => ListBuilder<ArticleActionInfo>())
      ..addPlugin(StandardJsonPlugin())
      ..add(DateTimeMillisecondsSerializer()))
    .build();
