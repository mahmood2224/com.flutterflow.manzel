import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manzel/auth_flow/data/models/GenerateOtpResponse.dart';
import 'package:manzel/auth_flow/data/models/VerifyOtpResponse.dart';
import 'package:manzel/auth_flow/data/models/send_models/auth_send_model.dart';
import 'package:manzel/flutter_flow/flutter_flow_util.dart';
import 'package:manzel/shared/data/api_call_options.dart';
import 'package:manzel/shared/data/base_cubit/base_cubit.dart';
import 'package:manzel/shared/data/enums/methods__enum.dart';
import 'package:manzel/shared/data/types.dart';
import 'package:manzel/shared/services/auth_services.dart';
import 'package:manzel/shared/services/dio/end_points.dart';
import 'package:manzel/shared/utils/Messages.dart';

import 'auth_state.dart';

class AuthCubit extends BaseCubit<AuthState> {
  AuthCubit() :super(AuthStateInit());
  AuthSendModel dataModel = AuthSendModel();
  int _otpSendTimes = 4 ;

  ///Function for init the cubit if wanted in this there is no need to init any thing
  @override
  init(){}

  ///login function request an OTP from the backend,
  ///the Backend handle the adding user or authinticaing him after verify code
  login(){
      emit(AuthStateLoading(login: true));
      generateOtp();
  }

  verifyOtp(){
    emit(AuthStateLoading(otpVerify: true));
    makeApiRequest(ApiCallOptions(
        networkMethodType: NetworkMethodType.post,
        endPoint: EndPoints.verifyOtp.value,
        body: dataModel.toJsonVerifyCode(),
        onSuccess: (jsonResult){
          final verifyResponse = VerifyOtpResponse.fromJson(jsonResult);
          AuthService().notifySignIn(token: verifyResponse.tokenKey ,onSuccess: (){
            emit(AuthStateSuccess());
            showAlertMessage(context, message: verifyResponse.message??"" ,backgroundColor: Colors.green);

          });
        },
        onError: (error){
          emit(AuthStateInit());
          showAlertMessage(context, message: error.errorMessage , backgroundColor: Colors.red);
        })
    );
  }

  generateOtp( ){
    _otpSendTimes-- ;
    if(_otpSendTimes <=0) {
      showAlertMessage(context, message: "You Resend Code too much times",
          backgroundColor: Colors.red);
      return;
    }
    makeApiRequest(ApiCallOptions(
        networkMethodType: NetworkMethodType.post,
        endPoint: EndPoints.generateOtp.value,
        body:dataModel.toJsonGenerateOtp(),
        onSuccess: (DynamicMap jsonResult){
         final otpResponse = GenerateOtpResponse.fromJson(jsonResult);
         dataModel.verificationKey = otpResponse.key ;
         showAlertMessage(context, message: otpResponse.success??"" , backgroundColor: Colors.green);
         context.goNamed("otp");
          emit(AuthStateSuccess());
        },
        onError: (error){
          emit(AuthStateInit());
          showAlertMessage(context, message: error.errorMessage , backgroundColor: Colors.red);
        }));
  }


}
