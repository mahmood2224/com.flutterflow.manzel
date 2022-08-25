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
  const MyPropertiesWidget({Key key}) : super(key: key);

  @override
  _MyPropertiesWidgetState createState() => _MyPropertiesWidgetState();
}

class _MyPropertiesWidgetState extends State<MyPropertiesWidget> {
  ApiCallResponse bookmarkApiResponse;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'MyProperties'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          FFLocalizations.of(context).getText(
            '21gpsvgr' /* My Properties */,
          ),
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Sofia Pro By Khuzaimah',
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w800,
                useGoogleFonts: false,
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (!loggedIn)
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 260, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        logFirebaseEvent('MY_PROPERTIES_PAGE_logIn_ON_TAP');
                        // login
                        logFirebaseEvent('logIn_login');
                        context.goNamed('Login');
                      },
                      text: FFLocalizations.of(context).getText(
                        '6silbaqf' /* Login */,
                      ),
                      options: FFButtonOptions(
                        width: 335,
                        height: 48,
                        color: Colors.white,
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Sofia Pro By Khuzaimah',
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  useGoogleFonts: false,
                                ),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
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
                            FutureBuilder<ApiCallResponse>(
                              future: BookedPropertiesCall.call(
                                userId: currentUserUid,
                                locale: FFAppState().locale,
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
                                final propertiesListBookedPropertiesResponse =
                                    snapshot.data;
                                return Builder(
                                  builder: (context) {
                                    final bookedProperties =
                                        BookedPropertiesCall.result(
                                      propertiesListBookedPropertiesResponse
                                          .jsonBody,
                                    ).toList();
                                    if (bookedProperties.isEmpty) {
                                      return Center(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.6,
                                          child: NoResultsFoundWidget(
                                            titleText:
                                                functions.emptyListWidgetTitle(
                                                    'bookedProperties',
                                                    FFAppState().locale),
                                            subtitleText:
                                                functions.subTitleText(
                                                    FFAppState().locale,
                                                    'bookedProperties'),
                                            isButtonVisible: true,
                                            screenName: 'myPropertiesBooked',
                                          ),
                                        ),
                                      );
                                    }
                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      itemCount: bookedProperties.length,
                                      itemBuilder:
                                          (context, bookedPropertiesIndex) {
                                        final bookedPropertiesItem =
                                            bookedProperties[
                                                bookedPropertiesIndex];
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
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
                                                  mainAxisSize:
                                                      MainAxisSize.max,
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
                                                                    .circular(
                                                                        5),
                                                            child:
                                                                Image.network(
                                                              valueOrDefault<
                                                                  String>(
                                                                getJsonField(
                                                                  bookedPropertiesItem,
                                                                  r'''$.property_images[0].url''',
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
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            2),
                                                                    child:
                                                                        SingleChildScrollView(
                                                                      scrollDirection:
                                                                          Axis.horizontal,
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
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
                                                                                color: Color(0xFFF0A637),
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
                                                                                color: Color(0xFF81D05C),
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
                                                                                color: Color(0xFFF0A637),
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
                                                                                color: Color(0xFFD05C5C),
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
                                                                                color: Color(0xFFD05C5C),
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
                                                                                color: Color(0xFFD05C5C),
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
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            9,
                                                                            0,
                                                                            4),
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
                                                                            Text(
                                                                              valueOrDefault<String>(
                                                                                getJsonField(
                                                                                  bookedPropertiesItem,
                                                                                  r'''$.order_id''',
                                                                                ).toString(),
                                                                                'null',
                                                                              ),
                                                                              maxLines: 2,
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
                                                                          functions
                                                                              .myPropertiesFormatDate(getJsonField(
                                                                            bookedPropertiesItem,
                                                                            r'''$.created_at._seconds''',
                                                                          )),
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
                                                                            4,
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
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            3,
                                                                            0),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .location_on_outlined,
                                                                          color:
                                                                              Colors.black,
                                                                          size:
                                                                              15,
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
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    if (!functions
                                                        .conditionalVisibility(
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
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                border:
                                                                    Border.all(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                ),
                                                              ),
                                                              child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  logFirebaseEvent(
                                                                      'MY_PROPERTIES_PAGE_Row_od4ycs47_ON_TAP');
                                                                  logFirebaseEvent(
                                                                      'Row_Navigate-To');
                                                                  context
                                                                      .pushNamed(
                                                                    'BookingDetails',
                                                                    queryParams:
                                                                        {
                                                                      'orderId': serializeParam(
                                                                          getJsonField(
                                                                            bookedPropertiesItem,
                                                                            r'''$.order_id''',
                                                                          ).toString(),
                                                                          ParamType.String),
                                                                      'orderStatus': serializeParam(
                                                                          valueOrDefault<String>(
                                                                            getJsonField(
                                                                              bookedPropertiesItem,
                                                                              r'''$.order_status''',
                                                                            ).toString(),
                                                                            'accepted',
                                                                          ),
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
                                                                          color:
                                                                              Colors.white,
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
                                                                            .circular(8),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    Row(
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
                                                            child:
                                                                FFButtonWidget(
                                                              onPressed:
                                                                  () async {
                                                                logFirebaseEvent(
                                                                    'MY_PROPERTIES_PAGE_PAY_NOW_BTN_ON_TAP');
                                                                logFirebaseEvent(
                                                                    'Button_Bottom-Sheet');
                                                                await showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .white,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return Padding(
                                                                      padding: MediaQuery.of(
                                                                              context)
                                                                          .viewInsets,
                                                                      child:
                                                                          Container(
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.89,
                                                                        child:
                                                                            ReservationBottomSheetWidget(
                                                                          reservationCost:
                                                                              getJsonField(
                                                                            bookedPropertiesItem,
                                                                            r'''$.reservation_amount''',
                                                                          ),
                                                                          propertyId:
                                                                              functions.bookinPagePropertyIdToInt(getJsonField(
                                                                            bookedPropertiesItem,
                                                                            r'''$.property_id''',
                                                                          ).toString()),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              text: FFLocalizations
                                                                      .of(context)
                                                                  .getText(
                                                                '6pr2fkpk' /* Pay now */,
                                                              ),
                                                              options:
                                                                  FFButtonOptions(
                                                                width: double
                                                                    .infinity,
                                                                height: 38,
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
                                                                          FontWeight
                                                                              .w500,
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
                                                      ],
                                                    ),
                                                  ],
                                                ),
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
                            FutureBuilder<ApiCallResponse>(
                              future: GetBookMarkedPropertiesCall.call(
                                userId: currentUserUid,
                                locale: FFAppState().locale,
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
                                final propertiesListGetBookMarkedPropertiesResponse =
                                    snapshot.data;
                                return Builder(
                                  builder: (context) {
                                    final bookmarkedProperties =
                                        GetBookMarkedPropertiesCall.result(
                                      propertiesListGetBookMarkedPropertiesResponse
                                          .jsonBody,
                                    ).toList();
                                    if (bookmarkedProperties.isEmpty) {
                                      return Center(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.4,
                                          child: NoResultsFoundWidget(
                                            titleText:
                                                functions.emptyListWidgetTitle(
                                                    'favorite',
                                                    FFAppState().locale),
                                            subtitleText:
                                                functions.subTitleText(
                                                    FFAppState().locale,
                                                    'favorite'),
                                            isButtonVisible: true,
                                            screenName: 'myPropertiesFavorite',
                                          ),
                                        ),
                                      );
                                    }
                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      itemCount: bookmarkedProperties.length,
                                      itemBuilder:
                                          (context, bookmarkedPropertiesIndex) {
                                        final bookmarkedPropertiesItem =
                                            bookmarkedProperties[
                                                bookmarkedPropertiesIndex];
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 23, 19, 0),
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
                                                                      r'''$.property_data.data.attributes.property_images.data[0].attributes.url''',
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
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          getJsonField(
                                                                            bookmarkedPropertiesItem,
                                                                            r'''$.property_data.property_name''',
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
                                                                              lineHeight: 2,
                                                                            ),
                                                                      ),
                                                                    ],
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
                                                                            0,
                                                                            3),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .location_on_outlined,
                                                                          color:
                                                                              Colors.black,
                                                                          size:
                                                                              15,
                                                                        ),
                                                                      ),
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
                                                                                0,
                                                                                0,
                                                                                9,
                                                                                0),
                                                                            child:
                                                                                Icon(
                                                                              Icons.single_bed,
                                                                              color: Colors.black,
                                                                              size: 20,
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
                                                                              Icons.bathtub_outlined,
                                                                              color: Colors.black,
                                                                              size: 20,
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
                                                                              Icons.design_services_outlined,
                                                                              color: Colors.black,
                                                                              size: 20,
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
                                                                          Text(
                                                                            FFLocalizations.of(context).getText(
                                                                              '747xbn3l' /*  sqm */,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                  fontFamily: 'AvenirArabic',
                                                                                  fontSize: 12,
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
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          logFirebaseEvent(
                                                              'MY_PROPERTIES_PAGE_Icon_0lkum35u_ON_TAP');
                                                          logFirebaseEvent(
                                                              'Icon_Backend-Call');
                                                          bookmarkApiResponse =
                                                              await BookmarkPropertyCall
                                                                  .call(
                                                            userId:
                                                                currentUserUid,
                                                            propertyId:
                                                                valueOrDefault<
                                                                    String>(
                                                              getJsonField(
                                                                bookmarkedPropertiesItem,
                                                                r'''$.property_data.data.id''',
                                                              ).toString(),
                                                              '0',
                                                            ),
                                                          );
                                                          if ((bookmarkApiResponse
                                                                      ?.statusCode ??
                                                                  200) ==
                                                              200) {
                                                            logFirebaseEvent(
                                                                'Icon_Show-Snack-Bar');
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
                                                                    Color(
                                                                        0xFF777777),
                                                              ),
                                                            );
                                                          } else {
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
                                                                    Color(
                                                                        0xFF676767),
                                                              ),
                                                            );
                                                          }

                                                          setState(() {});
                                                        },
                                                        child: Icon(
                                                          Icons
                                                              .bookmark_rounded,
                                                          color:
                                                              Color(0xFFD05C5C),
                                                          size: 24,
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
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
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
}
