import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:manzel/enviorment/env_variables.dart';
import 'package:manzel/shared/services/auth_services.dart';
import 'package:manzel/shared/services/dio/helpers_methods.dart';

class MainInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async  {
    final _authService = AuthService();
    if(!_authService.isLogin) {
      ///adding base authintcation
      String basicAuth = 'Basic ' +
          base64.encode(utf8.encode(
              '${EnvVariables.instance.basicAuthUserName}:${EnvVariables
                  .instance.basicAuthPassword}'));
      options.headers['authorization'] = basicAuth;
    }
    else {
      ///adding Bearer token
      final token = _authService.token;
      options.headers['Authorization'] = "Bearer $token";
    }
    debugPrintPreRequest(
        url: options.uri, data: options.data, headers: options.headers);
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    return super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path} => DATA : ${response.data}');
    return super.onResponse(response, handler);
  }
}
