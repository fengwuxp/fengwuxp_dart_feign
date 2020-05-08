// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_article_action_req.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<EditArticleActionReq> _$editArticleActionReqSerializer =
    new _$EditArticleActionReqSerializer();

class _$EditArticleActionReqSerializer
    implements StructuredSerializer<EditArticleActionReq> {
  @override
  final Iterable<Type> types = const [
    EditArticleActionReq,
    _$EditArticleActionReq
  ];
  @override
  final String wireName = 'EditArticleActionReq';

  @override
  Iterable<Object> serialize(
      Serializers serializers, EditArticleActionReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
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
    if (object.crateTime != null) {
      result
        ..add('crateTime')
        ..add(serializers.serialize(object.crateTime,
            specifiedType: const FullType(DateTime)));
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
  EditArticleActionReq deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new EditArticleActionReqBuilder();

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
        case 'crateTime':
          result.crateTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
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

class _$EditArticleActionReq extends EditArticleActionReq {
  @override
  final int id;
  @override
  final int articleId;
  @override
  final ArticleActionType actionType;
  @override
  final String sourceCode;
  @override
  final DateTime crateTime;
  @override
  final String ip;

  factory _$EditArticleActionReq(
          [void Function(EditArticleActionReqBuilder) updates]) =>
      (new EditArticleActionReqBuilder()..update(updates)).build();

  _$EditArticleActionReq._(
      {this.id,
      this.articleId,
      this.actionType,
      this.sourceCode,
      this.crateTime,
      this.ip})
      : super._();

  @override
  EditArticleActionReq rebuild(
          void Function(EditArticleActionReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EditArticleActionReqBuilder toBuilder() =>
      new EditArticleActionReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EditArticleActionReq &&
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
    return (newBuiltValueToStringHelper('EditArticleActionReq')
          ..add('id', id)
          ..add('articleId', articleId)
          ..add('actionType', actionType)
          ..add('sourceCode', sourceCode)
          ..add('crateTime', crateTime)
          ..add('ip', ip))
        .toString();
  }
}

class EditArticleActionReqBuilder
    implements Builder<EditArticleActionReq, EditArticleActionReqBuilder> {
  _$EditArticleActionReq _$v;

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

  DateTime _crateTime;
  DateTime get crateTime => _$this._crateTime;
  set crateTime(DateTime crateTime) => _$this._crateTime = crateTime;

  String _ip;
  String get ip => _$this._ip;
  set ip(String ip) => _$this._ip = ip;

  EditArticleActionReqBuilder();

  EditArticleActionReqBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _articleId = _$v.articleId;
      _actionType = _$v.actionType;
      _sourceCode = _$v.sourceCode;
      _crateTime = _$v.crateTime;
      _ip = _$v.ip;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EditArticleActionReq other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$EditArticleActionReq;
  }

  @override
  void update(void Function(EditArticleActionReqBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$EditArticleActionReq build() {
    final _$result = _$v ??
        new _$EditArticleActionReq._(
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

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
