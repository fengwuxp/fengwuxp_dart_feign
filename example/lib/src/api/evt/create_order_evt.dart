import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';

            import './base_evt.dart';
            import '../serializers.dart';

    part 'create_order_evt.g.dart';





abstract class CreateOrderEvt implements Built<CreateOrderEvt, CreateOrderEvtBuilder>, JsonSerializableObject {

       CreateOrderEvt._();

      factory CreateOrderEvt([Function(CreateOrderEvtBuilder) updates]) = _$CreateOrderEvt;


                    /// 属性：sn输入字符串的最小长度为：0，输入字符串的最大长度为：50
                    /// 在java中的类型为：String
                @nullable
                @BuiltValueField(wireName: 'sn')
                String get sn;

                    /// 属性：totalAmount为必填项，不能为空
                    /// 在java中的类型为：Integer
                @nullable
                @BuiltValueField(wireName: 'totalAmount')
                num get totalAmount;

        @override
        Map<String, dynamic> toMap() {
            return serializers.serializeWith(CreateOrderEvt.serializer, this);
        }

        @override
        String toJson() {
           return json.encode(toMap());
        }

        static Serializer<CreateOrderEvt> get serializer => _$createOrderEvtSerializer;

        static CreateOrderEvt formJson(String json) {
             return serializers.deserializeWith(CreateOrderEvt.serializer, jsonDecode(json));
        }

}
