import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';

import '../../built/serializers.dart';

part 'page_info.g.dart';

abstract class PageInfo<T> implements Built<PageInfo<T>, PageInfoBuilder<T>>, JsonSerializableObject {
  PageInfo._();

  factory PageInfo([Function(PageInfoBuilder<T>) updates]) = _$PageInfo<T>;

  @BuiltValueField(wireName: 'total')
  int get total;

  @BuiltValueField(wireName: 'records')
  BuiltList<T> get records;

  @BuiltValueField(wireName: 'querySize')
  int get querySize;

  @BuiltValueField(wireName: 'queryPage')
  int get queryPage;

  @BuiltValueField(wireName: 'queryType')
  String get queryType;

//  static Serializer<PageInfo<T>> getSerializer<T>() => _$pageInfoSerializer;

  static Serializer<PageInfo> get serializer => _$pageInfoSerializer;

  static PageInfo formJson(String json, [Serializer genericSerializer]) {
    final Map map = jsonDecode(json);

//    var records = (map["records"] as List);
//    records.setRange(0, records.length, records.map((item) {
//      return serializers.deserializeWith(genericSerializer, item);
//    }));
//    map.remove("records");

    var pageInfo = serializers.deserializeWith(PageInfo.serializer, map);
    return pageInfo;
  }

  @override
  Map<String, dynamic> toMap() {
    return serializers.serializeWith(PageInfo.serializer, this);
  }

  @override
  String toJson() {
    return json.encode(toMap());
  }
}
