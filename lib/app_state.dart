import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/lat_lng.dart';
import 'dart:convert';

Map<String,bool> favorite = {};
class FavoriteList {
  static FavoriteList _instance = FavoriteList._();
  static FavoriteList get instance => _instance;
  Map<String,bool> _favorite = {};
  FavoriteList._();
  Future<void> initialise() async {
    _favorite ;
  }
  Map<String,bool> get favorite => _favorite;
}

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
    _isInitailLaunch =  prefs.getBool('ff_isInitailLaunch') ?? _isInitailLaunch;
    _locale = await prefs.getString('ff_locale') ?? _locale;
    _authToken = prefs.getString('ff_authToken') ?? _authToken;
    _apiVersion = prefs.getString('ff__apiVersion') ?? _apiVersion;
  }

  late SharedPreferences prefs;

  dynamic property;

  LatLng? coordinates;

  dynamic filter = jsonDecode(
      '{\"city\":null,\" furnishing_type\":null,\"property_type\":null,\"minimum_price\":null,\"mximum_price\":null}');

  String filterCity = '';

  bool _isInitailLaunch = true;
  bool get isInitailLaunch => _isInitailLaunch;
  set isInitailLaunch(bool _value) {
    _isInitailLaunch = _value;
    prefs.setBool('ff_isInitailLaunch', _value);
  }

  List<String> filterPropertyType = [];

  List<String> filterFurnishingType = [];

  int buildNo = 0;

  String buildVersion = '';

  int filterMinPrice = 0;

  int filterMaxPrice = 0;

  String propertyStatus = '';

  String _locale = 'ar';
  String get locale => _locale;
  set locale(String _value) {
    _locale = _value;
    prefs.setString('ff_locale', _value);
  }

  String refreshToken = '';

  String _authToken = '';
  String get authToken => _authToken;
  set authToken(String _value) {
    _authToken = _value;
    prefs.setString('ff_authToken', _value);
  }

  String _apiVersion = '';
  String get apiVersion => _apiVersion;
  set apiVersion(String _value) {
    _apiVersion = _value;
    prefs.setString('ff__apiVersion', _value);
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
