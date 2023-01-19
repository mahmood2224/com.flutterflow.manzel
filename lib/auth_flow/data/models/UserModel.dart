import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manzel/auth_flow/data/firestore/firestore_auth_Service.dart';

class UserModel{
  String?  email;
  String?  uid;
  DateTime?  createdAt;
  String?  phoneNumber;
  String?  employmentStatus;
  String?  bank;
  String?  monthlyIncome;
  String?  photoUrl;
  String?  status;
  String?  name;
  String?  countryCode;
  String?  roleId;
  String?  gender;
  String?  displayName;
  String?  language;
  int?  isDeleted;
  bool?  sakaniLoanCoverage;
  DateTime?  lastLogin;
  String?  firebaseToken ;
  DateTime?  updatedAt ;
  DocumentReference?  ffRef;


  UserModel({this.email, this.uid, this.createdAt, this.phoneNumber,
    this.employmentStatus, this.bank, this.monthlyIncome, this.photoUrl,
    this.status, this.name, this.countryCode, this.roleId, this.gender,
    this.displayName, this.language, this.isDeleted, this.sakaniLoanCoverage,
    this.lastLogin, this.firebaseToken, this.updatedAt, this.ffRef});

  factory UserModel.fromJson(json , {key}){
    return UserModel(
      email:  json[AuthFireStoresKeys.email.value],
      uid:  json[AuthFireStoresKeys.uuid.value],
      createdAt:  json[AuthFireStoresKeys.createdAt.value],
      phoneNumber:  json[AuthFireStoresKeys.phoneNumber.value],
      employmentStatus:  json[AuthFireStoresKeys.employmentStatus.value],
      bank:  json[AuthFireStoresKeys.bank.value],
      monthlyIncome:  json[AuthFireStoresKeys.monthlyIncome.value],
      photoUrl:  json[AuthFireStoresKeys.photoUrl.value],
      status:  json[AuthFireStoresKeys.status.value],
      name:  json[AuthFireStoresKeys.name.value],
      countryCode:  json[AuthFireStoresKeys.countryCode.value],
      roleId:  json[AuthFireStoresKeys.roleId.value],
      gender:  json[AuthFireStoresKeys.gender.value],
      displayName:  json[AuthFireStoresKeys.displayName.value],
      language:  json[AuthFireStoresKeys.language.value],
      isDeleted:  json[AuthFireStoresKeys.isDeleted.value],
      sakaniLoanCoverage:  json[AuthFireStoresKeys.sakaniLoanCoverage.value],
      lastLogin:  json[AuthFireStoresKeys.lastLogin.value],
      firebaseToken:  json[AuthFireStoresKeys.firebaseToken.value],
      updatedAt:  json[AuthFireStoresKeys.updatedAt.value],
      ffRef: key
    );
  }
}
