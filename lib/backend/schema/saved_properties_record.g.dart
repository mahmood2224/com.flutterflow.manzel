// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_properties_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SavedPropertiesRecord> _$savedPropertiesRecordSerializer =
    new _$SavedPropertiesRecordSerializer();

class _$SavedPropertiesRecordSerializer
    implements StructuredSerializer<SavedPropertiesRecord> {
  @override
  final Iterable<Type> types = const [
    SavedPropertiesRecord,
    _$SavedPropertiesRecord
  ];
  @override
  final String wireName = 'SavedPropertiesRecord';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, SavedPropertiesRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.createdAt;
    if (value != null) {
      result
        ..add('created_at')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.propertyId;
    if (value != null) {
      result
        ..add('property_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.userId;
    if (value != null) {
      result
        ..add('user_id')
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
  SavedPropertiesRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SavedPropertiesRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'property_id':
          result.propertyId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'user_id':
          result.userId = serializers.deserialize(value,
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

class _$SavedPropertiesRecord extends SavedPropertiesRecord {
  @override
  final DateTime? createdAt;
  @override
  final String? propertyId;
  @override
  final String? userId;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$SavedPropertiesRecord(
          [void Function(SavedPropertiesRecordBuilder)? updates]) =>
      (new SavedPropertiesRecordBuilder()..update(updates))._build();

  _$SavedPropertiesRecord._(
      {this.createdAt, this.propertyId, this.userId, this.ffRef})
      : super._();

  @override
  SavedPropertiesRecord rebuild(
          void Function(SavedPropertiesRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SavedPropertiesRecordBuilder toBuilder() =>
      new SavedPropertiesRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SavedPropertiesRecord &&
        createdAt == other.createdAt &&
        propertyId == other.propertyId &&
        userId == other.userId &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, createdAt.hashCode), propertyId.hashCode),
            userId.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SavedPropertiesRecord')
          ..add('createdAt', createdAt)
          ..add('propertyId', propertyId)
          ..add('userId', userId)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class SavedPropertiesRecordBuilder
    implements Builder<SavedPropertiesRecord, SavedPropertiesRecordBuilder> {
  _$SavedPropertiesRecord? _$v;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  String? _propertyId;
  String? get propertyId => _$this._propertyId;
  set propertyId(String? propertyId) => _$this._propertyId = propertyId;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  SavedPropertiesRecordBuilder() {
    SavedPropertiesRecord._initializeBuilder(this);
  }

  SavedPropertiesRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _createdAt = $v.createdAt;
      _propertyId = $v.propertyId;
      _userId = $v.userId;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SavedPropertiesRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SavedPropertiesRecord;
  }

  @override
  void update(void Function(SavedPropertiesRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SavedPropertiesRecord build() => _build();

  _$SavedPropertiesRecord _build() {
    final _$result = _$v ??
        new _$SavedPropertiesRecord._(
            createdAt: createdAt,
            propertyId: propertyId,
            userId: userId,
            ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
