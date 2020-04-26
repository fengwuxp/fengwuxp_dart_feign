// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_hello_req.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<QueryHelloReq> _$queryHelloReqSerializer =
    new _$QueryHelloReqSerializer();

class _$QueryHelloReqSerializer implements StructuredSerializer<QueryHelloReq> {
  @override
  final Iterable<Type> types = const [QueryHelloReq, _$QueryHelloReq];
  @override
  final String wireName = 'QueryHelloReq';

  @override
  Iterable<Object> serialize(Serializers serializers, QueryHelloReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'date',
      serializers.serialize(object.date, specifiedType: const FullType(String)),
      'date_gmt',
      serializers.serialize(object.dateGmt,
          specifiedType: const FullType(String)),
      'type',
      serializers.serialize(object.type, specifiedType: const FullType(String)),
      'link',
      serializers.serialize(object.link, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  QueryHelloReq deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new QueryHelloReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'date_gmt':
          result.dateGmt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'link':
          result.link = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$QueryHelloReq extends QueryHelloReq {
  @override
  final int id;
  @override
  final String date;
  @override
  final String dateGmt;
  @override
  final String type;
  @override
  final String link;

  factory _$QueryHelloReq([void Function(QueryHelloReqBuilder) updates]) =>
      (new QueryHelloReqBuilder()..update(updates)).build();

  _$QueryHelloReq._({this.id, this.date, this.dateGmt, this.type, this.link})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('QueryHelloReq', 'id');
    }
    if (date == null) {
      throw new BuiltValueNullFieldError('QueryHelloReq', 'date');
    }
    if (dateGmt == null) {
      throw new BuiltValueNullFieldError('QueryHelloReq', 'dateGmt');
    }
    if (type == null) {
      throw new BuiltValueNullFieldError('QueryHelloReq', 'type');
    }
    if (link == null) {
      throw new BuiltValueNullFieldError('QueryHelloReq', 'link');
    }
  }

  @override
  QueryHelloReq rebuild(void Function(QueryHelloReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QueryHelloReqBuilder toBuilder() => new QueryHelloReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QueryHelloReq &&
        id == other.id &&
        date == other.date &&
        dateGmt == other.dateGmt &&
        type == other.type &&
        link == other.link;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, id.hashCode), date.hashCode), dateGmt.hashCode),
            type.hashCode),
        link.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('QueryHelloReq')
          ..add('id', id)
          ..add('date', date)
          ..add('dateGmt', dateGmt)
          ..add('type', type)
          ..add('link', link))
        .toString();
  }
}

class QueryHelloReqBuilder
    implements Builder<QueryHelloReq, QueryHelloReqBuilder> {
  _$QueryHelloReq _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _date;
  String get date => _$this._date;
  set date(String date) => _$this._date = date;

  String _dateGmt;
  String get dateGmt => _$this._dateGmt;
  set dateGmt(String dateGmt) => _$this._dateGmt = dateGmt;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  String _link;
  String get link => _$this._link;
  set link(String link) => _$this._link = link;

  QueryHelloReqBuilder();

  QueryHelloReqBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _date = _$v.date;
      _dateGmt = _$v.dateGmt;
      _type = _$v.type;
      _link = _$v.link;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QueryHelloReq other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$QueryHelloReq;
  }

  @override
  void update(void Function(QueryHelloReqBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$QueryHelloReq build() {
    final _$result = _$v ??
        new _$QueryHelloReq._(
            id: id, date: date, dateGmt: dateGmt, type: type, link: link);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
