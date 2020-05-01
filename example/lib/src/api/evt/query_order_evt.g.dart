// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_order_evt.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<QueryOrderEvt> _$queryOrderEvtSerializer =
    new _$QueryOrderEvtSerializer();

class _$QueryOrderEvtSerializer implements StructuredSerializer<QueryOrderEvt> {
  @override
  final Iterable<Type> types = const [QueryOrderEvt, _$QueryOrderEvt];
  @override
  final String wireName = 'QueryOrderEvt';

  @override
  Iterable<Object> serialize(Serializers serializers, QueryOrderEvt object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.sn != null) {
      result
        ..add('sn')
        ..add(serializers.serialize(object.sn,
            specifiedType: const FullType(String)));
    }
    if (object.ids != null) {
      result
        ..add('ids')
        ..add(serializers.serialize(object.ids,
            specifiedType:
                const FullType(BuiltList, const [const FullType(num)])));
    }
    return result;
  }

  @override
  QueryOrderEvt deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new QueryOrderEvtBuilder();

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
        case 'ids':
          result.ids.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(num)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$QueryOrderEvt extends QueryOrderEvt {
  @override
  final String sn;
  @override
  final BuiltList<num> ids;

  factory _$QueryOrderEvt([void Function(QueryOrderEvtBuilder) updates]) =>
      (new QueryOrderEvtBuilder()..update(updates)).build();

  _$QueryOrderEvt._({this.sn, this.ids}) : super._();

  @override
  QueryOrderEvt rebuild(void Function(QueryOrderEvtBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QueryOrderEvtBuilder toBuilder() => new QueryOrderEvtBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QueryOrderEvt && sn == other.sn && ids == other.ids;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, sn.hashCode), ids.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('QueryOrderEvt')
          ..add('sn', sn)
          ..add('ids', ids))
        .toString();
  }
}

class QueryOrderEvtBuilder
    implements Builder<QueryOrderEvt, QueryOrderEvtBuilder> {
  _$QueryOrderEvt _$v;

  String _sn;
  String get sn => _$this._sn;
  set sn(String sn) => _$this._sn = sn;

  ListBuilder<num> _ids;
  ListBuilder<num> get ids => _$this._ids ??= new ListBuilder<num>();
  set ids(ListBuilder<num> ids) => _$this._ids = ids;

  QueryOrderEvtBuilder();

  QueryOrderEvtBuilder get _$this {
    if (_$v != null) {
      _sn = _$v.sn;
      _ids = _$v.ids?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QueryOrderEvt other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$QueryOrderEvt;
  }

  @override
  void update(void Function(QueryOrderEvtBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$QueryOrderEvt build() {
    _$QueryOrderEvt _$result;
    try {
      _$result = _$v ?? new _$QueryOrderEvt._(sn: sn, ids: _ids?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'ids';
        _ids?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'QueryOrderEvt', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
