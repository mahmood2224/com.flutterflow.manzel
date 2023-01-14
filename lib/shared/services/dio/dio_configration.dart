import 'package:dio/dio.dart';
import 'package:manzel/enviorment/env_variables.dart';
import 'package:manzel/shared/services/dio/dio_interceptors/main_interceptor.dart';

Dio initDioObject() {
  final dio = Dio(BaseOptions(
    baseUrl: EnvVariables.instance.firebaseBaseUrl,
    connectTimeout: 30000,
    receiveTimeout: 50000,
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json, text/plain, */*",
      "X-Requested-With": "XMLHttpRequest"
    },
    validateStatus: (_) => true,
    responseType: ResponseType.json,
  ));

  dio.interceptors.add(MainInterceptor());

  return dio;
}
