import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:manzel/shared/di_main_module.config.dart';
import 'package:manzel/shared/services/network_handler/network_handle_cubit.dart';

import 'services/dio/dio_configration.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();


@module
abstract class MainModule {
  @singleton
  Dio get dio => initDioObject();

  @singleton
  NetworkHandlerCubit get handler => NetworkHandlerCubit()..init();


}