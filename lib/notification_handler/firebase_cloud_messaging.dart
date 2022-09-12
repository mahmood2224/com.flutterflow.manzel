import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:manzel/notification_handler/push_notification_handler.dart';

// Future<void> _onBackgroundHandler(RemoteMessage message)async{
//   if (message.data.containsKey('redirect_to')) {
//     var routeName = message.data['redirect_to'];
//     DeepLinkManager.navigate(routeName,message.data);
//   }
//
// }
// class FirebaseCloudMessaging{
//
//    void init(){
//     _configure();
//   }
//
//   void _configure(){
//     /// called when when app is opened from terminated state
//     FirebaseMessaging.instance.getInitialMessage().then(_terminateStateHandler);
//
//     /// called when app in foreground (Android only)
//     FirebaseMessaging.onMessage.listen(_onMessage);
//
//     /// app in background and running and user tapped on it
//     FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
//
//     ///Get called when the app is in background.
//     FirebaseMessaging.onBackgroundMessage(_onBackgroundHandler);
//
//   }
//
//
//    Future<void> _onMessageOpenedApp(RemoteMessage message) async {
//      navigate(message);
//    }
//
//      Future<void> _onMessage(RemoteMessage message) async {
//      var messageData = message.data;
//      await PushNotificationHandler()
//          .onMessage(messageData, message.notification);
//    }
//
//
//
//    Future<void> _terminateStateHandler(RemoteMessage message) async {
//      navigate(message);
//      if (message == null || message.data.isEmpty) {
//        return;
//      }
//
//      await PushNotificationHandler().onTerminatedState(message);
//    }
//
//    void navigate(RemoteMessage message){
//      if (message != null && message.data.containsKey('redirect_to')) {
//        var routeName = message.data['redirect_to'];
//        DeepLinkManager.navigate(routeName, message.data);
//      }
//    }
//
// }

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