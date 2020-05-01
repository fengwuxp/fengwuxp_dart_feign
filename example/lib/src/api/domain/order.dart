import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';

            import './user.dart';
            import './base_info.dart';
            import '../serializers.dart';

    part 'order.g.dart';





abstract class Order implements Built<Order, OrderBuilder>, JsonSerializableObject {

       Order._();

      factory Order([Function(OrderBuilder) updates]) = _$Order;


                    /// 在java中的类型为：String
                @nullable
                @BuiltValueField(wireName: 'sn')
                String get sn;

                    /// 在java中的类型为：User
                @nullable
                @BuiltValueField(wireName: 'user')
                User get user;

                    /// 添加时间
                    /// 在java中的类型为：Date
                @nullable
                @BuiltValueField(wireName: 'addTime')
                DateTime get addTime;

        @override
        Map<String, dynamic> toMap() {
            return serializers.serializeWith(Order.serializer, this);
        }

        @override
        String toJson() {
           return json.encode(toMap());
        }

        static Serializer<Order> get serializer => _$orderSerializer;

        static Order formJson(String json) {
             return serializers.deserializeWith(Order.serializer, jsonDecode(json));
        }

}
