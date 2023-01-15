import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:manzel/shared/data/api_call_options.dart';
import 'package:manzel/shared/data/base_cubit/base_cubit.dart';
import 'package:manzel/shared/data/enums/methods__enum.dart';
import 'package:manzel/shared/data/types.dart';

import 'state.dart';

class AuthCubitCubit extends BaseCubit<AuthState> {
  AuthCubitCubit() :super(AuthStateInit());

  ///Function for init the cubit if wanted in this there is no need to init any thing
  @override
  init(){}

  ///login function request an OTP from the backend,
  ///the Backend handle the adding user or authinticaing him after verify code
  login(){
    makeApiRequest(ApiCallOptions(
        networkMethodType: NetworkMethodType.post,
        endPoint: "endPoint",
        onSuccess: (DynamicMap jsonResult){

        },
        onError: (error){

        }));
  }
}
