import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'booked_record.g.dart';

abstract class BookedRecord
    implements Built<BookedRecord, BookedRecordBuilder> {
  static Serializer<BookedRecord> get serializer => _$bookedRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'u_id')
  DocumentReference get uId;

  @nullable
  @BuiltValueField(wireName: 'p_id')
  int get pId;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(BookedRecordBuilder builder) =>
      builder..pId = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Booked');

  static Stream<BookedRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<BookedRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  BookedRecord._();
  factory BookedRecord([void Function(BookedRecordBuilder) updates]) =
      _$BookedRecord;

  static BookedRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createBookedRecordData({
  DocumentReference uId,
  int pId,
}) =>
    serializers.toFirestore(
        BookedRecord.serializer,
        BookedRecord((b) => b
          ..uId = uId
          ..pId = pId));
