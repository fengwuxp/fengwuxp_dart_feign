// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_article_action_req.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DeleteArticleActionReq> _$deleteArticleActionReqSerializer =
    new _$DeleteArticleActionReqSerializer();

class _$DeleteArticleActionReqSerializer
    implements StructuredSerializer<DeleteArticleActionReq> {
  @override
  final Iterable<Type> types = const [
    DeleteArticleActionReq,
    _$DeleteArticleActionReq
  ];
  @override
  final String wireName = 'DeleteArticleActionReq';

  @override
  Iterable<Object> serialize(
      Serializers serializers, DeleteArticleActionReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    if (object.ids != null) {
      result
        ..add('ids')
        ..add(serializers.serialize(object.ids,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    return result;
  }

  @override
  DeleteArticleActionReq deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DeleteArticleActionReqBuilder();

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
        case 'ids':
          result.ids.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$DeleteArticleActionReq extends DeleteArticleActionReq {
  @override
  final int id;
  @override
  final BuiltList<int> ids;

  factory _$DeleteArticleActionReq(
          [void Function(DeleteArticleActionReqBuilder) updates]) =>
      (new DeleteArticleActionReqBuilder()..update(updates)).build();

  _$DeleteArticleActionReq._({this.id, this.ids}) : super._();

  @override
  DeleteArticleActionReq rebuild(
          void Function(DeleteArticleActionReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeleteArticleActionReqBuilder toBuilder() =>
      new DeleteArticleActionReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteArticleActionReq &&
        id == other.id &&
        ids == other.ids;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), ids.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DeleteArticleActionReq')
          ..add('id', id)
          ..add('ids', ids))
        .toString();
  }
}

class DeleteArticleActionReqBuilder
    implements Builder<DeleteArticleActionReq, DeleteArticleActionReqBuilder> {
  _$DeleteArticleActionReq _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  ListBuilder<int> _ids;
  ListBuilder<int> get ids => _$this._ids ??= new ListBuilder<int>();
  set ids(ListBuilder<int> ids) => _$this._ids = ids;

  DeleteArticleActionReqBuilder();

  DeleteArticleActionReqBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _ids = _$v.ids?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeleteArticleActionReq other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DeleteArticleActionReq;
  }

  @override
  void update(void Function(DeleteArticleActionReqBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DeleteArticleActionReq build() {
    _$DeleteArticleActionReq _$result;
    try {
      _$result =
          _$v ?? new _$DeleteArticleActionReq._(id: id, ids: _ids?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'ids';
        _ids?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DeleteArticleActionReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
