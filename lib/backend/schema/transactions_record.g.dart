// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TransactionsRecord> _$transactionsRecordSerializer =
    new _$TransactionsRecordSerializer();

class _$TransactionsRecordSerializer
    implements StructuredSerializer<TransactionsRecord> {
  @override
  final Iterable<Type> types = const [TransactionsRecord, _$TransactionsRecord];
  @override
  final String wireName = 'TransactionsRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, TransactionsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.userId;
    if (value != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType(Object)])));
    }
    value = object.orderId;
    if (value != null) {
      result
        ..add('order_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.paidAmount;
    if (value != null) {
      result
        ..add('paid_amount')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.transactionType;
    if (value != null) {
      result
        ..add('transaction_type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.transactionMethod;
    if (value != null) {
      result
        ..add('transaction_method')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.transactionStatus;
    if (value != null) {
      result
        ..add('transaction_status')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
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
    value = object.transactionId;
    if (value != null) {
      result
        ..add('transaction_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.reference;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType(Object)])));
    }
    return result;
  }

  @override
  TransactionsRecord deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TransactionsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'user_id':
          result.userId = serializers.deserialize(value,
                  specifiedType: const FullType(
                      DocumentReference, const [const FullType(Object)]))
              as DocumentReference<Object>;
          break;
        case 'order_id':
          result.orderId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'paid_amount':
          result.paidAmount = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'transaction_type':
          result.transactionType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'transaction_method':
          result.transactionMethod = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'transaction_status':
          result.transactionStatus = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'transaction_id':
          result.transactionId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'Document__Reference__Field':
          result.reference = serializers.deserialize(value,
                  specifiedType: const FullType(
                      DocumentReference, const [const FullType(Object)]))
              as DocumentReference<Object>;
          break;
      }
    }

    return result.build();
  }
}

class _$TransactionsRecord extends TransactionsRecord {
  @override
  final DocumentReference<Object> userId;
  @override
  final int orderId;
  @override
  final String paidAmount;
  @override
  final String transactionType;
  @override
  final String transactionMethod;
  @override
  final String transactionStatus;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String transactionId;
  @override
  final DocumentReference<Object> reference;

  factory _$TransactionsRecord(
          [void Function(TransactionsRecordBuilder) updates]) =>
      (new TransactionsRecordBuilder()..update(updates))._build();

  _$TransactionsRecord._(
      {this.userId,
      this.orderId,
      this.paidAmount,
      this.transactionType,
      this.transactionMethod,
      this.transactionStatus,
      this.createdAt,
      this.updatedAt,
      this.transactionId,
      this.reference})
      : super._();

  @override
  TransactionsRecord rebuild(
          void Function(TransactionsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransactionsRecordBuilder toBuilder() =>
      new TransactionsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransactionsRecord &&
        userId == other.userId &&
        orderId == other.orderId &&
        paidAmount == other.paidAmount &&
        transactionType == other.transactionType &&
        transactionMethod == other.transactionMethod &&
        transactionStatus == other.transactionStatus &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        transactionId == other.transactionId &&
        reference == other.reference;
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
                                    $jc($jc(0, userId.hashCode),
                                        orderId.hashCode),
                                    paidAmount.hashCode),
                                transactionType.hashCode),
                            transactionMethod.hashCode),
                        transactionStatus.hashCode),
                    createdAt.hashCode),
                updatedAt.hashCode),
            transactionId.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransactionsRecord')
          ..add('userId', userId)
          ..add('orderId', orderId)
          ..add('paidAmount', paidAmount)
          ..add('transactionType', transactionType)
          ..add('transactionMethod', transactionMethod)
          ..add('transactionStatus', transactionStatus)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('transactionId', transactionId)
          ..add('reference', reference))
        .toString();
  }
}

class TransactionsRecordBuilder
    implements Builder<TransactionsRecord, TransactionsRecordBuilder> {
  _$TransactionsRecord _$v;

  DocumentReference<Object> _userId;
  DocumentReference<Object> get userId => _$this._userId;
  set userId(DocumentReference<Object> userId) => _$this._userId = userId;

  int _orderId;
  int get orderId => _$this._orderId;
  set orderId(int orderId) => _$this._orderId = orderId;

  String _paidAmount;
  String get paidAmount => _$this._paidAmount;
  set paidAmount(String paidAmount) => _$this._paidAmount = paidAmount;

  String _transactionType;
  String get transactionType => _$this._transactionType;
  set transactionType(String transactionType) =>
      _$this._transactionType = transactionType;

  String _transactionMethod;
  String get transactionMethod => _$this._transactionMethod;
  set transactionMethod(String transactionMethod) =>
      _$this._transactionMethod = transactionMethod;

  String _transactionStatus;
  String get transactionStatus => _$this._transactionStatus;
  set transactionStatus(String transactionStatus) =>
      _$this._transactionStatus = transactionStatus;

  DateTime _createdAt;
  DateTime get createdAt => _$this._createdAt;
  set createdAt(DateTime createdAt) => _$this._createdAt = createdAt;

  DateTime _updatedAt;
  DateTime get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime updatedAt) => _$this._updatedAt = updatedAt;

  String _transactionId;
  String get transactionId => _$this._transactionId;
  set transactionId(String transactionId) =>
      _$this._transactionId = transactionId;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  TransactionsRecordBuilder() {
    TransactionsRecord._initializeBuilder(this);
  }

  TransactionsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _orderId = $v.orderId;
      _paidAmount = $v.paidAmount;
      _transactionType = $v.transactionType;
      _transactionMethod = $v.transactionMethod;
      _transactionStatus = $v.transactionStatus;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _transactionId = $v.transactionId;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransactionsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TransactionsRecord;
  }

  @override
  void update(void Function(TransactionsRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  TransactionsRecord build() => _build();

  _$TransactionsRecord _build() {
    final _$result = _$v ??
        new _$TransactionsRecord._(
            userId: userId,
            orderId: orderId,
            paidAmount: paidAmount,
            transactionType: transactionType,
            transactionMethod: transactionMethod,
            transactionStatus: transactionStatus,
            createdAt: createdAt,
            updatedAt: updatedAt,
            transactionId: transactionId,
            reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
