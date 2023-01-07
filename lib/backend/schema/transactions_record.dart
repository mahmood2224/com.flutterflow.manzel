import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'transactions_record.g.dart';

abstract class TransactionsRecord
    implements Built<TransactionsRecord, TransactionsRecordBuilder> {
  static Serializer<TransactionsRecord> get serializer =>
      _$transactionsRecordSerializer;

  @BuiltValueField(wireName: 'user_id')
  DocumentReference? get userId;

  @BuiltValueField(wireName: 'order_id')
  int? get orderId;

  @BuiltValueField(wireName: 'paid_amount')
  String? get paidAmount;

  @BuiltValueField(wireName: 'transaction_type')
  String? get transactionType;

  @BuiltValueField(wireName: 'transaction_method')
  String? get transactionMethod;

  @BuiltValueField(wireName: 'transaction_status')
  String? get transactionStatus;

  @BuiltValueField(wireName: 'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: 'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: 'transaction_id')
  String? get transactionId;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(TransactionsRecordBuilder builder) => builder
    ..orderId = 0
    ..paidAmount = ''
    ..transactionType = ''
    ..transactionMethod = ''
    ..transactionStatus = ''
    ..transactionId = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Transactions');

  static Stream<TransactionsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<TransactionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  TransactionsRecord._();
  factory TransactionsRecord(
          [void Function(TransactionsRecordBuilder) updates]) =
      _$TransactionsRecord;

  static TransactionsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createTransactionsRecordData({
  DocumentReference? userId,
  int? orderId,
  String? paidAmount,
  String? transactionType,
  String? transactionMethod,
  String? transactionStatus,
  DateTime? createdAt,
  DateTime? updatedAt,
  String? transactionId,
}) {
  final firestoreData = serializers.toFirestore(
    TransactionsRecord.serializer,
    TransactionsRecord(
      (t) => t
        ..userId = userId
        ..orderId = orderId
        ..paidAmount = paidAmount
        ..transactionType = transactionType
        ..transactionMethod = transactionMethod
        ..transactionStatus = transactionStatus
        ..createdAt = createdAt
        ..updatedAt = updatedAt
        ..transactionId = transactionId,
    ),
  );

  return firestoreData;
}
