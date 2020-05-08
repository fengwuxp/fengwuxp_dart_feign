// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_resp.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ApiResp<Object>> _$apiRespSerializer = new _$ApiRespSerializer();

class _$ApiRespSerializer implements StructuredSerializer<ApiResp<Object>> {
  @override
  final Iterable<Type> types = const [ApiResp, _$ApiResp];
  @override
  final String wireName = 'ApiResp';

  @override
  Iterable<Object> serialize(Serializers serializers, ApiResp<Object> object,
      {FullType specifiedType = FullType.unspecified}) {
    final isUnderspecified =
        specifiedType.isUnspecified || specifiedType.parameters.isEmpty;
    if (!isUnderspecified) serializers.expectBuilder(specifiedType);
    final parameterT =
        isUnderspecified ? FullType.object : specifiedType.parameters[0];

    final result = <Object>[
      'code',
      serializers.serialize(object.code, specifiedType: const FullType(int)),
      'success',
      serializers.serialize(object.success,
          specifiedType: const FullType(bool)),
    ];
    if (object.data != null) {
      result
        ..add('data')
        ..add(serializers.serialize(object.data, specifiedType: parameterT));
    }
    if (object.message != null) {
      result
        ..add('message')
        ..add(serializers.serialize(object.message,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ApiResp<Object> deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final isUnderspecified =
        specifiedType.isUnspecified || specifiedType.parameters.isEmpty;
    if (!isUnderspecified) serializers.expectBuilder(specifiedType);
    final parameterT =
        isUnderspecified ? FullType.object : specifiedType.parameters[0];

    final result = isUnderspecified
        ? new ApiRespBuilder<Object>()
        : serializers.newBuilder(specifiedType) as ApiRespBuilder;

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data =
              serializers.deserialize(value, specifiedType: parameterT);
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'code':
          result.code = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'success':
          result.success = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$ApiResp<T> extends ApiResp<T> {
  @override
  final T data;
  @override
  final String message;
  @override
  final int code;
  @override
  final bool success;

  factory _$ApiResp([void Function(ApiRespBuilder<T>) updates]) =>
      (new ApiRespBuilder<T>()..update(updates)).build();

  _$ApiResp._({this.data, this.message, this.code, this.success}) : super._() {
    if (code == null) {
      throw new BuiltValueNullFieldError('ApiResp', 'code');
    }
    if (success == null) {
      throw new BuiltValueNullFieldError('ApiResp', 'success');
    }
    if (T == dynamic) {
      throw new BuiltValueMissingGenericsError('ApiResp', 'T');
    }
  }

  @override
  ApiResp<T> rebuild(void Function(ApiRespBuilder<T>) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ApiRespBuilder<T> toBuilder() => new ApiRespBuilder<T>()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiResp &&
        data == other.data &&
        message == other.message &&
        code == other.code &&
        success == other.success;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, data.hashCode), message.hashCode), code.hashCode),
        success.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ApiResp')
          ..add('data', data)
          ..add('message', message)
          ..add('code', code)
          ..add('success', success))
        .toString();
  }
}

class ApiRespBuilder<T> implements Builder<ApiResp<T>, ApiRespBuilder<T>> {
  _$ApiResp<T> _$v;

  T _data;
  T get data => _$this._data;
  set data(T data) => _$this._data = data;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  int _code;
  int get code => _$this._code;
  set code(int code) => _$this._code = code;

  bool _success;
  bool get success => _$this._success;
  set success(bool success) => _$this._success = success;

  ApiRespBuilder();

  ApiRespBuilder<T> get _$this {
    if (_$v != null) {
      _data = _$v.data;
      _message = _$v.message;
      _code = _$v.code;
      _success = _$v.success;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiResp<T> other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ApiResp<T>;
  }

  @override
  void update(void Function(ApiRespBuilder<T>) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ApiResp<T> build() {
    final _$result = _$v ??
        new _$ApiResp<T>._(
            data: data, message: message, code: code, success: success);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
