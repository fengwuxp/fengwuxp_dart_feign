
import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';

import '../serializers.dart';

part 'query_hello_req.g.dart';

abstract class QueryHelloReq implements Built<QueryHelloReq, QueryHelloReqBuilder>,JsonSerializableObject {
  static Serializer<QueryHelloReq> get serializer => _$queryHelloReqSerializer;

  QueryHelloReq._();

  factory QueryHelloReq([updates(QueryHelloReqBuilder b)]) = _$QueryHelloReq;

  @BuiltValueField(wireName: 'id')
  int get id;

  @BuiltValueField(wireName: 'date')
  String get date;

  @BuiltValueField(wireName: 'date_gmt')
  String get dateGmt;

  @BuiltValueField(wireName: 'type')
  String get type;

  @BuiltValueField(wireName: 'link')
  String get link;

  @override
  Map<String, dynamic> toMap() {
    return serializers.serializeWith(QueryHelloReq.serializer, this);
  }

  @override
  String toJson() {
    return json.encode(toMap());
  }
}
