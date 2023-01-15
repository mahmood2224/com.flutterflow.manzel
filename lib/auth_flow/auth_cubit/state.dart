import 'package:manzel/auth_flow/auth_cubit/cubit.dart';
import 'package:manzel/shared/data/base_cubit/base_state.dart';

abstract class AuthState extends BaseState {}

class AuthStateInit extends AuthState{}

class AuthStateLoading extends AuthState{}

class AuthStateSuccess extends AuthState{}

class AuthStateError extends AuthState{}