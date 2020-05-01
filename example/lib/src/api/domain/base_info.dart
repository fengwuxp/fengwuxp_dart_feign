import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';

            import '../serializers.dart';

    part 'base_info.g.dart';





abstract class BaseInfo<ID,T> implements Built<BaseInfo<ID,T>, BaseInfoBuilder<ID,T>>, JsonSerializableObject {

       BaseInfo._();

      factory BaseInfo([Function(BaseInfoBuilder<ID,T>) updates]) = _$BaseInfo<ID,T>;


                @nullable
                @BuiltValueField(wireName: 'id')
                ID get id;

                @nullable
                @BuiltValueField(wireName: 'data')
                T get data;

        @override
        Map<String, dynamic> toMap() {
            return serializers.serializeWith(BaseInfo.serializer, this);
        }

        @override
        String toJson() {
           return json.encode(toMap());
        }

        static Serializer<BaseInfo> get serializer => _$baseInfoSerializer;

        static BaseInfo formJson(String json) {
             return serializers.deserializeWith(BaseInfo.serializer, jsonDecode(json));
        }

}
