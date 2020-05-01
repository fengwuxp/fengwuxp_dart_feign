// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_evt.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BaseEvt> _$baseEvtSerializer = new _$BaseEvtSerializer();

class _$BaseEvtSerializer implements StructuredSerializer<BaseEvt> {
  @override
  final Iterable<Type> types = const [BaseEvt, _$BaseEvt];
  @override
  final String wireName = 'BaseEvt';

  @override
  Iterable<Object> serialize(Serializers serializers, BaseEvt object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object>[];
  }

  @override
  BaseEvt deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new BaseEvtBuilder().build();
  }
}

class _$BaseEvt extends BaseEvt {
  factory _$BaseEvt([void Function(BaseEvtBuilder) updates]) =>
      (new BaseEvtBuilder()..update(updates)).build();

  _$BaseEvt._() : super._();

  @override
  BaseEvt rebuild(void Function(BaseEvtBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BaseEvtBuilder toBuilder() => new BaseEvtBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseEvt;
  }

  @override
  int get hashCode {
    return 508070834;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('BaseEvt').toString();
  }
}

class BaseEvtBuilder implements Builder<BaseEvt, BaseEvtBuilder> {
  _$BaseEvt _$v;

  BaseEvtBuilder();

  @override
  void replace(BaseEvt other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BaseEvt;
  }

  @override
  void update(void Function(BaseEvtBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BaseEvt build() {
    final _$result = _$v ?? new _$BaseEvt._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
