import 'package:dio/dio.dart';

class MainInterceptor extends Interceptor{

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //TODO we should add the token to request header here
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO we should handle request base errors here like un-authinticated code and so on
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    /// if we need to do any thing to the response after getting it
  }
}