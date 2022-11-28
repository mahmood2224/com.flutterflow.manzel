import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvVariables {
  static final EnvVariables _instance = EnvVariables._();

  static EnvVariables get instance => _instance;

  String _strapiBaseUrl = '';
  String _firebaseBaseUrl = '';
  String _sendbirdAppId = '';
  String _jetAdminUserName = '';
  String _jetAdminPassword = '';


  EnvVariables._();

  Future<void> initialise() async {
    await dotenv.load();
    //Variables from .env files
     _strapiBaseUrl = dotenv.get('STRAPI_BASE_URL', fallback: '');
     _firebaseBaseUrl = dotenv.get('FIREBASE_BASE_URL', fallback: '');
    _sendbirdAppId = dotenv.get('SENDBIRD_APP_ID', fallback: '');
    _jetAdminUserName = dotenv.get('JET_ADMIN_USER_NAME', fallback: '');
    _jetAdminPassword = dotenv.get('JET_ADMIN_PASSWORD', fallback: '');

  }



  String get strapiBaseURl => _strapiBaseUrl;

  String get firebaseBaseUrl => _firebaseBaseUrl;

  String get sendbirdAppId => _sendbirdAppId;

  String get jetAdminUserName => _jetAdminUserName;

  String get jetAdminPassword => _jetAdminPassword;


}