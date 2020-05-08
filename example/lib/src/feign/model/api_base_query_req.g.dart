// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_base_query_req.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ApiBaseQueryReq> _$apiBaseQueryReqSerializer =
    new _$ApiBaseQueryReqSerializer();

class _$ApiBaseQueryReqSerializer
    implements StructuredSerializer<ApiBaseQueryReq> {
  @override
  final Iterable<Type> types = const [ApiBaseQueryReq, _$ApiBaseQueryReq];
  @override
  final String wireName = 'ApiBaseQueryReq';

  @override
  Iterable<Object> serialize(Serializers serializers, ApiBaseQueryReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.queryType != null) {
      result
        ..add('queryType')
        ..add(serializers.serialize(object.queryType,
            specifiedType: const FullType(QueryType)));
    }
    if (object.queryPage != null) {
      result
        ..add('queryPage')
        ..add(serializers.serialize(object.queryPage,
            specifiedType: const FullType(int)));
    }
    if (object.querySize != null) {
      result
        ..add('querySize')
        ..add(serializers.serialize(object.querySize,
            specifiedType: const FullType(int)));
    }
    if (object.orderBy != null) {
      result
        ..add('orderBy')
        ..add(serializers.serialize(object.orderBy,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    if (object.orderType != null) {
      result
        ..add('orderType')
        ..add(serializers.serialize(object.orderType,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    if (object.fromCache != null) {
      result
        ..add('fromCache')
        ..add(serializers.serialize(object.fromCache,
            specifiedType: const FullType(bool)));
    }
    if (object.orderByArr != null) {
      result
        ..add('orderByArr')
        ..add(serializers.serialize(object.orderByArr,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    if (object.join != null) {
      result
        ..add('join')
        ..add(serializers.serialize(object.join,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ApiBaseQueryReq deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ApiBaseQueryReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'queryType':
          result.queryType = serializers.deserialize(value,
              specifiedType: const FullType(QueryType)) as QueryType;
          break;
        case 'queryPage':
          result.queryPage = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'querySize':
          result.querySize = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'orderBy':
          result.orderBy.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'orderType':
          result.orderType.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'fromCache':
          result.fromCache = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'orderByArr':
          result.orderByArr.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'join':
          result.join = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ApiBaseQueryReq extends ApiBaseQueryReq {
  @override
  final QueryType queryType;
  @override
  final int queryPage;
  @override
  final int querySize;
  @override
  final BuiltList<String> orderBy;
  @override
  final BuiltList<String> orderType;
  @override
  final bool fromCache;
  @override
  final BuiltList<String> orderByArr;
  @override
  final String join;

  factory _$ApiBaseQueryReq([void Function(ApiBaseQueryReqBuilder) updates]) =>
      (new ApiBaseQueryReqBuilder()..update(updates)).build();

  _$ApiBaseQueryReq._(
      {this.queryType,
      this.queryPage,
      this.querySize,
      this.orderBy,
      this.orderType,
      this.fromCache,
      this.orderByArr,
      this.join})
      : super._();

  @override
  ApiBaseQueryReq rebuild(void Function(ApiBaseQueryReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ApiBaseQueryReqBuilder toBuilder() =>
      new ApiBaseQueryReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiBaseQueryReq &&
        queryType == other.queryType &&
        queryPage == other.queryPage &&
        querySize == other.querySize &&
        orderBy == other.orderBy &&
        orderType == other.orderType &&
        fromCache == other.fromCache &&
        orderByArr == other.orderByArr &&
        join == other.join;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, queryType.hashCode), queryPage.hashCode),
                            querySize.hashCode),
                        orderBy.hashCode),
                    orderType.hashCode),
                fromCache.hashCode),
            orderByArr.hashCode),
        join.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ApiBaseQueryReq')
          ..add('queryType', queryType)
          ..add('queryPage', queryPage)
          ..add('querySize', querySize)
          ..add('orderBy', orderBy)
          ..add('orderType', orderType)
          ..add('fromCache', fromCache)
          ..add('orderByArr', orderByArr)
          ..add('join', join))
        .toString();
  }
}

class ApiBaseQueryReqBuilder
    implements Builder<ApiBaseQueryReq, ApiBaseQueryReqBuilder> {
  _$ApiBaseQueryReq _$v;

  QueryType _queryType;
  QueryType get queryType => _$this._queryType;
  set queryType(QueryType queryType) => _$this._queryType = queryType;

  int _queryPage;
  int get queryPage => _$this._queryPage;
  set queryPage(int queryPage) => _$this._queryPage = queryPage;

  int _querySize;
  int get querySize => _$this._querySize;
  set querySize(int querySize) => _$this._querySize = querySize;

  ListBuilder<String> _orderBy;
  ListBuilder<String> get orderBy =>
      _$this._orderBy ??= new ListBuilder<String>();
  set orderBy(ListBuilder<String> orderBy) => _$this._orderBy = orderBy;

  ListBuilder<String> _orderType;
  ListBuilder<String> get orderType =>
      _$this._orderType ??= new ListBuilder<String>();
  set orderType(ListBuilder<String> orderType) => _$this._orderType = orderType;

  bool _fromCache;
  bool get fromCache => _$this._fromCache;
  set fromCache(bool fromCache) => _$this._fromCache = fromCache;

  ListBuilder<String> _orderByArr;
  ListBuilder<String> get orderByArr =>
      _$this._orderByArr ??= new ListBuilder<String>();
  set orderByArr(ListBuilder<String> orderByArr) =>
      _$this._orderByArr = orderByArr;

  String _join;
  String get join => _$this._join;
  set join(String join) => _$this._join = join;

  ApiBaseQueryReqBuilder();

  ApiBaseQueryReqBuilder get _$this {
    if (_$v != null) {
      _queryType = _$v.queryType;
      _queryPage = _$v.queryPage;
      _querySize = _$v.querySize;
      _orderBy = _$v.orderBy?.toBuilder();
      _orderType = _$v.orderType?.toBuilder();
      _fromCache = _$v.fromCache;
      _orderByArr = _$v.orderByArr?.toBuilder();
      _join = _$v.join;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiBaseQueryReq other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ApiBaseQueryReq;
  }

  @override
  void update(void Function(ApiBaseQueryReqBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ApiBaseQueryReq build() {
    _$ApiBaseQueryReq _$result;
    try {
      _$result = _$v ??
          new _$ApiBaseQueryReq._(
              queryType: queryType,
              queryPage: queryPage,
              querySize: querySize,
              orderBy: _orderBy?.build(),
              orderType: _orderType?.build(),
              fromCache: fromCache,
              orderByArr: _orderByArr?.build(),
              join: join);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'orderBy';
        _orderBy?.build();
        _$failedField = 'orderType';
        _orderType?.build();

        _$failedField = 'orderByArr';
        _orderByArr?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ApiBaseQueryReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
