




import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';

import '../../built/serializers.dart';
import '../enums/article_action_type.dart';

part 'article_action_info.g.dart';

abstract class ArticleActionInfo implements Built<ArticleActionInfo, ArticleActionInfoBuilder>, JsonSerializableObject {

  ArticleActionInfo._();

  factory ArticleActionInfo([updates(ArticleActionInfoBuilder b)]) = _$ArticleActionInfo;

  @BuiltValueField(wireName: 'id')
  int get id;

  @BuiltValueField(wireName: 'articleId')
  int get articleId;

  @BuiltValueField(wireName: 'actionType')
  ArticleActionType get actionType;

  @BuiltValueField(wireName: 'sourceCode')
  String get sourceCode;

  @BuiltValueField(wireName: 'crateTime')
  DateTime get crateTime;

  static Serializer<ArticleActionInfo> get serializer => _$articleActionInfoSerializer;

  static ArticleActionInfo formJson(String json) {
    return serializers.deserializeWith(ArticleActionInfo.serializer, jsonDecode(json));
  }

  @override
  Map<String, dynamic> toMap() {
    return serializers.serializeWith(ArticleActionInfo.serializer, this);
  }

  @override
  String toJson() {
    return json.encode(toMap());
  }
}
