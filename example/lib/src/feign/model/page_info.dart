import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';

import '../query_type.dart';
import '../serializers.dart';

part 'page_info.g.dart';

     /// 分页对象




abstract class PageInfo<T> implements Built<PageInfo<T>, PageInfoBuilder<T>>, JsonSerializableObject {

       PageInfo._();

      factory PageInfo([Function(PageInfoBuilder<T>) updates]) = _$PageInfo<T>;


                    /// 总数
                    /// 在java中的类型为：long
                @nullable
                @BuiltValueField(wireName: 'total')
                int get total;

                    /// 查询类型
                    /// 在java中的类型为：QueryType
                @nullable
                @BuiltValueField(wireName: 'queryType')
                QueryType get queryType;

                    /// 查询结果列表
                    /// 在java中的类型为：List
                @nullable
                @BuiltValueField(wireName: 'records')
                BuiltList<T> get records;

                    /// 查询页码
                    /// 在java中的类型为：int
                @nullable
                @BuiltValueField(wireName: 'queryPage')
                num get queryPage;

                    /// 查询大小
                    /// 在java中的类型为：int
                @nullable
                @BuiltValueField(wireName: 'querySize')
                num get querySize;

                    /// 在java中的类型为：boolean
                @nullable
                @BuiltValueField(wireName: 'empty')
                bool get empty;

        @override
        Map<String, dynamic> toMap() {
            return serializers.serializeWith(PageInfo.serializer, this);
        }

        @override
        String toJson() {
           return json.encode(toMap());
        }

        static Serializer<PageInfo> get serializer => _$pageInfoSerializer;

        static PageInfo formJson(String json) {
             return serializers.deserializeWith(PageInfo.serializer, jsonDecode(json));
        }

}
