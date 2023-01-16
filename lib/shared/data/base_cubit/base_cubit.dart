import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manzel/main.dart';
import 'package:manzel/shared/data/api_call_options.dart';
import 'package:manzel/shared/data/base_cubit/base_state.dart';
import 'package:manzel/shared/data/enums/methods__enum.dart';
import 'package:manzel/shared/data/errors/base_error.dart';
import 'package:manzel/shared/di_main_module.dart';
import 'package:manzel/shared/services/network_handler/network_handle_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzel/shared/services/network_handler/state.dart';
import 'package:manzel/shared/utils/Messages.dart';
import 'package:dio/dio.dart';

//TODO apply translation
//TODO handle diff status code responses
abstract class BaseCubit<T extends BaseState> extends Cubit<T>{
  late BuildContext context ;
  late NetworkHandlerCubit networkHandler ;
  late NetworkHandlerState _networkState ;
  Dio dio = getIt.get<Dio>() ;
  BaseCubit(super.initialState){
   context = router!.navigator!.context ;
   networkHandler = BlocProvider.of<NetworkHandlerCubit>(context);
  }

  init();


  makeApiRequest(ApiCallOptions options){
    _networkState = networkHandler.getState();
    if(_networkState is NetworkDisconnected){
      showAlertMessage(context, message: "There is no internet connection" , backgroundColor: Colors.red);
      options.onError(MainResponseError("There is no internet connection"));
      return;
    }
    switch(options.networkMethodType){
      case NetworkMethodType.post:
        this._post(options);
        break ;

      default:
        this._get(options);
        break ;
    }

  }

  _get(ApiCallOptions options) async {
    try{
     final result = await dio.get(options.endPoint , queryParameters: options.query ,options: Options(
          headers: options.headers
      ));
     options.onSuccess(result.data);
    }on DioError catch(error){
      String message = error.response?.data != null ? error.response?.data['error'] : error.message ;
      options.onError(MainResponseError(message , error: error.response?.data));
    }catch(error){
      options.onError(MainResponseError("there is server error please try again later"));
    }
  }

  _post(ApiCallOptions options) async {
    try{
      final result = await dio.post(options.endPoint , queryParameters: options.query ,data: options.body,options: Options(
          headers: options.headers
      ));
      options.onSuccess(result.data);
    }on DioError catch(error){
      String message = error.response?.data != null ? error.response?.data['error'] : error.message ;
      options.onError(MainResponseError(message , error: error.response?.data));
    }catch(error){
      options.onError(MainResponseError("there is server error please try again later"));
    }
  }


}