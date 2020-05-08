// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_action_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ArticleActionType _$VIEW = const ArticleActionType._('VIEW');
const ArticleActionType _$LIKE = const ArticleActionType._('LIKE');
const ArticleActionType _$COMMENT = const ArticleActionType._('COMMENT');
const ArticleActionType _$COLLECTION = const ArticleActionType._('COLLECTION');
const ArticleActionType _$SHARE = const ArticleActionType._('SHARE');

ArticleActionType _$valueOf(String name) {
  switch (name) {
    case 'VIEW':
      return _$VIEW;
    case 'LIKE':
      return _$LIKE;
    case 'COMMENT':
      return _$COMMENT;
    case 'COLLECTION':
      return _$COLLECTION;
    case 'SHARE':
      return _$SHARE;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<ArticleActionType> _$values =
    new BuiltSet<ArticleActionType>(const <ArticleActionType>[
  _$VIEW,
  _$LIKE,
  _$COMMENT,
  _$COLLECTION,
  _$SHARE,
]);

Serializer<ArticleActionType> _$articleActionTypeSerializer =
    new _$ArticleActionTypeSerializer();

class _$ArticleActionTypeSerializer
    implements PrimitiveSerializer<ArticleActionType> {
  @override
  final Iterable<Type> types = const <Type>[ArticleActionType];
  @override
  final String wireName = 'ArticleActionType';

  @override
  Object serialize(Serializers serializers, ArticleActionType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  ArticleActionType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ArticleActionType.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
