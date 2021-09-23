import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_openfeign_example/src/feign/serializers.dart';


part 'api_resp.g.dart';

abstract class ApiResp<T> implements Built<ApiResp<T>, ApiRespBuilder<T>>, JsonSerializableObject {
  static Serializer<ApiResp> get serializer => _$apiRespSerializer;

  ApiResp._();

  factory ApiResp([updates(ApiRespBuilder<T> b)]) = _$ApiResp<T>;

  @BuiltValueField(wireName: 'data')
  T? get data;

  @BuiltValueField(wireName: 'message')
  String? get message;

  @BuiltValueField(wireName: 'code')
  int get code;

  bool get success => code == 0;

  static ApiResp<T> formJson<T>(Map map, FullType specifiedType) {
    return serializers.deserialize(map, specifiedType: FullType(ApiResp, [specifiedType])) as ApiResp<T>;
  }

  static ApiResp formJsonBySerializer(Map map) {
    return serializers.deserializeWith(ApiResp.serializer, map) as ApiResp;
  }

  @override
  Map<String, dynamic> toMap() {
    return serializers.serializeWith(ApiResp.serializer, this) as Map<String, dynamic>;
  }

  @override
  String toJson() {
    return json.encode(toMap());
  }
}
