import 'package:manzel/shared/data/types.dart';

class AuthSendModel{
  String? phoneNumber ;
  String? verificationKey ;
  String? otp ;

  AuthSendModel({this.phoneNumber});

  StringMap toJsonGenerateOtp(){
    return {
      "phoneNumber" : this.phoneNumber??""
    };
  }
  getDecoratedPhoneNumber(){
    return "${phoneNumber?.substring(0,4)??""}*****${phoneNumber?.substring((phoneNumber?.length??0) -2)}";
  }
  StringMap toJsonVerifyCode(){
    return {
      "phoneNumber" : phoneNumber??"",
      "key" : verificationKey??"",
      "otp": otp??""
    };
  }
}