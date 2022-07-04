// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PropertyRecord> _$propertyRecordSerializer =
    new _$PropertyRecordSerializer();

class _$PropertyRecordSerializer
    implements StructuredSerializer<PropertyRecord> {
  @override
  final Iterable<Type> types = const [PropertyRecord, _$PropertyRecord];
  @override
  final String wireName = 'PropertyRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, PropertyRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.pId;
    if (value != null) {
      result
        ..add('p_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.propertyCity;
    if (value != null) {
      result
        ..add('property_city')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
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
  PropertyRecord deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PropertyRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'p_id':
          result.pId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'property_city':
          result.propertyCity = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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

class _$PropertyRecord extends PropertyRecord {
  @override
  final int pId;
  @override
  final String propertyCity;
  @override
  final DocumentReference<Object> reference;

  factory _$PropertyRecord([void Function(PropertyRecordBuilder) updates]) =>
      (new PropertyRecordBuilder()..update(updates)).build();

  _$PropertyRecord._({this.pId, this.propertyCity, this.reference}) : super._();

  @override
  PropertyRecord rebuild(void Function(PropertyRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PropertyRecordBuilder toBuilder() =>
      new PropertyRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PropertyRecord &&
        pId == other.pId &&
        propertyCity == other.propertyCity &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, pId.hashCode), propertyCity.hashCode), reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PropertyRecord')
          ..add('pId', pId)
          ..add('propertyCity', propertyCity)
          ..add('reference', reference))
        .toString();
  }
}

class PropertyRecordBuilder
    implements Builder<PropertyRecord, PropertyRecordBuilder> {
  _$PropertyRecord _$v;

  int _pId;
  int get pId => _$this._pId;
  set pId(int pId) => _$this._pId = pId;

  String _propertyCity;
  String get propertyCity => _$this._propertyCity;
  set propertyCity(String propertyCity) => _$this._propertyCity = propertyCity;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  PropertyRecordBuilder() {
    PropertyRecord._initializeBuilder(this);
  }

  PropertyRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _pId = $v.pId;
      _propertyCity = $v.propertyCity;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PropertyRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PropertyRecord;
  }

  @override
  void update(void Function(PropertyRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PropertyRecord build() {
    final _$result = _$v ??
        new _$PropertyRecord._(
            pId: pId, propertyCity: propertyCity, reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
