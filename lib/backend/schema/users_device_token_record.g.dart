// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_device_token_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UsersDeviceTokenRecord> _$usersDeviceTokenRecordSerializer =
    new _$UsersDeviceTokenRecordSerializer();

class _$UsersDeviceTokenRecordSerializer
    implements StructuredSerializer<UsersDeviceTokenRecord> {
  @override
  final Iterable<Type> types = const [
    UsersDeviceTokenRecord,
    _$UsersDeviceTokenRecord
  ];
  @override
  final String wireName = 'UsersDeviceTokenRecord';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, UsersDeviceTokenRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
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
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.ffRef;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    return result;
  }

  @override
  UsersDeviceTokenRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UsersDeviceTokenRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'device_token':
          result.deviceToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'user_id':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'Document__Reference__Field':
          result.ffRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
      }
    }

    return result.build();
  }
}

class _$UsersDeviceTokenRecord extends UsersDeviceTokenRecord {
  @override
  final String? deviceToken;
  @override
  final DocumentReference<Object?>? userId;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$UsersDeviceTokenRecord(
          [void Function(UsersDeviceTokenRecordBuilder)? updates]) =>
      (new UsersDeviceTokenRecordBuilder()..update(updates))._build();

  _$UsersDeviceTokenRecord._({this.deviceToken, this.userId, this.ffRef})
      : super._();

  @override
  UsersDeviceTokenRecord rebuild(
          void Function(UsersDeviceTokenRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UsersDeviceTokenRecordBuilder toBuilder() =>
      new UsersDeviceTokenRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UsersDeviceTokenRecord &&
        deviceToken == other.deviceToken &&
        userId == other.userId &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, deviceToken.hashCode), userId.hashCode), ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UsersDeviceTokenRecord')
          ..add('deviceToken', deviceToken)
          ..add('userId', userId)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class UsersDeviceTokenRecordBuilder
    implements Builder<UsersDeviceTokenRecord, UsersDeviceTokenRecordBuilder> {
  _$UsersDeviceTokenRecord? _$v;

  String? _deviceToken;
  String? get deviceToken => _$this._deviceToken;
  set deviceToken(String? deviceToken) => _$this._deviceToken = deviceToken;

  DocumentReference<Object?>? _userId;
  DocumentReference<Object?>? get userId => _$this._userId;
  set userId(DocumentReference<Object?>? userId) => _$this._userId = userId;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  UsersDeviceTokenRecordBuilder() {
    UsersDeviceTokenRecord._initializeBuilder(this);
  }

  UsersDeviceTokenRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _deviceToken = $v.deviceToken;
      _userId = $v.userId;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UsersDeviceTokenRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UsersDeviceTokenRecord;
  }

  @override
  void update(void Function(UsersDeviceTokenRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UsersDeviceTokenRecord build() => _build();

  _$UsersDeviceTokenRecord _build() {
    final _$result = _$v ??
        new _$UsersDeviceTokenRecord._(
            deviceToken: deviceToken, userId: userId, ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
