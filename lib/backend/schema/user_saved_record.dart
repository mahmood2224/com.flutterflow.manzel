import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'user_saved_record.g.dart';

abstract class UserSavedRecord
    implements Built<UserSavedRecord, UserSavedRecordBuilder> {
  static Serializer<UserSavedRecord> get serializer =>
      _$userSavedRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'u_id')
  DocumentReference get uId;

  @nullable
  @BuiltValueField(wireName: 'p_id')
  int get pId;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UserSavedRecordBuilder builder) =>
      builder..pId = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('userSaved');

  static Stream<UserSavedRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<UserSavedRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  UserSavedRecord._();
  factory UserSavedRecord([void Function(UserSavedRecordBuilder) updates]) =
      _$UserSavedRecord;

  static UserSavedRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createUserSavedRecordData({
  DocumentReference uId,
  int pId,
}) =>
    serializers.toFirestore(
        UserSavedRecord.serializer,
        UserSavedRecord((u) => u
          ..uId = uId
          ..pId = pId));
