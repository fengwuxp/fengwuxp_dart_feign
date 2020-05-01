import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';

            import '../serializers.dart';

    part 'user.g.dart';

     /// 用户信息描述




abstract class User implements Built<User, UserBuilder>, JsonSerializableObject {

       User._();

      factory User([Function(UserBuilder) updates]) = _$User;


        @override
        Map<String, dynamic> toMap() {
            return serializers.serializeWith(User.serializer, this);
        }

        @override
        String toJson() {
           return json.encode(toMap());
        }

        static Serializer<User> get serializer => _$userSerializer;

        static User formJson(String json) {
             return serializers.deserializeWith(User.serializer, jsonDecode(json));
        }

}
