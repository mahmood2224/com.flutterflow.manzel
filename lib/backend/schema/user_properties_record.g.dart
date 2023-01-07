// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_properties_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserPropertiesRecord> _$userPropertiesRecordSerializer =
    new _$UserPropertiesRecordSerializer();

class _$UserPropertiesRecordSerializer
    implements StructuredSerializer<UserPropertiesRecord> {
  @override
  final Iterable<Type> types = const [
    UserPropertiesRecord,
    _$UserPropertiesRecord
  ];
  @override
  final String wireName = 'UserPropertiesRecord';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, UserPropertiesRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.uId;
    if (value != null) {
      result
        ..add('u_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.pId;
    if (value != null) {
      result
        ..add('p_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
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
  UserPropertiesRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserPropertiesRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'u_id':
          result.uId = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'p_id':
          result.pId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
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

class _$UserPropertiesRecord extends UserPropertiesRecord {
  @override
  final DocumentReference<Object?>? uId;
  @override
  final int? pId;
  @override
  final String? status;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$UserPropertiesRecord(
          [void Function(UserPropertiesRecordBuilder)? updates]) =>
      (new UserPropertiesRecordBuilder()..update(updates))._build();

  _$UserPropertiesRecord._({this.uId, this.pId, this.status, this.ffRef})
      : super._();

  @override
  UserPropertiesRecord rebuild(
          void Function(UserPropertiesRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserPropertiesRecordBuilder toBuilder() =>
      new UserPropertiesRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserPropertiesRecord &&
        uId == other.uId &&
        pId == other.pId &&
        status == other.status &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, uId.hashCode), pId.hashCode), status.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserPropertiesRecord')
          ..add('uId', uId)
          ..add('pId', pId)
          ..add('status', status)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class UserPropertiesRecordBuilder
    implements Builder<UserPropertiesRecord, UserPropertiesRecordBuilder> {
  _$UserPropertiesRecord? _$v;

  DocumentReference<Object?>? _uId;
  DocumentReference<Object?>? get uId => _$this._uId;
  set uId(DocumentReference<Object?>? uId) => _$this._uId = uId;

  int? _pId;
  int? get pId => _$this._pId;
  set pId(int? pId) => _$this._pId = pId;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  UserPropertiesRecordBuilder() {
    UserPropertiesRecord._initializeBuilder(this);
  }

  UserPropertiesRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _uId = $v.uId;
      _pId = $v.pId;
      _status = $v.status;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserPropertiesRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserPropertiesRecord;
  }

  @override
  void update(void Function(UserPropertiesRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserPropertiesRecord build() => _build();

  _$UserPropertiesRecord _build() {
    final _$result = _$v ??
        new _$UserPropertiesRecord._(
            uId: uId, pId: pId, status: status, ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
