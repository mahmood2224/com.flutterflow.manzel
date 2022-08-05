import '../auth/auth_util.dart';
import '../auth/firebase_user_provider.dart';
import '../backend/api_requests/api_calls.dart';
import '../components/no_result_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class OffersWidget extends StatefulWidget {
  const OffersWidget({
    Key key,
    this.propertyId,
  }) : super(key: key);

  final String propertyId;

  @override
  _OffersWidgetState createState() => _OffersWidgetState();
}

class _OffersWidgetState extends State<OffersWidget> {
  ApiCallResponse acceptOfferResponse;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('OFFERS_PAGE_Offers_ON_PAGE_LOAD');
      if (loggedIn) {
        if (valueOrDefault(currentUserDocument?.status, '') == 'Active') {
          return;
        }

        logFirebaseEvent('Offers_Alert-Dialog');
        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return AlertDialog(
              title: Text('Please get your account activated'),
              content: Text(
                  'You are not an active user please connect admin for further details on ok logout user '),
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
              title: Text('Please login'),
              content: Text('Please login with your credentials'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(alertDialogContext),
                  child: Text('Ok'),
                ),
              ],
            );
          },
        );
        logFirebaseEvent('Offers_Navigate-To');
        context.pushNamedAuth('Login', mounted);
      }
    });

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Offers'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Visibility(
            visible: loggedIn == true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 15, 16, 0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  'mthnzz7x' /* Offers */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .title2
                                    .override(
                                      fontFamily: 'Sofia Pro By Khuzaimah',
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800,
                                      useGoogleFonts: false,
                                    ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      'r282eka0' /* You have  */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Sofia Pro By Khuzaimah',
                                          fontSize: 16,
                                          useGoogleFonts: false,
                                        ),
                                  ),
                                  FutureBuilder<ApiCallResponse>(
                                    future: GetOffersCall.call(
                                      userId: currentUserUid,
                                      propertyId:
                                          functions.offerScreenPropertyIdisNull(
                                              widget.propertyId),
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: SpinKitRipple(
                                              color: Color(0xFF2971FB),
                                              size: 50,
                                            ),
                                          ),
                                        );
                                      }
                                      final textGetOffersResponse =
                                          snapshot.data;
                                      return Text(
                                        valueOrDefault<String>(
                                          functions.countJsonData(getJsonField(
                                            textGetOffersResponse.jsonBody,
                                            r'''$.result''',
                                          )),
                                          '0',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily:
                                                  'Sofia Pro By Khuzaimah',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              useGoogleFonts: false,
                                            ),
                                      );
                                    },
                                  ),
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      '9i2we2yx' /*  offers active */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Sofia Pro By Khuzaimah',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          useGoogleFonts: false,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (widget.propertyId != null &&
                            widget.propertyId != '')
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 25,
                            borderWidth: 1,
                            buttonSize: 60,
                            icon: Icon(
                              Icons.clear,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 25,
                            ),
                            onPressed: () async {
                              logFirebaseEvent('OFFERS_PAGE_clear_ICN_ON_TAP');
                              logFirebaseEvent(
                                  'IconButton_Close-Dialog,-Drawer,-Etc');
                              Navigator.pop(context);
                            },
                          ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                          child: FutureBuilder<ApiCallResponse>(
                            future: GetOffersCall.call(
                              userId: currentUserUid,
                              propertyId: functions.offerScreenPropertyIdisNull(
                                  widget.propertyId),
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: SpinKitRipple(
                                      color: Color(0xFF2971FB),
                                      size: 50,
                                    ),
                                  ),
                                );
                              }
                              final listViewGetOffersResponse = snapshot.data;
                              return Builder(
                                builder: (context) {
                                  final activeOffers = GetOffersCall.result(
                                    listViewGetOffersResponse.jsonBody,
                                  ).toList();
                                  if (activeOffers.isEmpty) {
                                    return Center(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.6,
                                        child: NoResultWidget(
                                          titleText: 'No offers added yet',
                                          screenName: 'offer',
                                        ),
                                      ),
                                    );
                                  }
                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: activeOffers.length,
                                    itemBuilder: (context, activeOffersIndex) {
                                      final activeOffersItem =
                                          activeOffers[activeOffersIndex];
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
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
                                          child: InkWell(
                                            onTap: () async {
                                              logFirebaseEvent(
                                                  'OFFERS_PAGE_Column_wm4v6ku0_ON_TAP');
                                              if (valueOrDefault(
                                                      currentUserDocument
                                                          ?.status,
                                                      '') ==
                                                  'Active') {
                                                return;
                                              }

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
                                                                  .fromSTEB(0,
                                                                      0, 8, 0),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        43),
                                                            child:
                                                                Image.network(
                                                              getJsonField(
                                                                activeOffersItem,
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
                                                                  Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      't2kwojss' /* Offers # */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Sofia Pro By Khuzaimah',
                                                                          fontSize:
                                                                              12,
                                                                          useGoogleFonts:
                                                                              false,
                                                                        ),
                                                                  ),
                                                                  Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      getJsonField(
                                                                        activeOffersItem,
                                                                        r'''$.order_id''',
                                                                      ).toString(),
                                                                      '0000000000',
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Sofia Pro By Khuzaimah',
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
                                                                          'Sofia Pro By Khuzaimah',
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
                                                                      'n5d3s79r' /* Last update:  */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Sofia Pro By Khuzaimah',
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
                                                                  Text(
                                                                    functions.offerScreenTime(
                                                                        valueOrDefault<int>(
                                                                          getJsonField(
                                                                            activeOffersItem,
                                                                            r'''$.created_at._seconds''',
                                                                          ),
                                                                          0,
                                                                        ),
                                                                        valueOrDefault<String>(
                                                                          FFAppState()
                                                                              .locale,
                                                                          'en',
                                                                        )),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Sofia Pro By Khuzaimah',
                                                                          color:
                                                                              Color(0xFF2971FB),
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
                                                                        activeOffersItem,
                                                                        r'''$.status''',
                                                                      ).toString(),
                                                                      'null',
                                                                    ),
                                                                    'new'))
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
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
                                                                          'lre09mx2' /* New Offer */,
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Sofia Pro By Khuzaimah',
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
                                                                        'nu7aeeks' /* Pending */,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText1
                                                                          .override(
                                                                            fontFamily:
                                                                                'Sofia Pro By Khuzaimah',
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
                                                        CrossAxisAlignment
                                                            .start,
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
                                                                'np7vw75o' /* Property */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'Sofia Pro By Khuzaimah',
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
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'Sofia Pro By Khuzaimah',
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
                                                                'vs0xmudi' /* Booking Ref. */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'Sofia Pro By Khuzaimah',
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
                                                                Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    '2bmjizhc' /* # */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyText1
                                                                      .override(
                                                                        fontFamily:
                                                                            'Sofia Pro By Khuzaimah',
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        useGoogleFonts:
                                                                            false,
                                                                      ),
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      getJsonField(
                                                                        activeOffersItem,
                                                                        r'''$.id''',
                                                                      ).toString(),
                                                                      '0',
                                                                    ),
                                                                    maxLines: 2,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Sofia Pro By Khuzaimah',
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
                                                                      'ez8wbssn' /* Initial installment */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Sofia Pro By Khuzaimah',
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
                                                                        valueOrDefault<
                                                                            String>(
                                                                          functions
                                                                              .formatAmount(valueOrDefault<String>(
                                                                            getJsonField(
                                                                              activeOffersItem,
                                                                              r'''$.offered_installment_amount''',
                                                                            ).toString(),
                                                                            '0',
                                                                          )),
                                                                          '0',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Sofia Pro By Khuzaimah',
                                                                              fontSize: 19,
                                                                              fontWeight: FontWeight.bold,
                                                                              useGoogleFonts: false,
                                                                            ),
                                                                      ),
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'ldwv6qbd' /* .00 */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Sofia Pro By Khuzaimah',
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
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'z7x7wv59' /* SAR */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Sofia Pro By Khuzaimah',
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
                                                                        '4ha591ne' /* Installment period */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText1
                                                                          .override(
                                                                            fontFamily:
                                                                                'Sofia Pro By Khuzaimah',
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
                                                                          valueOrDefault<
                                                                              String>(
                                                                            getJsonField(
                                                                              activeOffersItem,
                                                                              r'''$.offered_installment_period''',
                                                                            ).toString(),
                                                                            '0',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Sofia Pro By Khuzaimah',
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
                                                                                  fontFamily: 'Sofia Pro By Khuzaimah',
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
                                                                      '2kxnix92' /* Total price */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Sofia Pro By Khuzaimah',
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
                                                                        valueOrDefault<
                                                                            String>(
                                                                          functions
                                                                              .formatAmount(valueOrDefault<String>(
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
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Sofia Pro By Khuzaimah',
                                                                              fontSize: 19,
                                                                              fontWeight: FontWeight.bold,
                                                                              useGoogleFonts: false,
                                                                            ),
                                                                      ),
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'c0ty6rbh' /* .00 */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Sofia Pro By Khuzaimah',
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
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'h47bvnhi' /* SAR */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Sofia Pro By Khuzaimah',
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
                                                                        'wxex1r7b' /* Agent Name */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText1
                                                                          .override(
                                                                            fontFamily:
                                                                                'Sofia Pro By Khuzaimah',
                                                                            color:
                                                                                Color(0xFF6B6B6B),
                                                                            fontWeight:
                                                                                FontWeight.w300,
                                                                            useGoogleFonts:
                                                                                false,
                                                                          ),
                                                                    ),
                                                                    Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        getJsonField(
                                                                          activeOffersItem,
                                                                          r'''$.agent_name''',
                                                                        ).toString(),
                                                                        'null',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText1
                                                                          .override(
                                                                            fontFamily:
                                                                                'Sofia Pro By Khuzaimah',
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            useGoogleFonts:
                                                                                false,
                                                                          ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
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
                                                            if (functions
                                                                .chatButtonVisibility(
                                                                    getJsonField(
                                                              activeOffersItem,
                                                              r'''$.status''',
                                                            ).toString()))
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            8),
                                                                child:
                                                                    Container(
                                                                  width: 100,
                                                                  height: 42,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
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
                                                                          'pasrxjal' /* Chat with  */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Sofia Pro By Khuzaimah',
                                                                              color: FlutterFlowTheme.of(context).white,
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w500,
                                                                              useGoogleFonts: false,
                                                                            ),
                                                                      ),
                                                                      Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          getJsonField(
                                                                            activeOffersItem,
                                                                            r'''$.agent_name''',
                                                                          ).toString(),
                                                                          'null',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Sofia Pro By Khuzaimah',
                                                                              color: FlutterFlowTheme.of(context).white,
                                                                              fontSize: 15,
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
                                                                    'new'))
                                                              Container(
                                                                width: 100,
                                                                height: 42,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  border: Border
                                                                      .all(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                  ),
                                                                ),
                                                                child: InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    logFirebaseEvent(
                                                                        'OFFERS_PAGE_Row_k1bql2go_ON_TAP');
                                                                    logFirebaseEvent(
                                                                        'Row_Alert-Dialog');
                                                                    var confirmDialogResponse =
                                                                        await showDialog<bool>(
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
                                                                      logFirebaseEvent(
                                                                          'Row_Backend-Call');
                                                                      acceptOfferResponse =
                                                                          await AcceptOfferCall
                                                                              .call(
                                                                        userId:
                                                                            currentUserUid,
                                                                        offerId:
                                                                            valueOrDefault<String>(
                                                                          getJsonField(
                                                                            activeOffersItem,
                                                                            r'''$.id''',
                                                                          ).toString(),
                                                                          'null',
                                                                        ),
                                                                      );
                                                                      if ((acceptOfferResponse?.statusCode ??
                                                                              200) ==
                                                                          200) {
                                                                        logFirebaseEvent(
                                                                            'Row_Show-Snack-Bar');
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          SnackBar(
                                                                            content:
                                                                                Text(
                                                                              'Offer accepted',
                                                                              style: TextStyle(
                                                                                color: FlutterFlowTheme.of(context).white,
                                                                                fontWeight: FontWeight.w800,
                                                                                fontSize: 18,
                                                                              ),
                                                                            ),
                                                                            duration:
                                                                                Duration(milliseconds: 4000),
                                                                            backgroundColor:
                                                                                Color(0xFFA5A5A5),
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        logFirebaseEvent(
                                                                            'Row_Show-Snack-Bar');
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          SnackBar(
                                                                            content:
                                                                                Text(
                                                                              'An error has occured',
                                                                              style: TextStyle(
                                                                                color: FlutterFlowTheme.of(context).white,
                                                                                fontWeight: FontWeight.w800,
                                                                                fontSize: 18,
                                                                              ),
                                                                            ),
                                                                            duration:
                                                                                Duration(milliseconds: 4000),
                                                                            backgroundColor:
                                                                                Color(0xFFA5A5A5),
                                                                          ),
                                                                        );
                                                                      }
                                                                    }

                                                                    setState(
                                                                        () {});
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
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'n6rgv2jr' /* Accept offer */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Sofia Pro By Khuzaimah',
                                                                              color: FlutterFlowTheme.of(context).primaryColor,
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w500,
                                                                              useGoogleFonts: false,
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
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 20, 16, 10),
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
                                    transitionType: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 0),
                                  ),
                                },
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              height: 52,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).white,
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
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        18, 0, 0, 0),
                                    child: Text(
                                      FFLocalizations.of(context).getText(
                                        '5gvwuuh2' /* Completed or canceled offers */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily:
                                                'Sofia Pro By Khuzaimah',
                                            color: Color(0xFF474747),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts: false,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 17, 0),
                                    child: Icon(
                                      Icons.keyboard_arrow_right,
                                      color: Colors.black,
                                      size: 24,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
