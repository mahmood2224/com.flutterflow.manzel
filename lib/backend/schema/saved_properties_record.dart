import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'saved_properties_record.g.dart';

abstract class SavedPropertiesRecord
    implements Built<SavedPropertiesRecord, SavedPropertiesRecordBuilder> {
  static Serializer<SavedPropertiesRecord> get serializer =>
      _$savedPropertiesRecordSerializer;

  @BuiltValueField(wireName: 'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: 'property_id')
  String? get propertyId;

  @BuiltValueField(wireName: 'user_id')
  String? get userId;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(SavedPropertiesRecordBuilder builder) =>
      builder
        ..propertyId = ''
        ..userId = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Saved_Properties');

  static Stream<SavedPropertiesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<SavedPropertiesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  SavedPropertiesRecord._();
  factory SavedPropertiesRecord(
          [void Function(SavedPropertiesRecordBuilder) updates]) =
      _$SavedPropertiesRecord;

  static SavedPropertiesRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createSavedPropertiesRecordData({
  DateTime? createdAt,
  String? propertyId,
  String? userId,
}) {
  final firestoreData = serializers.toFirestore(
    SavedPropertiesRecord.serializer,
    SavedPropertiesRecord(
      (s) => s
        ..createdAt = createdAt
        ..propertyId = propertyId
        ..userId = userId,
    ),
  );

  return firestoreData;
}
