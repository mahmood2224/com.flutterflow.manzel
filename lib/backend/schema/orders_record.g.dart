// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OrdersRecord> _$ordersRecordSerializer =
    new _$OrdersRecordSerializer();

class _$OrdersRecordSerializer implements StructuredSerializer<OrdersRecord> {
  @override
  final Iterable<Type> types = const [OrdersRecord, _$OrdersRecord];
  @override
  final String wireName = 'OrdersRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, OrdersRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.orderId;
    if (value != null) {
      result
        ..add('order_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.createdAt;
    if (value != null) {
      result
        ..add('created_at')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.updatedAt;
    if (value != null) {
      result
        ..add('updated_at')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.userId;
    if (value != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.propertyId;
    if (value != null) {
      result
        ..add('property_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.orderStatus;
    if (value != null) {
      result
        ..add('order_status')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.bookingExpiryDate;
    if (value != null) {
      result
        ..add('booking_expiry_date')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.reservationAmount;
    if (value != null) {
      result
        ..add('reservation_amount')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.depositReceipt;
    if (value != null) {
      result
        ..add('deposit_receipt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.cammundaInstanceId;
    if (value != null) {
      result
        ..add('cammunda_instance_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.ffRef;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    return result;
  }

  @override
  OrdersRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OrdersRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'order_id':
          result.orderId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'user_id':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'property_id':
          result.propertyId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'order_status':
          result.orderStatus = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'booking_expiry_date':
          result.bookingExpiryDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'reservation_amount':
          result.reservationAmount = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'deposit_receipt':
          result.depositReceipt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'cammunda_instance_id':
          result.cammundaInstanceId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'Document__Reference__Field':
          result.ffRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
      }
    }

    return result.build();
  }
}

class _$OrdersRecord extends OrdersRecord {
  @override
  final int? orderId;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DocumentReference<Object?>? userId;
  @override
  final int? propertyId;
  @override
  final String? orderStatus;
  @override
  final DateTime? bookingExpiryDate;
  @override
  final String? reservationAmount;
  @override
  final String? depositReceipt;
  @override
  final String? cammundaInstanceId;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$OrdersRecord([void Function(OrdersRecordBuilder)? updates]) =>
      (new OrdersRecordBuilder()..update(updates))._build();

  _$OrdersRecord._(
      {this.orderId,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.propertyId,
      this.orderStatus,
      this.bookingExpiryDate,
      this.reservationAmount,
      this.depositReceipt,
      this.cammundaInstanceId,
      this.ffRef})
      : super._();

  @override
  OrdersRecord rebuild(void Function(OrdersRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrdersRecordBuilder toBuilder() => new OrdersRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrdersRecord &&
        orderId == other.orderId &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        userId == other.userId &&
        propertyId == other.propertyId &&
        orderStatus == other.orderStatus &&
        bookingExpiryDate == other.bookingExpiryDate &&
        reservationAmount == other.reservationAmount &&
        depositReceipt == other.depositReceipt &&
        cammundaInstanceId == other.cammundaInstanceId &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc($jc(0, orderId.hashCode),
                                            createdAt.hashCode),
                                        updatedAt.hashCode),
                                    userId.hashCode),
                                propertyId.hashCode),
                            orderStatus.hashCode),
                        bookingExpiryDate.hashCode),
                    reservationAmount.hashCode),
                depositReceipt.hashCode),
            cammundaInstanceId.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrdersRecord')
          ..add('orderId', orderId)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('userId', userId)
          ..add('propertyId', propertyId)
          ..add('orderStatus', orderStatus)
          ..add('bookingExpiryDate', bookingExpiryDate)
          ..add('reservationAmount', reservationAmount)
          ..add('depositReceipt', depositReceipt)
          ..add('cammundaInstanceId', cammundaInstanceId)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class OrdersRecordBuilder
    implements Builder<OrdersRecord, OrdersRecordBuilder> {
  _$OrdersRecord? _$v;

  int? _orderId;
  int? get orderId => _$this._orderId;
  set orderId(int? orderId) => _$this._orderId = orderId;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  DocumentReference<Object?>? _userId;
  DocumentReference<Object?>? get userId => _$this._userId;
  set userId(DocumentReference<Object?>? userId) => _$this._userId = userId;

  int? _propertyId;
  int? get propertyId => _$this._propertyId;
  set propertyId(int? propertyId) => _$this._propertyId = propertyId;

  String? _orderStatus;
  String? get orderStatus => _$this._orderStatus;
  set orderStatus(String? orderStatus) => _$this._orderStatus = orderStatus;

  DateTime? _bookingExpiryDate;
  DateTime? get bookingExpiryDate => _$this._bookingExpiryDate;
  set bookingExpiryDate(DateTime? bookingExpiryDate) =>
      _$this._bookingExpiryDate = bookingExpiryDate;

  String? _reservationAmount;
  String? get reservationAmount => _$this._reservationAmount;
  set reservationAmount(String? reservationAmount) =>
      _$this._reservationAmount = reservationAmount;

  String? _depositReceipt;
  String? get depositReceipt => _$this._depositReceipt;
  set depositReceipt(String? depositReceipt) =>
      _$this._depositReceipt = depositReceipt;

  String? _cammundaInstanceId;
  String? get cammundaInstanceId => _$this._cammundaInstanceId;
  set cammundaInstanceId(String? cammundaInstanceId) =>
      _$this._cammundaInstanceId = cammundaInstanceId;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  OrdersRecordBuilder() {
    OrdersRecord._initializeBuilder(this);
  }

  OrdersRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _orderId = $v.orderId;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _userId = $v.userId;
      _propertyId = $v.propertyId;
      _orderStatus = $v.orderStatus;
      _bookingExpiryDate = $v.bookingExpiryDate;
      _reservationAmount = $v.reservationAmount;
      _depositReceipt = $v.depositReceipt;
      _cammundaInstanceId = $v.cammundaInstanceId;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrdersRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$OrdersRecord;
  }

  @override
  void update(void Function(OrdersRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrdersRecord build() => _build();

  _$OrdersRecord _build() {
    final _$result = _$v ??
        new _$OrdersRecord._(
            orderId: orderId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            userId: userId,
            propertyId: propertyId,
            orderStatus: orderStatus,
            bookingExpiryDate: bookingExpiryDate,
            reservationAmount: reservationAmount,
            depositReceipt: depositReceipt,
            cammundaInstanceId: cammundaInstanceId,
            ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
