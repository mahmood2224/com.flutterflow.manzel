// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_device_token_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserDeviceTokenRecord> _$userDeviceTokenRecordSerializer =
    new _$UserDeviceTokenRecordSerializer();

class _$UserDeviceTokenRecordSerializer
    implements StructuredSerializer<UserDeviceTokenRecord> {
  @override
  final Iterable<Type> types = const [
    UserDeviceTokenRecord,
    _$UserDeviceTokenRecord
  ];
  @override
  final String wireName = 'UserDeviceTokenRecord';

  @override
  Iterable<Object> serialize(
      Serializers serializers, UserDeviceTokenRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.deviceToken;
    if (value != null) {
      result
        ..add('device_token')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.userId;
    if (value != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType(Object)])));
    }
    value = object.reference;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType(Object)])));
    }
    return result;
  }

  @override
  UserDeviceTokenRecord deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserDeviceTokenRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'device_token':
          result.deviceToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'user_id':
          result.userId = serializers.deserialize(value,
                  specifiedType: const FullType(
                      DocumentReference, const [const FullType(Object)]))
              as DocumentReference<Object>;
          break;
        case 'Document__Reference__Field':
          result.reference = serializers.deserialize(value,
                  specifiedType: const FullType(
                      DocumentReference, const [const FullType(Object)]))
              as DocumentReference<Object>;
          break;
      }
    }

    return result.build();
  }
}

class _$UserDeviceTokenRecord extends UserDeviceTokenRecord {
  @override
  final String deviceToken;
  @override
  final DocumentReference<Object> userId;
  @override
  final DocumentReference<Object> reference;

  factory _$UserDeviceTokenRecord(
          [void Function(UserDeviceTokenRecordBuilder) updates]) =>
      (new UserDeviceTokenRecordBuilder()..update(updates))._build();

  _$UserDeviceTokenRecord._({this.deviceToken, this.userId, this.reference})
      : super._();

  @override
  UserDeviceTokenRecord rebuild(
          void Function(UserDeviceTokenRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserDeviceTokenRecordBuilder toBuilder() =>
      new UserDeviceTokenRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserDeviceTokenRecord &&
        deviceToken == other.deviceToken &&
        userId == other.userId &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, deviceToken.hashCode), userId.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserDeviceTokenRecord')
          ..add('deviceToken', deviceToken)
          ..add('userId', userId)
          ..add('reference', reference))
        .toString();
  }
}

class UserDeviceTokenRecordBuilder
    implements Builder<UserDeviceTokenRecord, UserDeviceTokenRecordBuilder> {
  _$UserDeviceTokenRecord _$v;

  String _deviceToken;
  String get deviceToken => _$this._deviceToken;
  set deviceToken(String deviceToken) => _$this._deviceToken = deviceToken;

  DocumentReference<Object> _userId;
  DocumentReference<Object> get userId => _$this._userId;
  set userId(DocumentReference<Object> userId) => _$this._userId = userId;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  UserDeviceTokenRecordBuilder() {
    UserDeviceTokenRecord._initializeBuilder(this);
  }

  UserDeviceTokenRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _deviceToken = $v.deviceToken;
      _userId = $v.userId;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserDeviceTokenRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserDeviceTokenRecord;
  }

  @override
  void update(void Function(UserDeviceTokenRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  UserDeviceTokenRecord build() => _build();

  _$UserDeviceTokenRecord _build() {
    final _$result = _$v ??
        new _$UserDeviceTokenRecord._(
            deviceToken: deviceToken, userId: userId, reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
