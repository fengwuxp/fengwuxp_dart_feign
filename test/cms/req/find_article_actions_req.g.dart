// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find_article_actions_req.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<FindArticleActionsReq> _$findArticleActionsReqSerializer =
    new _$FindArticleActionsReqSerializer();

class _$FindArticleActionsReqSerializer
    implements StructuredSerializer<FindArticleActionsReq> {
  @override
  final Iterable<Type> types = const [
    FindArticleActionsReq,
    _$FindArticleActionsReq
  ];
  @override
  final String wireName = 'FindArticleActionsReq';

  @override
  Iterable<Object> serialize(
      Serializers serializers, FindArticleActionsReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'sourceCode',
      serializers.serialize(object.sourceCode,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  FindArticleActionsReq deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FindArticleActionsReqBuilder();

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
        case 'sourceCode':
          result.sourceCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$FindArticleActionsReq extends FindArticleActionsReq {
  @override
  final int id;
  @override
  final String sourceCode;

  factory _$FindArticleActionsReq(
          [void Function(FindArticleActionsReqBuilder) updates]) =>
      (new FindArticleActionsReqBuilder()..update(updates)).build();

  _$FindArticleActionsReq._({this.id, this.sourceCode}) : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('FindArticleActionsReq', 'id');
    }
    if (sourceCode == null) {
      throw new BuiltValueNullFieldError('FindArticleActionsReq', 'sourceCode');
    }
  }

  @override
  FindArticleActionsReq rebuild(
          void Function(FindArticleActionsReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FindArticleActionsReqBuilder toBuilder() =>
      new FindArticleActionsReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FindArticleActionsReq &&
        id == other.id &&
        sourceCode == other.sourceCode;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), sourceCode.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FindArticleActionsReq')
          ..add('id', id)
          ..add('sourceCode', sourceCode))
        .toString();
  }
}

class FindArticleActionsReqBuilder
    implements Builder<FindArticleActionsReq, FindArticleActionsReqBuilder> {
  _$FindArticleActionsReq _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _sourceCode;
  String get sourceCode => _$this._sourceCode;
  set sourceCode(String sourceCode) => _$this._sourceCode = sourceCode;

  FindArticleActionsReqBuilder();

  FindArticleActionsReqBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _sourceCode = _$v.sourceCode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FindArticleActionsReq other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FindArticleActionsReq;
  }

  @override
  void update(void Function(FindArticleActionsReqBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FindArticleActionsReq build() {
    final _$result =
        _$v ?? new _$FindArticleActionsReq._(id: id, sourceCode: sourceCode);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
