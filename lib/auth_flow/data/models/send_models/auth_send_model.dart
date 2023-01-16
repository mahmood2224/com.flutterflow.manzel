import 'package:manzel/shared/data/types.dart';

class AuthSendModel{
  String? phoneNumber ;

  AuthSendModel({this.phoneNumber});

  StringMap toJsonGenerateOtp(){
    return {
      "phoneNumber" : this.phoneNumber??""
    };
  }
}