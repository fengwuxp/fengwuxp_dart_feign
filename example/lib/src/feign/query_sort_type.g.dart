// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_sort_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const QuerySortType _$DESC = const QuerySortType._('DESC');
const QuerySortType _$ASC = const QuerySortType._('ASC');

QuerySortType _$valueOf(String name) {
  switch (name) {
    case 'DESC':
      return _$DESC;
    case 'ASC':
      return _$ASC;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<QuerySortType> _$values =
    new BuiltSet<QuerySortType>(const <QuerySortType>[
  _$DESC,
  _$ASC,
]);

Serializer<QuerySortType> _$querySortTypeSerializer =
    new _$QuerySortTypeSerializer();

class _$QuerySortTypeSerializer implements PrimitiveSerializer<QuerySortType> {
  @override
  final Iterable<Type> types = const <Type>[QuerySortType];
  @override
  final String wireName = 'QuerySortType';

  @override
  Object serialize(Serializers serializers, QuerySortType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  QuerySortType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      QuerySortType.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
