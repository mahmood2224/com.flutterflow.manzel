import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'notifications_record.g.dart';

abstract class NotificationsRecord
    implements Built<NotificationsRecord, NotificationsRecordBuilder> {
  static Serializer<NotificationsRecord> get serializer =>
      _$notificationsRecordSerializer;

  @BuiltValueField(wireName: 'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: 'message_ar')
  String? get messageAr;

  @BuiltValueField(wireName: 'message_en')
  String? get messageEn;

  @BuiltValueField(wireName: 'notification_type')
  String? get notificationType;

  @BuiltValueField(wireName: 'order_id')
  int? get orderId;

  @BuiltValueField(wireName: 'property_id')
  String? get propertyId;

  @BuiltValueField(wireName: 'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: 'user_id')
  DocumentReference? get userId;

  @BuiltValueField(wireName: 'is_read')
  int? get isRead;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(NotificationsRecordBuilder builder) => builder
    ..messageAr = ''
    ..messageEn = ''
    ..notificationType = ''
    ..orderId = 0
    ..propertyId = ''
    ..isRead = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Notifications');

  static Stream<NotificationsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<NotificationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  NotificationsRecord._();
  factory NotificationsRecord(
          [void Function(NotificationsRecordBuilder) updates]) =
      _$NotificationsRecord;

  static NotificationsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createNotificationsRecordData({
  DateTime? createdAt,
  String? messageAr,
  String? messageEn,
  String? notificationType,
  int? orderId,
  String? propertyId,
  DateTime? updatedAt,
  DocumentReference? userId,
  int? isRead,
}) {
  final firestoreData = serializers.toFirestore(
    NotificationsRecord.serializer,
    NotificationsRecord(
      (n) => n
        ..createdAt = createdAt
        ..messageAr = messageAr
        ..messageEn = messageEn
        ..notificationType = notificationType
        ..orderId = orderId
        ..propertyId = propertyId
        ..updatedAt = updatedAt
        ..userId = userId
        ..isRead = isRead,
    ),
  );

  return firestoreData;
}
