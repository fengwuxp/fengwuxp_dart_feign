import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';

import '../article_action_type.dart';
import '../serializers.dart';

part 'article_action_info.g.dart';

     /// ArticleAction




abstract class ArticleActionInfo implements Built<ArticleActionInfo, ArticleActionInfoBuilder>, JsonSerializableObject {

       ArticleActionInfo._();

      factory ArticleActionInfo([Function(ArticleActionInfoBuilder) updates]) = _$ArticleActionInfo;


                    /// ID
                    /// 在java中的类型为：Long
                @nullable
                @BuiltValueField(wireName: 'id')
                int get id;

                    /// 文章ID
                    /// 在java中的类型为：Long
                @nullable
                @BuiltValueField(wireName: 'articleId')
                int get articleId;

                    /// 互动类型
                    /// 在java中的类型为：ArticleActionType
                @nullable
                @BuiltValueField(wireName: 'actionType')
                ArticleActionType get actionType;

                    /// 关联来源
                    /// 在java中的类型为：String
                @nullable
                @BuiltValueField(wireName: 'sourceCode')
                String get sourceCode;

                    /// 创建日期
                    /// 在java中的类型为：Date
                @nullable
                @BuiltValueField(wireName: 'crateTime')
                DateTime get crateTime;

                    /// 访问的客户端ip
                    /// 在java中的类型为：String
                @nullable
                @BuiltValueField(wireName: 'ip')
                String get ip;

        @override
        Map<String, dynamic> toMap() {
            return serializers.serializeWith(ArticleActionInfo.serializer, this);
        }

        @override
        String toJson() {
           return json.encode(toMap());
        }

        static Serializer<ArticleActionInfo> get serializer => _$articleActionInfoSerializer;

        static ArticleActionInfo formJson(String json) {
             return serializers.deserializeWith(ArticleActionInfo.serializer, jsonDecode(json));
        }

}
