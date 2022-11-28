import 'package:flutter/scheduler.dart';
import 'package:go_sell_sdk_flutter/go_sell_sdk_flutter.dart';
import 'package:manzel/common_alert_dialog/common_alert_dialog.dart';
import 'package:manzel/common_widgets/manzel_icons.dart';
import 'package:manzel/components/something_went_wrong_widget.dart';
import 'package:manzel/flutter_flow/custom_functions.dart';
import 'package:manzel/confirmation/confirmation_widget.dart';
import 'package:manzel/flutter_flow/flutter_flow_timer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../auth/auth_util.dart';
import '../auth/firebase_user_provider.dart';
import '../backend/api_requests/api_calls.dart';
import '../components/no_results_found_widget.dart';
import '../components/reservation_bottom_sheet_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class MyPropertiesWidget extends StatefulWidget {
  const MyPropertiesWidget({Key? key}) : super(key: key);

  @override
  _MyPropertiesWidgetState createState() => _MyPropertiesWidgetState();
}

class _MyPropertiesWidgetState extends State<MyPropertiesWidget> {
  ApiCallResponse? bookmarkApiResponse;
  ApiCallResponse? bookedPropertiesApiResponse;
  ApiCallResponse? getBookMarkedPropertiesApiResponse;
  StopWatchTimer timerController = StopWatchTimer(
    mode: StopWatchMode.countDown,
  );
  String? timerValue;
  int? timerMilliseconds;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ValueNotifier<int> changeTimer = ValueNotifier<int>(0);
  ValueNotifier<int> changeText = ValueNotifier<int>(0);
  ValueNotifier<bool> timerOver = ValueNotifier<bool>(true);
  bool? isInternetAvailable;
  List? bookedProperties;
  List? bookmarkedProperties;
  bool isBookedPropertiesLoading = true;
  bool isBookMarkedProperties = true;
  var alertCalled = 0;
  var height;

  @override
  void initState() {
    super.initState();
    // On page load action.
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'MyProperties'});
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('MY_PROPERTIES_MyProperties_ON_LOAD');
      logFirebaseEvent('MyProperties_timer');
      timerController.onStartTimer();
    });

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'MyProperties'});
    // WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    bookedPropertiesCall();
    getBookMarkedPropertiesCall();
  }

  Future<void> bookedPropertiesCall() async {
    isBookedPropertiesLoading = true;
    setState(() {});
    isInternetAvailable = await isInternetConnected();
    if ((isInternetAvailable ?? false) && loggedIn) {
      bookedPropertiesApiResponse = await BookedPropertiesCall.call(
        userId: currentUserUid,
        locale: FFAppState().locale,
        authorazationToken: FFAppState().authToken,
        version: FFAppState().apiVersion,
      );
      isBookedPropertiesLoading = false;
      setState(() {});
      bookedProperties = BookedPropertiesCall.result(
        bookedPropertiesApiResponse?.jsonBody,
      ).toList();
    } else if ((!(isInternetAvailable ?? false)) && loggedIn) {
      isBookedPropertiesLoading = false;
      setState(() {});
      bookedPropertiesApiResponse = null;
      alertCalled++;
      setState(() {});
      if (alertCalled <= 1)
        showDialog(
          context: context,
          builder: (BuildContext context) => CommonAlertDialog(
            onCancel: () {
              alertCalled = 0;
              setState(() {});
              Navigator.pop(context);
            },
          ),
        );
    }
  }

  Future<void> getBookMarkedPropertiesCall() async {
    isBookMarkedProperties = true;
    setState(() {});
    isInternetAvailable = await isInternetConnected();
    if ((isInternetAvailable ?? false) && loggedIn) {
      getBookMarkedPropertiesApiResponse =
          await GetBookMarkedPropertiesCall.call(
        userId: currentUserUid,
        locale: FFAppState().locale,
        authorazationToken: FFAppState().authToken,
        version: FFAppState().apiVersion,
      );
      isBookMarkedProperties = false;
      setState(() {});
      bookmarkedProperties = GetBookMarkedPropertiesCall.result(
        getBookMarkedPropertiesApiResponse?.jsonBody,
      ).toList();
    } else if ((!(isInternetAvailable ?? false)) && loggedIn) {
      isBookMarkedProperties = false;
      setState(() {});
      getBookMarkedPropertiesApiResponse = null;
      alertCalled++;
      setState(() {});
      if (alertCalled <= 1)
        showDialog(
          context: context,
          builder: (BuildContext context) => CommonAlertDialog(
            onCancel: () {
              Navigator.pop(context);
              alertCalled = 0;
              setState(() {});
            },
          ),
        );
    }
  }

  @override
  void dispose() {
    timerController.dispose();
    super.dispose();
  }

  Future<void> configurePaymentSdk() async {
    GoSellSdkFlutter.configureApp(
      bundleId: 'com.flutterflow.manzel',
      productionSecreteKey: 'sk_live_o4Z3j8HafuOCG9PNJ1eVrvsz',
      sandBoxsecretKey: 'sk_test_2r5JvPVafKxklSn6LRpqWycQ',
      lang: FFAppState().locale,
    );
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
            '21gpsvgr' /* Offers */,
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
        actions: [],
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!loggedIn)
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, height / 3, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.asset(
                              'assets/images/myPropertiesBooked.png',
                              width: 45,
                              height: 45,
                              fit: BoxFit.fill,
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 8, 10, 0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  'w4bgagrv' /* You need to create an account ... */,
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
                                  '9m2bglko' /* login to see this section */,
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
                            //           'MY_PROPERTIES_LOGIN_SIGNUP_BTN_ON_TAP');
                            //       logFirebaseEvent('Button_Navigate-To');
                            //
                            //       context.pushNamed('Login');
                            //     },
                            //     text: FFLocalizations.of(context).getText(
                            //       'yo5djc7x' /* Login/Signup */,
                            //     ),
                            //     options: FFButtonOptions(
                            //       width: 215,
                            //       height: 40,
                            //       color: FlutterFlowTheme.of(context).primaryColor,
                            //       textStyle: FlutterFlowTheme.of(context)
                            //           .subtitle2
                            //           .override(
                            //             fontFamily: 'AvenirArabic',
                            //             color:
                            //                 FlutterFlowTheme.of(context).white,
                            //             fontSize: 14,
                            //             useGoogleFonts: false,
                            //           ),
                            //       borderSide: BorderSide(
                            //         width: 1,
                            //         color: Colors.transparent,
                            //       ),
                            //       borderRadius: BorderRadius.circular(12),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (loggedIn)
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: FlutterFlowTheme.of(context).primaryColor,
                        unselectedLabelColor: Colors.black,
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyText1.override(
                                  fontFamily: 'AvenirArabic',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  useGoogleFonts: false,
                                ),
                        indicatorColor:
                            FlutterFlowTheme.of(context).primaryColor,
                        indicatorWeight: 3,
                        tabs: [
                          Tab(
                            text: FFLocalizations.of(context).getText(
                              'gl02050s' /* Booked */,
                            ),
                          ),
                          Tab(
                            text: FFLocalizations.of(context).getText(
                              '4uvlncbs' /* Favorite */,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            Builder(
                              builder: (context) {
                                if (isBookedPropertiesLoading) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: SpinKitRipple(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryColor,
                                        size: 50,
                                      ),
                                    ),
                                  );
                                }
                                else if (bookedProperties?.isEmpty ?? false) {
                                  return Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.6,
                                      child: NoResultsFoundWidget(
                                        titleText:
                                            functions.emptyListWidgetTitle(
                                                'bookedProperties',
                                                FFAppState().locale),
                                        subtitleText: functions.subTitleText(
                                            FFAppState().locale,
                                            'bookedProperties'),
                                        isButtonVisible: false,
                                        screenName: 'myPropertiesBooked',
                                      ),
                                    ),
                                  );
                                } else if ((bookedProperties != null) &&
                                    (bookedProperties?.isNotEmpty ?? false) &&
                                    bookedPropertiesApiResponse?.statusCode ==
                                        200) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    itemCount: bookedProperties?.length ?? 0,
                                    itemBuilder:
                                        (context, bookedPropertiesIndex) {
                                      final bookedPropertiesItem =
                                          bookedProperties?[
                                              bookedPropertiesIndex];
                                      var diffValue = (getJsonField(
                                            bookedPropertiesItem,
                                            r'''$.booking_expiry_date._seconds''',
                                          ) -
                                          ((DateTime.now()
                                                      .millisecondsSinceEpoch *
                                                  0.001)
                                              .toInt()));
                                      if (functions.conditionalVisibility(
                                          functions.myPropertiesBookedStatus(
                                              getJsonField(
                                                bookedPropertiesItem,
                                                r'''$.transaction_id''',
                                              ).toString(),
                                              getJsonField(
                                                bookedPropertiesItem,
                                                r'''$.order_status''',
                                              ).toString()),
                                          'pending_payment')) {
                                        timerController
                                          ..setPresetSecondTime(diffValue,
                                              add: false);
                                        timerController.onStartTimer();
                                      }
                                      print(
                                          ">>>>>>>>>>>>>>>>>>>>> diffTime = ${diffValue}");
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 23, 16, 1),
                                        child: InkWell(
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'MY_PROPERTIES_Container_mj6t37nu_ON_TAP');
                                            logFirebaseEvent(
                                                'Container_Navigate-To');

                                            context.pushNamed(
                                              'PropertyDetails',
                                              queryParams: {
                                                'propertyId': serializeParam(
                                                    getJsonField(
                                                      bookedPropertiesItem,
                                                      r'''$.property_id''',
                                                    ),
                                                    ParamType.int),
                                              }.withoutNulls,
                                            );
                                          },
                                          child: Container(
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 0,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .lineColor,
                                                  offset: Offset(0, 1),
                                                )
                                              ],
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 16),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 0, 12),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          child: Image.network(
                                                            valueOrDefault<
                                                                String>(
                                                              getJsonField(
                                                                bookedPropertiesItem,
                                                                r'''$.property_images[0].formats.medium.url''',
                                                              ),
                                                              'https://media.istockphoto.com/photos/luxurious-beautiful-modern-villa-with-front-yard-garden-picture-id1283532143?b=1&k=20&m=1283532143&s=170667a&w=0&h=Vd_WTUbHxnc_NZNwMr1UnS0xVW1FjtUxKJUtCoL4Fgk=',
                                                            ),
                                                            width: 80,
                                                            height: 75,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        13,
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
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          SingleChildScrollView(
                                                                        scrollDirection:
                                                                            Axis.horizontal,
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Row(children: [
                                                                              if (functions.conditionalVisibility(
                                                                                  getJsonField(
                                                                                    bookedPropertiesItem,
                                                                                    r'''$.order_status''',
                                                                                  ).toString(),
                                                                                  'offer_accepted'))
                                                                                Container(
                                                                                  width: 130,
                                                                                  height: 23,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(0xFF328B0B),
                                                                                    borderRadius: BorderRadius.circular(7),
                                                                                  ),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Text(
                                                                                        FFLocalizations.of(context).getText(
                                                                                          'sfs0xn10' /* Offer Accepted */,
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                              fontFamily: 'AvenirArabic',
                                                                                              color: FlutterFlowTheme.of(context).white,
                                                                                              fontSize: 12,
                                                                                              fontWeight: FontWeight.w500,
                                                                                              useGoogleFonts: false,
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              if (functions.conditionalVisibility(
                                                                                  getJsonField(
                                                                                    bookedPropertiesItem,
                                                                                    r'''$.order_status''',
                                                                                  ).toString(),
                                                                                  'waiting_offer_acceptance'))
                                                                                Container(
                                                                                  width: 202,
                                                                                  height: 23,
                                                                                  decoration: BoxDecoration(
                                                                                    color: FlutterFlowTheme.of(context).primaryOrange,
                                                                                    borderRadius: BorderRadius.circular(7),
                                                                                  ),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Text(
                                                                                        FFLocalizations.of(context).getText(
                                                                                          '55a9qb7p' /* Waiting for customer acceptanc... */,
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                              fontFamily: 'AvenirArabic',
                                                                                              color: FlutterFlowTheme.of(context).white,
                                                                                              fontSize: 12,
                                                                                              fontWeight: FontWeight.w500,
                                                                                              useGoogleFonts: false,
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              if (functions.conditionalVisibility(
                                                                                  getJsonField(
                                                                                    bookedPropertiesItem,
                                                                                    r'''$.order_status''',
                                                                                  ).toString(),
                                                                                  'collect_offers'))
                                                                                Container(
                                                                                  width: 98,
                                                                                  height: 23,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(0xFF41566C),
                                                                                    borderRadius: BorderRadius.circular(7),
                                                                                  ),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Text(
                                                                                        FFLocalizations.of(context).getText(
                                                                                          'hv5vj04i' /* Collect Offer */,
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                              fontFamily: 'AvenirArabic',
                                                                                              color: FlutterFlowTheme.of(context).white,
                                                                                              fontSize: 12,
                                                                                              fontWeight: FontWeight.w500,
                                                                                              useGoogleFonts: false,
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              if (functions.conditionalVisibility(
                                                                                  getJsonField(
                                                                                    bookedPropertiesItem,
                                                                                    r'''$.order_status''',
                                                                                  ).toString(),
                                                                                  'ownership_transferred'))
                                                                                Container(
                                                                                  width: 89,
                                                                                  height: 23,
                                                                                  decoration: BoxDecoration(
                                                                                    color: FlutterFlowTheme.of(context).secondaryGreen,
                                                                                    borderRadius: BorderRadius.circular(7),
                                                                                  ),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Text(
                                                                                        FFLocalizations.of(context).getText(
                                                                                          'r3xdvf7i' /* Completed */,
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                              fontFamily: 'AvenirArabic',
                                                                                              color: FlutterFlowTheme.of(context).white,
                                                                                              fontSize: 12,
                                                                                              fontWeight: FontWeight.w500,
                                                                                              useGoogleFonts: false,
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              if (functions.conditionalVisibility(
                                                                                  functions.myPropertiesBookedStatus(
                                                                                      getJsonField(
                                                                                        bookedPropertiesItem,
                                                                                        r'''$.transaction_id''',
                                                                                      ).toString(),
                                                                                      getJsonField(
                                                                                        bookedPropertiesItem,
                                                                                        r'''$.order_status''',
                                                                                      ).toString()),
                                                                                  'pending_payment'))
                                                                                Container(
                                                                                  width: 125,
                                                                                  height: 23,
                                                                                  decoration: BoxDecoration(
                                                                                    color: FlutterFlowTheme.of(context).primaryOrange,
                                                                                    borderRadius: BorderRadius.circular(7),
                                                                                  ),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Text(
                                                                                        FFLocalizations.of(context).getText(
                                                                                          '0pgvkbhl' /* Pending Payment */,
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                              fontFamily: 'AvenirArabic',
                                                                                              color: FlutterFlowTheme.of(context).white,
                                                                                              fontSize: 12,
                                                                                              fontWeight: FontWeight.w500,
                                                                                              useGoogleFonts: false,
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              if (functions.conditionalVisibility(
                                                                                  getJsonField(
                                                                                    bookedPropertiesItem,
                                                                                    r'''$.order_status''',
                                                                                  ).toString(),
                                                                                  'cancelled'))
                                                                                Container(
                                                                                  width: 74,
                                                                                  height: 23,
                                                                                  decoration: BoxDecoration(
                                                                                    color: FlutterFlowTheme.of(context).secondaryRed,
                                                                                    borderRadius: BorderRadius.circular(7),
                                                                                  ),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Text(
                                                                                        FFLocalizations.of(context).getText(
                                                                                          'cwzirftq' /* Cancelled */,
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                              fontFamily: 'AvenirArabic',
                                                                                              color: FlutterFlowTheme.of(context).white,
                                                                                              fontSize: 12,
                                                                                              fontWeight: FontWeight.w500,
                                                                                              useGoogleFonts: false,
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              if (functions.conditionalVisibility(
                                                                                  functions.myPropertiesBookedStatus(
                                                                                      getJsonField(
                                                                                        bookedPropertiesItem,
                                                                                        r'''$.transaction_id''',
                                                                                      ).toString(),
                                                                                      getJsonField(
                                                                                        bookedPropertiesItem,
                                                                                        r'''$.order_status''',
                                                                                      ).toString()),
                                                                                  'reserved'))
                                                                                Container(
                                                                                  width: 82,
                                                                                  height: 23,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(0xFF389688),
                                                                                    borderRadius: BorderRadius.circular(7),
                                                                                  ),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Text(
                                                                                        FFLocalizations.of(context).getText(
                                                                                          'ksi1ofk3' /* Reserved */,
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                              fontFamily: 'AvenirArabic',
                                                                                              color: FlutterFlowTheme.of(context).white,
                                                                                              fontSize: 12,
                                                                                              fontWeight: FontWeight.w500,
                                                                                              useGoogleFonts: false,
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              if (functions.conditionalVisibility(
                                                                                  getJsonField(
                                                                                    bookedPropertiesItem,
                                                                                    r'''$.order_status''',
                                                                                  ).toString(),
                                                                                  'disqualified'))
                                                                                Container(
                                                                                  width: 74,
                                                                                  height: 23,
                                                                                  decoration: BoxDecoration(
                                                                                    color: FlutterFlowTheme.of(context).secondaryRed,
                                                                                    borderRadius: BorderRadius.circular(7),
                                                                                  ),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Text(
                                                                                        FFLocalizations.of(context).getText(
                                                                                          '9svos0f4' /* Disqualified */,
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                              fontFamily: 'AvenirArabic',
                                                                                              color: FlutterFlowTheme.of(context).white,
                                                                                              fontSize: 12,
                                                                                              fontWeight: FontWeight.w500,
                                                                                              useGoogleFonts: false,
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              if (functions.conditionalVisibility(
                                                                                  getJsonField(
                                                                                    bookedPropertiesItem,
                                                                                    r'''$.order_status''',
                                                                                  ).toString(),
                                                                                  'expired'))
                                                                                Container(
                                                                                  width: 100,
                                                                                  height: 23,
                                                                                  decoration: BoxDecoration(
                                                                                    color: FlutterFlowTheme.of(context).secondaryRed,
                                                                                    borderRadius: BorderRadius.circular(7),
                                                                                  ),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Text(
                                                                                        FFLocalizations.of(context).getText(
                                                                                          '1ky73fb2' /* Expired */,
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                              fontFamily: 'AvenirArabic',
                                                                                              color: FlutterFlowTheme.of(context).white,
                                                                                              fontSize: 12,
                                                                                              fontWeight: FontWeight.w500,
                                                                                              useGoogleFonts: false,
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                            ]),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    if (functions.conditionalVisibility(
                                                                        functions.myPropertiesBookedStatus(
                                                                            getJsonField(
                                                                              bookedPropertiesItem,
                                                                              r'''$.transaction_id''',
                                                                            ).toString(),
                                                                            getJsonField(
                                                                              bookedPropertiesItem,
                                                                              r'''$.order_status''',
                                                                            ).toString()),
                                                                        'pending_payment'))
                                                                      Container(
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            Align(
                                                                              alignment: AlignmentDirectional(0, 0),
                                                                              child: StreamBuilder<int>(
                                                                                  stream: timerController.rawTime,
                                                                                  initialData: 10,
                                                                                  builder: (context, snap) {
                                                                                    final value = snap.data;
                                                                                    print(">>>>>>>>>>>>>>>>>>> value = ${value}");
                                                                                    print('${snap.data.runtimeType}');
                                                                                    if ((value ?? 0) <= 0) {
                                                                                      timerController.onStopTimer();
                                                                                      timerOver.value = false;
                                                                                    }
                                                                                    final displayTime = StopWatchTimer.getDisplayTime(
                                                                                      value ?? 0,
                                                                                      hours: true,
                                                                                      minute: true,
                                                                                      second: true,
                                                                                      milliSecond: false,
                                                                                    );

                                                                                    return timerOver.value
                                                                                        ? CircularPercentIndicator(
                                                                                            linearGradient: LinearGradient(begin: Alignment.centerRight, end: Alignment.centerLeft, colors: <Color>[
                                                                                              Color(0xFFFBE947),
                                                                                              Color(0xFFFF5A5A)
                                                                                            ]),
                                                                                            center: Text(
                                                                                              FFAppState().locale == 'en' ? '${displayTime}' : '${displayTime}',
                                                                                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                                    fontFamily: 'AvenirArabic',
                                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                                    fontSize: 6,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    useGoogleFonts: false,
                                                                                                  ),
                                                                                            ),
                                                                                            percent: remainingTime(
                                                                                                    getJsonField(
                                                                                                      bookedPropertiesItem,
                                                                                                      r'''$.booking_expiry_date._seconds''',
                                                                                                    ),
                                                                                                    getJsonField(
                                                                                                      bookedPropertiesItem,
                                                                                                      r'''$.created_at._seconds''',
                                                                                                    )) /
                                                                                                100,
                                                                                            radius: 17,
                                                                                            lineWidth: 4,
                                                                                            animation: false,
                                                                                            backgroundColor: FlutterFlowTheme.of(context).white,
                                                                                          )
                                                                                        : SizedBox.shrink();
                                                                                  }),
                                                                            ),
                                                                            Align(
                                                                              alignment: AlignmentDirectional(1, 1),
                                                                              child: ValueListenableBuilder<int>(
                                                                                builder: (BuildContext context, int value, Widget? child) {
                                                                                  return timerWidget(6000);
                                                                                },
                                                                                valueListenable: changeTimer,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          4,
                                                                          0,
                                                                          0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0,
                                                                                0,
                                                                                1,
                                                                                0),
                                                                            child:
                                                                                Text(
                                                                              FFLocalizations.of(context).getText(
                                                                                'tu9ytzrl' /* Booking ref:  */,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyText2.override(
                                                                                    fontFamily: 'AvenirArabic',
                                                                                    color: Color(0xFF6B6B6B),
                                                                                    fontSize: 13,
                                                                                    fontWeight: FontWeight.w300,
                                                                                    useGoogleFonts: false,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            functions.orderIdFormatter(getJsonField(
                                                                              bookedPropertiesItem,
                                                                              r'''$.order_id''',
                                                                            ).toString()),
                                                                            maxLines:
                                                                                2,
                                                                            style: FlutterFlowTheme.of(context).bodyText2.override(
                                                                                  fontFamily: 'AvenirArabic',
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.w300,
                                                                                  useGoogleFonts: false,
                                                                                ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        functions.myPropertiesFormatDate(
                                                                            getJsonField(
                                                                              bookedPropertiesItem,
                                                                              r'''$.created_at._seconds''',
                                                                            ),
                                                                            FFAppState().locale),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText2
                                                                            .override(
                                                                              fontFamily: 'AvenirArabic',
                                                                              fontSize: 13,
                                                                              fontWeight: FontWeight.w300,
                                                                              useGoogleFonts: false,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          2),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          getJsonField(
                                                                            bookedPropertiesItem,
                                                                            r'''$.property_name''',
                                                                          ).toString(),
                                                                          'null',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'AvenirArabic',
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.bold,
                                                                              useGoogleFonts: false,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              0,
                                                                              3,
                                                                              0),
                                                                      child:
                                                                          Icon(
                                                                        Manzel
                                                                            .location_pin,
                                                                        color: Colors
                                                                            .black,
                                                                        size:
                                                                            13,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        getJsonField(
                                                                          bookedPropertiesItem,
                                                                          r'''$.property_address''',
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
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w300,
                                                                            useGoogleFonts:
                                                                                false,
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
                                                          functions
                                                              .myPropertiesBookedStatus(
                                                                  getJsonField(
                                                                    bookedPropertiesItem,
                                                                    r'''$.transaction_id''',
                                                                  ).toString(),
                                                                  getJsonField(
                                                                    bookedPropertiesItem,
                                                                    r'''$.order_status''',
                                                                  ).toString()),
                                                          'pending_payment'))
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            width: 100,
                                                            height: 38,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              border: Border.all(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryColor),
                                                            ),
                                                            child: InkWell(
                                                              onTap: () async {
                                                                logFirebaseEvent(
                                                                    'MY_PROPERTIES_PAGE_Row_od4ycs47_ON_TAP');
                                                                logFirebaseEvent(
                                                                    'Row_Navigate-To');

                                                                context
                                                                    .pushNamed(
                                                                  'BookingDetails',
                                                                  queryParams: {
                                                                    'orderId': serializeParam(
                                                                        getJsonField(
                                                                          bookedPropertiesItem,
                                                                          r'''$.order_id''',
                                                                        ).toString(),
                                                                        ParamType.String),
                                                                  }.withoutNulls,
                                                                );
                                                              },
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      'j1l9ymld' /* View Details */,
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
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          useGoogleFonts:
                                                                              false,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        if (!functions
                                                            .myPropertiesViewOffersVisibility(
                                                                valueOrDefault<
                                                                    String>(
                                                          getJsonField(
                                                            bookedPropertiesItem,
                                                            r'''$.order_status''',
                                                          ).toString(),
                                                          'null',
                                                        )))
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          9,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              child:
                                                                  FFButtonWidget(
                                                                onPressed:
                                                                    () async {
                                                                  logFirebaseEvent(
                                                                      'MY_PROPERTIES_VIEW_OFFERS_BTN_ON_TAP');
                                                                  logFirebaseEvent(
                                                                      'Button_Navigate-To');

                                                                  context
                                                                      .pushNamed(
                                                                    'Offers',
                                                                    queryParams:
                                                                        {
                                                                      'propertyId': serializeParam(
                                                                          valueOrDefault<String>(
                                                                            getJsonField(
                                                                              bookedPropertiesItem,
                                                                              r'''$.property_id''',
                                                                            ).toString(),
                                                                            'null',
                                                                          ),
                                                                          ParamType.String),
                                                                    }.withoutNulls,
                                                                  );
                                                                },
                                                                text: FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'o7mo3ne7' /* View Offers */,
                                                                ),
                                                                options:
                                                                    FFButtonOptions(
                                                                  height: 38,
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          9,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  textStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtitle2
                                                                      .override(
                                                                        fontFamily:
                                                                            'AvenirArabic',
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        useGoogleFonts:
                                                                            false,
                                                                      ),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .transparent,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ValueListenableBuilder<bool>(
                                                    builder:
                                                        (BuildContext context,
                                                            bool value,
                                                            Widget? child) {
                                                      return Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          if (functions.conditionalVisibility(
                                                              functions.myPropertiesBookedStatus(
                                                                  getJsonField(
                                                                    bookedPropertiesItem,
                                                                    r'''$.transaction_id''',
                                                                  ).toString(),
                                                                  getJsonField(
                                                                    bookedPropertiesItem,
                                                                    r'''$.order_status''',
                                                                  ).toString()),
                                                              'pending_payment'))
                                                            Expanded(
                                                              child: timerOver
                                                                      .value
                                                                  ? FFButtonWidget(
                                                                      onPressed:
                                                                          () async {
                                                                        bool
                                                                            isInternetAvailable =
                                                                            await isInternetConnected();
                                                                        if (isInternetAvailable) {
                                                                          var addOrderApiResponse = await AddOrderCall.call(
                                                                              propertyId: getJsonField(
                                                                                bookedPropertiesItem,
                                                                                r'''$.property_id''',
                                                                              ).toString(),
                                                                              userId: currentUserReference?.id,
                                                                              authorazationToken: FFAppState().authToken,
                                                                              version: FFAppState().apiVersion);
                                                                          if ((addOrderApiResponse.statusCode ?? 398) ==
                                                                              398) {
                                                                            Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => ConfirmationWidget(
                                                                                  orderId: getJsonField(
                                                                                    bookedPropertiesItem,
                                                                                    r'''$.order_id''',
                                                                                  ).toString(),
                                                                                  transactionCase: 'SUCCESS',
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }
                                                                          else if(addOrderApiResponse.statusCode ==403){
                                                                            unAuthorizedUser(context, mounted);
                                                                          }
                                                                          else {
                                                                            await configurePaymentSdk();
                                                                            await showModalBottomSheet(
                                                                              isScrollControlled: true,
                                                                              backgroundColor: FlutterFlowTheme.of(context).white,
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return Padding(
                                                                                  padding: MediaQuery.of(context).viewInsets,
                                                                                  child: Container(
                                                                                    height: MediaQuery.of(context).size.height * 0.89,
                                                                                    child: ReservationBottomSheetWidget(
                                                                                      reservationCost: getJsonField(
                                                                                        bookedPropertiesItem,
                                                                                        r'''$.reservation_amount''',
                                                                                      ),
                                                                                      propertyId: functions.bookinPagePropertyIdToInt(getJsonField(
                                                                                        bookedPropertiesItem,
                                                                                        r'''$.property_id''',
                                                                                      ).toString()),
                                                                                      orderId: getJsonField(
                                                                                        bookedPropertiesItem,
                                                                                        r'''$.order_id''',
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ).then((value) =>
                                                                                setState(() {}));
                                                                          }
                                                                        } else {
                                                                          showDialog(
                                                                            context:
                                                                                context,
                                                                            builder: (BuildContext context) =>
                                                                                CommonAlertDialog(
                                                                              onCancel: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                            ),
                                                                          );
                                                                        }
                                                                      },
                                                                      text: FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        '6pr2fkpk' /* Pay now */,
                                                                      ),
                                                                      options:
                                                                          FFButtonOptions(
                                                                        width: double
                                                                            .infinity,
                                                                        height:
                                                                            38,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryColor,
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .subtitle2
                                                                            .override(
                                                                              fontFamily: 'AvenirArabic',
                                                                              color: Colors.white,
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w500,
                                                                              useGoogleFonts: false,
                                                                            ),
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.transparent,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                    )
                                                                  : SizedBox
                                                                      .shrink(),
                                                            ),
                                                        ],
                                                      );
                                                    },
                                                    valueListenable: timerOver,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else if(bookedPropertiesApiResponse
                                    ?.statusCode ==403){
                                  unAuthorizedUser(context, mounted);

                                }
                                else if (bookedPropertiesApiResponse
                                            ?.statusCode !=
                                        200 &&
                                    bookedPropertiesApiResponse?.statusCode !=
                                        null&&bookedPropertiesApiResponse
                                    ?.statusCode !=403) {
                                  return SomethingWentWrongWidget(
                                      onTryAgain: () {
                                    bookedPropertiesCall();
                                  });
                                }

                                return SizedBox();
                              },
                            ),
                            Builder(
                              builder: (context) {
                                if (isBookMarkedProperties) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: SpinKitRipple(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryColor,
                                        size: 50,
                                      ),
                                    ),
                                  );
                                } else if (bookmarkedProperties?.isEmpty ??
                                    false) {
                                  return Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      child: NoResultsFoundWidget(
                                        titleText:
                                            functions.emptyListWidgetTitle(
                                                'favorite',
                                                FFAppState().locale),
                                        subtitleText: functions.subTitleText(
                                            FFAppState().locale, 'favorite'),
                                        isButtonVisible: false,
                                        screenName: 'myPropertiesFavorite',
                                      ),
                                    ),
                                  );
                                } else if ((bookmarkedProperties != null) &&
                                    (bookmarkedProperties?.isNotEmpty ??
                                        false)) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    itemCount: bookmarkedProperties?.length,
                                    itemBuilder:
                                        (context, bookmarkedPropertiesIndex) {
                                      final bookmarkedPropertiesItem =
                                          bookmarkedProperties?[
                                              bookmarkedPropertiesIndex];
                                      return InkWell(
                                        onTap: () async {
                                          context.pushNamed(
                                            'PropertyDetails',
                                            queryParams: {
                                              'propertyId': serializeParam(
                                                  getJsonField(
                                                    bookmarkedPropertiesItem,
                                                    r'''$..property_id''',
                                                  ),
                                                  ParamType.int),
                                            }.withoutNulls,
                                          );
                                        },
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 23, 16, 0),
                                          child: Container(
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 20),
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
                                                                    0, 0, 0, 2),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          5,
                                                                          3,
                                                                          0),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6),
                                                                child: Image
                                                                    .network(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    getJsonField(
                                                                      bookmarkedPropertiesItem,
                                                                      r'''$..property_images[0].formats.medium.url''',
                                                                    ),
                                                                    'https://media.istockphoto.com/photos/house-in-dubai-picture-id490348444?k=20&m=490348444&s=612x612&w=0&h=HAhcenCKgOe5WQR3Ko514qWAkzHX3ugvlMpeKmUiStc=',
                                                                  ),
                                                                  width: 103,
                                                                  height: 75,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10,
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
                                                                  SizedBox(
                                                                    width: (MediaQuery.of(context)
                                                                            .size
                                                                            .width) /
                                                                        2,
                                                                    child: Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        getJsonField(
                                                                          bookmarkedPropertiesItem,
                                                                          r'''$.property_data.property_name''',
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
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            useGoogleFonts:
                                                                                false,
                                                                            lineHeight:
                                                                                1.25,
                                                                          ),
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            1,
                                                                            0,
                                                                            3,
                                                                            3),
                                                                        child:
                                                                            Icon(
                                                                          Manzel
                                                                              .location_pin,
                                                                          color:
                                                                              Colors.black,
                                                                          size:
                                                                              13,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 3),
                                                                        child:
                                                                            Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            getJsonField(
                                                                              bookmarkedPropertiesItem,
                                                                              r'''$.property_data.property_city''',
                                                                            ).toString(),
                                                                            'null',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'AvenirArabic',
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w300,
                                                                                useGoogleFonts: false,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'j1mv6jzk' /* ,  */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'AvenirArabic',
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w300,
                                                                              useGoogleFonts: false,
                                                                            ),
                                                                      ),
                                                                      Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          getJsonField(
                                                                            bookmarkedPropertiesItem,
                                                                            r'''$.property_data.property_district''',
                                                                          ).toString(),
                                                                          'null',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'AvenirArabic',
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w300,
                                                                              useGoogleFonts: false,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            13,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        SingleChildScrollView(
                                                                      scrollDirection:
                                                                          Axis.horizontal,
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                FFAppState().locale == 'en' ? 0 : 9,
                                                                                0,
                                                                                9,
                                                                                0),
                                                                            child:
                                                                                Icon(
                                                                              Manzel.bed,
                                                                              color: Colors.black,
                                                                              size: 10,
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                FFAppState().locale == 'en' ? 7 : 0,
                                                                                0,
                                                                                20,
                                                                                0),
                                                                            child:
                                                                                Text(
                                                                              valueOrDefault<String>(
                                                                                getJsonField(
                                                                                  bookmarkedPropertiesItem,
                                                                                  r'''$.property_data.property_bedrooms''',
                                                                                ).toString(),
                                                                                '0',
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                    color: Colors.black,
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    useGoogleFonts: false,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0,
                                                                                0,
                                                                                9,
                                                                                0),
                                                                            child:
                                                                                Icon(
                                                                              Manzel.bath,
                                                                              color: Colors.black,
                                                                              size: 16,
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0,
                                                                                0,
                                                                                20,
                                                                                0),
                                                                            child:
                                                                                Text(
                                                                              valueOrDefault<String>(
                                                                                getJsonField(
                                                                                  bookmarkedPropertiesItem,
                                                                                  r'''$.property_data.property_bathrooms''',
                                                                                ).toString(),
                                                                                '0',
                                                                              ),
                                                                              maxLines: 2,
                                                                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                    color: Colors.black,
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    useGoogleFonts: false,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0,
                                                                                0,
                                                                                9,
                                                                                0),
                                                                            child:
                                                                                Icon(
                                                                              Manzel.size,
                                                                              color: Colors.black,
                                                                              size: 16,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            valueOrDefault<String>(
                                                                              getJsonField(
                                                                                bookmarkedPropertiesItem,
                                                                                r'''$.property_data.property_size''',
                                                                              ).toString(),
                                                                              '0',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                  fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                  color: Colors.black,
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  useGoogleFonts: false,
                                                                                ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                4,
                                                                                0,
                                                                                4,
                                                                                0),
                                                                            child:
                                                                                Text(
                                                                              FFLocalizations.of(context).getText(
                                                                                '747xbn3l' /* sqm */,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                    fontFamily: 'AvenirArabic',
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    useGoogleFonts: false,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          logFirebaseEvent(
                                                              'view_cart');
                                                          logFirebaseEvent(
                                                              'MY_PROPERTIES_PAGE_Icon_0lkum35u_ON_TAP');
                                                          logFirebaseEvent(
                                                              'Icon_Backend-Call');
                                                          bookmarkApiResponse =
                                                              await BookmarkPropertyCall
                                                                  .call(
                                                            authorazationToken:
                                                                FFAppState()
                                                                    .authToken,
                                                            userId:
                                                                currentUserUid,
                                                            propertyId:
                                                                valueOrDefault<
                                                                    String>(
                                                              getJsonField(
                                                                bookmarkedPropertiesItem,
                                                                r'''$..property_id''',
                                                              ).toString(),
                                                              '0',
                                                            ),
                                                            version:
                                                                FFAppState()
                                                                    .apiVersion,
                                                          );
                                                          if ((bookmarkApiResponse?.statusCode) == 200) {
                                                            getBookMarkedPropertiesCall();
                                                            logFirebaseEvent(
                                                                'Icon_Show-Snack-Bar');
                                                            isInternetAvailable =
                                                                await isInternetConnected();
                                                            if (isInternetAvailable ??
                                                                false)
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    functions.snackBarMessage(
                                                                        'bookmarkRemoved',
                                                                        FFAppState()
                                                                            .locale),
                                                                    style:
                                                                        TextStyle(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16,
                                                                      height: 2,
                                                                    ),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          4000),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryGreen,
                                                                ),
                                                              );
                                                          }
                                                          else if((bookmarkApiResponse?.statusCode) == 403){
                                                            unAuthorizedUser(context,mounted);
                                                          }
                                                          else {
                                                            logFirebaseEvent(
                                                                'Icon_Show-Snack-Bar');
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  functions.snackBarMessage(
                                                                      'error',
                                                                      FFAppState()
                                                                          .locale),
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16,
                                                                    height: 2,
                                                                  ),
                                                                ),
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        4000),
                                                                backgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryRed,
                                                              ),
                                                            );
                                                          }

                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          width: 30,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0x4fFF0000),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Icon(
                                                            Manzel.favourite,
                                                            color: Colors.white,
                                                            size: 15,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  thickness: 1,
                                                  color: Color(0xFFECECEC),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else if (getBookMarkedPropertiesApiResponse?.statusCode == 403){
                                  unAuthorizedUser(context,mounted);
                                }
                                else if (getBookMarkedPropertiesApiResponse
                                            ?.statusCode !=
                                        200 &&
                                    getBookMarkedPropertiesApiResponse
                                            ?.statusCode !=
                                        null) {
                                  return SomethingWentWrongWidget(
                                      onTryAgain: () {
                                    getBookMarkedPropertiesCall();
                                  });
                                }

                                return SizedBox();
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget timerWidget(int duration) {
    return FlutterFlowTimer(
      timerValue: timerValue ??= StopWatchTimer.getDisplayTime(
        timerMilliseconds ??= duration,
        hours: true,
        minute: true,
        second: true,
        milliSecond: false,
      ),
      timer: timerController,
      //??= StopWatchTimer(
      //   mode: StopWatchMode.countDown,
      //   presetMillisecond: timerMilliseconds ??= duration,
      //   onChange: (value) {
      //     changeTimer.value += 1;
      //     changeText.value += 1;
      //     timerMilliseconds = value;
      //     timerValue = StopWatchTimer.getDisplayTime(
      //       value,
      //       hours: false,
      //       minute: false,
      //       second: true,
      //       milliSecond: false,
      //     );
      //   },
      // ),
      textAlign: TextAlign.start,
      style: FlutterFlowTheme.of(context).bodyText1.override(
            fontFamily: 'AvenirArabic',
            color: Colors.white.withOpacity(0),
            fontSize: 7,
            fontWeight: FontWeight.bold,
            useGoogleFonts: false,
          ),
      onEnded: () {},
    );
  }

  double remainingTime(int expiryDate, int createdAt) {
    double remaingValue =
        (expiryDate - (DateTime.now().millisecondsSinceEpoch * 0.001).toInt()) /
            (expiryDate - createdAt);
    if (remaingValue < 0) {
      return 0;
    }
    return remaingValue;
  }
}
