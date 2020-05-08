// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_article_action_req.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AddArticleActionReq> _$addArticleActionReqSerializer =
    new _$AddArticleActionReqSerializer();

class _$AddArticleActionReqSerializer
    implements StructuredSerializer<AddArticleActionReq> {
  @override
  final Iterable<Type> types = const [
    AddArticleActionReq,
    _$AddArticleActionReq
  ];
  @override
  final String wireName = 'AddArticleActionReq';

  @override
  Iterable<Object> serialize(
      Serializers serializers, AddArticleActionReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.articleId != null) {
      result
        ..add('articleId')
        ..add(serializers.serialize(object.articleId,
            specifiedType: const FullType(int)));
    }
    if (object.actionType != null) {
      result
        ..add('actionType')
        ..add(serializers.serialize(object.actionType,
            specifiedType: const FullType(ArticleActionType)));
    }
    if (object.sourceCode != null) {
      result
        ..add('sourceCode')
        ..add(serializers.serialize(object.sourceCode,
            specifiedType: const FullType(String)));
    }
    if (object.ip != null) {
      result
        ..add('ip')
        ..add(serializers.serialize(object.ip,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  AddArticleActionReq deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AddArticleActionReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
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
        case 'ip':
          result.ip = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$AddArticleActionReq extends AddArticleActionReq {
  @override
  final int articleId;
  @override
  final ArticleActionType actionType;
  @override
  final String sourceCode;
  @override
  final String ip;

  factory _$AddArticleActionReq(
          [void Function(AddArticleActionReqBuilder) updates]) =>
      (new AddArticleActionReqBuilder()..update(updates)).build();

  _$AddArticleActionReq._(
      {this.articleId, this.actionType, this.sourceCode, this.ip})
      : super._();

  @override
  AddArticleActionReq rebuild(
          void Function(AddArticleActionReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AddArticleActionReqBuilder toBuilder() =>
      new AddArticleActionReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddArticleActionReq &&
        articleId == other.articleId &&
        actionType == other.actionType &&
        sourceCode == other.sourceCode &&
        ip == other.ip;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, articleId.hashCode), actionType.hashCode),
            sourceCode.hashCode),
        ip.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AddArticleActionReq')
          ..add('articleId', articleId)
          ..add('actionType', actionType)
          ..add('sourceCode', sourceCode)
          ..add('ip', ip))
        .toString();
  }
}

class AddArticleActionReqBuilder
    implements Builder<AddArticleActionReq, AddArticleActionReqBuilder> {
  _$AddArticleActionReq _$v;

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

  String _ip;
  String get ip => _$this._ip;
  set ip(String ip) => _$this._ip = ip;

  AddArticleActionReqBuilder();

  AddArticleActionReqBuilder get _$this {
    if (_$v != null) {
      _articleId = _$v.articleId;
      _actionType = _$v.actionType;
      _sourceCode = _$v.sourceCode;
      _ip = _$v.ip;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddArticleActionReq other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AddArticleActionReq;
  }

  @override
  void update(void Function(AddArticleActionReqBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AddArticleActionReq build() {
    final _$result = _$v ??
        new _$AddArticleActionReq._(
            articleId: articleId,
            actionType: actionType,
            sourceCode: sourceCode,
            ip: ip);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
