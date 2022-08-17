import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'notifications_record.g.dart';

abstract class NotificationsRecord
    implements Built<NotificationsRecord, NotificationsRecordBuilder> {
  static Serializer<NotificationsRecord> get serializer =>
      _$notificationsRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @nullable
  @BuiltValueField(wireName: 'is_read')
  bool get isRead;

  @nullable
  @BuiltValueField(wireName: 'message_ar')
  String get messageAr;

  @nullable
  @BuiltValueField(wireName: 'message_en')
  String get messageEn;

  @nullable
  @BuiltValueField(wireName: 'notification_type')
  String get notificationType;

  @nullable
  @BuiltValueField(wireName: 'order_id')
  int get orderId;

  @nullable
  @BuiltValueField(wireName: 'property_id')
  String get propertyId;

  @nullable
  @BuiltValueField(wireName: 'updated_at')
  DateTime get updatedAt;

  @nullable
  @BuiltValueField(wireName: 'user_id')
  DocumentReference get userId;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(NotificationsRecordBuilder builder) => builder
    ..isRead = false
    ..messageAr = ''
    ..messageEn = ''
    ..notificationType = ''
    ..orderId = 0
    ..propertyId = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Notifications');

  static Stream<NotificationsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<NotificationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  NotificationsRecord._();
  factory NotificationsRecord(
          [void Function(NotificationsRecordBuilder) updates]) =
      _$NotificationsRecord;

  static NotificationsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createNotificationsRecordData({
  DateTime createdAt,
  bool isRead,
  String messageAr,
  String messageEn,
  String notificationType,
  int orderId,
  String propertyId,
  DateTime updatedAt,
  DocumentReference userId,
}) =>
    serializers.toFirestore(
        NotificationsRecord.serializer,
        NotificationsRecord((n) => n
          ..createdAt = createdAt
          ..isRead = isRead
          ..messageAr = messageAr
          ..messageEn = messageEn
          ..notificationType = notificationType
          ..orderId = orderId
          ..propertyId = propertyId
          ..updatedAt = updatedAt
          ..userId = userId));
