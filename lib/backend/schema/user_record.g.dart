// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserRecord> _$userRecordSerializer = new _$UserRecordSerializer();

class _$UserRecordSerializer implements StructuredSerializer<UserRecord> {
  @override
  final Iterable<Type> types = const [UserRecord, _$UserRecord];
  @override
  final String wireName = 'UserRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, UserRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.email;
    if (value != null) {
      result
        ..add('email')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.uid;
    if (value != null) {
      result
        ..add('uid')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.createdTime;
    if (value != null) {
      result
        ..add('created_time')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.phoneNumber;
    if (value != null) {
      result
        ..add('phone_number')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.employmentStatus;
    if (value != null) {
      result
        ..add('employment_status')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.bank;
    if (value != null) {
      result
        ..add('bank')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.monthlyIncome;
    if (value != null) {
      result
        ..add('monthly_income')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.photoUrl;
    if (value != null) {
      result
        ..add('photo_url')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.countryCode;
    if (value != null) {
      result
        ..add('country_code')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.roleId;
    if (value != null) {
      result
        ..add('role_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.gender;
    if (value != null) {
      result
        ..add('gender')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.displayName;
    if (value != null) {
      result
        ..add('display_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.language;
    if (value != null) {
      result
        ..add('language')
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
  UserRecord deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'created_time':
          result.createdTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'phone_number':
          result.phoneNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'employment_status':
          result.employmentStatus = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'bank':
          result.bank = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'monthly_income':
          result.monthlyIncome = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'photo_url':
          result.photoUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'country_code':
          result.countryCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'role_id':
          result.roleId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'gender':
          result.gender = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'display_name':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'language':
          result.language = serializers.deserialize(value,
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

class _$UserRecord extends UserRecord {
  @override
  final String email;
  @override
  final String uid;
  @override
  final DateTime createdTime;
  @override
  final String phoneNumber;
  @override
  final String employmentStatus;
  @override
  final String bank;
  @override
  final String monthlyIncome;
  @override
  final String photoUrl;
  @override
  final String status;
  @override
  final String name;
  @override
  final String countryCode;
  @override
  final String roleId;
  @override
  final String gender;
  @override
  final String displayName;
  @override
  final String language;
  @override
  final DocumentReference<Object> reference;

  factory _$UserRecord([void Function(UserRecordBuilder) updates]) =>
      (new UserRecordBuilder()..update(updates))._build();

  _$UserRecord._(
      {this.email,
      this.uid,
      this.createdTime,
      this.phoneNumber,
      this.employmentStatus,
      this.bank,
      this.monthlyIncome,
      this.photoUrl,
      this.status,
      this.name,
      this.countryCode,
      this.roleId,
      this.gender,
      this.displayName,
      this.language,
      this.reference})
      : super._();

  @override
  UserRecord rebuild(void Function(UserRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserRecordBuilder toBuilder() => new UserRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserRecord &&
        email == other.email &&
        uid == other.uid &&
        createdTime == other.createdTime &&
        phoneNumber == other.phoneNumber &&
        employmentStatus == other.employmentStatus &&
        bank == other.bank &&
        monthlyIncome == other.monthlyIncome &&
        photoUrl == other.photoUrl &&
        status == other.status &&
        name == other.name &&
        countryCode == other.countryCode &&
        roleId == other.roleId &&
        gender == other.gender &&
        displayName == other.displayName &&
        language == other.language &&
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
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    0,
                                                                    email
                                                                        .hashCode),
                                                                uid.hashCode),
                                                            createdTime
                                                                .hashCode),
                                                        phoneNumber.hashCode),
                                                    employmentStatus.hashCode),
                                                bank.hashCode),
                                            monthlyIncome.hashCode),
                                        photoUrl.hashCode),
                                    status.hashCode),
                                name.hashCode),
                            countryCode.hashCode),
                        roleId.hashCode),
                    gender.hashCode),
                displayName.hashCode),
            language.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserRecord')
          ..add('email', email)
          ..add('uid', uid)
          ..add('createdTime', createdTime)
          ..add('phoneNumber', phoneNumber)
          ..add('employmentStatus', employmentStatus)
          ..add('bank', bank)
          ..add('monthlyIncome', monthlyIncome)
          ..add('photoUrl', photoUrl)
          ..add('status', status)
          ..add('name', name)
          ..add('countryCode', countryCode)
          ..add('roleId', roleId)
          ..add('gender', gender)
          ..add('displayName', displayName)
          ..add('language', language)
          ..add('reference', reference))
        .toString();
  }
}

class UserRecordBuilder implements Builder<UserRecord, UserRecordBuilder> {
  _$UserRecord _$v;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _uid;
  String get uid => _$this._uid;
  set uid(String uid) => _$this._uid = uid;

  DateTime _createdTime;
  DateTime get createdTime => _$this._createdTime;
  set createdTime(DateTime createdTime) => _$this._createdTime = createdTime;

  String _phoneNumber;
  String get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String phoneNumber) => _$this._phoneNumber = phoneNumber;

  String _employmentStatus;
  String get employmentStatus => _$this._employmentStatus;
  set employmentStatus(String employmentStatus) =>
      _$this._employmentStatus = employmentStatus;

  String _bank;
  String get bank => _$this._bank;
  set bank(String bank) => _$this._bank = bank;

  String _monthlyIncome;
  String get monthlyIncome => _$this._monthlyIncome;
  set monthlyIncome(String monthlyIncome) =>
      _$this._monthlyIncome = monthlyIncome;

  String _photoUrl;
  String get photoUrl => _$this._photoUrl;
  set photoUrl(String photoUrl) => _$this._photoUrl = photoUrl;

  String _status;
  String get status => _$this._status;
  set status(String status) => _$this._status = status;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _countryCode;
  String get countryCode => _$this._countryCode;
  set countryCode(String countryCode) => _$this._countryCode = countryCode;

  String _roleId;
  String get roleId => _$this._roleId;
  set roleId(String roleId) => _$this._roleId = roleId;

  String _gender;
  String get gender => _$this._gender;
  set gender(String gender) => _$this._gender = gender;

  String _displayName;
  String get displayName => _$this._displayName;
  set displayName(String displayName) => _$this._displayName = displayName;

  String _language;
  String get language => _$this._language;
  set language(String language) => _$this._language = language;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  UserRecordBuilder() {
    UserRecord._initializeBuilder(this);
  }

  UserRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _uid = $v.uid;
      _createdTime = $v.createdTime;
      _phoneNumber = $v.phoneNumber;
      _employmentStatus = $v.employmentStatus;
      _bank = $v.bank;
      _monthlyIncome = $v.monthlyIncome;
      _photoUrl = $v.photoUrl;
      _status = $v.status;
      _name = $v.name;
      _countryCode = $v.countryCode;
      _roleId = $v.roleId;
      _gender = $v.gender;
      _displayName = $v.displayName;
      _language = $v.language;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserRecord;
  }

  @override
  void update(void Function(UserRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  UserRecord build() => _build();

  _$UserRecord _build() {
    final _$result = _$v ??
        new _$UserRecord._(
            email: email,
            uid: uid,
            createdTime: createdTime,
            phoneNumber: phoneNumber,
            employmentStatus: employmentStatus,
            bank: bank,
            monthlyIncome: monthlyIncome,
            photoUrl: photoUrl,
            status: status,
            name: name,
            countryCode: countryCode,
            roleId: roleId,
            gender: gender,
            displayName: displayName,
            language: language,
            reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
