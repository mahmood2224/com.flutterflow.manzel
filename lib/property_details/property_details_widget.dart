import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_static_map.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/lat_lng.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:map_launcher/map_launcher.dart' as $ml;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PropertyDetailsWidget extends StatefulWidget {
  const PropertyDetailsWidget({
    Key key,
    this.propertyId,
  }) : super(key: key);

  final int propertyId;

  @override
  _PropertyDetailsWidgetState createState() => _PropertyDetailsWidgetState();
}

class _PropertyDetailsWidgetState extends State<PropertyDetailsWidget> {
  PageController pageViewController;
  UserSavedRecord saveProperty;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'PropertyDetails'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: FutureBuilder<ApiCallResponse>(
          future: PropertyCall.call(
            propertyId: widget.propertyId,
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
            final columnPropertyResponse = snapshot.data;
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    height: 500,
                    child: Stack(
                      alignment: AlignmentDirectional(0, -1),
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 320, 0, 0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 700,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0),
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 16),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(16, 20, 16, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        14,
                                                                        0),
                                                            child: Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                PropertyCall
                                                                    .propertyRef(
                                                                  (columnPropertyResponse
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                ).toString(),
                                                                'Un-Known',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'Sofia Pro By Khuzaimah',
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    useGoogleFonts:
                                                                        false,
                                                                  ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        75,
                                                                        0),
                                                            child:
                                                                FFButtonWidget(
                                                              onPressed: () {
                                                                print(
                                                                    'propertyStatus pressed ...');
                                                              },
                                                              text: PropertyCall
                                                                  .propertyStatus(
                                                                (columnPropertyResponse
                                                                        ?.jsonBody ??
                                                                    ''),
                                                              ).toString(),
                                                              options:
                                                                  FFButtonOptions(
                                                                width: 80,
                                                                height: 26,
                                                                color: Color(
                                                                    0xFF81D05C),
                                                                textStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .subtitle2
                                                                    .override(
                                                                      fontFamily:
                                                                          'Sofia Pro By Khuzaimah',
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      useGoogleFonts:
                                                                          false,
                                                                    ),
                                                                elevation: 0,
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .transparent,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7),
                                                              ),
                                                              showLoadingIndicator:
                                                                  false,
                                                            ),
                                                          ),
                                                          Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              'ak0ss5un' /* Updated:  */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Sofia Pro By Khuzaimah',
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                          ),
                                                          Text(
                                                            PropertyCall
                                                                    .propertyUpdatedAt(
                                                              (columnPropertyResponse
                                                                      ?.jsonBody ??
                                                                  ''),
                                                            )
                                                                .toString()
                                                                .maybeHandleOverflow(
                                                                    maxChars:
                                                                        10),
                                                            maxLines: 2,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Sofia Pro By Khuzaimah',
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16, 0, 16, 0),
                                                      child: ListView(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        23,
                                                                        0,
                                                                        1),
                                                            child: Container(
                                                              width: 100,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    blurRadius:
                                                                        0,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .lineColor,
                                                                  )
                                                                ],
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            20),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30),
                                                                      child: Image
                                                                          .network(
                                                                        PropertyCall
                                                                            .companyLogo(
                                                                          (columnPropertyResponse?.jsonBody ??
                                                                              ''),
                                                                        ),
                                                                        width:
                                                                            46,
                                                                        height:
                                                                            46,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            13,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 9, 0, 4),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(0, 0.4),
                                                                                    child: Text(
                                                                                      FFLocalizations.of(context).getText(
                                                                                        'kqc4ney0' /* Property manage by  */,
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                            fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                            fontSize: 13,
                                                                                            fontWeight: FontWeight.w300,
                                                                                            useGoogleFonts: false,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 2),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Text(
                                                                                    PropertyCall.mangedBy(
                                                                                      (columnPropertyResponse?.jsonBody ?? ''),
                                                                                    ).toString(),
                                                                                    style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                          fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                          fontSize: 16,
                                                                                          fontWeight: FontWeight.bold,
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
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        10),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      PropertyCall
                                                                          .propertyName(
                                                                        (columnPropertyResponse?.jsonBody ??
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
                                                                              25,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          useGoogleFonts:
                                                                              false,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Row(
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
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            3),
                                                                    child: Icon(
                                                                      Icons
                                                                          .location_on_outlined,
                                                                      color: Colors
                                                                          .black,
                                                                      size: 15,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    PropertyCall
                                                                        .propertyCity(
                                                                      (columnPropertyResponse
                                                                              ?.jsonBody ??
                                                                          ''),
                                                                    ).toString(),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Sofia Pro By Khuzaimah',
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          useGoogleFonts:
                                                                              false,
                                                                        ),
                                                                  ),
                                                                  Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      '73rcbvl6' /* ,  */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Sofia Pro By Khuzaimah',
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          useGoogleFonts:
                                                                              false,
                                                                        ),
                                                                  ),
                                                                  Text(
                                                                    PropertyCall
                                                                        .propertyDistrict(
                                                                      (columnPropertyResponse
                                                                              ?.jsonBody ??
                                                                          ''),
                                                                    ).toString(),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
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
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        10,
                                                                        0,
                                                                        0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    PropertyCall
                                                                        .propertyDescription(
                                                                      (columnPropertyResponse
                                                                              ?.jsonBody ??
                                                                          ''),
                                                                    ).toString(),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
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
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        35,
                                                                        0,
                                                                        0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16,
                                                                            0,
                                                                            16,
                                                                            0),
                                                                    child:
                                                                        GridView(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      gridDelegate:
                                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                                        crossAxisCount:
                                                                            3,
                                                                        crossAxisSpacing:
                                                                            10,
                                                                        mainAxisSpacing:
                                                                            10,
                                                                        childAspectRatio:
                                                                            1,
                                                                      ),
                                                                      shrinkWrap:
                                                                          true,
                                                                      scrollDirection:
                                                                          Axis.vertical,
                                                                      children: [
                                                                        Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.single_bed,
                                                                              color: Colors.black,
                                                                              size: 24,
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Text(
                                                                                    valueOrDefault<String>(
                                                                                      PropertyCall.propertyBedrooms(
                                                                                        (columnPropertyResponse?.jsonBody ?? ''),
                                                                                      ).toString(),
                                                                                      'Un-Known',
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                          fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                          fontWeight: FontWeight.w300,
                                                                                          useGoogleFonts: false,
                                                                                        ),
                                                                                  ),
                                                                                  Text(
                                                                                    FFLocalizations.of(context).getText(
                                                                                      'd1l98zzs' /*  Bedrooms */,
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                          fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                          fontWeight: FontWeight.w300,
                                                                                          useGoogleFonts: false,
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.design_services_outlined,
                                                                              color: Colors.black,
                                                                              size: 24,
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Text(
                                                                                    valueOrDefault<String>(
                                                                                      PropertyCall.propertySize(
                                                                                        (columnPropertyResponse?.jsonBody ?? ''),
                                                                                      ).toString(),
                                                                                      'Un-Known',
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                          fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                          fontWeight: FontWeight.w300,
                                                                                          useGoogleFonts: false,
                                                                                        ),
                                                                                  ),
                                                                                  Text(
                                                                                    FFLocalizations.of(context).getText(
                                                                                      'swyvkhf5' /*  sqm */,
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                          fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                          fontWeight: FontWeight.w300,
                                                                                          useGoogleFonts: false,
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.bathtub_outlined,
                                                                              color: Colors.black,
                                                                              size: 24,
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Text(
                                                                                    valueOrDefault<String>(
                                                                                      PropertyCall.propertyBathrooms(
                                                                                        (columnPropertyResponse?.jsonBody ?? ''),
                                                                                      ).toString(),
                                                                                      'Un-Known',
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                          fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                          fontWeight: FontWeight.w300,
                                                                                          useGoogleFonts: false,
                                                                                        ),
                                                                                  ),
                                                                                  Text(
                                                                                    FFLocalizations.of(context).getText(
                                                                                      'gqq478h5' /*  Bathrooms */,
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                          fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                          fontWeight: FontWeight.w300,
                                                                                          useGoogleFonts: false,
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.house_outlined,
                                                                              color: Colors.black,
                                                                              size: 24,
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Text(
                                                                                    functions
                                                                                        .calculate(PropertyCall.propertyBuiltIn(
                                                                                          (columnPropertyResponse?.jsonBody ?? ''),
                                                                                        ).toString())
                                                                                        .toString(),
                                                                                    style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                          fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                          fontWeight: FontWeight.w300,
                                                                                          useGoogleFonts: false,
                                                                                        ),
                                                                                  ),
                                                                                  Text(
                                                                                    FFLocalizations.of(context).getText(
                                                                                      '7xi05192' /*  Years */,
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                          fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                          fontWeight: FontWeight.w300,
                                                                                          useGoogleFonts: false,
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.live_tv_rounded,
                                                                              color: Colors.black,
                                                                              size: 24,
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Text(
                                                                                    valueOrDefault<String>(
                                                                                      PropertyCall.propertyLivingrooms(
                                                                                        (columnPropertyResponse?.jsonBody ?? ''),
                                                                                      ).toString(),
                                                                                      'Un-Known',
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                          fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                          fontWeight: FontWeight.w300,
                                                                                          useGoogleFonts: false,
                                                                                        ),
                                                                                  ),
                                                                                  Text(
                                                                                    FFLocalizations.of(context).getText(
                                                                                      'u0xq15h6' /*  Livingrooms */,
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                          fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                          fontWeight: FontWeight.w300,
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
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Divider(
                                                thickness: 1,
                                                indent: 10,
                                                endIndent: 10,
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(16, 20, 0, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'nq19lw60' /* Features and Amenities */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Sofia Pro By Khuzaimah',
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            useGoogleFonts:
                                                                false,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(16, 17, 16, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '6brswcwm' /* Ref no. */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Sofia Pro By Khuzaimah',
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            useGoogleFonts:
                                                                false,
                                                          ),
                                                    ),
                                                    Text(
                                                      valueOrDefault<String>(
                                                        PropertyCall
                                                            .propertyRef(
                                                          (columnPropertyResponse
                                                                  ?.jsonBody ??
                                                              ''),
                                                        ).toString(),
                                                        'Un-Known',
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Sofia Pro By Khuzaimah',
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            useGoogleFonts:
                                                                false,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(16, 17, 16, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'ku7u4p9w' /* Floors */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Sofia Pro By Khuzaimah',
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            useGoogleFonts:
                                                                false,
                                                          ),
                                                    ),
                                                    Text(
                                                      valueOrDefault<String>(
                                                        PropertyCall
                                                            .propertyFloors(
                                                          (columnPropertyResponse
                                                                  ?.jsonBody ??
                                                              ''),
                                                        ).toString(),
                                                        'Un-Known',
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Sofia Pro By Khuzaimah',
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            useGoogleFonts:
                                                                false,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(16, 17, 16, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'vrdckjrg' /* Furnishing type */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Sofia Pro By Khuzaimah',
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            useGoogleFonts:
                                                                false,
                                                          ),
                                                    ),
                                                    Text(
                                                      valueOrDefault<String>(
                                                        PropertyCall
                                                            .propertyFurnishingType(
                                                          (columnPropertyResponse
                                                                  ?.jsonBody ??
                                                              ''),
                                                        ).toString(),
                                                        'Un-Known',
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Sofia Pro By Khuzaimah',
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            useGoogleFonts:
                                                                false,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(16, 17, 16, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'fk1mf2ip' /* Street width */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Sofia Pro By Khuzaimah',
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            useGoogleFonts:
                                                                false,
                                                          ),
                                                    ),
                                                    Text(
                                                      valueOrDefault<String>(
                                                        PropertyCall
                                                            .propertyStreetWidth(
                                                          (columnPropertyResponse
                                                                  ?.jsonBody ??
                                                              ''),
                                                        ).toString(),
                                                        'Un-Known',
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Sofia Pro By Khuzaimah',
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            useGoogleFonts:
                                                                false,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(16, 17, 16, 32),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'e52iigjz' /* Total Price */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Sofia Pro By Khuzaimah',
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            useGoogleFonts:
                                                                false,
                                                          ),
                                                    ),
                                                    Text(
                                                      valueOrDefault<String>(
                                                        PropertyCall
                                                            .propertyPrice(
                                                          (columnPropertyResponse
                                                                  ?.jsonBody ??
                                                              ''),
                                                        ).toString(),
                                                        'Un-Known',
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Sofia Pro By Khuzaimah',
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            useGoogleFonts:
                                                                false,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                thickness: 1,
                                                indent: 10,
                                                endIndent: 10,
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(16, 20, 16, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'fobsike6' /* Supported Banks */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Sofia Pro By Khuzaimah',
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            useGoogleFonts:
                                                                false,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(16, 19, 16, 30),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: 200,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                        ),
                                                        child: Builder(
                                                          builder: (context) {
                                                            final banks =
                                                                PropertyCall
                                                                        .banks(
                                                                      (columnPropertyResponse
                                                                              ?.jsonBody ??
                                                                          ''),
                                                                    )?.toList() ??
                                                                    [];
                                                            return ListView
                                                                .builder(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              primary: false,
                                                              shrinkWrap: true,
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              itemCount:
                                                                  banks.length,
                                                              itemBuilder:
                                                                  (context,
                                                                      banksIndex) {
                                                                final banksItem =
                                                                    banks[
                                                                        banksIndex];
                                                                return Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          2,
                                                                          2,
                                                                          2,
                                                                          2),
                                                                  child:
                                                                      InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      logFirebaseEvent(
                                                                          'PROPERTY_DETAILS_Container_94tgk0v4_ON_T');
                                                                      // bankDetails
                                                                      logFirebaseEvent(
                                                                          'Container_bankDetails');
                                                                      context
                                                                          .goNamed(
                                                                        'bankDetails',
                                                                        queryParams:
                                                                            {
                                                                          'propertyId': serializeParam(
                                                                              widget.propertyId,
                                                                              ParamType.int),
                                                                          'bankId': serializeParam(
                                                                              getJsonField(
                                                                                banksItem,
                                                                                r'''$.id''',
                                                                              ),
                                                                              ParamType.int),
                                                                        }.withoutNulls,
                                                                      );
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          123,
                                                                      height:
                                                                          177,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                Color(0x230F1113),
                                                                          )
                                                                        ],
                                                                        borderRadius:
                                                                            BorderRadius.circular(12),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              Color(0xFFF3F3F3),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                6,
                                                                                6,
                                                                                6,
                                                                                6),
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                              child: Image.network(
                                                                                getJsonField(
                                                                                  banksItem,
                                                                                  r'''$..bank_logo..alternativeText''',
                                                                                ),
                                                                                width: 111,
                                                                                height: 80,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                9,
                                                                                0,
                                                                                9,
                                                                                2),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    getJsonField(
                                                                                      banksItem,
                                                                                      r'''$..bank_name''',
                                                                                    ).toString(),
                                                                                    style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                          fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                          fontSize: 12,
                                                                                          fontWeight: FontWeight.bold,
                                                                                          useGoogleFonts: false,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                9,
                                                                                1,
                                                                                9,
                                                                                0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    getJsonField(
                                                                                      banksItem,
                                                                                      r'''$..bank_description''',
                                                                                    ).toString(),
                                                                                    style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                          fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                          fontSize: 12,
                                                                                          fontWeight: FontWeight.w300,
                                                                                          useGoogleFonts: false,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                9,
                                                                                9,
                                                                                9,
                                                                                0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    '1v1r516t' /* More Details */,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                        fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                        color: FlutterFlowTheme.of(context).primaryColor,
                                                                                        fontSize: 11,
                                                                                        fontWeight: FontWeight.bold,
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
                                                                );
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                thickness: 1,
                                                indent: 10,
                                                endIndent: 10,
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(16, 20, 16, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '8fdy3f5a' /* Location */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Sofia Pro By Khuzaimah',
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            useGoogleFonts:
                                                                false,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(16, 10, 16, 7),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      valueOrDefault<String>(
                                                        PropertyCall
                                                            .propertyEntranceDirection(
                                                          (columnPropertyResponse
                                                                  ?.jsonBody ??
                                                              ''),
                                                        ).toString(),
                                                        'Un-Known',
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Sofia Pro By Khuzaimah',
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            useGoogleFonts:
                                                                false,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(16, 7, 16, 16),
                                                child: Container(
                                                  width: 343,
                                                  height: 219,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFEEEEEE),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () async {
                                                            logFirebaseEvent(
                                                                'PROPERTY_DETAILS_StaticMap_xhp2s348_ON_T');
                                                            // OpenMap
                                                            logFirebaseEvent(
                                                                'StaticMap_OpenMap');
                                                            await launchMap(
                                                              mapType: $ml
                                                                  .MapType
                                                                  .google,
                                                              location: functions
                                                                  .propertyLocation(
                                                                      PropertyCall
                                                                          .propertyLat(
                                                                        (columnPropertyResponse?.jsonBody ??
                                                                            ''),
                                                                      ),
                                                                      PropertyCall
                                                                          .propertylng(
                                                                        (columnPropertyResponse?.jsonBody ??
                                                                            ''),
                                                                      )),
                                                              title: PropertyCall
                                                                  .propertyName(
                                                                (columnPropertyResponse
                                                                        ?.jsonBody ??
                                                                    ''),
                                                              ).toString(),
                                                            );
                                                          },
                                                          child:
                                                              FlutterFlowStaticMap(
                                                            location: functions
                                                                .propertyLocation(
                                                                    PropertyCall
                                                                        .propertyLat(
                                                                      (columnPropertyResponse
                                                                              ?.jsonBody ??
                                                                          ''),
                                                                    ),
                                                                    PropertyCall
                                                                        .propertylng(
                                                                      (columnPropertyResponse
                                                                              ?.jsonBody ??
                                                                          ''),
                                                                    )),
                                                            apiKey:
                                                                'pk.eyJ1IjoibWFuemVsIiwiYSI6ImNsNTB0NjI3YjA3OXQzYm9sdWNvM2Rrc2kifQ.zAYcxr9ozMoZfe4pEfxv7A',
                                                            style: MapBoxStyle
                                                                .Streets,
                                                            width: 300,
                                                            height: 300,
                                                            fit: BoxFit.cover,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            markerColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                            cached: true,
                                                            zoom: 14,
                                                            tilt: 0,
                                                            rotation: 0,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Material(
                                                color: Colors.transparent,
                                                elevation: 5,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(0),
                                                ),
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 90,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 4,
                                                        color:
                                                            Color(0x0E000000),
                                                        offset: Offset(0, -2),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, -0.35),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                16, 16, 16, 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            150,
                                                                            0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'i17ddd6l' /* Installment starting from */,
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
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          10,
                                                                          0,
                                                                          0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            AutoSizeText(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            PropertyCall.propertyInitialInstallment(
                                                                              (columnPropertyResponse?.jsonBody ?? ''),
                                                                            ).toString(),
                                                                            'Un-Known',
                                                                          ).maybeHandleOverflow(
                                                                              maxChars: 10),
                                                                          maxLines:
                                                                              1,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                color: FlutterFlowTheme.of(context).primaryColor,
                                                                                fontSize: 24,
                                                                                fontWeight: FontWeight.bold,
                                                                                useGoogleFonts: false,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            40,
                                                                            0),
                                                                        child:
                                                                            Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'mgi2d0o9' /* SAR/Monthly */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                color: FlutterFlowTheme.of(context).primaryColor,
                                                                                fontSize: 11,
                                                                                fontWeight: FontWeight.w500,
                                                                                useGoogleFonts: false,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      FFButtonWidget(
                                                                        onPressed:
                                                                            () async {
                                                                          logFirebaseEvent(
                                                                              'PROPERTY_DETAILS_PAGE_reserved_ON_TAP');
                                                                          // reserve
                                                                          logFirebaseEvent(
                                                                              'reserved_reserve');
                                                                          context
                                                                              .goNamed(
                                                                            'ReservationConfirmation',
                                                                            queryParams:
                                                                                {
                                                                              'propertyId': serializeParam(widget.propertyId, ParamType.int),
                                                                            }.withoutNulls,
                                                                          );
                                                                        },
                                                                        text: FFLocalizations.of(context)
                                                                            .getText(
                                                                          'dpmrt150' /* Reserve */,
                                                                        ),
                                                                        options:
                                                                            FFButtonOptions(
                                                                          width:
                                                                              140,
                                                                          height:
                                                                              56,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryColor,
                                                                          textStyle: FlutterFlowTheme.of(context)
                                                                              .subtitle2
                                                                              .override(
                                                                                fontFamily: 'Sofia Pro By Khuzaimah',
                                                                                color: Colors.white,
                                                                                fontSize: 18,
                                                                                fontWeight: FontWeight.w800,
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
                                                                              BorderRadius.circular(12),
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
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 340,
                          decoration: BoxDecoration(
                            color: Color(0x8D090F13),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.network(
                                getJsonField(
                                  (columnPropertyResponse?.jsonBody ?? ''),
                                  r'''$..images.data..attributes.name''',
                                ),
                              ).image,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Builder(
                                  builder: (context) {
                                    final images = PropertyCall.propertyImages(
                                          (columnPropertyResponse?.jsonBody ??
                                              ''),
                                        )?.toList() ??
                                        [];
                                    return Container(
                                      width: 375,
                                      height: 340,
                                      child: Stack(
                                        children: [
                                          PageView.builder(
                                            controller: pageViewController ??=
                                                PageController(
                                                    initialPage: min(
                                                        0, images.length - 1)),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: images.length,
                                            itemBuilder:
                                                (context, imagesIndex) {
                                              final imagesItem =
                                                  images[imagesIndex];
                                              return CachedNetworkImage(
                                                imageUrl: getJsonField(
                                                  imagesItem,
                                                  r'''$''',
                                                ),
                                                width: double.infinity,
                                                height: double.infinity,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0.9),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 10),
                                              child: SmoothPageIndicator(
                                                controller:
                                                    pageViewController ??=
                                                        PageController(
                                                            initialPage: min(
                                                                0,
                                                                images.length -
                                                                    1)),
                                                count: images.length,
                                                axisDirection: Axis.horizontal,
                                                onDotClicked: (i) {
                                                  pageViewController
                                                      .animateToPage(
                                                    i,
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.ease,
                                                  );
                                                },
                                                effect: ExpandingDotsEffect(
                                                  expansionFactor: 2,
                                                  spacing: 8,
                                                  radius: 16,
                                                  dotWidth: 8,
                                                  dotHeight: 8,
                                                  dotColor: Color(0xFF9E9E9E),
                                                  activeDotColor:
                                                      Color(0xFF3F51B5),
                                                  paintStyle:
                                                      PaintingStyle.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(18, 52, 18, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 30,
                                    buttonSize: 34,
                                    fillColor: Colors.white,
                                    icon: Icon(
                                      Icons.arrow_back_rounded,
                                      color: Colors.black,
                                      size: 18,
                                    ),
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'PROPERTY_DETAILS_arrow_back_rounded_ICN_');
                                      // back
                                      logFirebaseEvent('IconButton_back');
                                      context.pop();
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 16, 0),
                                    child: FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 30,
                                      buttonSize: 34,
                                      fillColor: Colors.white,
                                      icon: Icon(
                                        Icons.share_outlined,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                      onPressed: () async {
                                        logFirebaseEvent(
                                            'PROPERTY_DETAILS_PAGE_share_ON_TAP');
                                        // shareProperty
                                        logFirebaseEvent('share_shareProperty');
                                        await Share.share(
                                            'manzel://manzel.com${GoRouter.of(context).location}');
                                      },
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: 30,
                                        buttonSize: 34,
                                        fillColor: Colors.white,
                                        icon: Icon(
                                          Icons.favorite_border,
                                          color: Colors.black,
                                          size: 18,
                                        ),
                                        onPressed: () async {
                                          logFirebaseEvent(
                                              'PROPERTY_DETAILS_favorite_border_ICN_ON_');
                                          // save
                                          logFirebaseEvent('IconButton_save');

                                          final userSavedCreateData =
                                              createUserSavedRecordData(
                                            uId: currentUserReference,
                                            pId: widget.propertyId,
                                          );
                                          var userSavedRecordReference =
                                              UserSavedRecord.collection.doc();
                                          await userSavedRecordReference
                                              .set(userSavedCreateData);
                                          saveProperty = UserSavedRecord
                                              .getDocumentFromData(
                                                  userSavedCreateData,
                                                  userSavedRecordReference);

                                          setState(() {});
                                        },
                                      ),
                                      FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: 30,
                                        borderWidth: 1,
                                        buttonSize: 34,
                                        fillColor: Colors.white,
                                        icon: Icon(
                                          Icons.favorite,
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          size: 18,
                                        ),
                                        onPressed: () {
                                          print('IconButton pressed ...');
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
