// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sex.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Sex _$MAN = const Sex._('MAN');
const Sex _$WOMAN = const Sex._('WOMAN');
const Sex _$NONE = const Sex._('NONE');

Sex _$valueOf(String name) {
  switch (name) {
    case 'MAN':
      return _$MAN;
    case 'WOMAN':
      return _$WOMAN;
    case 'NONE':
      return _$NONE;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<Sex> _$values = new BuiltSet<Sex>(const <Sex>[
  _$MAN,
  _$WOMAN,
  _$NONE,
]);

Serializer<Sex> _$sexSerializer = new _$SexSerializer();

class _$SexSerializer implements PrimitiveSerializer<Sex> {
  @override
  final Iterable<Type> types = const <Type>[Sex];
  @override
  final String wireName = 'Sex';

  @override
  Object serialize(Serializers serializers, Sex object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  Sex deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Sex.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
