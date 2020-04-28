




import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';

import '../../built/serializers.dart';

part 'find_article_actions_req.g.dart';

abstract class FindArticleActionsReq implements Built<FindArticleActionsReq, FindArticleActionsReqBuilder>, JsonSerializableObject {

  FindArticleActionsReq._();

  factory FindArticleActionsReq([updates(FindArticleActionsReqBuilder b)]) = _$FindArticleActionsReq;

  @BuiltValueField(wireName: 'articleId')
  int get articleId;

  @BuiltValueField(wireName: 'sourceCode')
  String get sourceCode;


  static Serializer<FindArticleActionsReq> get serializer => _$findArticleActionsReqSerializer;

  static FindArticleActionsReq formJson(String json) {
    return serializers.deserializeWith(FindArticleActionsReq.serializer, jsonDecode(json));
  }

  @override
  Map<String, dynamic> toMap() {
    return serializers.serializeWith(FindArticleActionsReq.serializer, this);
  }

  @override
  String toJson() {
    return json.encode(toMap());
  }
}
