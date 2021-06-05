// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_article_action_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PageArticleActionInfo> _$pageArticleActionInfoSerializer =
    new _$PageArticleActionInfoSerializer();

class _$PageArticleActionInfoSerializer
    implements StructuredSerializer<PageArticleActionInfo> {
  @override
  final Iterable<Type> types = const [
    PageArticleActionInfo,
    _$PageArticleActionInfo
  ];
  @override
  final String wireName = 'PageArticleActionInfo';

  @override
  Iterable<Object> serialize(
      Serializers serializers, PageArticleActionInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'records',
      serializers.serialize(object.records,
          specifiedType: const FullType(
              BuiltList, const [const FullType(ArticleActionInfo)])),
      'querySize',
      serializers.serialize(object.querySize,
          specifiedType: const FullType(int)),
      'queryPage',
      serializers.serialize(object.queryPage,
          specifiedType: const FullType(int)),
      'queryType',
      serializers.serialize(object.queryType,
          specifiedType: const FullType(String)),
    ];
    Object value;
    value = object.total;
    if (value != null) {
      result
        ..add('total')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  PageArticleActionInfo deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PageArticleActionInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'total':
          result.total = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'records':
          result.records.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ArticleActionInfo)]))
              as BuiltList<Object>);
          break;
        case 'querySize':
          result.querySize = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'queryPage':
          result.queryPage = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'queryType':
          result.queryType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$PageArticleActionInfo extends PageArticleActionInfo {
  @override
  final int total;
  @override
  final BuiltList<ArticleActionInfo> records;
  @override
  final int querySize;
  @override
  final int queryPage;
  @override
  final String queryType;

  factory _$PageArticleActionInfo(
          [void Function(PageArticleActionInfoBuilder) updates]) =>
      (new PageArticleActionInfoBuilder()..update(updates)).build();

  _$PageArticleActionInfo._(
      {this.total,
      this.records,
      this.querySize,
      this.queryPage,
      this.queryType})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        records, 'PageArticleActionInfo', 'records');
    BuiltValueNullFieldError.checkNotNull(
        querySize, 'PageArticleActionInfo', 'querySize');
    BuiltValueNullFieldError.checkNotNull(
        queryPage, 'PageArticleActionInfo', 'queryPage');
    BuiltValueNullFieldError.checkNotNull(
        queryType, 'PageArticleActionInfo', 'queryType');
  }

  @override
  PageArticleActionInfo rebuild(
          void Function(PageArticleActionInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PageArticleActionInfoBuilder toBuilder() =>
      new PageArticleActionInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PageArticleActionInfo &&
        total == other.total &&
        records == other.records &&
        querySize == other.querySize &&
        queryPage == other.queryPage &&
        queryType == other.queryType;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, total.hashCode), records.hashCode),
                querySize.hashCode),
            queryPage.hashCode),
        queryType.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PageArticleActionInfo')
          ..add('total', total)
          ..add('records', records)
          ..add('querySize', querySize)
          ..add('queryPage', queryPage)
          ..add('queryType', queryType))
        .toString();
  }
}

class PageArticleActionInfoBuilder
    implements Builder<PageArticleActionInfo, PageArticleActionInfoBuilder> {
  _$PageArticleActionInfo _$v;

  int _total;
  int get total => _$this._total;
  set total(int total) => _$this._total = total;

  ListBuilder<ArticleActionInfo> _records;
  ListBuilder<ArticleActionInfo> get records =>
      _$this._records ??= new ListBuilder<ArticleActionInfo>();
  set records(ListBuilder<ArticleActionInfo> records) =>
      _$this._records = records;

  int _querySize;
  int get querySize => _$this._querySize;
  set querySize(int querySize) => _$this._querySize = querySize;

  int _queryPage;
  int get queryPage => _$this._queryPage;
  set queryPage(int queryPage) => _$this._queryPage = queryPage;

  String _queryType;
  String get queryType => _$this._queryType;
  set queryType(String queryType) => _$this._queryType = queryType;

  PageArticleActionInfoBuilder();

  PageArticleActionInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _total = $v.total;
      _records = $v.records.toBuilder();
      _querySize = $v.querySize;
      _queryPage = $v.queryPage;
      _queryType = $v.queryType;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PageArticleActionInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PageArticleActionInfo;
  }

  @override
  void update(void Function(PageArticleActionInfoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PageArticleActionInfo build() {
    _$PageArticleActionInfo _$result;
    try {
      _$result = _$v ??
          new _$PageArticleActionInfo._(
              total: total,
              records: records.build(),
              querySize: BuiltValueNullFieldError.checkNotNull(
                  querySize, 'PageArticleActionInfo', 'querySize'),
              queryPage: BuiltValueNullFieldError.checkNotNull(
                  queryPage, 'PageArticleActionInfo', 'queryPage'),
              queryType: BuiltValueNullFieldError.checkNotNull(
                  queryType, 'PageArticleActionInfo', 'queryType'));
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'records';
        records.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PageArticleActionInfo', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
