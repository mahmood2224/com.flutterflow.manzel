import 'package:base_project/app/repository/global_variables.dart';
import 'package:base_project/utils/services/logging/logging_service.dart';
import 'package:base_project/utils/services/push_notification/push_notification_handler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _onBackgroundHandler(RemoteMessage message)async{
  if (message.data.containsKey('redirect_to')) {
    var routeName = message.data['redirect_to'];
    DeepLinkManager.navigate(routeName,message.data);
  }
  LoggingService().printLog(message: 'FirebaseCloudMessaging._onBackgroundHandler is called.');
  LoggingService().printLog(
      tag: 'title and message body',
      message: '${message.notification!.title}  ${message.data.toString()}'
  );
}
class FirebaseCloudMessaging{

   void init(){
    _configure();
  }

  void _configure(){
    /// called when when app is opened from terminated state
    FirebaseMessaging.instance.getInitialMessage().then(_terminateStateHandler);

    /// called when app in foreground (Android only)
    FirebaseMessaging.onMessage.listen(_onMessage);

    /// app in background and running and user tapped on it
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    ///Get called when the app is in background.
    FirebaseMessaging.onBackgroundMessage(_onBackgroundHandler);

  }


   Future<void> _onMessageOpenedApp(RemoteMessage message) async {
     navigate(message);
     LoggingService().printLog(
         message:
         'FirebaseCloudMessaging._onMessageOpenedApp is called and title:- ${message.notification!.title}');
   }

     Future<void> _onMessage(RemoteMessage message) async {
     var messageData = message.data;
     if (messageData.isEmpty) {
       LoggingService().printLog(
           message: 'FirebaseCloudMessaging._onMessage messageData is null or isEmpty');
     }
     LoggingService().printLog(message: messageData.toString(),tag: '_onMessage');
     await PushNotificationHandler()
         .onMessage(messageData, message.notification);
   }



   Future<void> _terminateStateHandler(RemoteMessage? message) async {
     navigate(message);
     if (message == null || message.data.isEmpty) {
       LoggingService().printLog(
           message: 'FirebaseCloudMessaging._onTerminateState, messageData is null or isEmpty');
       return;
     }
     LoggingService().printLog(message: message.data.toString(),tag: '_onMessage');

     await PushNotificationHandler().onTerminatedState(message);
   }

   void navigate(RemoteMessage? message){
     if (message != null && message.data.containsKey('redirect_to')) {
       var routeName = message.data['redirect_to'];
       DeepLinkManager.navigate(routeName, message.data);
     }
   }

}

class FirebaseMessagingUtils{
  FirebaseMessagingUtils._();

  static Future<void> getPushNotificationToken() async{
    var deviceToken = await FirebaseMessaging.instance.getToken();
    if(deviceToken != null && deviceToken.trim().isNotEmpty){
      GlobalVariables.deviceNotificationToken = deviceToken;
      print(deviceToken);
    }
  }
}