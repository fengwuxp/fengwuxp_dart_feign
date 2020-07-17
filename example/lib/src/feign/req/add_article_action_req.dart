import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';

import '../article_action_type.dart';
import '../serializers.dart';

part 'add_article_action_req.g.dart';

     /// 创建文章互动记录




abstract class AddArticleActionReq implements Built<AddArticleActionReq, AddArticleActionReqBuilder>, JsonSerializableObject {

       AddArticleActionReq._();

      factory AddArticleActionReq([Function(AddArticleActionReqBuilder) updates]) = _$AddArticleActionReq;


                    /// 文章ID
                    /// 属性：articleId为必填项，不能为空
                    /// 在java中的类型为：Long
                @nullable
                @BuiltValueField(wireName: 'articleId')
                int get articleId;

                    /// 互动类型
                    /// 属性：actionType为必填项，不能为空
                    /// 在java中的类型为：ArticleActionType
                @nullable
                @BuiltValueField(wireName: 'actionType')
                ArticleActionType get actionType;

                    /// 关联来源
                    /// 属性：sourceCode为必填项，不能为空
                    /// 属性：sourceCode输入字符串的最小长度为：0，输入字符串的最大长度为：64
                    /// 在java中的类型为：String
                @nullable
                @BuiltValueField(wireName: 'sourceCode')
                String get sourceCode;

                    /// 访问的客户端ip
                    /// 在java中的类型为：String
                @nullable
                @BuiltValueField(wireName: 'ip')
                String get ip;

        @override
        Map<String, dynamic> toMap() {
            return serializers.serializeWith(AddArticleActionReq.serializer, this);
        }

        @override
        String toJson() {
           return json.encode(toMap());
        }

        static Serializer<AddArticleActionReq> get serializer => _$addArticleActionReqSerializer;

        static AddArticleActionReq formJson(String json) {
             return serializers.deserializeWith(AddArticleActionReq.serializer, jsonDecode(json));
        }

}
