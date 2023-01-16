import 'package:manzel/shared/data/base_cubit/base_state.dart';

abstract class NetworkHandlerState extends BaseState {}

class NetworkConnected extends NetworkHandlerState {}

class NetworkDisconnected extends NetworkHandlerState{}
