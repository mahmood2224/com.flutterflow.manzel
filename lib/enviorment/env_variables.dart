import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvVariables {
  static final EnvVariables _instance = EnvVariables._();

  static EnvVariables get instance => _instance;

  String _strapiBaseUrl = '';
  String _firebaseBaseUrl = '';
  String _sendbirdAppId = '';
  String _basicAuthUserName = '';
  String _basicAuthPassword = '';
  String _dynamicLinkUrl = '';


  EnvVariables._();

  Future<void> initialise() async {
    await dotenv.load();
    //Variables from .env files
     _strapiBaseUrl = dotenv.get('STRAPI_BASE_URL', fallback: '');
     _firebaseBaseUrl = dotenv.get('FIREBASE_BASE_URL', fallback: '');
    _sendbirdAppId = dotenv.get('SENDBIRD_APP_ID', fallback: '');
    _basicAuthUserName = dotenv.get('BASIC_AUTH_USER_NAME', fallback: '');
    _basicAuthPassword = dotenv.get('BASIC_AUTH_PASSWORD', fallback: '');
    _dynamicLinkUrl = dotenv.get('DYNAMIC_LINK_URL', fallback: '');
  }



  String get strapiBaseURl => _strapiBaseUrl;

  String get firebaseBaseUrl => _firebaseBaseUrl;

  String get sendbirdAppId => _sendbirdAppId;

  String get basicAuthUserName => _basicAuthUserName;

  String get basicAuthPassword => _basicAuthPassword;

  String get dynamicLinkUrl => _dynamicLinkUrl;


}