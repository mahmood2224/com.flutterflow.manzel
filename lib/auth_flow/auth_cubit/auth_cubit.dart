import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:manzel/auth_flow/data/models/send_models/auth_send_model.dart';
import 'package:manzel/shared/data/api_call_options.dart';
import 'package:manzel/shared/data/base_cubit/base_cubit.dart';
import 'package:manzel/shared/data/enums/methods__enum.dart';
import 'package:manzel/shared/data/types.dart';
import 'package:manzel/shared/services/dio/end_points.dart';

import 'auth_state.dart';

class AuthCubit extends BaseCubit<AuthState> {
  AuthCubit() :super(AuthStateInit());

  ///Function for init the cubit if wanted in this there is no need to init any thing
  @override
  init(){}

  ///login function request an OTP from the backend,
  ///the Backend handle the adding user or authinticaing him after verify code
  login(AuthSendModel data){
      emit(AuthStateLoading(login: true));
      _generateOtp(data.toJsonGenerateOtp());
  }

  _generateOtp( body){
    makeApiRequest(ApiCallOptions(
        networkMethodType: NetworkMethodType.post,
        endPoint: EndPoints.generateOtp.value,
        body:body,
        onSuccess: (DynamicMap jsonResult){
          print("Success ***********");
          emit(AuthStateInit());
        },
        onError: (error){
          print("error *************");
          emit(AuthStateInit());

        }));
  }
}
