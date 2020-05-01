// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BaseInfo<Object, Object>> _$baseInfoSerializer =
    new _$BaseInfoSerializer();

class _$BaseInfoSerializer
    implements StructuredSerializer<BaseInfo<Object, Object>> {
  @override
  final Iterable<Type> types = const [BaseInfo, _$BaseInfo];
  @override
  final String wireName = 'BaseInfo';

  @override
  Iterable<Object> serialize(
      Serializers serializers, BaseInfo<Object, Object> object,
      {FullType specifiedType = FullType.unspecified}) {
    final isUnderspecified =
        specifiedType.isUnspecified || specifiedType.parameters.isEmpty;
    if (!isUnderspecified) serializers.expectBuilder(specifiedType);
    final parameterID =
        isUnderspecified ? FullType.object : specifiedType.parameters[0];
    final parameterT =
        isUnderspecified ? FullType.object : specifiedType.parameters[1];

    final result = <Object>[];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id, specifiedType: parameterID));
    }
    if (object.data != null) {
      result
        ..add('data')
        ..add(serializers.serialize(object.data, specifiedType: parameterT));
    }
    return result;
  }

  @override
  BaseInfo<Object, Object> deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final isUnderspecified =
        specifiedType.isUnspecified || specifiedType.parameters.isEmpty;
    if (!isUnderspecified) serializers.expectBuilder(specifiedType);
    final parameterID =
        isUnderspecified ? FullType.object : specifiedType.parameters[0];
    final parameterT =
        isUnderspecified ? FullType.object : specifiedType.parameters[1];

    final result = isUnderspecified
        ? new BaseInfoBuilder<Object, Object>()
        : serializers.newBuilder(specifiedType) as BaseInfoBuilder;

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id =
              serializers.deserialize(value, specifiedType: parameterID);
          break;
        case 'data':
          result.data =
              serializers.deserialize(value, specifiedType: parameterT);
          break;
      }
    }

    return result.build();
  }
}

class _$BaseInfo<ID, T> extends BaseInfo<ID, T> {
  @override
  final ID id;
  @override
  final T data;

  factory _$BaseInfo([void Function(BaseInfoBuilder<ID, T>) updates]) =>
      (new BaseInfoBuilder<ID, T>()..update(updates)).build();

  _$BaseInfo._({this.id, this.data}) : super._() {
    if (ID == dynamic) {
      throw new BuiltValueMissingGenericsError('BaseInfo', 'ID');
    }
    if (T == dynamic) {
      throw new BuiltValueMissingGenericsError('BaseInfo', 'T');
    }
  }

  @override
  BaseInfo<ID, T> rebuild(void Function(BaseInfoBuilder<ID, T>) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BaseInfoBuilder<ID, T> toBuilder() =>
      new BaseInfoBuilder<ID, T>()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseInfo && id == other.id && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BaseInfo')
          ..add('id', id)
          ..add('data', data))
        .toString();
  }
}

class BaseInfoBuilder<ID, T>
    implements Builder<BaseInfo<ID, T>, BaseInfoBuilder<ID, T>> {
  _$BaseInfo<ID, T> _$v;

  ID _id;
  ID get id => _$this._id;
  set id(ID id) => _$this._id = id;

  T _data;
  T get data => _$this._data;
  set data(T data) => _$this._data = data;

  BaseInfoBuilder();

  BaseInfoBuilder<ID, T> get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _data = _$v.data;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BaseInfo<ID, T> other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BaseInfo<ID, T>;
  }

  @override
  void update(void Function(BaseInfoBuilder<ID, T>) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BaseInfo<ID, T> build() {
    final _$result = _$v ?? new _$BaseInfo<ID, T>._(id: id, data: data);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
