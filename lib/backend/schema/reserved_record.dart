import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'reserved_record.g.dart';

abstract class ReservedRecord
    implements Built<ReservedRecord, ReservedRecordBuilder> {
  static Serializer<ReservedRecord> get serializer =>
      _$reservedRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'u_id')
  DocumentReference get uId;

  @nullable
  @BuiltValueField(wireName: 'p_id')
  int get pId;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ReservedRecordBuilder builder) =>
      builder..pId = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Reserved');

  static Stream<ReservedRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<ReservedRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  ReservedRecord._();
  factory ReservedRecord([void Function(ReservedRecordBuilder) updates]) =
      _$ReservedRecord;

  static ReservedRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createReservedRecordData({
  DocumentReference uId,
  int pId,
}) =>
    serializers.toFirestore(
        ReservedRecord.serializer,
        ReservedRecord((r) => r
          ..uId = uId
          ..pId = pId));
