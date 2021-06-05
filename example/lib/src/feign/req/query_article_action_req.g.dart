// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_article_action_req.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<QueryArticleActionReq> _$queryArticleActionReqSerializer =
    new _$QueryArticleActionReqSerializer();

class _$QueryArticleActionReqSerializer
    implements StructuredSerializer<QueryArticleActionReq> {
  @override
  final Iterable<Type> types = const [
    QueryArticleActionReq,
    _$QueryArticleActionReq
  ];
  @override
  final String wireName = 'QueryArticleActionReq';

  @override
  Iterable<Object> serialize(
      Serializers serializers, QueryArticleActionReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.articleId;
    if (value != null) {
      result
        ..add('articleId')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.actionType;
    if (value != null) {
      result
        ..add('actionType')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(ArticleActionType)));
    }
    value = object.sourceCode;
    if (value != null) {
      result
        ..add('sourceCode')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.minCrateTime;
    if (value != null) {
      result
        ..add('minCrateTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.maxCrateTime;
    if (value != null) {
      result
        ..add('maxCrateTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.ip;
    if (value != null) {
      result
        ..add('ip')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.queryType;
    if (value != null) {
      result
        ..add('queryType')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(QueryType)));
    }
    value = object.queryPage;
    if (value != null) {
      result
        ..add('queryPage')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.querySize;
    if (value != null) {
      result
        ..add('querySize')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.orderBy;
    if (value != null) {
      result
        ..add('orderBy')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.orderType;
    if (value != null) {
      result
        ..add('orderType')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.fromCache;
    if (value != null) {
      result
        ..add('fromCache')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  QueryArticleActionReq deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new QueryArticleActionReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'articleId':
          result.articleId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'actionType':
          result.actionType = serializers.deserialize(value,
                  specifiedType: const FullType(ArticleActionType))
              as ArticleActionType;
          break;
        case 'sourceCode':
          result.sourceCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'minCrateTime':
          result.minCrateTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'maxCrateTime':
          result.maxCrateTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'ip':
          result.ip = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
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
      }
    }

    return result.build();
  }
}

class _$QueryArticleActionReq extends QueryArticleActionReq {
  @override
  final int id;
  @override
  final int articleId;
  @override
  final ArticleActionType actionType;
  @override
  final String sourceCode;
  @override
  final DateTime minCrateTime;
  @override
  final DateTime maxCrateTime;
  @override
  final String ip;
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

  factory _$QueryArticleActionReq(
          [void Function(QueryArticleActionReqBuilder) updates]) =>
      (new QueryArticleActionReqBuilder()..update(updates)).build();

  _$QueryArticleActionReq._(
      {this.id,
      this.articleId,
      this.actionType,
      this.sourceCode,
      this.minCrateTime,
      this.maxCrateTime,
      this.ip,
      this.queryType,
      this.queryPage,
      this.querySize,
      this.orderBy,
      this.orderType,
      this.fromCache})
      : super._();

  @override
  QueryArticleActionReq rebuild(
          void Function(QueryArticleActionReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QueryArticleActionReqBuilder toBuilder() =>
      new QueryArticleActionReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QueryArticleActionReq &&
        id == other.id &&
        articleId == other.articleId &&
        actionType == other.actionType &&
        sourceCode == other.sourceCode &&
        minCrateTime == other.minCrateTime &&
        maxCrateTime == other.maxCrateTime &&
        ip == other.ip &&
        queryType == other.queryType &&
        queryPage == other.queryPage &&
        querySize == other.querySize &&
        orderBy == other.orderBy &&
        orderType == other.orderType &&
        fromCache == other.fromCache;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc($jc(0, id.hashCode),
                                                    articleId.hashCode),
                                                actionType.hashCode),
                                            sourceCode.hashCode),
                                        minCrateTime.hashCode),
                                    maxCrateTime.hashCode),
                                ip.hashCode),
                            queryType.hashCode),
                        queryPage.hashCode),
                    querySize.hashCode),
                orderBy.hashCode),
            orderType.hashCode),
        fromCache.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('QueryArticleActionReq')
          ..add('id', id)
          ..add('articleId', articleId)
          ..add('actionType', actionType)
          ..add('sourceCode', sourceCode)
          ..add('minCrateTime', minCrateTime)
          ..add('maxCrateTime', maxCrateTime)
          ..add('ip', ip)
          ..add('queryType', queryType)
          ..add('queryPage', queryPage)
          ..add('querySize', querySize)
          ..add('orderBy', orderBy)
          ..add('orderType', orderType)
          ..add('fromCache', fromCache))
        .toString();
  }
}

class QueryArticleActionReqBuilder
    implements Builder<QueryArticleActionReq, QueryArticleActionReqBuilder> {
  _$QueryArticleActionReq _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  int _articleId;
  int get articleId => _$this._articleId;
  set articleId(int articleId) => _$this._articleId = articleId;

  ArticleActionType _actionType;
  ArticleActionType get actionType => _$this._actionType;
  set actionType(ArticleActionType actionType) =>
      _$this._actionType = actionType;

  String _sourceCode;
  String get sourceCode => _$this._sourceCode;
  set sourceCode(String sourceCode) => _$this._sourceCode = sourceCode;

  DateTime _minCrateTime;
  DateTime get minCrateTime => _$this._minCrateTime;
  set minCrateTime(DateTime minCrateTime) =>
      _$this._minCrateTime = minCrateTime;

  DateTime _maxCrateTime;
  DateTime get maxCrateTime => _$this._maxCrateTime;
  set maxCrateTime(DateTime maxCrateTime) =>
      _$this._maxCrateTime = maxCrateTime;

  String _ip;
  String get ip => _$this._ip;
  set ip(String ip) => _$this._ip = ip;

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

  QueryArticleActionReqBuilder();

  QueryArticleActionReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _articleId = $v.articleId;
      _actionType = $v.actionType;
      _sourceCode = $v.sourceCode;
      _minCrateTime = $v.minCrateTime;
      _maxCrateTime = $v.maxCrateTime;
      _ip = $v.ip;
      _queryType = $v.queryType;
      _queryPage = $v.queryPage;
      _querySize = $v.querySize;
      _orderBy = $v.orderBy?.toBuilder();
      _orderType = $v.orderType?.toBuilder();
      _fromCache = $v.fromCache;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QueryArticleActionReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$QueryArticleActionReq;
  }

  @override
  void update(void Function(QueryArticleActionReqBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$QueryArticleActionReq build() {
    _$QueryArticleActionReq _$result;
    try {
      _$result = _$v ??
          new _$QueryArticleActionReq._(
              id: id,
              articleId: articleId,
              actionType: actionType,
              sourceCode: sourceCode,
              minCrateTime: minCrateTime,
              maxCrateTime: maxCrateTime,
              ip: ip,
              queryType: queryType,
              queryPage: queryPage,
              querySize: querySize,
              orderBy: _orderBy?.build(),
              orderType: _orderType?.build(),
              fromCache: fromCache);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'orderBy';
        _orderBy?.build();
        _$failedField = 'orderType';
        _orderType?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'QueryArticleActionReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
