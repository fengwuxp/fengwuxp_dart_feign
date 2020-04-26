// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'title.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Title> _$titleSerializer = new _$TitleSerializer();

class _$TitleSerializer implements StructuredSerializer<Title> {
  @override
  final Iterable<Type> types = const [Title, _$Title];
  @override
  final String wireName = 'Title';

  @override
  Iterable<Object> serialize(Serializers serializers, Title object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'rendered',
      serializers.serialize(object.rendered,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  Title deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TitleBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'rendered':
          result.rendered = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Title extends Title {
  @override
  final String rendered;

  factory _$Title([void Function(TitleBuilder) updates]) =>
      (new TitleBuilder()..update(updates)).build();

  _$Title._({this.rendered}) : super._() {
    if (rendered == null) {
      throw new BuiltValueNullFieldError('Title', 'rendered');
    }
  }

  @override
  Title rebuild(void Function(TitleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TitleBuilder toBuilder() => new TitleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Title && rendered == other.rendered;
  }

  @override
  int get hashCode {
    return $jf($jc(0, rendered.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Title')..add('rendered', rendered))
        .toString();
  }
}

class TitleBuilder implements Builder<Title, TitleBuilder> {
  _$Title _$v;

  String _rendered;
  String get rendered => _$this._rendered;
  set rendered(String rendered) => _$this._rendered = rendered;

  TitleBuilder();

  TitleBuilder get _$this {
    if (_$v != null) {
      _rendered = _$v.rendered;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Title other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Title;
  }

  @override
  void update(void Function(TitleBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Title build() {
    final _$result = _$v ?? new _$Title._(rendered: rendered);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
