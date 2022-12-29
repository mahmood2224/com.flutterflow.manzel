import 'package:firebase_messaging/firebase_messaging.dart';
class FirebaseMessagingUtils{
  FirebaseMessagingUtils._();

  static Future<String> getPushNotificationToken() async{
    String? deviceToken = await FirebaseMessaging.instance.getToken();
    if(deviceToken != null && deviceToken.trim().isNotEmpty){
     return deviceToken;
    }
    return deviceToken!;
  }
}