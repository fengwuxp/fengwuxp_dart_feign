import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';

import '../query_type.dart';
import '../serializers.dart';

part 'api_base_query_req.g.dart';

     /// 基础的查询请求对象




abstract class ApiBaseQueryReq implements Built<ApiBaseQueryReq, ApiBaseQueryReqBuilder>, JsonSerializableObject {

       ApiBaseQueryReq._();

      factory ApiBaseQueryReq([Function(ApiBaseQueryReqBuilder) updates]) = _$ApiBaseQueryReq;


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

                    /// 在java中的类型为：数组
                    /// 在java中的类型为：String
                @nullable
                @BuiltValueField(wireName: 'orderByArr')
                BuiltList<String> get orderByArr;

                    /// 在java中的类型为：String
                @nullable
                @BuiltValueField(wireName: 'join')
                String get join;

        @override
        Map<String, dynamic> toMap() {
            return serializers.serializeWith(ApiBaseQueryReq.serializer, this);
        }

        @override
        String toJson() {
           return json.encode(toMap());
        }

        static Serializer<ApiBaseQueryReq> get serializer => _$apiBaseQueryReqSerializer;

        static ApiBaseQueryReq formJson(String json) {
             return serializers.deserializeWith(ApiBaseQueryReq.serializer, jsonDecode(json));
        }

}
