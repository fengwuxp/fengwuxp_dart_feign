// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Order> _$orderSerializer = new _$OrderSerializer();

class _$OrderSerializer implements StructuredSerializer<Order> {
  @override
  final Iterable<Type> types = const [Order, _$Order];
  @override
  final String wireName = 'Order';

  @override
  Iterable<Object> serialize(Serializers serializers, Order object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.sn != null) {
      result
        ..add('sn')
        ..add(serializers.serialize(object.sn,
            specifiedType: const FullType(String)));
    }
    if (object.user != null) {
      result
        ..add('user')
        ..add(serializers.serialize(object.user,
            specifiedType: const FullType(User)));
    }
    if (object.addTime != null) {
      result
        ..add('addTime')
        ..add(serializers.serialize(object.addTime,
            specifiedType: const FullType(DateTime)));
    }
    return result;
  }

  @override
  Order deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OrderBuilder();

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
        case 'user':
          result.user.replace(serializers.deserialize(value,
              specifiedType: const FullType(User)) as User);
          break;
        case 'addTime':
          result.addTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
      }
    }

    return result.build();
  }
}

class _$Order extends Order {
  @override
  final String sn;
  @override
  final User user;
  @override
  final DateTime addTime;

  factory _$Order([void Function(OrderBuilder) updates]) =>
      (new OrderBuilder()..update(updates)).build();

  _$Order._({this.sn, this.user, this.addTime}) : super._();

  @override
  Order rebuild(void Function(OrderBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderBuilder toBuilder() => new OrderBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Order &&
        sn == other.sn &&
        user == other.user &&
        addTime == other.addTime;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, sn.hashCode), user.hashCode), addTime.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Order')
          ..add('sn', sn)
          ..add('user', user)
          ..add('addTime', addTime))
        .toString();
  }
}

class OrderBuilder implements Builder<Order, OrderBuilder> {
  _$Order _$v;

  String _sn;
  String get sn => _$this._sn;
  set sn(String sn) => _$this._sn = sn;

  UserBuilder _user;
  UserBuilder get user => _$this._user ??= new UserBuilder();
  set user(UserBuilder user) => _$this._user = user;

  DateTime _addTime;
  DateTime get addTime => _$this._addTime;
  set addTime(DateTime addTime) => _$this._addTime = addTime;

  OrderBuilder();

  OrderBuilder get _$this {
    if (_$v != null) {
      _sn = _$v.sn;
      _user = _$v.user?.toBuilder();
      _addTime = _$v.addTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Order other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Order;
  }

  @override
  void update(void Function(OrderBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Order build() {
    _$Order _$result;
    try {
      _$result =
          _$v ?? new _$Order._(sn: sn, user: _user?.build(), addTime: addTime);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        _user?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Order', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
