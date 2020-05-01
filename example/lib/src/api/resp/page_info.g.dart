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
      }
    }

    return result.build();
  }
}

class _$PageInfo<T> extends PageInfo<T> {
  @override
  final BuiltList<T> records;
  @override
  final num queryPage;
  @override
  final num querySize;

  factory _$PageInfo([void Function(PageInfoBuilder<T>) updates]) =>
      (new PageInfoBuilder<T>()..update(updates)).build();

  _$PageInfo._({this.records, this.queryPage, this.querySize}) : super._() {
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
        records == other.records &&
        queryPage == other.queryPage &&
        querySize == other.querySize;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, records.hashCode), queryPage.hashCode), querySize.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PageInfo')
          ..add('records', records)
          ..add('queryPage', queryPage)
          ..add('querySize', querySize))
        .toString();
  }
}

class PageInfoBuilder<T> implements Builder<PageInfo<T>, PageInfoBuilder<T>> {
  _$PageInfo<T> _$v;

  ListBuilder<T> _records;
  ListBuilder<T> get records => _$this._records ??= new ListBuilder<T>();
  set records(ListBuilder<T> records) => _$this._records = records;

  num _queryPage;
  num get queryPage => _$this._queryPage;
  set queryPage(num queryPage) => _$this._queryPage = queryPage;

  num _querySize;
  num get querySize => _$this._querySize;
  set querySize(num querySize) => _$this._querySize = querySize;

  PageInfoBuilder();

  PageInfoBuilder<T> get _$this {
    if (_$v != null) {
      _records = _$v.records?.toBuilder();
      _queryPage = _$v.queryPage;
      _querySize = _$v.querySize;
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
              records: _records?.build(),
              queryPage: queryPage,
              querySize: querySize);
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
