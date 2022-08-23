import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'user_record.g.dart';

abstract class UserRecord implements Built<UserRecord, UserRecordBuilder> {
  static Serializer<UserRecord> get serializer => _$userRecordSerializer;

  @nullable
  String get email;

  @nullable
  String get uid;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  @BuiltValueField(wireName: 'phone_number')
  String get phoneNumber;

  @nullable
  @BuiltValueField(wireName: 'employment_status')
  String get employmentStatus;

  @nullable
  String get bank;

  @nullable
  @BuiltValueField(wireName: 'monthly_income')
  String get monthlyIncome;

  @nullable
  @BuiltValueField(wireName: 'photo_url')
  String get photoUrl;

  @nullable
  String get status;

  @nullable
  String get name;

  @nullable
  @BuiltValueField(wireName: 'country_code')
  String get countryCode;

  @nullable
  @BuiltValueField(wireName: 'role_id')
  String get roleId;

  @nullable
  String get gender;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  String get language;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UserRecordBuilder builder) => builder
    ..email = ''
    ..uid = ''
    ..phoneNumber = ''
    ..employmentStatus = ''
    ..bank = ''
    ..monthlyIncome = ''
    ..photoUrl = ''
    ..status = ''
    ..name = ''
    ..countryCode = ''
    ..roleId = ''
    ..gender = ''
    ..displayName = ''
    ..language = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('User');

  static Stream<UserRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<UserRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  UserRecord._();
  factory UserRecord([void Function(UserRecordBuilder) updates]) = _$UserRecord;

  static UserRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createUserRecordData({
  String email,
  String uid,
  DateTime createdTime,
  String phoneNumber,
  String employmentStatus,
  String bank,
  String monthlyIncome,
  String photoUrl,
  String status,
  String name,
  String countryCode,
  String roleId,
  String gender,
  String displayName,
  String language,
}) =>
    serializers.toFirestore(
        UserRecord.serializer,
        UserRecord((u) => u
          ..email = email
          ..uid = uid
          ..createdTime = createdTime
          ..phoneNumber = phoneNumber
          ..employmentStatus = employmentStatus
          ..bank = bank
          ..monthlyIncome = monthlyIncome
          ..photoUrl = photoUrl
          ..status = status
          ..name = name
          ..countryCode = countryCode
          ..roleId = roleId
          ..gender = gender
          ..displayName = displayName
          ..language = language));
