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
  Iterable<Object?> serialize(Serializers serializers, UserSavedRecord object,
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
  UserSavedRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserSavedRecordBuilder();

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

class _$UserSavedRecord extends UserSavedRecord {
  @override
  final DocumentReference<Object?>? uId;
  @override
  final int? pId;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$UserSavedRecord([void Function(UserSavedRecordBuilder)? updates]) =>
      (new UserSavedRecordBuilder()..update(updates))._build();

  _$UserSavedRecord._({this.uId, this.pId, this.ffRef}) : super._();

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
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, uId.hashCode), pId.hashCode), ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserSavedRecord')
          ..add('uId', uId)
          ..add('pId', pId)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class UserSavedRecordBuilder
    implements Builder<UserSavedRecord, UserSavedRecordBuilder> {
  _$UserSavedRecord? _$v;

  DocumentReference<Object?>? _uId;
  DocumentReference<Object?>? get uId => _$this._uId;
  set uId(DocumentReference<Object?>? uId) => _$this._uId = uId;

  int? _pId;
  int? get pId => _$this._pId;
  set pId(int? pId) => _$this._pId = pId;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  UserSavedRecordBuilder() {
    UserSavedRecord._initializeBuilder(this);
  }

  UserSavedRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _uId = $v.uId;
      _pId = $v.pId;
      _ffRef = $v.ffRef;
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
  void update(void Function(UserSavedRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserSavedRecord build() => _build();

  _$UserSavedRecord _build() {
    final _$result =
        _$v ?? new _$UserSavedRecord._(uId: uId, pId: pId, ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
