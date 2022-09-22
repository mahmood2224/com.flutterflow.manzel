import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvVariables {
  static final EnvVariables _instance = EnvVariables._();

  static EnvVariables get instance => _instance;

  String _strapiBaseUrl = '';
  String _firebaseBaseUrl = '';
  String _sendbirdAppId = '';
  // String _healthSdkProfileId = '';
  // String _healthSdkPartnerId = '';
  // String _healthSdkTestId = '';
  // String _baseUrl = '';
  // String _antiTheftSDKBaseUrl = '';
  // String _applicationID = '';
  // String _antiTheftApiKey = '';
  // String _userConsentBaseUrl = '';

  EnvVariables._();

  Future<void> initialise() async {
    await dotenv.load();
    //Variables from .env files
     _strapiBaseUrl = dotenv.get('STRAPI_BASE_URL', fallback: '');
     _firebaseBaseUrl = dotenv.get('FIREBASE_BASE_URL', fallback: '');
    _sendbirdAppId = dotenv.get('SENDBIRD_FIREBASE_KEY', fallback: '');
    // _healthSdkProfileId = dotenv.get('PROFILE_ID', fallback: '');
    // _healthSdkPartnerId = dotenv.get('PARTNER_ID', fallback: '');
    // _healthSdkTestId = dotenv.get('TEST_ID', fallback: '');
    // _baseUrl = dotenv.get('BASE_URL', fallback: '');
    // _antiTheftSDKBaseUrl = dotenv.get('ANTI_THEFT_SDK_BASE_URL', fallback: '');
    // _applicationID = dotenv.get('APPLICATION_ID', fallback: '');
    // _antiTheftApiKey = dotenv.get('ANTI_THEFT_API_KEY', fallback: '');
    // _userConsentBaseUrl = dotenv.get('USER_CONSENT_BASE_URL', fallback: '');
  }

  // String get userConsentBaseUrl => _userConsentBaseUrl;
  //
  // String get antiTheftApiKey => _antiTheftApiKey;

  String get strapiBaseURl => _strapiBaseUrl;

  String get firebaseBaseUrl => _firebaseBaseUrl;

  String get sendbirdAppId => _sendbirdAppId;
  //
  // String get healthSdkProfileId => _healthSdkProfileId;
  //
  // String get healthSdkPartnerId => _healthSdkPartnerId;
  //
  // String get healthSdkTestId => _healthSdkTestId;
  //
  // String get baseUrl => _baseUrl;
  //
  // String get antiTheftSDKBaseUrl => _antiTheftSDKBaseUrl;
  //
  // String get applicationID => _applicationID;
}