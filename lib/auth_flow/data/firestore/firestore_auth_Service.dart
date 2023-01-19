import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manzel/auth_flow/data/models/UserModel.dart';

class FireStoreAuthService{
  FireStoreAuthService._();
  static final FireStoreAuthService _instance = FireStoreAuthService._();
  factory FireStoreAuthService() => _instance ;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance ;


  checkIsFirstTimeUser(String phoneNumber) async {
    final users = _fireStore.collection(AuthFireStoresKeys.users.value);
    final allUsers = await users.get();
    final QuerySnapshot result = await users.where({AuthFireStoresKeys.phoneNumber.value , phoneNumber }).get();
    if(result.size <= 0)
      return false ;

    final user = result.docs.first ;
    if(result.size > 1)
      print("there is more than one have this phone number we picked the first ${user[AuthFireStoresKeys.name.value]}");

    if((user[AuthFireStoresKeys.name.value] as String?)?.isEmpty??true)
      return false ;

    return true ;

  }

  getUserData(String phoneNumber) async {
    final users = _fireStore.collection(AuthFireStoresKeys.users.value);
    final QuerySnapshot result = await users.where({AuthFireStoresKeys.phoneNumber.value , phoneNumber }).get();
    if(result.size <= 0)
      return false ;

    final user = result.docs.first ;

    return UserModel.fromJson(user);
  }
}

enum AuthFireStoresKeys{
  phoneNumber("phone_number"),
  name("name"),
  createdAt("created_time"),
  email("email"),
  uuid("uid"),
  employmentStatus("employment_status"),
  bank("bank"),
  monthlyIncome("monthly_income"),
  photoUrl("photo_url"),
  status("status"),
  countryCode("country_code"),
  roleId("role_id"),
  gender("gender"),
  displayName("display_name"),
  language("language"),
  isDeleted("is_deleted"),
  sakaniLoanCoverage("sakani_loan_coverage"),
  lastLogin("last_login"),
  firebaseToken("firebase_device_token"),
  updatedAt("updated_at"),

  users("User");

  final String value ;
  const AuthFireStoresKeys(this.value);
}