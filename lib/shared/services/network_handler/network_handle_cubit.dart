import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

import 'state.dart';

class NetworkHandlerCubit extends Cubit<NetworkHandlerState> {
  NetworkHandlerCubit() : super(NetworkConnected());
  late NetworkHandlerState _currentState ;

  init() async {
    final result  = await Connectivity().checkConnectivity();
      _currentState =result != ConnectivityResult.none ? NetworkConnected() : NetworkDisconnected();
    _startListener();
  }

  _startListener(){
    Connectivity().onConnectivityChanged.listen((event) {
      _currentState = event != ConnectivityResult.none ? NetworkConnected() : NetworkDisconnected();
      //TODO here we should show Toast for that
      emit(_currentState);
    });
  }

  NetworkHandlerState checkResult(){
    return _currentState ;
  }
}
