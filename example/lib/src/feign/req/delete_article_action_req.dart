import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';

import '../serializers.dart';

part 'delete_article_action_req.g.dart';

     /// 删除ArticleAction




abstract class DeleteArticleActionReq implements Built<DeleteArticleActionReq, DeleteArticleActionReqBuilder>, JsonSerializableObject {

       DeleteArticleActionReq._();

      factory DeleteArticleActionReq([Function(DeleteArticleActionReqBuilder) updates]) = _$DeleteArticleActionReq;


                    /// ID
                    /// 在java中的类型为：Long
                @nullable
                @BuiltValueField(wireName: 'id')
                int get id;

                    /// ID集合
                    /// 在java中的类型为：数组
                    /// 在java中的类型为：Long
                @nullable
                @BuiltValueField(wireName: 'ids')
                BuiltList<int> get ids;

        @override
        Map<String, dynamic> toMap() {
            return serializers.serializeWith(DeleteArticleActionReq.serializer, this);
        }

        @override
        String toJson() {
           return json.encode(toMap());
        }

        static Serializer<DeleteArticleActionReq> get serializer => _$deleteArticleActionReqSerializer;

        static DeleteArticleActionReq formJson(String json) {
             return serializers.deserializeWith(DeleteArticleActionReq.serializer, jsonDecode(json));
        }

}
