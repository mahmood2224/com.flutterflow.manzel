import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'user_record.g.dart';

abstract class UserRecord implements Built<UserRecord, UserRecordBuilder> {
  static Serializer<UserRecord> get serializer => _$userRecordSerializer;

  String? get email;

  String? get uid;

  @BuiltValueField(wireName: 'created_time')
  DateTime? get createdTime;

  @BuiltValueField(wireName: 'phone_number')
  String? get phoneNumber;

  @BuiltValueField(wireName: 'employment_status')
  String? get employmentStatus;

  String? get bank;

  @BuiltValueField(wireName: 'monthly_income')
  String? get monthlyIncome;

  @BuiltValueField(wireName: 'photo_url')
  String? get photoUrl;

  String? get status;

  String? get name;

  @BuiltValueField(wireName: 'country_code')
  String? get countryCode;

  @BuiltValueField(wireName: 'role_id')
  String? get roleId;

  String? get gender;

  @BuiltValueField(wireName: 'display_name')
  String? get displayName;

  String? get language;

  @BuiltValueField(wireName: 'is_deleted')
  int? get isDeleted;

  @BuiltValueField(wireName: 'sakani_loan_coverage')
  bool? get sakaniLoanCoverage;

  @BuiltValueField(wireName: 'last_login')
  DateTime? get lastLogin;

  @BuiltValueField(wireName: 'firebase_device_token')
  String? get deviceToken ;
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

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
    ..language = ''
    ..isDeleted = 0
    ..deviceToken = ''
    ..sakaniLoanCoverage = false;


  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('User');

  static Stream<UserRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<UserRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  UserRecord._();
  factory UserRecord([void Function(UserRecordBuilder) updates]) = _$UserRecord;

  static UserRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createUserRecordData({
  String? email,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  String? employmentStatus,
  String? bank,
  String? monthlyIncome,
  String? photoUrl,
  String? status,
  String? name,
  String? countryCode,
  String? roleId,
  String? gender,
  String? displayName,
  String? language,
  int? isDeleted,
  bool? sakaniLoanCoverage,
  DateTime? lastLogin,
  String? deviceToken,
}) {
  final firestoreData = serializers.toFirestore(
    UserRecord.serializer,
    UserRecord(
      (u) => u
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
        ..language = language
        ..isDeleted = isDeleted
        ..sakaniLoanCoverage = sakaniLoanCoverage
        ..lastLogin = lastLogin
        ..deviceToken = deviceToken,
    ),
  );

  return firestoreData;
}
