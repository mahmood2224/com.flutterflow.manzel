// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<NotificationsRecord> _$notificationsRecordSerializer =
    new _$NotificationsRecordSerializer();

class _$NotificationsRecordSerializer
    implements StructuredSerializer<NotificationsRecord> {
  @override
  final Iterable<Type> types = const [
    NotificationsRecord,
    _$NotificationsRecord
  ];
  @override
  final String wireName = 'NotificationsRecord';

  @override
  Iterable<Object> serialize(
      Serializers serializers, NotificationsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.createdAt;
    if (value != null) {
      result
        ..add('created_at')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.messageAr;
    if (value != null) {
      result
        ..add('message_ar')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.messageEn;
    if (value != null) {
      result
        ..add('message_en')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.notificationType;
    if (value != null) {
      result
        ..add('notification_type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.orderId;
    if (value != null) {
      result
        ..add('order_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.propertyId;
    if (value != null) {
      result
        ..add('property_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
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
                DocumentReference, const [const FullType(Object)])));
    }
    value = object.isRead;
    if (value != null) {
      result
        ..add('is_read')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
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
  NotificationsRecord deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NotificationsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'message_ar':
          result.messageAr = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'message_en':
          result.messageEn = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'notification_type':
          result.notificationType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'order_id':
          result.orderId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'property_id':
          result.propertyId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'user_id':
          result.userId = serializers.deserialize(value,
                  specifiedType: const FullType(
                      DocumentReference, const [const FullType(Object)]))
              as DocumentReference<Object>;
          break;
        case 'is_read':
          result.isRead = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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

class _$NotificationsRecord extends NotificationsRecord {
  @override
  final DateTime createdAt;
  @override
  final String messageAr;
  @override
  final String messageEn;
  @override
  final String notificationType;
  @override
  final int orderId;
  @override
  final String propertyId;
  @override
  final DateTime updatedAt;
  @override
  final DocumentReference<Object> userId;
  @override
  final int isRead;
  @override
  final DocumentReference<Object> reference;

  factory _$NotificationsRecord(
          [void Function(NotificationsRecordBuilder) updates]) =>
      (new NotificationsRecordBuilder()..update(updates))._build();

  _$NotificationsRecord._(
      {this.createdAt,
      this.messageAr,
      this.messageEn,
      this.notificationType,
      this.orderId,
      this.propertyId,
      this.updatedAt,
      this.userId,
      this.isRead,
      this.reference})
      : super._();

  @override
  NotificationsRecord rebuild(
          void Function(NotificationsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NotificationsRecordBuilder toBuilder() =>
      new NotificationsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationsRecord &&
        createdAt == other.createdAt &&
        messageAr == other.messageAr &&
        messageEn == other.messageEn &&
        notificationType == other.notificationType &&
        orderId == other.orderId &&
        propertyId == other.propertyId &&
        updatedAt == other.updatedAt &&
        userId == other.userId &&
        isRead == other.isRead &&
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
                                    $jc($jc(0, createdAt.hashCode),
                                        messageAr.hashCode),
                                    messageEn.hashCode),
                                notificationType.hashCode),
                            orderId.hashCode),
                        propertyId.hashCode),
                    updatedAt.hashCode),
                userId.hashCode),
            isRead.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotificationsRecord')
          ..add('createdAt', createdAt)
          ..add('messageAr', messageAr)
          ..add('messageEn', messageEn)
          ..add('notificationType', notificationType)
          ..add('orderId', orderId)
          ..add('propertyId', propertyId)
          ..add('updatedAt', updatedAt)
          ..add('userId', userId)
          ..add('isRead', isRead)
          ..add('reference', reference))
        .toString();
  }
}

class NotificationsRecordBuilder
    implements Builder<NotificationsRecord, NotificationsRecordBuilder> {
  _$NotificationsRecord _$v;

  DateTime _createdAt;
  DateTime get createdAt => _$this._createdAt;
  set createdAt(DateTime createdAt) => _$this._createdAt = createdAt;

  String _messageAr;
  String get messageAr => _$this._messageAr;
  set messageAr(String messageAr) => _$this._messageAr = messageAr;

  String _messageEn;
  String get messageEn => _$this._messageEn;
  set messageEn(String messageEn) => _$this._messageEn = messageEn;

  String _notificationType;
  String get notificationType => _$this._notificationType;
  set notificationType(String notificationType) =>
      _$this._notificationType = notificationType;

  int _orderId;
  int get orderId => _$this._orderId;
  set orderId(int orderId) => _$this._orderId = orderId;

  String _propertyId;
  String get propertyId => _$this._propertyId;
  set propertyId(String propertyId) => _$this._propertyId = propertyId;

  DateTime _updatedAt;
  DateTime get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime updatedAt) => _$this._updatedAt = updatedAt;

  DocumentReference<Object> _userId;
  DocumentReference<Object> get userId => _$this._userId;
  set userId(DocumentReference<Object> userId) => _$this._userId = userId;

  int _isRead;
  int get isRead => _$this._isRead;
  set isRead(int isRead) => _$this._isRead = isRead;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  NotificationsRecordBuilder() {
    NotificationsRecord._initializeBuilder(this);
  }

  NotificationsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _createdAt = $v.createdAt;
      _messageAr = $v.messageAr;
      _messageEn = $v.messageEn;
      _notificationType = $v.notificationType;
      _orderId = $v.orderId;
      _propertyId = $v.propertyId;
      _updatedAt = $v.updatedAt;
      _userId = $v.userId;
      _isRead = $v.isRead;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NotificationsRecord;
  }

  @override
  void update(void Function(NotificationsRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  NotificationsRecord build() => _build();

  _$NotificationsRecord _build() {
    final _$result = _$v ??
        new _$NotificationsRecord._(
            createdAt: createdAt,
            messageAr: messageAr,
            messageEn: messageEn,
            notificationType: notificationType,
            orderId: orderId,
            propertyId: propertyId,
            updatedAt: updatedAt,
            userId: userId,
            isRead: isRead,
            reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
