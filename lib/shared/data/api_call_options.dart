import 'package:manzel/shared/data/enums/methods__enum.dart';
import 'package:manzel/shared/data/errors/base_error.dart';
import 'package:manzel/shared/data/types.dart';

class ApiCallOptions{
  DynamicMap? body;
  StringMap? headers ;
  String endPoint;
  StringMap? query ;
  List<String>? params ;
  Function(DynamicMap result) onSuccess ;
  Function(MainResponseError error) onError;
  NetworkMethodType networkMethodType ;
  ApiCallOptions({ required this.networkMethodType  ,required this.endPoint , required this.onSuccess , required this.onError , this.body , this.headers , this.query, this.params});

}

