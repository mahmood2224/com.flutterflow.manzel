import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'users_device_token_record.g.dart';

abstract class UsersDeviceTokenRecord
    implements Built<UsersDeviceTokenRecord, UsersDeviceTokenRecordBuilder> {
  static Serializer<UsersDeviceTokenRecord> get serializer =>
      _$usersDeviceTokenRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'device_token')
  String get deviceToken;

  @nullable
  @BuiltValueField(wireName: 'user_id')
  DocumentReference get userId;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UsersDeviceTokenRecordBuilder builder) =>
      builder..deviceToken = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Users_Device_Token');

  static Stream<UsersDeviceTokenRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<UsersDeviceTokenRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  UsersDeviceTokenRecord._();
  factory UsersDeviceTokenRecord(
          [void Function(UsersDeviceTokenRecordBuilder) updates]) =
      _$UsersDeviceTokenRecord;

  static UsersDeviceTokenRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createUsersDeviceTokenRecordData({
  String deviceToken,
  DocumentReference userId,
}) =>
    serializers.toFirestore(
        UsersDeviceTokenRecord.serializer,
        UsersDeviceTokenRecord((u) => u
          ..deviceToken = deviceToken
          ..userId = userId));
