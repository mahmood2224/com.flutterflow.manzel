import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'user_device_token_record.g.dart';

abstract class UserDeviceTokenRecord
    implements Built<UserDeviceTokenRecord, UserDeviceTokenRecordBuilder> {
  static Serializer<UserDeviceTokenRecord> get serializer =>
      _$userDeviceTokenRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'device_token')
  String get deviceToken;

  @nullable
  @BuiltValueField(wireName: 'user_id')
  DocumentReference get userId;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UserDeviceTokenRecordBuilder builder) =>
      builder..deviceToken = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('User_Device_Token');

  static Stream<UserDeviceTokenRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<UserDeviceTokenRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  UserDeviceTokenRecord._();
  factory UserDeviceTokenRecord(
          [void Function(UserDeviceTokenRecordBuilder) updates]) =
      _$UserDeviceTokenRecord;

  static UserDeviceTokenRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createUserDeviceTokenRecordData({
  String deviceToken,
  DocumentReference userId,
}) =>
    serializers.toFirestore(
        UserDeviceTokenRecord.serializer,
        UserDeviceTokenRecord((u) => u
          ..deviceToken = deviceToken
          ..userId = userId));
