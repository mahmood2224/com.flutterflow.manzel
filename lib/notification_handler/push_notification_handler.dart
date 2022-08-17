import 'dart:convert';


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import 'local_notification_service.dart';


class PushNotificationHandler {

  Future<void> onMessage(Map<String, dynamic>messageData, RemoteNotification notification) async{
    ;

    if(notification != null){
      await LocalNotificationService().showStandardNotification(
          title: notification.title,
          body: notification.body,
          payload: jsonEncode(messageData),
      );
    }
  }

  Future<void> onTerminatedState(RemoteMessage message) async{

    if (message.data.containsKey('redirect_to')) {
      var routeName = message.data['redirect_to'];
      DeepLinkManager.navigate(routeName, message.data);
    }
  }



}

class DeepLinkManager{
  DeepLinkManager._();
  static void navigate(String path,[Map<String,dynamic> arguments,bool isPushNotification=true]){
    if(path.trim().isEmpty){
      return;
    }
    // if(GlobalVariables.authToken.isEmpty){
    //   LoggingService().printLog(
    //       tag: 'Notification Navigation',
    //       message: 'path -> $path Navigation popAllAndPushNamed Complete'
    //   );
    //   locator<NavigationService>().popAllAndPushNamed(EnumRoute.registerScreen);
    //   return;
    // }
    // if(AppPreferenceHelper().shouldShowOnBoarding()){
    //   LoggingService().printLog(
    //       tag: 'Notification Navigation',
    //       message: 'path -> $path Navigation popAllAndPushNamed Complete'
    //   );
    //   locator<NavigationService>().popAllAndPushNamed(EnumRoute.onBoardingScreen);
    //   return;
    // }
    // if(path == EnumRoute.homeScreen){
    //   if(isPushNotification) {
    //     BuildContext? context = locator<NavigationService>().navigatorKey.currentContext;
    //     bool successNavigation=false;
    //     if(context!=null){
    //       String? path = ModalRoute.of(context)?.settings.name;
    //       if(path!=null){
    //         Uri pathUri = Uri.parse(path);
    //         if(pathUri.path!=EnumRoute.homeScreen){
    //           successNavigation=true;
    //           LoggingService().printLog(
    //               tag: 'Notification Navigation',
    //               message: 'path -> $path Navigation popAllAndPushNamed Complete'
    //           );
    //           locator<NavigationService>().popAllAndPushNamed(EnumRoute.homeScreen);
    //         }
    //       }
    //     }
    //     if(successNavigation==false){
    //       LoggingService().printLog(
    //           tag: 'Notification Navigation',
    //           message: 'path -> $path Navigation popAllAndPushNamed Complete'
    //       );
    //       locator<NavigationService>().popAllAndPushNamed(EnumRoute.homeScreen);
    //     }
    //   }
    //   BuildContext? context = locator<NavigationService>().navigatorKey.currentContext;
    //   if(context != null){
    //     LoggingService().printLog(
    //         tag: 'Notification Navigation',
    //         message: 'path -> $path Navigation NavigateToProjectListingEvent '
    //     );
    //     BlocProvider.of<HomeScreenBloc>(context).add(NavigateToProjectListingEvent());
    //   }
    // } else if(path == EnumRoute.orderDetailsScreen) {
    //    if (arguments != null && arguments.containsKey('order_id') && arguments.containsKey('property_id')&&arguments['order_id']!=null&&arguments['property_id']!=null){
    //      locator<NavigationService>().popUntil(EnumRoute.homeScreen);
    //      BuildContext? context = locator<NavigationService>().navigatorKey.currentContext;
    //      if (context != null) {
    //        BlocProvider.of<HomeScreenBloc>(context).add(
    //            NavigateToOrderScreenEvent());
    //        LoggingService().printLog(
    //            tag: 'Notification Navigation',
    //            message: 'path -> $path Navigation NavigateToOrderScreenEvent '
    //        );
    //      }
    //        locator<NavigationService>().pushNamed(EnumRoute.orderDetailsScreen,
    //            data: {
    //              AppConstants.kPropertyId: arguments['property_id'],
    //              AppConstants.kOrderId: arguments['order_id']
    //            });
    //   }
    // }else if(path == EnumRoute.propertyDetailScreen){
    //   if(arguments!=null&&arguments.containsKey('property_id')&&arguments['property_id']!=null) {
    //     locator<NavigationService>().navigateTo(EnumRoute.propertyDetailScreen,
    //         data: {
    //           AppConstants.kPropertyId:arguments['property_id'],
    //           AppConstants.kIndex: -1,
    //           AppConstants.kFavouriteScreenFrom: EnumFavouriteFrom.payment
    //         });
    //   }
    // }else if(path == EnumRoute.projectDetailScreen){
    //   if(arguments!=null&&arguments.containsKey('project_id')&&arguments['project_id']!=null){
    //     locator<NavigationService>().pushNamed(EnumRoute.projectDetailScreen,
    //         data: {
    //           AppConstants.kProjectID: arguments['project_id'],
    //           AppConstants.kProjectType: '',
    //           AppConstants.kProjectTypeEnumKey: ProjectTypeEnum.kBuilding,
    //           AppConstants.kIndex: -1,
    //           AppConstants.kFavouriteScreenFrom: EnumFavouriteFrom.tiktokProject,
    //         },
    //     );
    //     LoggingService().printLog(
    //         tag: 'Notification Navigation',
    //         message: 'path -> $path Navigation Complete'
    //     );
    //   }
    // }
  }
}