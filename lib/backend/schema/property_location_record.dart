import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'property_location_record.g.dart';

abstract class PropertyLocationRecord
    implements Built<PropertyLocationRecord, PropertyLocationRecordBuilder> {
  static Serializer<PropertyLocationRecord> get serializer =>
      _$propertyLocationRecordSerializer;

  @nullable
  String get name;

  @nullable
  LatLng get location;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(PropertyLocationRecordBuilder builder) =>
      builder..name = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('propertyLocation');

  static Stream<PropertyLocationRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<PropertyLocationRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  PropertyLocationRecord._();
  factory PropertyLocationRecord(
          [void Function(PropertyLocationRecordBuilder) updates]) =
      _$PropertyLocationRecord;

  static PropertyLocationRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createPropertyLocationRecordData({
  String name,
  LatLng location,
}) =>
    serializers.toFirestore(
        PropertyLocationRecord.serializer,
        PropertyLocationRecord((p) => p
          ..name = name
          ..location = location));
