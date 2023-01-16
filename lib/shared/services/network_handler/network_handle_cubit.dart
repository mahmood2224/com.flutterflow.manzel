import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manzel/main.dart';
import 'package:manzel/shared/data/base_cubit/base_cubit.dart';
import 'package:manzel/shared/services/network_handler/state.dart';
import 'package:manzel/shared/utils/Messages.dart';

//TODO handle translation
class NetworkHandlerCubit extends Cubit<NetworkHandlerState> {
  NetworkHandlerCubit() : super(NetworkConnected());
   NetworkHandlerState _currentState = NetworkConnected();
  late BuildContext context ;
  init() async {
    context = router!.navigator!.context;
    final result  = await Connectivity().checkConnectivity();
      _currentState =result != ConnectivityResult.none ? NetworkConnected() : NetworkDisconnected();
    _startListener();
  }

  _startListener(){
    Connectivity().onConnectivityChanged.listen((event) {
      _currentState = event != ConnectivityResult.none ? NetworkConnected() : NetworkDisconnected();
      if(_currentState is NetworkDisconnected){
        showAlertMessage(context, message: "Network lost Please reconnect" , backgroundColor: Colors.red);
      }else{
        showAlertMessage(context, message: "Network restored" , backgroundColor: Colors.green);
      }
      emit(_currentState);
    });
  }

  NetworkHandlerState getState(){
    return _currentState ;
  }
}
