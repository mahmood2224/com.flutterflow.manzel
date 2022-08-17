import 'dart:convert';

import 'package:base_project/utils/services/logging/logging_service.dart';
import 'package:base_project/utils/services/push_notification/push_notification_handler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
class LocalNotificationService{
  Future<void> initialize() async{
    final initializationSettingsAndroid =
    AndroidInitializationSettings('@drawable/app_icon');

    final initializationSettingsIOS = IOSInitializationSettings();

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await enableIOSNotifications();
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);
  }

  Future<void> enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  void onSelectNotification(String? payload){
    if(payload != null && payload.trim().isNotEmpty){
      try {
        Map<String, dynamic>? json = (jsonDecode(payload) as Map<String,
            dynamic>?);
        if(json!=null) {
          DeepLinkManager.navigate(json['redirect_to'], json);
        }
      }catch(error){
        LoggingService().printLog(
            message: 'PushNotificationHandler.onSelectNotification message==> $error');
      }
    }
    return;
  }

  Future<void> showStandardNotification(
      {required String? title,
        required String? body,
        int id = 0,
        String? payload,
        String? notificationChannelId,
        String? notificationChannelName,
        String? notificationChannelDes
      }) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
          notificationChannelId ?? 'SAKChannel',
          notificationChannelName ?? 'SAK Channel',
          channelDescription: notificationChannelDes ?? 'Channel to receive SAK notifications.',
          importance: Importance.max,
          priority: Priority.high,
        playSound: true,
        enableVibration: true,
      ),
      iOS: IOSNotificationDetails(
        presentBadge: true,
        presentSound: true,
      ),
    );
    return _showNotification(
        _flutterLocalNotificationsPlugin,
        title: title,
        body: body,
        id: id,
        payload: payload,
        type: notificationDetails
    );
  }

  // FUNCTIONS FOR NOTIFICATIONS
  Future _showNotification(
      FlutterLocalNotificationsPlugin notifications, {
        required String? title,
        required String? body,
        required NotificationDetails type,
        String? payload,
        int id = 0,
      }) {
    return notifications.show(id, title, body, type, payload: payload);
  }

  Future<void> cancelNotificationWithID(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

}