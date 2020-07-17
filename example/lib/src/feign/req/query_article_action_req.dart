import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';

import '../article_action_type.dart';
import '../query_type.dart';
import '../serializers.dart';

part 'query_article_action_req.g.dart';

     /// 查询ArticleAction




abstract class QueryArticleActionReq implements Built<QueryArticleActionReq, QueryArticleActionReqBuilder>, JsonSerializableObject {

       QueryArticleActionReq._();

      factory QueryArticleActionReq([Function(QueryArticleActionReqBuilder) updates]) = _$QueryArticleActionReq;


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

                    /// 最小创建日期
                    /// 在java中的类型为：Date
                @nullable
                @BuiltValueField(wireName: 'minCrateTime')
                DateTime get minCrateTime;

                    /// 最大创建日期
                    /// 在java中的类型为：Date
                @nullable
                @BuiltValueField(wireName: 'maxCrateTime')
                DateTime get maxCrateTime;

                    /// 访问的客户端ip
                    /// 在java中的类型为：String
                @nullable
                @BuiltValueField(wireName: 'ip')
                String get ip;

                    /// 查询类型,默认查询结果集
                    /// 属性：queryType为必填项，不能为空
                    /// 在java中的类型为：QueryType
                @nullable
                @BuiltValueField(wireName: 'queryType')
                QueryType get queryType;

                    /// 查询页码，从1开始
                    /// 属性：queryPage为必填项，不能为空
                    /// 在java中的类型为：Integer
                @nullable
                @BuiltValueField(wireName: 'queryPage')
                int get queryPage;

                    /// 查询大小，默认20
                    /// 属性：querySize为必填项，不能为空
                    /// 在java中的类型为：Integer
                @nullable
                @BuiltValueField(wireName: 'querySize')
                int get querySize;

                    /// 排序字段
                    /// 在java中的类型为：数组
                    /// 在java中的类型为：String
                @nullable
                @BuiltValueField(wireName: 'orderBy')
                BuiltList<String> get orderBy;

                    /// 排序类型，"asc"升序，"desc"降序，必须与orderBy一一对应
                    /// 在java中的类型为：数组
                    /// 在java中的类型为：String
                @nullable
                @BuiltValueField(wireName: 'orderType')
                BuiltList<String> get orderType;

                    /// 是否使用缓存
                    /// 在java中的类型为：Boolean
                @nullable
                @BuiltValueField(wireName: 'fromCache')
                bool get fromCache;

        @override
        Map<String, dynamic> toMap() {
            return serializers.serializeWith(QueryArticleActionReq.serializer, this);
        }

        @override
        String toJson() {
           return json.encode(toMap());
        }

        static Serializer<QueryArticleActionReq> get serializer => _$queryArticleActionReqSerializer;

        static QueryArticleActionReq formJson(String json) {
             return serializers.deserializeWith(QueryArticleActionReq.serializer, jsonDecode(json));
        }

}
