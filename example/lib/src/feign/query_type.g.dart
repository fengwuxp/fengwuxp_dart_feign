// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const QueryType _$QUERY_NUM = const QueryType._('QUERY_NUM');
const QueryType _$QUERY_RESET = const QueryType._('QUERY_RESET');
const QueryType _$QUERY_BOTH = const QueryType._('QUERY_BOTH');

QueryType _$valueOf(String name) {
  switch (name) {
    case 'QUERY_NUM':
      return _$QUERY_NUM;
    case 'QUERY_RESET':
      return _$QUERY_RESET;
    case 'QUERY_BOTH':
      return _$QUERY_BOTH;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<QueryType> _$values = new BuiltSet<QueryType>(const <QueryType>[
  _$QUERY_NUM,
  _$QUERY_RESET,
  _$QUERY_BOTH,
]);

Serializer<QueryType> _$queryTypeSerializer = new _$QueryTypeSerializer();

class _$QueryTypeSerializer implements PrimitiveSerializer<QueryType> {
  @override
  final Iterable<Type> types = const <Type>[QueryType];
  @override
  final String wireName = 'QueryType';

  @override
  Object serialize(Serializers serializers, QueryType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  QueryType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      QueryType.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
