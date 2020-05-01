// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_query_evt.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BaseQueryEvt> _$baseQueryEvtSerializer =
    new _$BaseQueryEvtSerializer();

class _$BaseQueryEvtSerializer implements StructuredSerializer<BaseQueryEvt> {
  @override
  final Iterable<Type> types = const [BaseQueryEvt, _$BaseQueryEvt];
  @override
  final String wireName = 'BaseQueryEvt';

  @override
  Iterable<Object> serialize(Serializers serializers, BaseQueryEvt object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.querySize != null) {
      result
        ..add('querySize')
        ..add(serializers.serialize(object.querySize,
            specifiedType: const FullType(num)));
    }
    if (object.queryPage != null) {
      result
        ..add('queryPage')
        ..add(serializers.serialize(object.queryPage,
            specifiedType: const FullType(num)));
    }
    return result;
  }

  @override
  BaseQueryEvt deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BaseQueryEvtBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'querySize':
          result.querySize = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num;
          break;
        case 'queryPage':
          result.queryPage = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num;
          break;
      }
    }

    return result.build();
  }
}

class _$BaseQueryEvt extends BaseQueryEvt {
  @override
  final num querySize;
  @override
  final num queryPage;

  factory _$BaseQueryEvt([void Function(BaseQueryEvtBuilder) updates]) =>
      (new BaseQueryEvtBuilder()..update(updates)).build();

  _$BaseQueryEvt._({this.querySize, this.queryPage}) : super._();

  @override
  BaseQueryEvt rebuild(void Function(BaseQueryEvtBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BaseQueryEvtBuilder toBuilder() => new BaseQueryEvtBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseQueryEvt &&
        querySize == other.querySize &&
        queryPage == other.queryPage;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, querySize.hashCode), queryPage.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BaseQueryEvt')
          ..add('querySize', querySize)
          ..add('queryPage', queryPage))
        .toString();
  }
}

class BaseQueryEvtBuilder
    implements Builder<BaseQueryEvt, BaseQueryEvtBuilder> {
  _$BaseQueryEvt _$v;

  num _querySize;
  num get querySize => _$this._querySize;
  set querySize(num querySize) => _$this._querySize = querySize;

  num _queryPage;
  num get queryPage => _$this._queryPage;
  set queryPage(num queryPage) => _$this._queryPage = queryPage;

  BaseQueryEvtBuilder();

  BaseQueryEvtBuilder get _$this {
    if (_$v != null) {
      _querySize = _$v.querySize;
      _queryPage = _$v.queryPage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BaseQueryEvt other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BaseQueryEvt;
  }

  @override
  void update(void Function(BaseQueryEvtBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BaseQueryEvt build() {
    final _$result =
        _$v ?? new _$BaseQueryEvt._(querySize: querySize, queryPage: queryPage);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
