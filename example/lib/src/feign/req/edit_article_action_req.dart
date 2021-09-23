import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';

import '../article_action_type.dart';
import '../serializers.dart';

part 'edit_article_action_req.g.dart';

/// 编辑ArticleAction

abstract class EditArticleActionReq
    implements Built<EditArticleActionReq, EditArticleActionReqBuilder>, JsonSerializableObject {
  EditArticleActionReq._();

  factory EditArticleActionReq([Function(EditArticleActionReqBuilder) updates]) = _$EditArticleActionReq;

  /// ID
  /// 属性：id为必填项，不能为空
  /// 在java中的类型为：Long
  @BuiltValueField(wireName: 'id')
  int? get id;

  /// 文章ID
  /// 在java中的类型为：Long
  @BuiltValueField(wireName: 'articleId')
  int? get articleId;

  /// 互动类型
  /// 在java中的类型为：ArticleActionType
  @BuiltValueField(wireName: 'actionType')
  ArticleActionType? get actionType;

  /// 属性：sourceCode输入字符串的最小长度为：0，输入字符串的最大长度为：64
  /// 关联来源
  /// 在java中的类型为：String
  @BuiltValueField(wireName: 'sourceCode')
  String? get sourceCode;

  /// 创建日期
  /// 在java中的类型为：Date
  @BuiltValueField(wireName: 'crateTime')
  DateTime? get crateTime;

  /// 访问的客户端ip
  /// 在java中的类型为：String
  @BuiltValueField(wireName: 'ip')
  String? get ip;

  @override
  Map<String, dynamic> toMap() {
    return serializers.serializeWith(EditArticleActionReq.serializer, this) as Map<String, dynamic>;
  }

  @override
  String toJson() {
    return json.encode(toMap());
  }

  static Serializer<EditArticleActionReq> get serializer => _$editArticleActionReqSerializer;

  static EditArticleActionReq formJson(String json) {
    return serializers.deserializeWith(EditArticleActionReq.serializer, jsonDecode(json)) as EditArticleActionReq;
  }
}
