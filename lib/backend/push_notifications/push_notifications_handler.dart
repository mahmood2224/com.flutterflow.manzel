import 'dart:async';
import 'dart:convert';

import 'serialization_util.dart';
import '../backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../index.dart';
import '../../main.dart';

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    setState(() => _loading = true);
    try {
      final initialPageName = message.data['initialPageName'] as String;
      //final initialParameterData = getInitialParameterData(message.data);
      final initialParameterData = message.data;
      final pageBuilder = pageBuilderMap[initialPageName];
      if (pageBuilder != null) {
        final page = await pageBuilder(initialParameterData);
        if(Navigator.canPop(context)){
          Navigator.pop(context);
        }
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page)
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    handleOpenedPushNotification();
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Container(
          color: FlutterFlowTheme.of(context).primaryBackground,
          child: Builder(
            builder: (context) => Image.asset(
              'assets/images/Group_4_(2).png',
              fit: BoxFit.scaleDown,
            ),
          ),
        )
      : widget.child;
}

final pageBuilderMap = <String, Future<Widget> Function(Map<String, dynamic>)>{
  'Login': (data) async => LoginWidget(),
  'OnboardingView': (data) async => OnboardingViewWidget(),
  'ConfirmOTP': (data) async => ConfirmOTPWidget(),
  'Profile': (data) async => NavBarPage(initialPage: 'Profile'),
  'AddingInformation': (data) async => AddingInformationWidget(),
  'TermsConditions': (data) async => TermsConditionsWidget(),
  'EditPersonallInfo': (data) async => EditPersonallInfoWidget(
        screenName: getParameter(data, 'screenName'),
      ),
  'EditMobileNumber': (data) async => EditMobileNumberWidget(),
  'ConfirmNewNumberOTP': (data) async => ConfirmNewNumberOTPWidget(),
  'HelpAndSupport': (data) async => HelpAndSupportWidget(),
  'Notifications': (data) async => NotificationsWidget(),
  'Offers': (data) async => hasMatchingParameters(data, {'propertyId'})
      ? OffersWidget(
          propertyId: getParameter(data, 'propertyId'),
        )
      : NavBarPage(initialPage: 'Offers'),
  'Filter': (data) async => FilterWidget(),
  'PastOffers': (data) async => PastOffersWidget(),
  'filterResults': (data) async => FilterResultsWidget(
        cityName: getParameter(data, 'cityName'),
        furnishingType: getParameter(data, 'furnishingType'),
        propertyType: getParameter(data, 'propertyType'),
        minInstallment: getParameter(data, 'minInstallment'),
        maxInstallment: getParameter(data, 'maxInstallment'),
      ),
  'MyProperties': (data) async => NavBarPage(initialPage: 'MyProperties'),
  'PropertyDetails': (data) async => PropertyDetailsWidget(
        propertyId: getParameter(data, 'propertyId'),
      ),
  'propertyVideo': (data) async => PropertyVideoWidget(
        videoURL: getParameter(data, 'videoURL'),
        propertyName: getParameter(data, 'propertyName'),
      ),
  'FloorPlan': (data) async => FloorPlanWidget(
        propertyId: getParameter(data, 'propertyId'),
      ),
  'ThreeSixtyView': (data) async => ThreeSixtyViewWidget(
        url: getParameter(data, 'url'),
      ),
  'imageGalleryView': (data) async => ImageGalleryViewWidget(
        propertyId: getParameter(data, 'propertyId'),
      ),
  'WhereAreYouLooking': (data) async => WhereAreYouLookingWidget(
        city: getParameter(data, 'city'),
      ),
  'SearchCityResult': (data) async => SearchCityResultWidget(
        cityName: getParameter(data, 'cityName'),
        propertiesAvailable: getParameter(data, 'propertiesAvailable'),
      ),
  'ReservationConfirmation': (data) async => ReservationConfirmationWidget(
        propertyId: getParameter(data, 'propertyId'),
      ),
  'Confirmation': (data) async => ConfirmationWidget(
        propertyId: getParameter(data, 'propertyId'),
        paymentMethod: getParameter(data, 'paymentMethod'),
        orderId: getParameter(data, 'orderId'),
        transactionId: getParameter(data, 'transactionId'),
      ),
  'bankDetails': (data) async => BankDetailsWidget(
        bankId: getParameter(data, 'bankId'),
        propertyId: getParameter(data, 'propertyId'),
      ),
  'OrderDetails': (data) async => OrderDetailsWidget(
        propertId: getParameter(data, 'propertId'),
      ),
  'AddCardDetails': (data) async => AddCardDetailsWidget(),
  'KYC': (data) async => KycWidget(),
  'AbsherVerification': (data) async => AbsherVerificationWidget(),
  'ConfirmAbsher': (data) async => ConfirmAbsherWidget(),
  'PersonalEmploymentDetails': (data) async =>
      PersonalEmploymentDetailsWidget(),
  'Chat': (data) async => ChatWidget(
        bankJson: getParameter(data, 'bankJson'),
      ),
  'BookingDetails': (data) async => BookingDetailsWidget(
        orderId: getParameter(data, 'orderId'),
      ),
  'depositeRecipt': (data) async => DepositeReciptWidget(
        depositeRecpit: getParameter(data, 'depositeRecpit'),
      ),
};

bool hasMatchingParameters(Map<String, dynamic> data, Set<String> params) =>
    params.any((param) => getParameter(data, param) != null);

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
