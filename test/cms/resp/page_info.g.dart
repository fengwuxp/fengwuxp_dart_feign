// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PageInfo<Object>> _$pageInfoSerializer = new _$PageInfoSerializer();

class _$PageInfoSerializer implements StructuredSerializer<PageInfo<Object>> {
  @override
  final Iterable<Type> types = const [PageInfo, _$PageInfo];
  @override
  final String wireName = 'PageInfo';

  @override
  Iterable<Object> serialize(Serializers serializers, PageInfo<Object> object,
      {FullType specifiedType = FullType.unspecified}) {
    final isUnderspecified =
        specifiedType.isUnspecified || specifiedType.parameters.isEmpty;
    if (!isUnderspecified) serializers.expectBuilder(specifiedType);
    final parameterT =
        isUnderspecified ? FullType.object : specifiedType.parameters[0];

    final result = <Object>[
      'total',
      serializers.serialize(object.total, specifiedType: const FullType(int)),
      'records',
      serializers.serialize(object.records,
          specifiedType: new FullType(BuiltList, [parameterT])),
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

    return result;
  }

  @override
  PageInfo<Object> deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final isUnderspecified =
        specifiedType.isUnspecified || specifiedType.parameters.isEmpty;
    if (!isUnderspecified) serializers.expectBuilder(specifiedType);
    final parameterT =
        isUnderspecified ? FullType.object : specifiedType.parameters[0];

    final result = isUnderspecified
        ? new PageInfoBuilder<Object>()
        : serializers.newBuilder(specifiedType) as PageInfoBuilder;

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'total':
          result.total = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'records':
          result.records.replace(serializers.deserialize(value,
                  specifiedType: new FullType(BuiltList, [parameterT]))
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

class _$PageInfo<T> extends PageInfo<T> {
  @override
  final int total;
  @override
  final BuiltList<T> records;
  @override
  final int querySize;
  @override
  final int queryPage;
  @override
  final String queryType;

  factory _$PageInfo([void Function(PageInfoBuilder<T>) updates]) =>
      (new PageInfoBuilder<T>()..update(updates)).build();

  _$PageInfo._(
      {this.total,
      this.records,
      this.querySize,
      this.queryPage,
      this.queryType})
      : super._() {
    if (total == null) {
      throw new BuiltValueNullFieldError('PageInfo', 'total');
    }
    if (records == null) {
      throw new BuiltValueNullFieldError('PageInfo', 'records');
    }
    if (querySize == null) {
      throw new BuiltValueNullFieldError('PageInfo', 'querySize');
    }
    if (queryPage == null) {
      throw new BuiltValueNullFieldError('PageInfo', 'queryPage');
    }
    if (queryType == null) {
      throw new BuiltValueNullFieldError('PageInfo', 'queryType');
    }
    if (T == dynamic) {
      throw new BuiltValueMissingGenericsError('PageInfo', 'T');
    }
  }

  @override
  PageInfo<T> rebuild(void Function(PageInfoBuilder<T>) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PageInfoBuilder<T> toBuilder() => new PageInfoBuilder<T>()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PageInfo &&
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
    return (newBuiltValueToStringHelper('PageInfo')
          ..add('total', total)
          ..add('records', records)
          ..add('querySize', querySize)
          ..add('queryPage', queryPage)
          ..add('queryType', queryType))
        .toString();
  }
}

class PageInfoBuilder<T> implements Builder<PageInfo<T>, PageInfoBuilder<T>> {
  _$PageInfo<T> _$v;

  int _total;
  int get total => _$this._total;
  set total(int total) => _$this._total = total;

  ListBuilder<T> _records;
  ListBuilder<T> get records => _$this._records ??= new ListBuilder<T>();
  set records(ListBuilder<T> records) => _$this._records = records;

  int _querySize;
  int get querySize => _$this._querySize;
  set querySize(int querySize) => _$this._querySize = querySize;

  int _queryPage;
  int get queryPage => _$this._queryPage;
  set queryPage(int queryPage) => _$this._queryPage = queryPage;

  String _queryType;
  String get queryType => _$this._queryType;
  set queryType(String queryType) => _$this._queryType = queryType;

  PageInfoBuilder();

  PageInfoBuilder<T> get _$this {
    if (_$v != null) {
      _total = _$v.total;
      _records = _$v.records?.toBuilder();
      _querySize = _$v.querySize;
      _queryPage = _$v.queryPage;
      _queryType = _$v.queryType;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PageInfo<T> other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PageInfo<T>;
  }

  @override
  void update(void Function(PageInfoBuilder<T>) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PageInfo<T> build() {
    _$PageInfo<T> _$result;
    try {
      _$result = _$v ??
          new _$PageInfo<T>._(
              total: total,
              records: records.build(),
              querySize: querySize,
              queryPage: queryPage,
              queryType: queryType);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'records';
        records.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PageInfo', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
