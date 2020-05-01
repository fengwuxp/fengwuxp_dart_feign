// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_evt.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CreateOrderEvt> _$createOrderEvtSerializer =
    new _$CreateOrderEvtSerializer();

class _$CreateOrderEvtSerializer
    implements StructuredSerializer<CreateOrderEvt> {
  @override
  final Iterable<Type> types = const [CreateOrderEvt, _$CreateOrderEvt];
  @override
  final String wireName = 'CreateOrderEvt';

  @override
  Iterable<Object> serialize(Serializers serializers, CreateOrderEvt object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.sn != null) {
      result
        ..add('sn')
        ..add(serializers.serialize(object.sn,
            specifiedType: const FullType(String)));
    }
    if (object.totalAmount != null) {
      result
        ..add('totalAmount')
        ..add(serializers.serialize(object.totalAmount,
            specifiedType: const FullType(num)));
    }
    return result;
  }

  @override
  CreateOrderEvt deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CreateOrderEvtBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'sn':
          result.sn = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'totalAmount':
          result.totalAmount = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num;
          break;
      }
    }

    return result.build();
  }
}

class _$CreateOrderEvt extends CreateOrderEvt {
  @override
  final String sn;
  @override
  final num totalAmount;

  factory _$CreateOrderEvt([void Function(CreateOrderEvtBuilder) updates]) =>
      (new CreateOrderEvtBuilder()..update(updates)).build();

  _$CreateOrderEvt._({this.sn, this.totalAmount}) : super._();

  @override
  CreateOrderEvt rebuild(void Function(CreateOrderEvtBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateOrderEvtBuilder toBuilder() =>
      new CreateOrderEvtBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateOrderEvt &&
        sn == other.sn &&
        totalAmount == other.totalAmount;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, sn.hashCode), totalAmount.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CreateOrderEvt')
          ..add('sn', sn)
          ..add('totalAmount', totalAmount))
        .toString();
  }
}

class CreateOrderEvtBuilder
    implements Builder<CreateOrderEvt, CreateOrderEvtBuilder> {
  _$CreateOrderEvt _$v;

  String _sn;
  String get sn => _$this._sn;
  set sn(String sn) => _$this._sn = sn;

  num _totalAmount;
  num get totalAmount => _$this._totalAmount;
  set totalAmount(num totalAmount) => _$this._totalAmount = totalAmount;

  CreateOrderEvtBuilder();

  CreateOrderEvtBuilder get _$this {
    if (_$v != null) {
      _sn = _$v.sn;
      _totalAmount = _$v.totalAmount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateOrderEvt other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CreateOrderEvt;
  }

  @override
  void update(void Function(CreateOrderEvtBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CreateOrderEvt build() {
    final _$result =
        _$v ?? new _$CreateOrderEvt._(sn: sn, totalAmount: totalAmount);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
