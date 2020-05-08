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

    final result = <Object>[];
    if (object.total != null) {
      result
        ..add('total')
        ..add(serializers.serialize(object.total,
            specifiedType: const FullType(int)));
    }
    if (object.queryType != null) {
      result
        ..add('queryType')
        ..add(serializers.serialize(object.queryType,
            specifiedType: const FullType(QueryType)));
    }
    if (object.records != null) {
      result
        ..add('records')
        ..add(serializers.serialize(object.records,
            specifiedType: new FullType(BuiltList, [parameterT])));
    }
    if (object.queryPage != null) {
      result
        ..add('queryPage')
        ..add(serializers.serialize(object.queryPage,
            specifiedType: const FullType(num)));
    }
    if (object.querySize != null) {
      result
        ..add('querySize')
        ..add(serializers.serialize(object.querySize,
            specifiedType: const FullType(num)));
    }
    if (object.empty != null) {
      result
        ..add('empty')
        ..add(serializers.serialize(object.empty,
            specifiedType: const FullType(bool)));
    }
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
        case 'queryType':
          result.queryType = serializers.deserialize(value,
              specifiedType: const FullType(QueryType)) as QueryType;
          break;
        case 'records':
          result.records.replace(serializers.deserialize(value,
                  specifiedType: new FullType(BuiltList, [parameterT]))
              as BuiltList<Object>);
          break;
        case 'queryPage':
          result.queryPage = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num;
          break;
        case 'querySize':
          result.querySize = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num;
          break;
        case 'empty':
          result.empty = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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
  final QueryType queryType;
  @override
  final BuiltList<T> records;
  @override
  final num queryPage;
  @override
  final num querySize;
  @override
  final bool empty;

  factory _$PageInfo([void Function(PageInfoBuilder<T>) updates]) =>
      (new PageInfoBuilder<T>()..update(updates)).build();

  _$PageInfo._(
      {this.total,
      this.queryType,
      this.records,
      this.queryPage,
      this.querySize,
      this.empty})
      : super._() {
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
        queryType == other.queryType &&
        records == other.records &&
        queryPage == other.queryPage &&
        querySize == other.querySize &&
        empty == other.empty;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, total.hashCode), queryType.hashCode),
                    records.hashCode),
                queryPage.hashCode),
            querySize.hashCode),
        empty.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PageInfo')
          ..add('total', total)
          ..add('queryType', queryType)
          ..add('records', records)
          ..add('queryPage', queryPage)
          ..add('querySize', querySize)
          ..add('empty', empty))
        .toString();
  }
}

class PageInfoBuilder<T> implements Builder<PageInfo<T>, PageInfoBuilder<T>> {
  _$PageInfo<T> _$v;

  int _total;
  int get total => _$this._total;
  set total(int total) => _$this._total = total;

  QueryType _queryType;
  QueryType get queryType => _$this._queryType;
  set queryType(QueryType queryType) => _$this._queryType = queryType;

  ListBuilder<T> _records;
  ListBuilder<T> get records => _$this._records ??= new ListBuilder<T>();
  set records(ListBuilder<T> records) => _$this._records = records;

  num _queryPage;
  num get queryPage => _$this._queryPage;
  set queryPage(num queryPage) => _$this._queryPage = queryPage;

  num _querySize;
  num get querySize => _$this._querySize;
  set querySize(num querySize) => _$this._querySize = querySize;

  bool _empty;
  bool get empty => _$this._empty;
  set empty(bool empty) => _$this._empty = empty;

  PageInfoBuilder();

  PageInfoBuilder<T> get _$this {
    if (_$v != null) {
      _total = _$v.total;
      _queryType = _$v.queryType;
      _records = _$v.records?.toBuilder();
      _queryPage = _$v.queryPage;
      _querySize = _$v.querySize;
      _empty = _$v.empty;
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
              queryType: queryType,
              records: _records?.build(),
              queryPage: queryPage,
              querySize: querySize,
              empty: empty);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'records';
        _records?.build();
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
