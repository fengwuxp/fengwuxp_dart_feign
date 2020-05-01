import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';

import '../../built/serializers.dart';
import 'article_action_info.dart';

part 'page_article_action_info.g.dart';

abstract class PageArticleActionInfo implements Built<PageArticleActionInfo, PageArticleActionInfoBuilder>, JsonSerializableObject {
  PageArticleActionInfo._();

  factory PageArticleActionInfo([Function(PageArticleActionInfoBuilder) updates]) = _$PageArticleActionInfo;

  @BuiltValueField(wireName: 'total')
  @nullable
  int get total;

  @BuiltValueField(wireName: 'records')
  BuiltList<ArticleActionInfo> get records;

  @BuiltValueField(wireName: 'querySize')
  int get querySize;

  @BuiltValueField(wireName: 'queryPage')
  int get queryPage;

  @BuiltValueField(wireName: 'queryType')
  String get queryType;

  static Serializer<PageArticleActionInfo> get serializer => _$pageArticleActionInfoSerializer;

  static PageArticleActionInfo formJson(String json) {
    return serializers.deserializeWith(PageArticleActionInfo.serializer, jsonDecode(json));
  }

  @override
  Map<String, dynamic> toMap() {
    return serializers.serializeWith(PageArticleActionInfo.serializer, this);
  }

  @override
  String toJson() {
    return json.encode(toMap());
  }
}
