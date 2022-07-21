import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'orders_record.g.dart';

abstract class OrdersRecord
    implements Built<OrdersRecord, OrdersRecordBuilder> {
  static Serializer<OrdersRecord> get serializer => _$ordersRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'order_id')
  int get orderId;

  @nullable
  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @nullable
  @BuiltValueField(wireName: 'updated_at')
  DateTime get updatedAt;

  @nullable
  @BuiltValueField(wireName: 'user_id')
  DocumentReference get userId;

  @nullable
  @BuiltValueField(wireName: 'property_id')
  int get propertyId;

  @nullable
  @BuiltValueField(wireName: 'order_status')
  String get orderStatus;

  @nullable
  @BuiltValueField(wireName: 'booking_expiry_date')
  DateTime get bookingExpiryDate;

  @nullable
  @BuiltValueField(wireName: 'reservation_amount')
  String get reservationAmount;

  @nullable
  @BuiltValueField(wireName: 'deposit_receipt')
  String get depositReceipt;

  @nullable
  @BuiltValueField(wireName: 'cammunda_instance_id')
  String get cammundaInstanceId;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(OrdersRecordBuilder builder) => builder
    ..orderId = 0
    ..propertyId = 0
    ..orderStatus = ''
    ..reservationAmount = ''
    ..depositReceipt = ''
    ..cammundaInstanceId = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('orders');

  static Stream<OrdersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<OrdersRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  OrdersRecord._();
  factory OrdersRecord([void Function(OrdersRecordBuilder) updates]) =
      _$OrdersRecord;

  static OrdersRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createOrdersRecordData({
  int orderId,
  DateTime createdAt,
  DateTime updatedAt,
  DocumentReference userId,
  int propertyId,
  String orderStatus,
  DateTime bookingExpiryDate,
  String reservationAmount,
  String depositReceipt,
  String cammundaInstanceId,
}) =>
    serializers.toFirestore(
        OrdersRecord.serializer,
        OrdersRecord((o) => o
          ..orderId = orderId
          ..createdAt = createdAt
          ..updatedAt = updatedAt
          ..userId = userId
          ..propertyId = propertyId
          ..orderStatus = orderStatus
          ..bookingExpiryDate = bookingExpiryDate
          ..reservationAmount = reservationAmount
          ..depositReceipt = depositReceipt
          ..cammundaInstanceId = cammundaInstanceId));
