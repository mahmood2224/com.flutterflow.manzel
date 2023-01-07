import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'user_properties_record.g.dart';

abstract class UserPropertiesRecord
    implements Built<UserPropertiesRecord, UserPropertiesRecordBuilder> {
  static Serializer<UserPropertiesRecord> get serializer =>
      _$userPropertiesRecordSerializer;

  @BuiltValueField(wireName: 'u_id')
  DocumentReference? get uId;

  @BuiltValueField(wireName: 'p_id')
  int? get pId;

  String? get status;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(UserPropertiesRecordBuilder builder) => builder
    ..pId = 0
    ..status = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('userProperties');

  static Stream<UserPropertiesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<UserPropertiesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  UserPropertiesRecord._();
  factory UserPropertiesRecord(
          [void Function(UserPropertiesRecordBuilder) updates]) =
      _$UserPropertiesRecord;

  static UserPropertiesRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createUserPropertiesRecordData({
  DocumentReference? uId,
  int? pId,
  String? status,
}) {
  final firestoreData = serializers.toFirestore(
    UserPropertiesRecord.serializer,
    UserPropertiesRecord(
      (u) => u
        ..uId = uId
        ..pId = pId
        ..status = status,
    ),
  );

  return firestoreData;
}
