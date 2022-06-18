import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'saved_record.g.dart';

abstract class SavedRecord implements Built<SavedRecord, SavedRecordBuilder> {
  static Serializer<SavedRecord> get serializer => _$savedRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'p_id')
  int get pId;

  @nullable
  @BuiltValueField(wireName: 'u_id')
  DocumentReference get uId;

  @nullable
  bool get isSaved;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(SavedRecordBuilder builder) => builder
    ..pId = 0
    ..isSaved = false;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Saved');

  static Stream<SavedRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<SavedRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  SavedRecord._();
  factory SavedRecord([void Function(SavedRecordBuilder) updates]) =
      _$SavedRecord;

  static SavedRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createSavedRecordData({
  int pId,
  DocumentReference uId,
  bool isSaved,
}) =>
    serializers.toFirestore(
        SavedRecord.serializer,
        SavedRecord((s) => s
          ..pId = pId
          ..uId = uId
          ..isSaved = isSaved));
