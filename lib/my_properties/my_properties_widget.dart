import '../auth/auth_util.dart';
import '../auth/firebase_user_provider.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../components/not_found_page_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class MyPropertiesWidget extends StatefulWidget {
  const MyPropertiesWidget({Key key}) : super(key: key);

  @override
  _MyPropertiesWidgetState createState() => _MyPropertiesWidgetState();
}

class _MyPropertiesWidgetState extends State<MyPropertiesWidget> {
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
            if (!(loggedIn) ?? true)
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
            if (loggedIn ?? true)
              Expanded(
                child: DefaultTabController(
                  length: 3,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: FlutterFlowTheme.of(context).primaryColor,
                        unselectedLabelColor: Colors.black,
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyText1.override(
                                  fontFamily: 'Sofia Pro By Khuzaimah',
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
                              'gl02050s' /* Purchased */,
                            ),
                          ),
                          Tab(
                            text: FFLocalizations.of(context).getText(
                              'mt7pfmk1' /* Reserved */,
                            ),
                          ),
                          Tab(
                            text: FFLocalizations.of(context).getText(
                              '4uvlncbs' /* Saved */,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            StreamBuilder<List<UserPropertiesRecord>>(
                              stream: queryUserPropertiesRecord(
                                queryBuilder: (userPropertiesRecord) =>
                                    userPropertiesRecord
                                        .where('u_id',
                                            isEqualTo: currentUserReference)
                                        .where('status',
                                            isEqualTo: 'purchased'),
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
                                List<UserPropertiesRecord>
                                    propertiesListUserPropertiesRecordList =
                                    snapshot.data;
                                if (propertiesListUserPropertiesRecordList
                                    .isEmpty) {
                                  return NotFoundPageWidget();
                                }
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      propertiesListUserPropertiesRecordList
                                          .length,
                                  itemBuilder: (context, propertiesListIndex) {
                                    final propertiesListUserPropertiesRecord =
                                        propertiesListUserPropertiesRecordList[
                                            propertiesListIndex];
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 23, 16, 1),
                                      child: FutureBuilder<ApiCallResponse>(
                                        future: PropertyCall.call(
                                          propertyId:
                                              propertiesListUserPropertiesRecord
                                                  .pId,
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
                                          final containerPropertyResponse =
                                              snapshot.data;
                                          return Container(
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
                                                  .fromSTEB(0, 0, 0, 20),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    child: Image.network(
                                                      PropertyCall.propertyImg(
                                                        (containerPropertyResponse
                                                                ?.jsonBody ??
                                                            ''),
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
                                                                  13, 0, 0, 0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          FFButtonWidget(
                                                            onPressed: () {
                                                              print(
                                                                  'status pressed ...');
                                                            },
                                                            text: PropertyCall
                                                                .propertyStatus(
                                                              (containerPropertyResponse
                                                                      ?.jsonBody ??
                                                                  ''),
                                                            ).toString(),
                                                            options:
                                                                FFButtonOptions(
                                                              width: 68,
                                                              height: 23,
                                                              color: Color(
                                                                  0xFF389688),
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtitle2
                                                                      .override(
                                                                        fontFamily:
                                                                            'Sofia Pro By Khuzaimah',
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12,
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
                                                                          7),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        9,
                                                                        0,
                                                                        4),
                                                            child: StreamBuilder<
                                                                List<
                                                                    OrdersRecord>>(
                                                              stream:
                                                                  queryOrdersRecord(
                                                                queryBuilder: (ordersRecord) => ordersRecord
                                                                    .where(
                                                                        'u_id',
                                                                        isEqualTo:
                                                                            currentUserReference)
                                                                    .where(
                                                                        'p_id',
                                                                        isEqualTo:
                                                                            PropertyCall.propertyId(
                                                                          (containerPropertyResponse?.jsonBody ??
                                                                              ''),
                                                                        )),
                                                                singleRecord:
                                                                    true,
                                                              ),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width: 50,
                                                                      height:
                                                                          50,
                                                                      child:
                                                                          SpinKitRipple(
                                                                        color: Color(
                                                                            0xFF2971FB),
                                                                        size:
                                                                            50,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                List<OrdersRecord>
                                                                    rowOrdersRecordList =
                                                                    snapshot
                                                                        .data;
                                                                // Return an empty Container when the document does not exist.
                                                                if (snapshot
                                                                    .data
                                                                    .isEmpty) {
                                                                  return Container();
                                                                }
                                                                final rowOrdersRecord =
                                                                    rowOrdersRecordList
                                                                            .isNotEmpty
                                                                        ? rowOrdersRecordList
                                                                            .first
                                                                        : null;
                                                                return Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'tu9ytzrl' /* Booking ref:  */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText2
                                                                              .override(
                                                                                fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                color: Color(0xFF6B6B6B),
                                                                                fontSize: 13,
                                                                                fontWeight: FontWeight.w300,
                                                                                useGoogleFonts: false,
                                                                              ),
                                                                        ),
                                                                        Text(
                                                                          rowOrdersRecord
                                                                              .orderId
                                                                              .toString(),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText2
                                                                              .override(
                                                                                fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w300,
                                                                                useGoogleFonts: false,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Text(
                                                                      dateTimeFormat(
                                                                          'MMMMEEEEd',
                                                                          rowOrdersRecord
                                                                              .createdAt),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText2
                                                                          .override(
                                                                            fontFamily:
                                                                                'Sofia Pro By Khuzaimah',
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.w300,
                                                                            useGoogleFonts:
                                                                                false,
                                                                          ),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
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
                                                                    PropertyCall
                                                                        .propertyName(
                                                                      (containerPropertyResponse
                                                                              ?.jsonBody ??
                                                                          ''),
                                                                    ).toString(),
                                                                    'Un-Known',
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
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .location_on_outlined,
                                                                color: Colors
                                                                    .black,
                                                                size: 12,
                                                              ),
                                                              Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  PropertyCall
                                                                      .propertyCity(
                                                                    (containerPropertyResponse
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                  ).toString(),
                                                                  'Un-Known',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily:
                                                                          'Sofia Pro By Khuzaimah',
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      useGoogleFonts:
                                                                          false,
                                                                    ),
                                                              ),
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'kdwkp7d8' /*  , */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily:
                                                                          'Sofia Pro By Khuzaimah',
                                                                      fontSize:
                                                                          12,
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
                                                                  PropertyCall
                                                                      .propertyDistrict(
                                                                    (containerPropertyResponse
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                  ).toString(),
                                                                  'Un-Known',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily:
                                                                          'Sofia Pro By Khuzaimah',
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      useGoogleFonts:
                                                                          false,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        23,
                                                                        130,
                                                                        0),
                                                            child: InkWell(
                                                              onTap: () async {
                                                                logFirebaseEvent(
                                                                    'MY_PROPERTIES_PAGE_Row_q00zz4kt_ON_TAP');
                                                                // propertyDetails
                                                                logFirebaseEvent(
                                                                    'Row_propertyDetails');
                                                                context.goNamed(
                                                                  'PropertyDetails',
                                                                  queryParams: {
                                                                    'propertyId':
                                                                        serializeParam(
                                                                            PropertyCall.propertyId(
                                                                              (containerPropertyResponse?.jsonBody ?? ''),
                                                                            ),
                                                                            ParamType.int),
                                                                  }.withoutNulls,
                                                                );
                                                              },
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            5,
                                                                            0),
                                                                    child: Icon(
                                                                      Icons
                                                                          .sticky_note_2_outlined,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                      size: 15,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      'a2yvcqcr' /* View Details */,
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
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            StreamBuilder<List<UserPropertiesRecord>>(
                              stream: queryUserPropertiesRecord(
                                queryBuilder: (userPropertiesRecord) =>
                                    userPropertiesRecord
                                        .where('u_id',
                                            isEqualTo: currentUserReference)
                                        .where('status', isEqualTo: 'reserved'),
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
                                List<UserPropertiesRecord>
                                    propertiesListUserPropertiesRecordList =
                                    snapshot.data;
                                if (propertiesListUserPropertiesRecordList
                                    .isEmpty) {
                                  return NotFoundPageWidget();
                                }
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      propertiesListUserPropertiesRecordList
                                          .length,
                                  itemBuilder: (context, propertiesListIndex) {
                                    final propertiesListUserPropertiesRecord =
                                        propertiesListUserPropertiesRecordList[
                                            propertiesListIndex];
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 23, 16, 1),
                                      child: FutureBuilder<ApiCallResponse>(
                                        future: PropertyCall.call(
                                          propertyId:
                                              propertiesListUserPropertiesRecord
                                                  .pId,
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
                                          final containerPropertyResponse =
                                              snapshot.data;
                                          return Container(
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
                                                  .fromSTEB(0, 0, 0, 20),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    child: Image.network(
                                                      PropertyCall.propertyImg(
                                                        (containerPropertyResponse
                                                                ?.jsonBody ??
                                                            ''),
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
                                                                  13, 0, 0, 0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          FFButtonWidget(
                                                            onPressed: () {
                                                              print(
                                                                  'status pressed ...');
                                                            },
                                                            text: PropertyCall
                                                                .propertyStatus(
                                                              (containerPropertyResponse
                                                                      ?.jsonBody ??
                                                                  ''),
                                                            ).toString(),
                                                            options:
                                                                FFButtonOptions(
                                                              width: 68,
                                                              height: 23,
                                                              color: Color(
                                                                  0xFF389688),
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtitle2
                                                                      .override(
                                                                        fontFamily:
                                                                            'Sofia Pro By Khuzaimah',
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12,
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
                                                                          7),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        9,
                                                                        0,
                                                                        4),
                                                            child: StreamBuilder<
                                                                List<
                                                                    OrdersRecord>>(
                                                              stream:
                                                                  queryOrdersRecord(
                                                                queryBuilder: (ordersRecord) => ordersRecord
                                                                    .where(
                                                                        'u_id',
                                                                        isEqualTo:
                                                                            currentUserReference)
                                                                    .where(
                                                                        'p_id',
                                                                        isEqualTo:
                                                                            PropertyCall.propertyId(
                                                                          (containerPropertyResponse?.jsonBody ??
                                                                              ''),
                                                                        )),
                                                                singleRecord:
                                                                    true,
                                                              ),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width: 50,
                                                                      height:
                                                                          50,
                                                                      child:
                                                                          SpinKitRipple(
                                                                        color: Color(
                                                                            0xFF2971FB),
                                                                        size:
                                                                            50,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                List<OrdersRecord>
                                                                    rowOrdersRecordList =
                                                                    snapshot
                                                                        .data;
                                                                // Return an empty Container when the document does not exist.
                                                                if (snapshot
                                                                    .data
                                                                    .isEmpty) {
                                                                  return Container();
                                                                }
                                                                final rowOrdersRecord =
                                                                    rowOrdersRecordList
                                                                            .isNotEmpty
                                                                        ? rowOrdersRecordList
                                                                            .first
                                                                        : null;
                                                                return Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'ry827uul' /* Booking ref:  */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText2
                                                                              .override(
                                                                                fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                color: Color(0xFF6B6B6B),
                                                                                fontSize: 13,
                                                                                fontWeight: FontWeight.w300,
                                                                                useGoogleFonts: false,
                                                                              ),
                                                                        ),
                                                                        Text(
                                                                          rowOrdersRecord
                                                                              .orderId
                                                                              .toString(),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText2
                                                                              .override(
                                                                                fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w300,
                                                                                useGoogleFonts: false,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Text(
                                                                      dateTimeFormat(
                                                                          'MMMMEEEEd',
                                                                          rowOrdersRecord
                                                                              .createdAt),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText2
                                                                          .override(
                                                                            fontFamily:
                                                                                'Sofia Pro By Khuzaimah',
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.w300,
                                                                            useGoogleFonts:
                                                                                false,
                                                                          ),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
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
                                                                    PropertyCall
                                                                        .propertyName(
                                                                      (containerPropertyResponse
                                                                              ?.jsonBody ??
                                                                          ''),
                                                                    ).toString(),
                                                                    'Un-Known',
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
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .location_on_outlined,
                                                                color: Colors
                                                                    .black,
                                                                size: 12,
                                                              ),
                                                              Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  PropertyCall
                                                                      .propertyCity(
                                                                    (containerPropertyResponse
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                  ).toString(),
                                                                  'Un-Known',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily:
                                                                          'Sofia Pro By Khuzaimah',
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      useGoogleFonts:
                                                                          false,
                                                                    ),
                                                              ),
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'tjiw2bkf' /*  , */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily:
                                                                          'Sofia Pro By Khuzaimah',
                                                                      fontSize:
                                                                          12,
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
                                                                  PropertyCall
                                                                      .propertyDistrict(
                                                                    (containerPropertyResponse
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                  ).toString(),
                                                                  'Un-Known',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily:
                                                                          'Sofia Pro By Khuzaimah',
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      useGoogleFonts:
                                                                          false,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        23,
                                                                        130,
                                                                        0),
                                                            child: InkWell(
                                                              onTap: () async {
                                                                logFirebaseEvent(
                                                                    'MY_PROPERTIES_PAGE_Row_w6uilgsq_ON_TAP');
                                                                // propertyDetails
                                                                logFirebaseEvent(
                                                                    'Row_propertyDetails');
                                                                context.goNamed(
                                                                  'PropertyDetails',
                                                                  queryParams: {
                                                                    'propertyId':
                                                                        serializeParam(
                                                                            PropertyCall.propertyId(
                                                                              (containerPropertyResponse?.jsonBody ?? ''),
                                                                            ),
                                                                            ParamType.int),
                                                                  }.withoutNulls,
                                                                );
                                                              },
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            5,
                                                                            0),
                                                                    child: Icon(
                                                                      Icons
                                                                          .sticky_note_2_outlined,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                      size: 15,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      'zypmgjph' /* View Details */,
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
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            StreamBuilder<List<UserSavedRecord>>(
                              stream: queryUserSavedRecord(
                                queryBuilder: (userSavedRecord) =>
                                    userSavedRecord.where('u_id',
                                        isEqualTo: currentUserReference),
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
                                List<UserSavedRecord>
                                    propertiesListUserSavedRecordList =
                                    snapshot.data;
                                if (propertiesListUserSavedRecordList.isEmpty) {
                                  return NotFoundPageWidget();
                                }
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      propertiesListUserSavedRecordList.length,
                                  itemBuilder: (context, propertiesListIndex) {
                                    final propertiesListUserSavedRecord =
                                        propertiesListUserSavedRecordList[
                                            propertiesListIndex];
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 23, 16, 0),
                                      child: FutureBuilder<ApiCallResponse>(
                                        future: PropertyCall.call(
                                          propertyId:
                                              propertiesListUserSavedRecord.pId,
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
                                          final containerPropertyResponse =
                                              snapshot.data;
                                          return InkWell(
                                            onTap: () async {
                                              logFirebaseEvent(
                                                  'MY_PROPERTIES_Container_cr4pa5y7_ON_TAP');
                                              // propertyDetails
                                              logFirebaseEvent(
                                                  'Container_propertyDetails');
                                              context.goNamed(
                                                'PropertyDetails',
                                                queryParams: {
                                                  'propertyId': serializeParam(
                                                      PropertyCall.propertyId(
                                                        (containerPropertyResponse
                                                                ?.jsonBody ??
                                                            ''),
                                                      ),
                                                      ParamType.int),
                                                }.withoutNulls,
                                              );
                                            },
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
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 0, 20),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                              child:
                                                                  Image.network(
                                                                PropertyCall
                                                                    .propertyImg(
                                                                  (containerPropertyResponse
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                ),
                                                                width: 103,
                                                                height: 75,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 0, 2),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            15,
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
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              0,
                                                                              25,
                                                                              5),
                                                                          child:
                                                                              Text(
                                                                            valueOrDefault<String>(
                                                                              PropertyCall.propertyName(
                                                                                (containerPropertyResponse?.jsonBody ?? ''),
                                                                              ).toString(),
                                                                              'Un-Known',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                  fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                  fontSize: 16,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  useGoogleFonts: false,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              3),
                                                                          child:
                                                                              Icon(
                                                                            Icons.location_on_outlined,
                                                                            color:
                                                                                Colors.black,
                                                                            size:
                                                                                15,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            PropertyCall.propertyCity(
                                                                              (containerPropertyResponse?.jsonBody ?? ''),
                                                                            ).toString(),
                                                                            'Un-Known',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w300,
                                                                                useGoogleFonts: false,
                                                                              ),
                                                                        ),
                                                                        Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'j1mv6jzk' /*  , */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w300,
                                                                                useGoogleFonts: false,
                                                                              ),
                                                                        ),
                                                                        Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            PropertyCall.propertyDistrict(
                                                                              (containerPropertyResponse?.jsonBody ?? ''),
                                                                            ).toString(),
                                                                            'Un-Known',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Sofia Pro By Khuzaimah',
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
                                                                              15,
                                                                              0,
                                                                              0),
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
                                                                              size: 24,
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
                                                                                PropertyCall.propertyBedrooms(
                                                                                  (containerPropertyResponse?.jsonBody ?? ''),
                                                                                ).toString(),
                                                                                '?',
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                    color: Colors.black,
                                                                                    fontSize: 14,
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
                                                                              size: 24,
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
                                                                                PropertyCall.propertyBathrooms(
                                                                                  (containerPropertyResponse?.jsonBody ?? ''),
                                                                                ).toString(),
                                                                                '?',
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                    color: Colors.black,
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
                                                                              size: 24,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            valueOrDefault<String>(
                                                                              PropertyCall.propertySize(
                                                                                (containerPropertyResponse?.jsonBody ?? ''),
                                                                              ).toString(),
                                                                              '?',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                  fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                  color: Colors.black,
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
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
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
