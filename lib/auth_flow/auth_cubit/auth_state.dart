import 'package:manzel/auth_flow/auth_cubit/auth_cubit.dart';
import 'package:manzel/shared/data/base_cubit/base_state.dart';

abstract class AuthState extends BaseState {}

class AuthStateInit extends AuthState{}

class AuthStateLoading extends AuthState{
  bool login = false ;
  bool otpVerify = false ;

  AuthStateLoading({this.login =false , this.otpVerify = false });
}

class AuthStateSuccess extends AuthState{}

class AuthStateError extends AuthState{}