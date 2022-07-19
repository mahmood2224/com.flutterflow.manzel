import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/lat_lng.dart';
import 'dart:convert';

class FFAppState {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _isInitailLaunch = prefs.getBool('ff_isInitailLaunch') ?? _isInitailLaunch;
  }

  SharedPreferences prefs;

  dynamic property;

  LatLng coordinates;

  dynamic filter = jsonDecode(
      '{\"city\":null,\" furnishing_type\":null,\"property_type\":null,\"minimum_price\":null,\"mximum_price\":null}');

  String filterCity = '';

  bool _isInitailLaunch = false;
  bool get isInitailLaunch => _isInitailLaunch;
  set isInitailLaunch(bool _value) {
    _isInitailLaunch = _value;
    prefs.setBool('ff_isInitailLaunch', _value);
  }

  String locale = '';

  List<String> filterPropertyType = [];

  List<String> filterFurnishingType = [];

  int filterMinPrice = 0;

  int filterMaxPrice = 0;
}

LatLng _latLngFromString(String val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
