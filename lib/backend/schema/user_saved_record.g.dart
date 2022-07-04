// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_saved_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserSavedRecord> _$userSavedRecordSerializer =
    new _$UserSavedRecordSerializer();

class _$UserSavedRecordSerializer
    implements StructuredSerializer<UserSavedRecord> {
  @override
  final Iterable<Type> types = const [UserSavedRecord, _$UserSavedRecord];
  @override
  final String wireName = 'UserSavedRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, UserSavedRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.uId;
    if (value != null) {
      result
        ..add('u_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType(Object)])));
    }
    value = object.pId;
    if (value != null) {
      result
        ..add('p_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
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
  UserSavedRecord deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserSavedRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'u_id':
          result.uId = serializers.deserialize(value,
                  specifiedType: const FullType(
                      DocumentReference, const [const FullType(Object)]))
              as DocumentReference<Object>;
          break;
        case 'p_id':
          result.pId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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

class _$UserSavedRecord extends UserSavedRecord {
  @override
  final DocumentReference<Object> uId;
  @override
  final int pId;
  @override
  final DocumentReference<Object> reference;

  factory _$UserSavedRecord([void Function(UserSavedRecordBuilder) updates]) =>
      (new UserSavedRecordBuilder()..update(updates)).build();

  _$UserSavedRecord._({this.uId, this.pId, this.reference}) : super._();

  @override
  UserSavedRecord rebuild(void Function(UserSavedRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserSavedRecordBuilder toBuilder() =>
      new UserSavedRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserSavedRecord &&
        uId == other.uId &&
        pId == other.pId &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, uId.hashCode), pId.hashCode), reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserSavedRecord')
          ..add('uId', uId)
          ..add('pId', pId)
          ..add('reference', reference))
        .toString();
  }
}

class UserSavedRecordBuilder
    implements Builder<UserSavedRecord, UserSavedRecordBuilder> {
  _$UserSavedRecord _$v;

  DocumentReference<Object> _uId;
  DocumentReference<Object> get uId => _$this._uId;
  set uId(DocumentReference<Object> uId) => _$this._uId = uId;

  int _pId;
  int get pId => _$this._pId;
  set pId(int pId) => _$this._pId = pId;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  UserSavedRecordBuilder() {
    UserSavedRecord._initializeBuilder(this);
  }

  UserSavedRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _uId = $v.uId;
      _pId = $v.pId;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserSavedRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserSavedRecord;
  }

  @override
  void update(void Function(UserSavedRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserSavedRecord build() {
    final _$result = _$v ??
        new _$UserSavedRecord._(uId: uId, pId: pId, reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
