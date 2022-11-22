import 'package:manzel/common_widgets/manzel_icons.dart';
import 'package:manzel/flutter_flow/custom_functions.dart';

import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../common_alert_dialog/common_alert_dialog.dart';
import '../components/no_result_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class PastOffersWidget extends StatefulWidget {
  const PastOffersWidget({Key? key}) : super(key: key);

  @override
  _PastOffersWidgetState createState() => _PastOffersWidgetState();
}

class _PastOffersWidgetState extends State<PastOffersWidget> {
  Completer<ApiCallResponse>? _apiRequestCompleter;
  ApiCallResponse? apiRequest;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List? allOffers;
  bool isLoading = true;
  bool? isInternetAvailable;

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'PastOffers'});
    apiRequestCompleterFunction();
  }
  Future<void> apiRequestCompleterFunction() async{
    isInternetAvailable = await isInternetConnected();
    if (isInternetAvailable ?? false) {
      apiRequest = await (_apiRequestCompleter ??= Completer<ApiCallResponse>()
        ..complete(ArchivedOffersCall.call(
          version: FFAppState().apiVersion,
          userId: currentUserUid,
          locale: FFAppState().locale,
          authorazationToken: FFAppState().authToken,
        )))
          .future;
      allOffers = ArchivedOffersCall.result(
        apiRequest?.jsonBody,
      ).toList();
      isLoading = false;
      setState(() {});
    }
    else{
      isLoading = false;
      setState((){});
      showDialog(
        context: context,
        builder: (BuildContext context) => CommonAlertDialog(
          onCancel: () {
            setState(() {});
            Navigator.pop(context);
          }, onSettings: () {  },
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(18, 9, 18, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFFF3F2F2),
                        ),
                      ),
                      child: InkWell(
                        onTap: () async {
                          logFirebaseEvent(
                              'PAST_OFFERS_PAGE_Icon_x76ofvg0_ON_TAP');
                          logFirebaseEvent('Icon_Close-Dialog,-Drawer,-Etc');
                          Navigator.pop(context);
                        },
                        child: RotatedBox(
                          quarterTurns: FFAppState().locale == 'en' ? 0 : 2,
                          child: Icon(
                            Manzel.back_icon,
                            color: Colors.black,
                            size: 14,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 34, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                'qvv3lsb7' /* Past Offers */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'AvenirArabic',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    useGoogleFonts: false,
                                    lineHeight: 2,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 17, 16, 0),
                  child: Builder(
                    builder: (context) {
                      // Customize what your widget looks like when it's loading.
                      if (isLoading) {
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
                      else if (allOffers?.isEmpty??false) {
                        return Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height:
                            MediaQuery.of(context).size.height * 0.6,
                            child: NoResultWidget(
                              titleText: functions.emptyListWidgetTitle(
                                  'pastOffers', FFAppState().locale),
                              screenName: 'offer',
                            ),
                          ),
                        );
                      }
                      else if((allOffers != null) &&
                          (allOffers?.isNotEmpty ?? false) &&
                          apiRequest?.statusCode ==
                              200){
                        return RefreshIndicator(
                          onRefresh: () async {
                            logFirebaseEvent(
                                'PAST_OFFERS_ListView_jjqn2huf_ON_PULL_TO');
                            logFirebaseEvent(
                                'ListView_Refresh-Database-Request');
                            setState(() => _apiRequestCompleter = null);
                            await waitForApiRequestCompleter();
                          },
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: allOffers?.length,
                            itemBuilder: (context, allOffersIndex) {
                              final allOffersItem = allOffers?[allOffersIndex];
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 8),
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
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Color(0xFFF1F1F1),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 12),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(0),
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          logFirebaseEvent(
                                              'PAST_OFFERS_PAGE_Column_zleebux1_ON_TAP');
                                          if (valueOrDefault(
                                              currentUserDocument?.status,
                                              '') ==
                                              'Active') {
                                            return;
                                          }

                                          if (FFAppState().locale == 'en') {
                                            logFirebaseEvent(
                                                'Column_Alert-Dialog');
                                            await showDialog(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: Text(
                                                      'Please get your account activated'),
                                                  content: Text(
                                                      'You are not an active user please connect admin for further details on ok logout user '),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext),
                                                      child: Text('Ok'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                            logFirebaseEvent('Column_Auth');
                                            GoRouter.of(context)
                                                .prepareAuthEvent();
                                            await signOut();
                                          } else {
                                            logFirebaseEvent(
                                                'Column_Alert-Dialog');
                                            await showDialog(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: Text(
                                                      'يرجى تفعيل حسابك'),
                                                  content: Text(
                                                      'أنت لست مستخدمًا نشطًا ، يرجى الاتصال بالمسؤول للحصول على مزيد من التفاصيل'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext),
                                                      child: Text('موافق'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                            logFirebaseEvent('Column_Auth');
                                            GoRouter.of(context)
                                                .prepareAuthEvent();
                                            await signOut();
                                          }

                                          context.goNamedAuth(
                                              'OnboardingView', mounted);
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(16, 16, 16, 16),
                                              child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                      context)
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
                                                          0, 0, 8, 0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(43),
                                                        child: Image.network(
                                                          getJsonField(
                                                            allOffersItem,
                                                            r'''$.bank_logo''',
                                                          ),
                                                          width: 43,
                                                          height: 43,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
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
                                                                    2,
                                                                    0),
                                                                child: Text(
                                                                  FFLocalizations.of(
                                                                      context)
                                                                      .getText(
                                                                    '3pqboynr' /* Offers  */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                      context)
                                                                      .bodyText1
                                                                      .override(
                                                                    fontFamily:
                                                                    'AvenirArabic',
                                                                    fontSize:
                                                                    12,
                                                                    useGoogleFonts:
                                                                    false,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                functions.orderIdFormatter(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      getJsonField(
                                                                        allOffersItem,
                                                                        r'''$.order_id''',
                                                                      ).toString(),
                                                                      '000000',
                                                                    )),
                                                                style: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodyText1
                                                                    .override(
                                                                  fontFamily:
                                                                  'AvenirArabic',
                                                                  fontSize:
                                                                  12,
                                                                  useGoogleFonts:
                                                                  false,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            valueOrDefault<
                                                                String>(
                                                              getJsonField(
                                                                allOffersItem,
                                                                r'''$.bank_name''',
                                                              ).toString(),
                                                              'null',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .bodyText1
                                                                .override(
                                                              fontFamily:
                                                              'AvenirArabic',
                                                              fontSize:
                                                              20,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
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
                                                              Text(
                                                                FFLocalizations.of(
                                                                    context)
                                                                    .getText(
                                                                  'mne0k69i' /* Last update:  */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodyText1
                                                                    .override(
                                                                  fontFamily:
                                                                  'AvenirArabic',
                                                                  color: Color(
                                                                      0xFF8C8C8C),
                                                                  fontSize:
                                                                  10,
                                                                  fontWeight:
                                                                  FontWeight.w500,
                                                                  useGoogleFonts:
                                                                  false,
                                                                ),
                                                              ),
                                                              Text(
                                                                functions
                                                                    .offerScreenTime(
                                                                    valueOrDefault<
                                                                        int>(
                                                                      getJsonField(
                                                                        allOffersItem,
                                                                        r'''$.created_at._seconds''',
                                                                      ),
                                                                      0,
                                                                    ),
                                                                    valueOrDefault<
                                                                        String>(
                                                                      FFAppState().locale,
                                                                      'en',
                                                                    )),
                                                                style: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodyText1
                                                                    .override(
                                                                  fontFamily:
                                                                  'AvenirArabic',
                                                                  color: Color(
                                                                      0xFF8C8C8C),
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
                                                      MainAxisSize.max,
                                                      children: [
                                                        if (functions
                                                            .conditionalVisibility(
                                                            valueOrDefault<
                                                                String>(
                                                              getJsonField(
                                                                allOffersItem,
                                                                r'''$.status''',
                                                              ).toString(),
                                                              'null',
                                                            ),
                                                            'accepted'))
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                0,
                                                                0,
                                                                0,
                                                                8),
                                                            child: Container(
                                                              width: 74,
                                                              height: 22,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Color(
                                                                    0xFF43B6A5),
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                                    FFLocalizations.of(
                                                                        context)
                                                                        .getText(
                                                                      '7r7omofu' /* Accepted */,
                                                                    ),
                                                                    textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                    style: FlutterFlowTheme.of(
                                                                        context)
                                                                        .bodyText1
                                                                        .override(
                                                                      fontFamily:
                                                                      'AvenirArabic',
                                                                      color:
                                                                      FlutterFlowTheme.of(context).white,
                                                                      fontSize:
                                                                      11,
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
                                                        if (functions
                                                            .conditionalVisibility(
                                                            valueOrDefault<
                                                                String>(
                                                              getJsonField(
                                                                allOffersItem,
                                                                r'''$.status''',
                                                              ).toString(),
                                                              'null',
                                                            ),
                                                            'expired'))
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                0,
                                                                0,
                                                                0,
                                                                8),
                                                            child: Container(
                                                              width: 74,
                                                              height: 22,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Color(
                                                                    0xFF444444),
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                                    FFLocalizations.of(
                                                                        context)
                                                                        .getText(
                                                                      'ftvaehka' /* Expired */,
                                                                    ),
                                                                    textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                    style: FlutterFlowTheme.of(
                                                                        context)
                                                                        .bodyText1
                                                                        .override(
                                                                      fontFamily:
                                                                      'AvenirArabic',
                                                                      color:
                                                                      FlutterFlowTheme.of(context).white,
                                                                      fontSize:
                                                                      11,
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
                                                        if (functions
                                                            .conditionalVisibility(
                                                            valueOrDefault<
                                                                String>(
                                                              getJsonField(
                                                                allOffersItem,
                                                                r'''$.status''',
                                                              ).toString(),
                                                              'null',
                                                            ),
                                                            'rejected'))
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                0,
                                                                0,
                                                                0,
                                                                8),
                                                            child: Container(
                                                              width: 74,
                                                              height: 22,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                    context)
                                                                    .secondaryRed,
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                                    FFLocalizations.of(
                                                                        context)
                                                                        .getText(
                                                                      'y5epausm' /* Rejected */,
                                                                    ),
                                                                    textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                    style: FlutterFlowTheme.of(
                                                                        context)
                                                                        .bodyText1
                                                                        .override(
                                                                      fontFamily:
                                                                      'AvenirArabic',
                                                                      color:
                                                                      FlutterFlowTheme.of(context).white,
                                                                      fontSize:
                                                                      11,
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
                                                        if (functions
                                                            .conditionalVisibility(
                                                            valueOrDefault<
                                                                String>(
                                                              getJsonField(
                                                                allOffersItem,
                                                                r'''$.status''',
                                                              ).toString(),
                                                              'null',
                                                            ),
                                                            'disqualified'))
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                0,
                                                                0,
                                                                0,
                                                                8),
                                                            child: Container(
                                                              width: 88,
                                                              height: 22,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                    context)
                                                                    .secondaryRed,
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                                    FFLocalizations.of(
                                                                        context)
                                                                        .getText(
                                                                      'dzlim6kq' /* Disqualified */,
                                                                    ),
                                                                    textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                    style: FlutterFlowTheme.of(
                                                                        context)
                                                                        .bodyText1
                                                                        .override(
                                                                      fontFamily:
                                                                      'AvenirArabic',
                                                                      color:
                                                                      FlutterFlowTheme.of(context).white,
                                                                      fontSize:
                                                                      11,
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
                                                        if (functions
                                                            .conditionalVisibility(
                                                            valueOrDefault<
                                                                String>(
                                                              getJsonField(
                                                                allOffersItem,
                                                                r'''$.status''',
                                                              ).toString(),
                                                              'null',
                                                            ),
                                                            'cancelled'))
                                                          Container(
                                                            width: 74,
                                                            height: 22,
                                                            decoration:
                                                            BoxDecoration(
                                                              color: FlutterFlowTheme.of(
                                                                  context)
                                                                  .secondaryRed,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
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
                                                                  FFLocalizations.of(
                                                                      context)
                                                                      .getText(
                                                                    '2h95uk6b' /* Canelled */,
                                                                  ),
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style: FlutterFlowTheme.of(
                                                                      context)
                                                                      .bodyText1
                                                                      .override(
                                                                    fontFamily:
                                                                    'AvenirArabic',
                                                                    color:
                                                                    FlutterFlowTheme.of(context).white,
                                                                    fontSize:
                                                                    11,
                                                                    fontWeight:
                                                                    FontWeight.w500,
                                                                    useGoogleFonts:
                                                                    false,
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
                                            Divider(
                                              thickness: 1,
                                              color: Color(0xFFF1F1F1),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(16, 18, 26, 16),
                                              child: Row(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                      MainAxisSize.max,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          FFLocalizations.of(
                                                              context)
                                                              .getText(
                                                            '6e3dl9a5' /* Property */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                              .of(context)
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
                                                              allOffersItem,
                                                              r'''$.property_name''',
                                                            ).toString(),
                                                            'null',
                                                          ),
                                                          style: FlutterFlowTheme
                                                              .of(context)
                                                              .bodyText1
                                                              .override(
                                                            fontFamily:
                                                            'AvenirArabic',
                                                            fontSize: 16,
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
                                                          5, 0, 0, 0),
                                                      child: Column(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            FFLocalizations.of(
                                                                context)
                                                                .getText(
                                                              'dcv75stq' /* Booking Ref. */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                .of(context)
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
                                                          Row(
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .max,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  functions
                                                                      .orderIdFormatter(
                                                                      getJsonField(
                                                                        allOffersItem,
                                                                        r'''$.order_id''',
                                                                      ).toString()),
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
                                                                    FontWeight.bold,
                                                                    useGoogleFonts:
                                                                    false,
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
                                            if (functions
                                                .pastOfferColumnVisibility(
                                                getJsonField(
                                                  allOffersItem,
                                                  r'''$.status''',
                                                ).toString(),
                                                getJsonField(
                                                  allOffersItem,
                                                  r'''$.offered_installment_period''',
                                                ).toString(),
                                                getJsonField(
                                                  allOffersItem,
                                                  r'''$.offered_installment_amount''',
                                                ).toString(),
                                                getJsonField(
                                                  allOffersItem,
                                                  r'''$.property_price''',
                                                ).toString(),
                                                getJsonField(
                                                  allOffersItem,
                                                  r'''$.agent_name''',
                                                ).toString()))
                                              Column(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(16, 0,
                                                        16, 16),
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
                                                                  'tpwleczh' /* Installment Amount */,
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
                                                                    .end,
                                                                children: [
                                                                  Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      functions
                                                                          .formatAmount(valueOrDefault<String>(
                                                                        getJsonField(
                                                                          allOffersItem,
                                                                          r'''$.offered_installment_amount''',
                                                                        ).toString(),
                                                                        '0',
                                                                      )),
                                                                      '0',
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
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        4,
                                                                        0,
                                                                        0,
                                                                        4),
                                                                    child:
                                                                    Text(
                                                                      FFLocalizations.of(context)
                                                                          .getText(
                                                                        '2szdgt5y' /* SAR */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(context)
                                                                          .bodyText1
                                                                          .override(
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
                                                                  'lastInstallment' /* Total price */,
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
                                                                    .end,
                                                                children: [
                                                                  Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      functions
                                                                          .formatAmount(valueOrDefault<String>(
                                                                        getJsonField(
                                                                          allOffersItem,
                                                                          r'''$.last_installment_amount''',
                                                                        ).toString(),
                                                                        '0',
                                                                      )),
                                                                      '0',
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                        context)
                                                                        .bodyText1
                                                                        .override(
                                                                      fontFamily:
                                                                      'AvenirArabic',
                                                                      fontSize:
                                                                      19,
                                                                      fontWeight:
                                                                      FontWeight.bold,
                                                                      useGoogleFonts:
                                                                      false,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        4,
                                                                        0,
                                                                        0,
                                                                        4),
                                                                    child:
                                                                    Text(
                                                                      FFLocalizations.of(context)
                                                                          .getText(
                                                                        'k4nw3frq' /* SAR */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(context)
                                                                          .bodyText1
                                                                          .override(
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
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(16, 0,
                                                        16, 18),
                                                    child: Row(
                                                      mainAxisSize:
                                                      MainAxisSize.max,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
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
                                                                    'yv9roric' /* Installment period */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                      context)
                                                                      .bodyText1
                                                                      .override(
                                                                    fontFamily:
                                                                    'AvenirArabic',
                                                                    color:
                                                                    Color(0xFF6B6B6B),
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
                                                                      .end,
                                                                  children: [
                                                                    Text(
                                                                      valueOrDefault<String>(
                                                                          getJsonField(
                                                                            allOffersItem,
                                                                            r'''$.offered_installment_period''',
                                                                          ).toString(),
                                                                          '0'),
                                                                      style: FlutterFlowTheme.of(context)
                                                                          .bodyText1
                                                                          .override(
                                                                        fontFamily: 'AvenirArabic',
                                                                        fontSize: 20,
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
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          '3v67jmtb' /* Month */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
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
                                                                  '3htsv7vx' /* Total price */,
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
                                                                    .end,
                                                                children: [
                                                                  Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      functions
                                                                          .formatAmount(valueOrDefault<String>(
                                                                        getJsonField(
                                                                          allOffersItem,
                                                                          r'''$.property_price''',
                                                                        ).toString(),
                                                                        '0',
                                                                      )),
                                                                      '0',
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                        context)
                                                                        .bodyText1
                                                                        .override(
                                                                      fontFamily:
                                                                      'AvenirArabic',
                                                                      fontSize:
                                                                      19,
                                                                      fontWeight:
                                                                      FontWeight.bold,
                                                                      useGoogleFonts:
                                                                      false,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        4,
                                                                        0,
                                                                        0,
                                                                        4),
                                                                    child:
                                                                    Text(
                                                                      FFLocalizations.of(context)
                                                                          .getText(
                                                                        'k4nw3frq' /* SAR */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(context)
                                                                          .bodyText1
                                                                          .override(
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
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return SizedBox();

                      //final listViewArchivedOffersResponse = snapshot.data!;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future waitForApiRequestCompleter({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = _apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
