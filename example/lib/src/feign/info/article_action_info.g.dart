// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_action_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ArticleActionInfo> _$articleActionInfoSerializer =
    new _$ArticleActionInfoSerializer();

class _$ArticleActionInfoSerializer
    implements StructuredSerializer<ArticleActionInfo> {
  @override
  final Iterable<Type> types = const [ArticleActionInfo, _$ArticleActionInfo];
  @override
  final String wireName = 'ArticleActionInfo';

  @override
  Iterable<Object?> serialize(Serializers serializers, ArticleActionInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
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
    value = object.crateTime;
    if (value != null) {
      result
        ..add('crateTime')
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
    return result;
  }

  @override
  ArticleActionInfo deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ArticleActionInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'articleId':
          result.articleId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'actionType':
          result.actionType = serializers.deserialize(value,
                  specifiedType: const FullType(ArticleActionType))
              as ArticleActionType?;
          break;
        case 'sourceCode':
          result.sourceCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'crateTime':
          result.crateTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'ip':
          result.ip = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$ArticleActionInfo extends ArticleActionInfo {
  @override
  final int? id;
  @override
  final int? articleId;
  @override
  final ArticleActionType? actionType;
  @override
  final String? sourceCode;
  @override
  final DateTime? crateTime;
  @override
  final String? ip;

  factory _$ArticleActionInfo(
          [void Function(ArticleActionInfoBuilder)? updates]) =>
      (new ArticleActionInfoBuilder()..update(updates)).build();

  _$ArticleActionInfo._(
      {this.id,
      this.articleId,
      this.actionType,
      this.sourceCode,
      this.crateTime,
      this.ip})
      : super._();

  @override
  ArticleActionInfo rebuild(void Function(ArticleActionInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ArticleActionInfoBuilder toBuilder() =>
      new ArticleActionInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ArticleActionInfo &&
        id == other.id &&
        articleId == other.articleId &&
        actionType == other.actionType &&
        sourceCode == other.sourceCode &&
        crateTime == other.crateTime &&
        ip == other.ip;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, id.hashCode), articleId.hashCode),
                    actionType.hashCode),
                sourceCode.hashCode),
            crateTime.hashCode),
        ip.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ArticleActionInfo')
          ..add('id', id)
          ..add('articleId', articleId)
          ..add('actionType', actionType)
          ..add('sourceCode', sourceCode)
          ..add('crateTime', crateTime)
          ..add('ip', ip))
        .toString();
  }
}

class ArticleActionInfoBuilder
    implements Builder<ArticleActionInfo, ArticleActionInfoBuilder> {
  _$ArticleActionInfo? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _articleId;
  int? get articleId => _$this._articleId;
  set articleId(int? articleId) => _$this._articleId = articleId;

  ArticleActionType? _actionType;
  ArticleActionType? get actionType => _$this._actionType;
  set actionType(ArticleActionType? actionType) =>
      _$this._actionType = actionType;

  String? _sourceCode;
  String? get sourceCode => _$this._sourceCode;
  set sourceCode(String? sourceCode) => _$this._sourceCode = sourceCode;

  DateTime? _crateTime;
  DateTime? get crateTime => _$this._crateTime;
  set crateTime(DateTime? crateTime) => _$this._crateTime = crateTime;

  String? _ip;
  String? get ip => _$this._ip;
  set ip(String? ip) => _$this._ip = ip;

  ArticleActionInfoBuilder();

  ArticleActionInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _articleId = $v.articleId;
      _actionType = $v.actionType;
      _sourceCode = $v.sourceCode;
      _crateTime = $v.crateTime;
      _ip = $v.ip;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ArticleActionInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ArticleActionInfo;
  }

  @override
  void update(void Function(ArticleActionInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ArticleActionInfo build() {
    final _$result = _$v ??
        new _$ArticleActionInfo._(
            id: id,
            articleId: articleId,
            actionType: actionType,
            sourceCode: sourceCode,
            crateTime: crateTime,
            ip: ip);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
