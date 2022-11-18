import 'package:auto_size_text/auto_size_text.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:manzel/common_alert_dialog/common_alert_dialog.dart';
import 'package:manzel/common_widgets/manzel_icons.dart';
import 'package:manzel/components/something_went_wrong_widget.dart';
import 'package:manzel/flutter_flow/flutter_flow_timer.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/query/channel_list/group_channel_list_query.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../auth/auth_util.dart';
import '../auth/firebase_user_provider.dart';
import '../backend/api_requests/api_calls.dart';
import '../components/no_result_widget.dart';
import '../enviorment/env_variables.dart';
import '../flutter_flow/custom_functions.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'dart:async';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//import 'packnt_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart' as sendbird;

//import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class OffersWidget extends StatefulWidget {
  const OffersWidget({
    Key? key,
    this.propertyId,
  }) : super(key: key);

  final String? propertyId;

  @override
  _OffersWidgetState createState() => _OffersWidgetState();
}

class _OffersWidgetState extends State<OffersWidget> {
  ApiCallResponse? acceptOfferResponse;
  ApiCallResponse? acceptOfferResponseAr;
  ApiCallResponse? getOfferResponse;
  var acceptOfferTappedIndex;
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final InAppReview inAppReview = InAppReview.instance;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, String> channels = {};
  var height;
  StopWatchTimer timerController = StopWatchTimer(
    mode: StopWatchMode.countDown,
  );
  Map<int, ValueNotifier<bool>> timerStoppedMap = {};
  Map<int, StopWatchTimer> timerControllersMap = {};
  Map<int, ValueNotifier<int>> timerMap = {};
  String? timerValue;
  int? timerMilliseconds;
  List? activeOffers;
  bool? isInternetAvailable;
  bool isPageLoading = true;

  Future<List<GroupChannel>?> getUnreadMessage() async {
    try {
      //String channel_url = channelUrl.toString();
      //final aChannel = await GroupChannel.getChannel(channel_url);
      final query = GroupChannelListQuery()
        ..userIdsIncludeIn = [currentUserUid]
        ..order = GroupChannelListOrder.chronological;
      final result = await query.loadNext();
      result.forEach((element) {
        channels[element.channelUrl.toString()] =
            element.unreadMessageCount.toString();
      });
      // print(aChannel.unreadMessageCount);
      // var channel = aChannel.unreadMessageCount.toString();
      // unreadMsg.value = channel;
      // return channel;

// print("unread Messages ${unreadMessage}");
//   return   unreadMessage.toString();

    } catch (error) {
      print("*********************************************************");
      print(error);
      print("*********************************************************");
    }
    if (mounted) setState(() {});
  }

  types.User asChatUiUser(sendbird.User user) {
    if (user == null) {
      return types.User(id: "", firstName: "");
    } else {
      return types.User(
          id: user.userId, firstName: user.nickname, lastSeen: user.lastSeenAt);
    }
  }

  @override
  void initState() {
    super.initState();

    // On page load action.
    // inAppReview.openStoreListing(appStoreId: '1630341481');
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (isInternetAvailable ?? false){
        final _sendbird = await sendbird.SendbirdSdk(
            appId: "${EnvVariables.instance.sendbirdAppId}");
        final _ = await _sendbird.connect(currentUserUid);
        // Future.delayed(Duration(seconds: 5));
        final _user = asChatUiUser(sendbird.SendbirdSdk().currentUser!);
        getUnreadMessage();
      }

      logFirebaseEvent('OFFERS_PAGE_Offers_ON_PAGE_LOAD');
      if (loggedIn) {
        if (valueOrDefault(currentUserDocument?.status, '') == 'Active') {
          return;
        }

        if (FFAppState().locale == 'en') {
          logFirebaseEvent('Offers_Alert-Dialog');
          await showDialog(
            context: context,
            builder: (alertDialogContext) {
              return AlertDialog(
                title: Text('Please get your account activated'),
                content: Text(
                    'You are not an active user please connect admin for further details'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(alertDialogContext),
                    child: Text('Ok'),
                  ),
                ],
              );
            },
          );
          logFirebaseEvent('Offers_Auth');
          GoRouter.of(context).prepareAuthEvent();
          await signOut();
        } else {
          logFirebaseEvent('Offers_Alert-Dialog');
          await showDialog(
            context: context,
            builder: (alertDialogContext) {
              return AlertDialog(
                title: Text('الرجاء تفعيل الحساب الخاص بك'),
                content: Text(
                    'أنت لست مستخدمًا نشطًا ، تواصل معنا للحصول على مزيد من التفاصيل'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(alertDialogContext),
                    child: Text('موافق'),
                  ),
                ],
              );
            },
          );
          logFirebaseEvent('Offers_Auth');
          GoRouter.of(context).prepareAuthEvent();
          await signOut();
        }
      } else {
        return;
      }

      context.goNamedAuth('OnboardingView', mounted);
    });

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Offers'});
    getOffersCall();
  }

  Future<void> getOffersCall() async {
    isInternetAvailable = await isInternetConnected();
    if (isInternetAvailable ?? false) {
      getOfferResponse = await GetOffersCall?.call(
          userId: currentUserUid,
          propertyId: functions.offerScreenPropertyIdisNull(widget.propertyId),
          locale: FFAppState().locale,
          authorazationToken: FFAppState().authToken,
          version: FFAppState().apiVersion);
      isPageLoading = false;
      setState(() {});
      activeOffers = getOfferResponse?.jsonBody["result"].toList();
    } else if((!(isInternetAvailable??false))&&loggedIn){
      isPageLoading = false;
      setState(() {});
      showDialog(
        context: context,
        builder: (BuildContext context) => CommonAlertDialog(
          onCancel: () {
            Navigator.pop(context);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 16,
        leadingWidth: 0,
        title: Text(
          FFLocalizations.of(context).getText(
            'mthnzz7x' /* Offers */,
          ),
          style: FlutterFlowTheme.of(context).title2.override(
            fontFamily: 'AvenirArabic',
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.w800,
            useGoogleFonts: false,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (widget.propertyId != null && widget.propertyId != '')
            InkWell(
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFFF3F2F2),
                        width: 1,
                      )),
                  height: 30,
                  width: 30,
                  child: Center(
                    child: Icon(
                      Manzel.clear,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 16,
                    ),
                  ),
                ),
              ),
              onTap: () async {
                logFirebaseEvent('OFFERS_PAGE_clear_ICN_ON_TAP');
                logFirebaseEvent('IconButton_Close-Dialog,-Drawer,-Etc');
                Navigator.pop(context);
              },
            ),
        ],
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: loggedIn ? MainAxisSize.max : MainAxisSize.min,
            children: [
              if (!loggedIn)
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, height / 3, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Image.asset(
                                'assets/images/offerScreenNoResult.png',
                                width: 40,
                                height: 38,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 15, 10, 0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'muecz7ra' /* You need to create an account ... */,
                                  ),
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                    fontFamily: 'AvenirArabic',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    useGoogleFonts: false,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 35),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'x824f0mb' /* login to see this section */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                    fontFamily: 'AvenirArabic',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    useGoogleFonts: false,
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding: EdgeInsetsDirectional.fromSTEB(
                              //       20, 10, 20, 10),
                              //   child: FFButtonWidget(
                              //     onPressed: () async {
                              //       logFirebaseEvent(
                              //           'OFFERS_PAGE_LOGIN_BTN_ON_TAP');
                              //       logFirebaseEvent('Button_Navigate-To');
                              //
                              //       context.pushNamed('Login');
                              //     },
                              //     text: FFLocalizations.of(context).getText(
                              //       '1cb5at0r' /* Login */,
                              //     ),
                              //     options: FFButtonOptions(
                              //       width: 215,
                              //       height: 40,
                              //       color: Color(0xFF2971FB),
                              //       textStyle: FlutterFlowTheme.of(context)
                              //           .subtitle2
                              //           .override(
                              //         fontFamily: 'AvenirArabic',
                              //         color: FlutterFlowTheme.of(context)
                              //             .white,
                              //         fontSize: 14,
                              //         useGoogleFonts: false,
                              //       ),
                              //       borderSide: BorderSide(
                              //         color: Colors.transparent,
                              //         width: 1,
                              //       ),
                              //       borderRadius: BorderRadius.circular(12),
                              //     ),
                              //   ),
                              //),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (functions.offerScreenConitionalVisibilty(
                  loggedIn, valueOrDefault(currentUserDocument?.status, '')))
                Builder(
                  builder: (BuildContext context) {
                    if (isPageLoading && loggedIn) {
                      return Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: SpinKitRipple(
                            color: FlutterFlowTheme.of(context).primaryColor,
                            size: 50,
                          ),
                        ),
                      );
                    }
                    return Expanded(
                      child: AuthUserStreamWidget(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(16, 0, 16, 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (functions.offerScreenConitionalVisibilty(
                                    loggedIn,
                                    valueOrDefault(
                                        currentUserDocument?.status, '')) &&
                                    (isInternetAvailable ?? false))
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 16, 20),
                                    child: AuthUserStreamWidget(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                1, 0, 1, 0),
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'r282eka0' /* You have */,
                                              ),
                                              style:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                fontFamily:
                                                'AvenirArabic',
                                                fontSize: 16,
                                                useGoogleFonts: false,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                4, 0, 4, 0),
                                            child: Text(
                                              valueOrDefault<String>(
                                                functions
                                                    .countJsonData(getJsonField(
                                                  getOfferResponse!.jsonBody,
                                                  r'''$.result''',
                                                )),
                                                '0',
                                              ),
                                              style: FlutterFlowTheme.of(
                                                  context)
                                                  .bodyText1
                                                  .override(
                                                fontFamily: 'AvenirArabic',
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                useGoogleFonts: false,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                1, 0, 1, 0),
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '9i2we2yx' /* offers active */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                  context)
                                                  .bodyText1
                                                  .override(
                                                fontFamily: 'AvenirArabic',
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                useGoogleFonts: false,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'z2siuoeg' /*   */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                Builder(
                                  builder: (context) {
                                    // final activeOffers =
                                    // getOfferResponse!.jsonBody["result"].toList();
                                    if (activeOffers?.isEmpty ?? false) {
                                      return Center(
                                        child: Container(
                                          width:
                                          MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.6,
                                          child: NoResultWidget(
                                            titleText:
                                            functions.emptyListWidgetTitle(
                                                'offers',
                                                FFAppState().locale),
                                            screenName: 'offer',
                                          ),
                                        ),
                                      );
                                    } else if ((activeOffers?.isNotEmpty ??
                                        false) &&
                                        (activeOffers != null) &&
                                        (getOfferResponse?.statusCode == 200)) {
                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        primary: false,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: activeOffers?.length,
                                        itemBuilder:
                                            (context, activeOffersIndex) {
                                          final activeOffersItem =
                                          activeOffers?[activeOffersIndex];
                                          if (functions.chatButtonVisibility(
                                              getJsonField(
                                                activeOffersItem,
                                                r'''$.status''',
                                              ).toString())) {
                                            var diffValue = (getJsonField(
                                              activeOffersItem,
                                              r'''$.booking_acceptance_expiry_time._seconds''',
                                            ) -
                                                ((DateTime.now()
                                                    .millisecondsSinceEpoch *
                                                    0.001)
                                                    .toInt()));
                                            if (diffValue > 0) {
                                              timerStoppedMap[
                                              activeOffersIndex] =
                                                  ValueNotifier(true);
                                              timerControllersMap[
                                              activeOffersIndex] =
                                                  StopWatchTimer(
                                                      mode: StopWatchMode
                                                          .countDown,
                                                      presetMillisecond:
                                                      diffValue * 1000);
                                              timerMap[activeOffersIndex] =
                                                  ValueNotifier(
                                                      diffValue * 1000);
                                              timerControllersMap[
                                              activeOffersIndex]!
                                                  .onStartTimer();
                                              timerControllersMap[
                                              activeOffersIndex]
                                                  ?.rawTime
                                                  .listen((event) {
                                                if (event <= 0) {
                                                  timerControllersMap[
                                                  activeOffersIndex]!
                                                      .onStopTimer();
                                                  timerStoppedMap[
                                                  activeOffersIndex]
                                                      ?.value = false;
                                                } else {
                                                  timerMap[activeOffersIndex]
                                                      ?.value = event;
                                                }
                                              });
                                            }
                                          }
                                          return Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 0, 12),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 15,
                                                    color: Color(0x06000000),
                                                    offset: Offset(0, 8),
                                                    spreadRadius: 0,
                                                  )
                                                ],
                                                borderRadius:
                                                BorderRadius.circular(12),
                                                border: Border.all(
                                                  color: Color(0xFFF1F1F1),
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        16, 16, 16, 16),
                                                    child: Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                            .of(context)
                                                            .primaryBackground,
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                0,
                                                                0,
                                                                8,
                                                                0),
                                                            child: Container(
                                                              height: 43,
                                                              width: 43,
                                                              decoration:
                                                              BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border:
                                                                  Border
                                                                      .all(
                                                                    color: Color(
                                                                        0xFFF3F2F2),
                                                                    width:
                                                                    1,
                                                                  )),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    21),
                                                                child: Image
                                                                    .network(
                                                                  getJsonField(
                                                                    activeOffersItem,
                                                                    r'''$.bank_logo''',
                                                                  ),
                                                                  width: 43,
                                                                  height: 43,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisSize:
                                                              MainAxisSize
                                                                  .max,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Row(
                                                                  mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          3,
                                                                          0),
                                                                      child:
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          't2kwojss' /* Offers */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                          fontFamily: 'AvenirArabic',
                                                                          fontSize: 12,
                                                                          useGoogleFonts: false,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      decoration:
                                                                      BoxDecoration(),
                                                                      child:
                                                                      Row(
                                                                        mainAxisSize:
                                                                        MainAxisSize.max,
                                                                        children: [
                                                                          Text(
                                                                            functions.orderIdFormatter(getJsonField(
                                                                              activeOffersItem,
                                                                              r'''$.order_id''',
                                                                            ).toString()),
                                                                            style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                              fontFamily: 'AvenirArabic',
                                                                              fontSize: 12,
                                                                              useGoogleFonts: false,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    getJsonField(
                                                                      activeOffersItem,
                                                                      r'''$.bank_name''',
                                                                    ).toString(),
                                                                    'null',
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                      context)
                                                                      .bodyText1
                                                                      .override(
                                                                    fontFamily:
                                                                    'AvenirArabic',
                                                                    fontSize:
                                                                    20,
                                                                    fontWeight:
                                                                    FontWeight.bold,
                                                                    useGoogleFonts:
                                                                    false,
                                                                    lineHeight:
                                                                    1.5,
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          3,
                                                                          0),
                                                                      child:
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'n5d3s79r' /* Last update :  */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                          fontFamily: 'AvenirArabic',
                                                                          color: FlutterFlowTheme.of(context).primaryColor,
                                                                          fontSize: 10,
                                                                          fontWeight: FontWeight.w500,
                                                                          useGoogleFonts: false,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        functions.offerScreenTime(
                                                                            valueOrDefault<int>(
                                                                              getJsonField(
                                                                                activeOffersItem,
                                                                                r'''$.created_at._seconds''',
                                                                              ),
                                                                              0,
                                                                            ),
                                                                            valueOrDefault<String>(
                                                                              FFAppState().locale,
                                                                              'en',
                                                                            )),
                                                                        '0',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                          context)
                                                                          .bodyText1
                                                                          .override(
                                                                        fontFamily:
                                                                        'AvenirArabic',
                                                                        color:
                                                                        FlutterFlowTheme.of(context).primaryColor,
                                                                        fontSize:
                                                                        10,
                                                                        fontWeight:
                                                                        FontWeight.w500,
                                                                        useGoogleFonts:
                                                                        false,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Column(
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .max,
                                                            children: [
                                                              if (functions.conditionalVisibility(
                                                                  getJsonField(
                                                                    activeOffersItem,
                                                                    r'''$.status''',
                                                                  ).toString(),
                                                                  'disqualified'))
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      8),
                                                                  child:
                                                                  Container(
                                                                    width: 88,
                                                                    height: 22,
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      color: Color(
                                                                          0xFFD05C5C),
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          5),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                      children: [
                                                                        Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'jcj51k47' /* Disqualified */,
                                                                          ),
                                                                          textAlign:
                                                                          TextAlign.center,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                            fontFamily: 'AvenirArabic',
                                                                            color: FlutterFlowTheme.of(context).white,
                                                                            fontSize: 11,
                                                                            fontWeight: FontWeight.w500,
                                                                            useGoogleFonts: false,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (functions
                                                                  .conditionalVisibility(
                                                                  getJsonField(
                                                                    activeOffersItem,
                                                                    r'''$.status''',
                                                                  ).toString(),
                                                                  'rejected'))
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      8),
                                                                  child:
                                                                  Container(
                                                                    width: 74,
                                                                    height: 22,
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      color: Color(
                                                                          0xFFD05C5C),
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          5),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                      children: [
                                                                        Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'zraegj7a' /* Rejected */,
                                                                          ),
                                                                          textAlign:
                                                                          TextAlign.center,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                            fontFamily: 'AvenirArabic',
                                                                            color: FlutterFlowTheme.of(context).white,
                                                                            fontSize: 11,
                                                                            fontWeight: FontWeight.w500,
                                                                            useGoogleFonts: false,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (functions
                                                                  .conditionalVisibility(
                                                                  getJsonField(
                                                                    activeOffersItem,
                                                                    r'''$.status''',
                                                                  ).toString(),
                                                                  'expired'))
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      8),
                                                                  child:
                                                                  Container(
                                                                    width: 74,
                                                                    height: 22,
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      color: Color(
                                                                          0xFF444444),
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          5),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                      children: [
                                                                        Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            '2ak58fes' /* Expired */,
                                                                          ),
                                                                          textAlign:
                                                                          TextAlign.center,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                            fontFamily: 'AvenirArabic',
                                                                            color: FlutterFlowTheme.of(context).white,
                                                                            fontSize: 11,
                                                                            fontWeight: FontWeight.w500,
                                                                            useGoogleFonts: false,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (functions
                                                                  .conditionalVisibility(
                                                                  getJsonField(
                                                                    activeOffersItem,
                                                                    r'''$.status''',
                                                                  ).toString(),
                                                                  'accepted'))
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      8),
                                                                  child:
                                                                  Container(
                                                                    width: 74,
                                                                    height: 22,
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      color: Color(
                                                                          0xFF43B6A5),
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          5),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                      children: [
                                                                        Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'vaaj8s0b' /* Accepted */,
                                                                          ),
                                                                          textAlign:
                                                                          TextAlign.center,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                            fontFamily: 'AvenirArabic',
                                                                            color: FlutterFlowTheme.of(context).white,
                                                                            fontSize: 11,
                                                                            fontWeight: FontWeight.w500,
                                                                            useGoogleFonts: false,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (functions
                                                                  .conditionalVisibility(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    getJsonField(
                                                                      activeOffersItem,
                                                                      r'''$.status''',
                                                                    ).toString(),
                                                                    'null',
                                                                  ),
                                                                  'new'))
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      8),
                                                                  child:
                                                                  Container(
                                                                    width: 74,
                                                                    height: 22,
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      color: Color(
                                                                          0xFFD05C5C),
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          5),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                      children: [
                                                                        Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'lre09mx2' /* New Offer */,
                                                                          ),
                                                                          textAlign:
                                                                          TextAlign.center,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                            fontFamily: 'AvenirArabic',
                                                                            color: FlutterFlowTheme.of(context).white,
                                                                            fontSize: 11,
                                                                            fontWeight: FontWeight.w500,
                                                                            useGoogleFonts: false,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (functions
                                                                  .conditionalVisibility(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    getJsonField(
                                                                      activeOffersItem,
                                                                      r'''$.status''',
                                                                    ).toString(),
                                                                    'null',
                                                                  ),
                                                                  'pending'))
                                                                Container(
                                                                  width: 74,
                                                                  height: 22,
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    color: Color(
                                                                        0xFFF0A637),
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(5),
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                    children: [
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'nu7aeeks' /* Pending */,
                                                                        ),
                                                                        textAlign:
                                                                        TextAlign.center,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                          fontFamily: 'AvenirArabic',
                                                                          color: FlutterFlowTheme.of(context).white,
                                                                          fontSize: 11,
                                                                          fontWeight: FontWeight.w500,
                                                                          useGoogleFonts: false,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  if (functions
                                                      .chatButtonVisibility(
                                                      getJsonField(
                                                        activeOffersItem,
                                                        r'''$.status''',
                                                      ).toString()))
                                                    ValueListenableBuilder(
                                                      valueListenable:
                                                      timerStoppedMap[
                                                      activeOffersIndex] ??
                                                          ValueNotifier(
                                                              true),
                                                      builder:
                                                          (BuildContext context,
                                                          bool value,
                                                          Widget? child) {
                                                        return timerStoppedMap[
                                                        activeOffersIndex]
                                                            ?.value ??
                                                            false
                                                            ? Padding(
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              0,
                                                              0,
                                                              0,
                                                              15),
                                                          child:
                                                          Container(
                                                            width: double
                                                                .infinity,
                                                            height: 30,
                                                            decoration:
                                                            BoxDecoration(
                                                              color: Color(
                                                                  0xFFFADA6B),
                                                            ),
                                                            child: Row(
                                                              mainAxisSize:
                                                              MainAxisSize
                                                                  .max,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              children: [
                                                                Text(
                                                                  FFLocalizations.of(context)
                                                                      .getText(
                                                                    'y42wn8bh' /* You have  */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(context)
                                                                      .bodyText1
                                                                      .override(
                                                                    fontFamily: 'AvenirArabic',
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.bold,
                                                                    useGoogleFonts: false,
                                                                  ),
                                                                ),
                                                                ValueListenableBuilder(
                                                                  valueListenable:
                                                                  timerMap[activeOffersIndex] ??
                                                                      ValueNotifier(true),
                                                                  builder: (BuildContext
                                                                  context,
                                                                      value,
                                                                      child) {
                                                                    final displayTime =
                                                                    StopWatchTimer.getDisplayTime(
                                                                      value
                                                                      as int,
                                                                      hours:
                                                                      true,
                                                                      minute:
                                                                      true,
                                                                      second:
                                                                      true,
                                                                      milliSecond:
                                                                      false,
                                                                    );
                                                                    return Container(
                                                                        child: Text(' ${displayTime}',
                                                                            style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                              fontFamily: 'AvenirArabic',
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.bold,
                                                                              useGoogleFonts: false,
                                                                            )));
                                                                  },
                                                                  //     Stack(
                                                                  //      children: [
                                                                  //Align(
                                                                  //  alignment: AlignmentDirectional(0, 0),
                                                                  //  child: StreamBuilder<int>(
                                                                  //      initialData: 10,
                                                                  //      stream: timerControllersMap[activeOffersIndex]!.rawTime,
                                                                  //      builder: (context, snap) {
                                                                  //        final value = snap.data;
                                                                  //        if(value!<=0){
                                                                  //          timerControllersMap[activeOffersIndex]!.onStopTimer();
                                                                  //           timerStoppedMap[activeOffersIndex]?.value = false;
                                                                  //         //  timerCompleted.value = true;
                                                                  //           return SizedBox.shrink();
                                                                  //        }
                                                                  //       // print(">>>>>>>>>>>>>>>>>>> value = ${value}");
                                                                  //        final displayTime = StopWatchTimer.getDisplayTime(
                                                                  //          value,
                                                                  //          hours: true,
                                                                  //          minute: true,
                                                                  //          second: true,
                                                                  //          milliSecond: false,
                                                                  //         );
                                                                  //
                                                                  //         return  Text(
                                                                  //             '${displayTime}',
                                                                  //             style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                  //               fontFamily: 'AvenirArabic',
                                                                  //               color: FlutterFlowTheme.of(context).primaryText,
                                                                  //               fontSize: 12,
                                                                  //               fontWeight: FontWeight.bold,
                                                                  //               useGoogleFonts: false,
                                                                  //             ),
                                                                  //          );
                                                                  //      }),
                                                                  //),

                                                                  //    ],
                                                                  //   ),
                                                                ),
                                                                // Padding(
                                                                //   padding:
                                                                //   EdgeInsetsDirectional
                                                                //       .fromSTEB(
                                                                //       2,
                                                                //       0,
                                                                //       2,
                                                                //       0),
                                                                //   child: Text(
                                                                //     FFLocalizations.of(
                                                                //         context)
                                                                //         .getText(
                                                                //       '9j4qhgy0' /* min. */,
                                                                //     ),
                                                                //     style: FlutterFlowTheme.of(
                                                                //         context)
                                                                //         .bodyText1
                                                                //         .override(
                                                                //       fontFamily:
                                                                //       'AvenirArabic',
                                                                //       fontSize:
                                                                //       12,
                                                                //       fontWeight:
                                                                //       FontWeight
                                                                //           .bold,
                                                                //       useGoogleFonts:
                                                                //       false,
                                                                //     ),
                                                                //   ),
                                                                // ),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(
                                                                      right:
                                                                      4.0,
                                                                      left:
                                                                      4.0),
                                                                  child:
                                                                  Text(
                                                                    FFLocalizations.of(context)
                                                                        .getText(
                                                                      'f82o9diq' /* to accept offer */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(context)
                                                                        .bodyText1
                                                                        .override(
                                                                      fontFamily: 'AvenirArabic',
                                                                      fontSize: 12,
                                                                      fontWeight: FontWeight.bold,
                                                                      useGoogleFonts: false,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                            : SizedBox.shrink();
                                                      },
                                                    ),
                                                  Divider(
                                                    thickness: 1,
                                                    color: Color(0xFFF1F1F1),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        16, 18, 26, 16),
                                                    child: Row(
                                                      mainAxisSize:
                                                      MainAxisSize.max,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .max,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text(
                                                                FFLocalizations.of(
                                                                    context)
                                                                    .getText(
                                                                  'np7vw75o' /* Property */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodyText1
                                                                    .override(
                                                                  fontFamily:
                                                                  'AvenirArabic',
                                                                  color: Color(
                                                                      0xFF6B6B6B),
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                                  useGoogleFonts:
                                                                  false,
                                                                ),
                                                              ),
                                                              Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  getJsonField(
                                                                    activeOffersItem,
                                                                    r'''$.property_name''',
                                                                  ).toString(),
                                                                  'null',
                                                                ),
                                                                maxLines: 2,
                                                                style: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodyText1
                                                                    .override(
                                                                  fontFamily:
                                                                  'AvenirArabic',
                                                                  fontSize:
                                                                  16,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  useGoogleFonts:
                                                                  false,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                5,
                                                                0,
                                                                0,
                                                                0),
                                                            child: Column(
                                                              mainAxisSize:
                                                              MainAxisSize
                                                                  .max,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  FFLocalizations.of(
                                                                      context)
                                                                      .getText(
                                                                    'vs0xmudi' /* Booking Ref. */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                      context)
                                                                      .bodyText1
                                                                      .override(
                                                                    fontFamily:
                                                                    'AvenirArabic',
                                                                    color: Color(
                                                                        0xFF6B6B6B),
                                                                    fontWeight:
                                                                    FontWeight.w300,
                                                                    useGoogleFonts:
                                                                    false,
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                      Text(
                                                                        functions
                                                                            .orderIdFormatter(getJsonField(
                                                                          activeOffersItem,
                                                                          r'''$.order_id''',
                                                                        ).toString()),
                                                                        maxLines:
                                                                        2,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                          fontFamily: 'AvenirArabic',
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.bold,
                                                                          useGoogleFonts: false,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    children: [
                                                      if (!functions
                                                          .conditionalVisibility(
                                                          getJsonField(
                                                            activeOffersItem,
                                                            r'''$.status''',
                                                          ).toString(),
                                                          'pending'))
                                                        Padding(
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              16,
                                                              0,
                                                              16,
                                                              16),
                                                          child: Row(
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'ez8wbssn' /* Installment Amount */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                          fontFamily: 'AvenirArabic',
                                                                          color: Color(0xFF6B6B6B),
                                                                          fontWeight: FontWeight.w300,
                                                                          useGoogleFonts: false,
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        mainAxisSize:
                                                                        MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.end,
                                                                        children: [
                                                                          Text(
                                                                            valueOrDefault<String>(
                                                                              functions.formatAmount(valueOrDefault<String>(
                                                                                getJsonField(
                                                                                  activeOffersItem,
                                                                                  r'''$.offered_installment_amount''',
                                                                                ).toString(),
                                                                                '0',
                                                                              )),
                                                                              '0',
                                                                            ),
                                                                            maxLines:
                                                                            2,
                                                                            style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                              fontFamily: 'AvenirArabic',
                                                                              fontSize: 19,
                                                                              fontWeight: FontWeight.bold,
                                                                              useGoogleFonts: false,
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                4,
                                                                                0,
                                                                                0,
                                                                                4),
                                                                            child:
                                                                            Text(
                                                                              FFLocalizations.of(context).getText(
                                                                                'h47bvnhi' /* SAR */,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                fontFamily: 'AvenirArabic',
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w500,
                                                                                useGoogleFonts: false,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'lastInstallmentOffer' /* Initial installment */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                          fontFamily: 'AvenirArabic',
                                                                          color: Color(0xFF6B6B6B),
                                                                          fontWeight: FontWeight.w300,
                                                                          useGoogleFonts: false,
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        mainAxisSize:
                                                                        MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.end,
                                                                        children: [
                                                                          Text(
                                                                            valueOrDefault<String>(
                                                                              functions.formatAmount(valueOrDefault<String>(
                                                                                getJsonField(
                                                                                  activeOffersItem,
                                                                                  r'''$.last_installment_amount''',
                                                                                ).toString(),
                                                                                '0',
                                                                              )),
                                                                              '0',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                              fontFamily: 'AvenirArabic',
                                                                              fontSize: 19,
                                                                              fontWeight: FontWeight.bold,
                                                                              useGoogleFonts: false,
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                4,
                                                                                0,
                                                                                0,
                                                                                4),
                                                                            child:
                                                                            Text(
                                                                              FFLocalizations.of(context).getText(
                                                                                'z7x7wv59' /* SAR */,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                fontFamily: 'AvenirArabic',
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w500,
                                                                                useGoogleFonts: false,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      if (!functions
                                                          .conditionalVisibility(
                                                          getJsonField(
                                                            activeOffersItem,
                                                            r'''$.status''',
                                                          ).toString(),
                                                          'pending'))
                                                        Padding(
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              16,
                                                              0,
                                                              16,
                                                              18),
                                                          child: Row(
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          '4ha591ne' /* Installment period */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                          fontFamily: 'AvenirArabic',
                                                                          color: Color(0xFF6B6B6B),
                                                                          fontWeight: FontWeight.w300,
                                                                          useGoogleFonts: false,
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        mainAxisSize:
                                                                        MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.end,
                                                                        children: [
                                                                          Text(
                                                                            valueOrDefault<String>(
                                                                              getJsonField(
                                                                                activeOffersItem,
                                                                                r'''$.offered_installment_period''',
                                                                              ).toString(),
                                                                              '0',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                              fontFamily: 'AvenirArabic',
                                                                              fontSize: 19,
                                                                              fontWeight: FontWeight.bold,
                                                                              useGoogleFonts: false,
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                4,
                                                                                0,
                                                                                0,
                                                                                4),
                                                                            child:
                                                                            Text(
                                                                              FFLocalizations.of(context).getText(
                                                                                'b1jmmlnc' /* Month */,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                fontFamily: 'AvenirArabic',
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w500,
                                                                                useGoogleFonts: false,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          '2kxnix92' /* Total price */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                          fontFamily: 'AvenirArabic',
                                                                          color: Color(0xFF6B6B6B),
                                                                          fontWeight: FontWeight.w300,
                                                                          useGoogleFonts: false,
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        mainAxisSize:
                                                                        MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.end,
                                                                        children: [
                                                                          Text(
                                                                            valueOrDefault<String>(
                                                                              functions.formatAmount(valueOrDefault<String>(
                                                                                getJsonField(
                                                                                  activeOffersItem,
                                                                                  r'''$.property_price''',
                                                                                ).toString(),
                                                                                '0',
                                                                              )),
                                                                              '0',
                                                                            ),
                                                                            maxLines:
                                                                            2,
                                                                            style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                              fontFamily: 'AvenirArabic',
                                                                              fontSize: 19,
                                                                              fontWeight: FontWeight.bold,
                                                                              useGoogleFonts: false,
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                4,
                                                                                0,
                                                                                0,
                                                                                4),
                                                                            child:
                                                                            Text(
                                                                              FFLocalizations.of(context).getText(
                                                                                'h47bvnhi' /* SAR */,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                fontFamily: 'AvenirArabic',
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w500,
                                                                                useGoogleFonts: false,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      Padding(
                                                        padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16, 0,
                                                            16, 20),
                                                        child: Column(
                                                          mainAxisSize:
                                                          MainAxisSize.max,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                          children: [
                                                            Badge(
                                                              badgeContent:
                                                              Text(
                                                                channels[valueOrDefault<
                                                                    String>(
                                                                    getJsonField(activeOffersItem,
                                                                        r'''$.channel_detail.channel_url''')
                                                                        .toString(),
                                                                    '0')] ??
                                                                    '0',
                                                                style: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodyText1
                                                                    .override(
                                                                  fontFamily:
                                                                  'AvenirArabic',
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  12,
                                                                  useGoogleFonts:
                                                                  false,
                                                                ),
                                                              ),
                                                              showBadge: (channels[valueOrDefault<String>(
                                                                  getJsonField(activeOffersItem, r'''$.channel_detail.channel_url''')
                                                                      .toString(),
                                                                  '0')] !=
                                                                  '0' &&
                                                                  channels[valueOrDefault<String>(
                                                                      getJsonField(activeOffersItem, r'''$.channel_detail.channel_url''').toString(),
                                                                      '0')] !=
                                                                      null)
                                                                  ? true
                                                                  : false,
                                                              shape: BadgeShape
                                                                  .circle,
                                                              badgeColor:
                                                              FlutterFlowTheme.of(
                                                                  context)
                                                                  .customColor3,
                                                              elevation: 4,
                                                              padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  10,
                                                                  10,
                                                                  10,
                                                                  10),
                                                              position:
                                                              BadgePosition
                                                                  .topEnd(),
                                                              animationType:
                                                              BadgeAnimationType
                                                                  .scale,
                                                              toAnimate: true,
                                                              child: Padding(
                                                                padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    0,
                                                                    7,
                                                                    0,
                                                                    8),
                                                                child: InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    logFirebaseEvent(
                                                                        'OFFERS_PAGE_Container_4zrbybz6_ON_TAP');
                                                                    logFirebaseEvent(
                                                                        'Container_Navigate-To');
                                                                    context
                                                                        .pushNamed(
                                                                      'Chat',
                                                                      queryParams:
                                                                      {
                                                                        'bankJson': serializeParam(
                                                                            getJsonField(
                                                                              activeOffersItem,
                                                                              r'''$''',
                                                                            ),
                                                                            ParamType.JSON),
                                                                      }.withoutNulls,
                                                                    );
                                                                  },
                                                                  child:
                                                                  Container(
                                                                    width: MediaQuery.of(
                                                                        context)
                                                                        .size
                                                                        .width,
                                                                    height: 42,
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                          context)
                                                                          .primaryColor,
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          10),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                          EdgeInsetsDirectional.only(end: 5),
                                                                          child:
                                                                          Icon(
                                                                            Manzel.chat_icon,
                                                                            size:
                                                                            22,
                                                                            color:
                                                                            Colors.white,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'pasrxjal' /* Chat with */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                            fontFamily: 'AvenirArabic',
                                                                            color: FlutterFlowTheme.of(context).white,
                                                                            fontSize: 15,
                                                                            fontWeight: FontWeight.w500,
                                                                            useGoogleFonts: false,
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              3,
                                                                              0,
                                                                              2,
                                                                              0),
                                                                          child:
                                                                          Text(
                                                                            FFLocalizations.of(context).getText(
                                                                              'ps7kcru7' /* bank */,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                              fontFamily: 'AvenirArabic',
                                                                              color: FlutterFlowTheme.of(context).white,
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w500,
                                                                              useGoogleFonts: false,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              3,
                                                                              0,
                                                                              2,
                                                                              0),
                                                                          child:
                                                                          Text(
                                                                            valueOrDefault<String>(
                                                                              getJsonField(
                                                                                activeOffersItem,
                                                                                r'''$.bank_name''',
                                                                              ).toString(),
                                                                              'null',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                              fontFamily: 'AvenirArabic',
                                                                              color: FlutterFlowTheme.of(context).white,
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w500,
                                                                              useGoogleFonts: false,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'alqnps4o' /*   */,
                                                                          ),
                                                                          style:
                                                                          FlutterFlowTheme.of(context).bodyText1,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            if (functions
                                                                .chatButtonVisibility(
                                                                getJsonField(
                                                                  activeOffersItem,
                                                                  r'''$.status''',
                                                                ).toString()))
                                                              ValueListenableBuilder<
                                                                  bool>(
                                                                builder: (BuildContext
                                                                context,
                                                                    bool value,
                                                                    Widget?
                                                                    child) {
                                                                  return ((timerStoppedMap[activeOffersIndex]
                                                                      ?.value ??
                                                                      false))
                                                                      ? Container(
                                                                    width:
                                                                    130,
                                                                    height:
                                                                    42,
                                                                    child:
                                                                    ElevatedButton(
                                                                      onPressed:
                                                                          () async {
                                                                        if (isLoading.value == false) {
                                                                          logFirebaseEvent('OFFERS_PAGE_ACCEPT_OFFER_BTN_ON_TAP');
                                                                          logFirebaseEvent('select_item');
                                                                          if (FFAppState().locale == 'en') {
                                                                            logFirebaseEvent('Button_Alert-Dialog');
                                                                            var confirmDialogResponse = await showDialog<bool>(
                                                                              context: context,
                                                                              builder: (alertDialogContext) {
                                                                                return AlertDialog(
                                                                                  title: Text('Accept offer'),
                                                                                  content: Text('Are you sure you want to accept the offer? we will reject all other offers if you accepted'),
                                                                                  actions: [
                                                                                    TextButton(
                                                                                      onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                      child: Text('No'),
                                                                                    ),
                                                                                    TextButton(
                                                                                      onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                                      child: Text('Accept'),
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              },
                                                                            ) ??
                                                                                false;
                                                                            if (confirmDialogResponse) {
                                                                              acceptOfferTappedIndex = activeOffersIndex;
                                                                              isLoading.value = true;
                                                                              logFirebaseEvent('Button_Backend-Call');
                                                                              acceptOfferResponse = await AcceptOfferCall.call(
                                                                                  userId: currentUserUid,
                                                                                  authorazationToken: FFAppState().authToken,
                                                                                  offerId: valueOrDefault<String>(
                                                                                    getJsonField(
                                                                                      activeOffersItem,
                                                                                      r'''$.id''',
                                                                                    ).toString(),
                                                                                    'null',
                                                                                  ),
                                                                                  version: FFAppState().apiVersion);
                                                                              if ((acceptOfferResponse?.statusCode ?? 200) == 200) {
                                                                                logFirebaseEvent('Button_Show-Snack-Bar');
                                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                                  SnackBar(
                                                                                    content: Text(
                                                                                      functions.snackBarMessage('offerAccepted', FFAppState().locale),
                                                                                      style: TextStyle(
                                                                                        color: FlutterFlowTheme.of(context).white,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: 16,
                                                                                      ),
                                                                                    ),
                                                                                    duration: Duration(milliseconds: 4000),
                                                                                    backgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                  ),
                                                                                );
                                                                                // Future.delayed(const Duration(seconds: 5), () {
                                                                                if (mounted)
                                                                                //  setState(() {});
                                                                                  getOffersCall();

                                                                                // });
                                                                                isLoading.value = false;
                                                                                if (await inAppReview.isAvailable()) {
                                                                                  Future.delayed(const Duration(seconds: 2), () {
                                                                                    inAppReview.requestReview();
                                                                                  });
                                                                                }
                                                                              } else {
                                                                                logFirebaseEvent('Button_Show-Snack-Bar');
                                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                                  SnackBar(
                                                                                    content: Text(
                                                                                      functions.snackBarMessage('error', FFAppState().locale),
                                                                                      style: TextStyle(
                                                                                        color: FlutterFlowTheme.of(context).white,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: 16,
                                                                                      ),
                                                                                    ),
                                                                                    duration: Duration(milliseconds: 4000),
                                                                                    backgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                  ),
                                                                                );
                                                                                isLoading.value = false;
                                                                              }
                                                                            }
                                                                          } else {
                                                                            logFirebaseEvent('Button_Alert-Dialog');
                                                                            var confirmDialogResponse = await showDialog<bool>(
                                                                              context: context,
                                                                              builder: (alertDialogContext) {
                                                                                return AlertDialog(
                                                                                  title: Text('اقبل العرض'),
                                                                                  content: Text('هل أنت متأكد أنك تريد قبول العرض؟ سيتم رفض جميع العروض الأخرى بعد قبول هذا العرض'),
                                                                                  actions: [
                                                                                    TextButton(
                                                                                      onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                      child: Text('لا، احتاج بعض من الوقت'),
                                                                                    ),
                                                                                    TextButton(
                                                                                      onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                                      child: Text('قبول العرض'),
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              },
                                                                            ) ??
                                                                                false;
                                                                            if (confirmDialogResponse) {
                                                                              acceptOfferTappedIndex = activeOffersIndex;
                                                                              isLoading.value = true;
                                                                              logFirebaseEvent('Button_Backend-Call');
                                                                              acceptOfferResponseAr = await AcceptOfferCall.call(
                                                                                  userId: currentUserUid,
                                                                                  authorazationToken: FFAppState().authToken,
                                                                                  offerId: valueOrDefault<String>(
                                                                                    getJsonField(
                                                                                      activeOffersItem,
                                                                                      r'''$.id''',
                                                                                    ).toString(),
                                                                                    'null',
                                                                                  ),
                                                                                  version: FFAppState().apiVersion);
                                                                              if ((acceptOfferResponseAr?.statusCode ?? 200) == 200) {
                                                                                logFirebaseEvent('Button_Show-Snack-Bar');
                                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                                  SnackBar(
                                                                                    content: Text(
                                                                                      functions.snackBarMessage('offerAccepted', FFAppState().locale),
                                                                                      style: TextStyle(
                                                                                        color: FlutterFlowTheme.of(context).white,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: 16,
                                                                                      ),
                                                                                    ),
                                                                                    duration: Duration(milliseconds: 4000),
                                                                                    backgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                  ),
                                                                                );
                                                                                if (mounted) setState(() {});
                                                                                isLoading.value = false;
                                                                              } else {
                                                                                logFirebaseEvent('Button_Show-Snack-Bar');
                                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                                  SnackBar(
                                                                                    content: Text(
                                                                                      functions.snackBarMessage('error', FFAppState().locale),
                                                                                      style: TextStyle(
                                                                                        color: FlutterFlowTheme.of(context).white,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: 16,
                                                                                      ),
                                                                                    ),
                                                                                    duration: Duration(milliseconds: 4000),
                                                                                    backgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                  ),
                                                                                );
                                                                                isLoading.value = false;
                                                                              }
                                                                            }
                                                                          }
                                                                          if (mounted)
                                                                            //setState(() {});
                                                                            getOffersCall();
                                                                        }
                                                                      },
                                                                      child:
                                                                      ValueListenableBuilder<bool>(
                                                                        builder: (BuildContext context, bool value, Widget? child) {
                                                                          return (((activeOffersIndex != acceptOfferTappedIndex) && (isLoading.value == true)) ? false : isLoading.value)
                                                                              ? Padding(
                                                                            padding: const EdgeInsets.all(5.0),
                                                                            child: Row(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: [
                                                                                SizedBox(
                                                                                  height: 30,
                                                                                  width: 30,
                                                                                  child: CircularProgressIndicator(
                                                                                    valueColor: AlwaysStoppedAnimation(FlutterFlowTheme.of(context).primaryColor),
                                                                                    strokeWidth: 5,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          )
                                                                              : AutoSizeText(
                                                                              FFLocalizations.of(context).getText(
                                                                                'y0qb0uvi' /* Accept offer */,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                fontFamily: 'AvenirArabic',
                                                                                color: FlutterFlowTheme.of(context).primaryColor,
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.w500,
                                                                                useGoogleFonts: false,
                                                                              ));
                                                                        },
                                                                        valueListenable: isLoading,
                                                                      ),
                                                                      style:
                                                                      ButtonStyle(
                                                                        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                                                                              (states) {
                                                                            if (states.contains(MaterialState.disabled)) {
                                                                              FlutterFlowTheme.of(context).subtitle2.override(
                                                                                fontFamily: 'AvenirArabic',
                                                                                color: FlutterFlowTheme.of(context).primaryColor,
                                                                                useGoogleFonts: false,
                                                                              );
                                                                            }
                                                                            FlutterFlowTheme.of(context).subtitle2.override(
                                                                              fontFamily: 'AvenirArabic',
                                                                              color: FlutterFlowTheme.of(context).primaryColor,
                                                                              useGoogleFonts: false,
                                                                            );
                                                                          },
                                                                        ),
                                                                        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                                                              (states) {
                                                                            if (states.contains(MaterialState.disabled)) {
                                                                              return Colors.white;
                                                                            }
                                                                            return Colors.white;
                                                                          },
                                                                        ),
                                                                        shape: MaterialStateProperty.all<OutlinedBorder>(
                                                                          RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                              side: BorderSide(
                                                                                color: FlutterFlowTheme.of(context).primaryColor,
                                                                                width: 1,
                                                                              )),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                      : SizedBox
                                                                      .shrink();
                                                                },
                                                                valueListenable:
                                                                timerStoppedMap[
                                                                activeOffersIndex] ??
                                                                    ValueNotifier(
                                                                        false),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                    else if((getOfferResponse?.statusCode!=200)&&(getOfferResponse!=null)){
                                      return SomethingWentWrongWidget(onTryAgain: (){

                                      });
                                    }
                                    return SizedBox();
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 20, 16, 10),
                                  child: InkWell(
                                    onTap: () async {
                                      logFirebaseEvent(
                                          'OFFERS_PAGE_Container_kc3eke2v_ON_TAP');
                                      logFirebaseEvent('Container_Navigate-To');

                                      context.pushNamed(
                                        'PastOffers',
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                            PageTransitionType.fade,
                                            duration: Duration(milliseconds: 0),
                                          ),
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 52,
                                      decoration: BoxDecoration(
                                        color:
                                        FlutterFlowTheme.of(context).white,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 15,
                                            color: Color(0x06000000),
                                            offset: Offset(0, 8),
                                            spreadRadius: 0,
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Color(0xFFF1F1F1),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                18, 0, 0, 0),
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '5gvwuuh2' /* Past Offers */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                  context)
                                                  .bodyText1
                                                  .override(
                                                fontFamily: 'AvenirArabic',
                                                color: Color(0xFF474747),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                useGoogleFonts: false,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 17, 0),
                                            child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Colors.black,
                                              size: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

//   Future waitForApiRequestCompleter({
//     double minWait = 0,
//     double maxWait = double.infinity,
//   }) async {
//     final stopwatch = Stopwatch()..start();
//     while (true) {
//       await Future.delayed(Duration(milliseconds: 50));
//       final timeElapsed = stopwatch.elapsedMilliseconds;
//       final requestComplete = _apiRequestCompleter?.isCompleted ?? false;
//       if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
//         break;
//       }
//     }
//   }

  @override
  void dispose() {
    super.dispose();
  }
}
