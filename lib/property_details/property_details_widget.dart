import 'package:go_sell_sdk_flutter/go_sell_sdk_flutter.dart';

import '../auth/auth_util.dart';
import '../auth/firebase_user_provider.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../components/bank_details_bottom_sheet_widget.dart';
import '../components/reservation_bottom_sheet_widget.dart';
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
  PageController pageViewController1;
  UserSavedRecord saveProperty;
  PageController pageViewController2;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'PropertyDetails'});
  }

  Future<void> configurePaymentSdk() async {

    GoSellSdkFlutter.configureApp(
        bundleId: 'com.flutterflow.manzel',
        productionSecreteKey: 'sk_live_o4Z3j8HafuOCG9PNJ1eVrvsz',
        sandBoxsecretKey: 'sk_test_2r5JvPVafKxklSn6LRpqWycQ',
        lang: FFAppState().locale,);
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
            final columnPropertyResponse = snapshot.data;
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Stack(
                          children: [
                            Stack(
                              children: [
                                Builder(
                                  builder: (context) {
                                    final images = PropertyCall.propertyImages(
                                      columnPropertyResponse.jsonBody,
                                    ).toList();
                                    return Container(
                                      width: double.infinity,
                                      height: 300,
                                      child: Stack(
                                        children: [
                                          PageView.builder(
                                            controller: pageViewController1 ??=
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
                                                  r'''$.attributes.url''',
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
                                                    pageViewController1 ??=
                                                        PageController(
                                                            initialPage: min(
                                                                0,
                                                                images.length -
                                                                    1)),
                                                count: images.length,
                                                axisDirection: Axis.horizontal,
                                                onDotClicked: (i) {
                                                  pageViewController1
                                                      .animateToPage(
                                                    i,
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.ease,
                                                  );
                                                },
                                                effect: SlideEffect(
                                                  spacing: 8,
                                                  radius: 16,
                                                  dotWidth: 6,
                                                  dotHeight: 6,
                                                  dotColor: Color(0xFF9E9E9E),
                                                  activeDotColor: Colors.white,
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
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      18, 52, 18, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 16, 0),
                                            child: FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30,
                                              buttonSize: 34,
                                              fillColor: Colors.white,
                                              icon: Icon(
                                                Icons.share_sharp,
                                                color: Colors.black,
                                                size: 18,
                                              ),
                                              onPressed: () async {
                                                logFirebaseEvent(
                                                    'PROPERTY_DETAILS_PAGE_share_ON_TAP');
                                                // shareProperty
                                                logFirebaseEvent(
                                                    'share_shareProperty');
                                                await Share.share(
                                                    'manzel://manzel.com${GoRouter.of(context).location}');
                                              },
                                            ),
                                          ),
                                          Stack(
                                            children: [
                                              FlutterFlowIconButton(
                                                borderColor: Colors.transparent,
                                                borderRadius: 30,
                                                borderWidth: 1,
                                                buttonSize: 34,
                                                fillColor: Colors.white,
                                                icon: Icon(
                                                  Icons.favorite,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                  size: 18,
                                                ),
                                                onPressed: () {
                                                  print(
                                                      'BookMarkedIconButton pressed ...');
                                                },
                                              ),
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
                                                  logFirebaseEvent(
                                                      'IconButton_save');

                                                  final userSavedCreateData =
                                                      createUserSavedRecordData(
                                                    uId: currentUserReference,
                                                    pId: widget.propertyId,
                                                  );
                                                  var userSavedRecordReference =
                                                      UserSavedRecord.collection
                                                          .doc();
                                                  await userSavedRecordReference
                                                      .set(userSavedCreateData);
                                                  saveProperty = UserSavedRecord
                                                      .getDocumentFromData(
                                                          userSavedCreateData,
                                                          userSavedRecordReference);

                                                  setState(() {});
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
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 280, 0, 0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0),
                                      topLeft: Radius.circular(17),
                                      topRight: Radius.circular(17),
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
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 20, 16, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'tpufujg8' /* # */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'AvenirArabic',
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            useGoogleFonts:
                                                                false,
                                                          ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 14, 0),
                                                      child: Text(
                                                        PropertyCall
                                                            .propertyRef(
                                                          columnPropertyResponse
                                                              .jsonBody,
                                                        ).toString(),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Sofia Pro By Khuzaimah',
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                      ),
                                                    ),
                                                    FFButtonWidget(
                                                      onPressed: () {
                                                        print(
                                                            'propertyStatus pressed ...');
                                                      },
                                                      text: PropertyCall
                                                          .propertyStatus(
                                                        columnPropertyResponse
                                                            .jsonBody,
                                                      ).toString(),
                                                      options: FFButtonOptions(
                                                        height: 26,
                                                        color:
                                                            Color(0xFF81D05C),
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .subtitle2
                                                                .override(
                                                                  fontFamily:
                                                                      'AvenirArabic',
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                        elevation: 0,
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                      ),
                                                      showLoadingIndicator:
                                                          false,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
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
                                                                'AvenirArabic',
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            useGoogleFonts:
                                                                false,
                                                          ),
                                                    ),
                                                    Text(
                                                      PropertyCall
                                                              .propertyUpdatedAt(
                                                        columnPropertyResponse
                                                            .jsonBody,
                                                      )
                                                          .toString()
                                                          .maybeHandleOverflow(
                                                              maxChars: 10),
                                                      maxLines: 2,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'AvenirArabic',
                                                            fontSize: 12,
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
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 19, 16, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 46,
                                                  height: 46,
                                                  decoration: BoxDecoration(
                                                    color: Color(0x80F3F1F1),
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Color(0x7EF3F1F1),
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    child: Image.network(
                                                      PropertyCall.companyLogo(
                                                        columnPropertyResponse
                                                            .jsonBody,
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(13, 0, 0, 0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0, 0),
                                                        child: Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'kqc4ney0' /* Property manage by  */,
                                                          ),
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'AvenirArabic',
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                useGoogleFonts:
                                                                    false,
                                                              ),
                                                        ),
                                                      ),
                                                      Text(
                                                        PropertyCall.mangedBy(
                                                          columnPropertyResponse
                                                              .jsonBody,
                                                        ).toString(),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Sofia Pro By Khuzaimah',
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
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 25, 16, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    PropertyCall.propertyName(
                                                      columnPropertyResponse
                                                          .jsonBody,
                                                    ).toString(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'AvenirArabic',
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          useGoogleFonts: false,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 1, 16, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 6, 0),
                                                      child: Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        color: Colors.black,
                                                        size: 18,
                                                      ),
                                                    ),
                                                    Text(
                                                      PropertyCall.propertyCity(
                                                        columnPropertyResponse
                                                            .jsonBody,
                                                      ).toString(),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'AvenirArabic',
                                                            fontSize: 15,
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
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'AvenirArabic',
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            useGoogleFonts:
                                                                false,
                                                          ),
                                                    ),
                                                    Text(
                                                      PropertyCall
                                                          .propertyDistrict(
                                                        columnPropertyResponse
                                                            .jsonBody,
                                                      ).toString(),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'AvenirArabic',
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            useGoogleFonts:
                                                                false,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(1, 0, 0, 0),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      logFirebaseEvent(
                                                          'PROPERTY_DETAILS_Text_ytdaqx1p_ON_TAP');
                                                      logFirebaseEvent(
                                                          'Text_Launch-Map');
                                                      await launchMap(
                                                        mapType:
                                                            $ml.MapType.google,
                                                        location: functions
                                                            .propertyLocation(
                                                                PropertyCall
                                                                    .propertyLat(
                                                                  columnPropertyResponse
                                                                      .jsonBody,
                                                                ),
                                                                PropertyCall
                                                                    .propertylng(
                                                                  columnPropertyResponse
                                                                      .jsonBody,
                                                                )),
                                                        title: PropertyCall
                                                            .propertyName(
                                                          columnPropertyResponse
                                                              .jsonBody,
                                                        ).toString(),
                                                      );
                                                    },
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'regy8zap' /* View on map */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'AvenirArabic',
                                                            color: Color(
                                                                0xFF2971FB),
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            useGoogleFonts:
                                                                false,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 8, 16, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    PropertyCall
                                                        .propertyDescription(
                                                      columnPropertyResponse
                                                          .jsonBody,
                                                    ).toString(),
                                                    maxLines: 20,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'AvenirArabic',
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          useGoogleFonts: false,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 35, 16, 0),
                                            child: Container(
                                              decoration: BoxDecoration(),
                                              child: GridView(
                                                padding: EdgeInsets.zero,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  crossAxisSpacing: 10,
                                                  mainAxisSpacing: 10,
                                                  childAspectRatio: 1.4,
                                                ),
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .single_bed_outlined,
                                                        color: Colors.black,
                                                        size: 24,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 8, 0, 0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              PropertyCall
                                                                  .propertyBedrooms(
                                                                columnPropertyResponse
                                                                    .jsonBody,
                                                              ).toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'AvenirArabic',
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
                                                                'd1l98zzs' /*  Bedrooms */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'AvenirArabic',
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
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.bathtub_outlined,
                                                        color: Colors.black,
                                                        size: 24,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 8, 0, 0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              PropertyCall
                                                                  .propertyBathrooms(
                                                                columnPropertyResponse
                                                                    .jsonBody,
                                                              ).toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'AvenirArabic',
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
                                                                'gqq478h5' /*  Bathrooms */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'AvenirArabic',
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
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .design_services_outlined,
                                                        color: Colors.black,
                                                        size: 24,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 8, 0, 0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              PropertyCall
                                                                  .propertySize(
                                                                columnPropertyResponse
                                                                    .jsonBody,
                                                              ).toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'AvenirArabic',
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
                                                                'swyvkhf5' /*  sqm */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'AvenirArabic',
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
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.live_tv_rounded,
                                                        color: Colors.black,
                                                        size: 24,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 8, 0, 0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              PropertyCall
                                                                  .propertyLivingrooms(
                                                                columnPropertyResponse
                                                                    .jsonBody,
                                                              ).toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'AvenirArabic',
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
                                                                'u0xq15h6' /*  Livingrooms */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'AvenirArabic',
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
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.house_outlined,
                                                        color: Colors.black,
                                                        size: 24,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 8, 0, 0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              PropertyCall
                                                                  .propertyBuiltIn(
                                                                columnPropertyResponse
                                                                    .jsonBody,
                                                              ).toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'AvenirArabic',
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
                                                ],
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            thickness: 1,
                                            indent: 10,
                                            endIndent: 10,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 20, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'nq19lw60' /* Features and Amenities */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'AvenirArabic',
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 17, 16, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    '6brswcwm' /* Ref no. */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'AvenirArabic',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                                Text(
                                                  PropertyCall.propertyRef(
                                                    columnPropertyResponse
                                                        .jsonBody,
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'AvenirArabic',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (functions.propertyTypeCheckHouse(
                                              PropertyCall.propertyType(
                                                columnPropertyResponse.jsonBody,
                                              ).toString(),
                                              FFAppState().locale))
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(16, 15, 16, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'ku7u4p9w' /* Floors */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'AvenirArabic',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          useGoogleFonts: false,
                                                        ),
                                                  ),
                                                  Text(
                                                    PropertyCall.propertyFloors(
                                                      columnPropertyResponse
                                                          .jsonBody,
                                                    ).toString(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'AvenirArabic',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          useGoogleFonts: false,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          if (functions
                                              .propertyTypeCheckApartment(
                                                  PropertyCall.propertyType(
                                                    columnPropertyResponse
                                                        .jsonBody,
                                                  ).toString(),
                                                  FFAppState().locale))
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(16, 15, 16, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'bidhdd2g' /* Floor Number */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'AvenirArabic',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          useGoogleFonts: false,
                                                        ),
                                                  ),
                                                  Text(
                                                    PropertyCall
                                                        .propertyFloorNumber(
                                                      columnPropertyResponse
                                                          .jsonBody,
                                                    ).toString(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'AvenirArabic',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          useGoogleFonts: false,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 15, 16, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'vrdckjrg' /* Furnishing type */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'AvenirArabic',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                                Text(
                                                  PropertyCall
                                                      .propertyFurnishingType(
                                                    columnPropertyResponse
                                                        .jsonBody,
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'AvenirArabic',
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 15, 16, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'fk1mf2ip' /* Street width */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'AvenirArabic',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      PropertyCall
                                                          .propertyStreetWidth(
                                                        columnPropertyResponse
                                                            .jsonBody,
                                                      ).toString(),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'AvenirArabic',
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            useGoogleFonts:
                                                                false,
                                                          ),
                                                    ),
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'ntqkfyop' /*  m */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'AvenirArabic',
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            useGoogleFonts:
                                                                false,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 15, 16, 32),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'e52iigjz' /* Total Price */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'AvenirArabic',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      valueOrDefault<String>(
                                                        functions
                                                            .formatAmountWithoutDecimal(
                                                                valueOrDefault<
                                                                    String>(
                                                          PropertyCall
                                                              .propertyPrice(
                                                            columnPropertyResponse
                                                                .jsonBody,
                                                          ).toString(),
                                                          '0',
                                                        )),
                                                        '0',
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'AvenirArabic',
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            useGoogleFonts:
                                                                false,
                                                          ),
                                                    ),
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        've2ud2ws' /*  SAR */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'AvenirArabic',
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            useGoogleFonts:
                                                                false,
                                                          ),
                                                    ),
                                                  ],
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
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 20, 16, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'fobsike6' /* Supported Banks */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'AvenirArabic',
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 19, 0, 30),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 164,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                    ),
                                                    child: Builder(
                                                      builder: (context) {
                                                        final banks =
                                                            PropertyCall.banks(
                                                          columnPropertyResponse
                                                              .jsonBody,
                                                        ).toList();
                                                        return ListView.builder(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          primary: false,
                                                          shrinkWrap: true,
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount:
                                                              banks.length,
                                                          itemBuilder: (context,
                                                              banksIndex) {
                                                            final banksItem =
                                                                banks[
                                                                    banksIndex];
                                                            return Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  logFirebaseEvent(
                                                                      'PROPERTY_DETAILS_Container_94tgk0v4_ON_T');
                                                                  logFirebaseEvent(
                                                                      'Container_Bottom-Sheet');
                                                                  await showModalBottomSheet(
                                                                    isScrollControlled:
                                                                        true,
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return Padding(
                                                                        padding:
                                                                            MediaQuery.of(context).viewInsets,
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              MediaQuery.of(context).size.height * 0.72,
                                                                          child:
                                                                              BankDetailsBottomSheetWidget(
                                                                            bankId:
                                                                                getJsonField(
                                                                              banksItem,
                                                                              r'''$.id''',
                                                                            ),
                                                                            bankJSON:
                                                                                getJsonField(
                                                                              banksItem,
                                                                              r'''$.attributes''',
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.328,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.14,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Color(
                                                                            0x230F1113),
                                                                      )
                                                                    ],
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Color(
                                                                          0xFFF3F3F3),
                                                                    ),
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            5,
                                                                            5,
                                                                            5,
                                                                            5),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                          child:
                                                                              Image.network(
                                                                            getJsonField(
                                                                              banksItem,
                                                                              r'''$..bank_logo..url''',
                                                                            ),
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.29,
                                                                            height:
                                                                                MediaQuery.of(context).size.height * 0.1,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              9,
                                                                              0,
                                                                              9,
                                                                              0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(9, 0, 0, 0),
                                                                                child: Text(
                                                                                  getJsonField(
                                                                                    banksItem,
                                                                                    r'''$..bank_name''',
                                                                                  ).toString(),
                                                                                  maxLines: 2,
                                                                                  style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                        fontFamily: 'AvenirArabic',
                                                                                        fontSize: 14,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        useGoogleFonts: false,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(9, 0, 0, 17),
                                                                                child: Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    '1v1r516t' /* More Details */,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                        fontFamily: 'AvenirArabic',
                                                                                        color: FlutterFlowTheme.of(context).primaryColor,
                                                                                        fontSize: 11,
                                                                                        fontWeight: FontWeight.bold,
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
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 20, 16, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    '8fdy3f5a' /* Location */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'AvenirArabic',
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 10, 16, 7),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  PropertyCall
                                                      .propertyEntranceDirection(
                                                    columnPropertyResponse
                                                        .jsonBody,
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'AvenirArabic',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 7, 16, 16),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.27,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFEEEEEE),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
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
                                                              .MapType.google,
                                                          location: functions
                                                              .propertyLocation(
                                                                  PropertyCall
                                                                      .propertyLat(
                                                                    columnPropertyResponse
                                                                        .jsonBody,
                                                                  ),
                                                                  PropertyCall
                                                                      .propertylng(
                                                                    columnPropertyResponse
                                                                        .jsonBody,
                                                                  )),
                                                          title: PropertyCall
                                                              .propertyName(
                                                            columnPropertyResponse
                                                                .jsonBody,
                                                          ).toString(),
                                                        );
                                                      },
                                                      child:
                                                          FlutterFlowStaticMap(
                                                        location: functions
                                                            .propertyLocation(
                                                                PropertyCall
                                                                    .propertyLat(
                                                                  columnPropertyResponse
                                                                      .jsonBody,
                                                                ),
                                                                PropertyCall
                                                                    .propertylng(
                                                                  columnPropertyResponse
                                                                      .jsonBody,
                                                                )),
                                                        apiKey:
                                                            'pk.eyJ1IjoibWFuemVsIiwiYSI6ImNsNTB0NjI3YjA3OXQzYm9sdWNvM2Rrc2kifQ.zAYcxr9ozMoZfe4pEfxv7A',
                                                        style:
                                                            MapBoxStyle.Streets,
                                                        width: double.infinity,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.27,
                                                        fit: BoxFit.cover,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        markerColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                        cached: true,
                                                        zoom: 10,
                                                        tilt: 0,
                                                        rotation: 0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            thickness: 1,
                                            indent: 10,
                                            endIndent: 10,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 20, 16, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                if (functions
                                                    .isSimilarPropertyAvailable(
                                                        getJsonField(
                                                  columnPropertyResponse
                                                      .jsonBody,
                                                  r'''$.data.attributes.similar_properties''',
                                                )))
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      '67qymqb4' /* Similar Properties */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'AvenirArabic',
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          useGoogleFonts: false,
                                                        ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          Builder(
                                            builder: (context) {
                                              final properties = getJsonField(
                                                columnPropertyResponse.jsonBody,
                                                r'''$.data.attributes.similar_properties''',
                                              ).toList();
                                              return ListView.builder(
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount: properties.length,
                                                itemBuilder:
                                                    (context, propertiesIndex) {
                                                  final propertiesItem =
                                                      properties[
                                                          propertiesIndex];
                                                  return Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                12, 12, 12, 12),
                                                    child: InkWell(
                                                      onTap: () async {
                                                        logFirebaseEvent(
                                                            'PROPERTY_DETAILS_propertyCard_ON_TAP');
                                                        logFirebaseEvent(
                                                            'propertyCard_Navigate-To');
                                                        context.pushNamed(
                                                          'PropertyDetails',
                                                          queryParams: {
                                                            'propertyId':
                                                                serializeParam(
                                                                    getJsonField(
                                                                      propertiesItem,
                                                                      r'''$.id''',
                                                                    ),
                                                                    ParamType
                                                                        .int),
                                                          }.withoutNulls,
                                                        );
                                                      },
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.3,
                                                            child: Stack(
                                                              children: [
                                                                Builder(
                                                                  builder:
                                                                      (context) {
                                                                    final propertyImages =
                                                                        getJsonField(
                                                                      propertiesItem,
                                                                      r'''$..property_images''',
                                                                    ).toList();
                                                                    return Container(
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.3,
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          PageView
                                                                              .builder(
                                                                            controller: pageViewController2 ??=
                                                                                PageController(initialPage: min(0, propertyImages.length - 1)),
                                                                            scrollDirection:
                                                                                Axis.horizontal,
                                                                            itemCount:
                                                                                propertyImages.length,
                                                                            itemBuilder:
                                                                                (context, propertyImagesIndex) {
                                                                              final propertyImagesItem = propertyImages[propertyImagesIndex];
                                                                              return ClipRRect(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                                child: CachedNetworkImage(
                                                                                  imageUrl: getJsonField(
                                                                                    propertyImagesItem,
                                                                                    r'''$.url''',
                                                                                  ),
                                                                                  width: MediaQuery.of(context).size.width,
                                                                                  height: MediaQuery.of(context).size.height * 0.3,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0, 0.7),
                                                                            child:
                                                                                SmoothPageIndicator(
                                                                              controller: pageViewController2 ??= PageController(initialPage: min(0, propertyImages.length - 1)),
                                                                              count: propertyImages.length,
                                                                              axisDirection: Axis.horizontal,
                                                                              onDotClicked: (i) {
                                                                                pageViewController2.animateToPage(
                                                                                  i,
                                                                                  duration: Duration(milliseconds: 500),
                                                                                  curve: Curves.ease,
                                                                                );
                                                                              },
                                                                              effect: SlideEffect(
                                                                                spacing: 8,
                                                                                radius: 3,
                                                                                dotWidth: 6,
                                                                                dotHeight: 6,
                                                                                dotColor: Color(0x80FFFFFF),
                                                                                activeDotColor: Colors.white,
                                                                                paintStyle: PaintingStyle.fill,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          1,
                                                                          -1),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            12,
                                                                            15,
                                                                            0),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        logFirebaseEvent(
                                                                            'PROPERTY_DETAILS_Container_8jf58tla_ON_T');
                                                                        if (!loggedIn) {
                                                                          logFirebaseEvent(
                                                                              'Container_Navigate-To');
                                                                          context
                                                                              .pushNamed('Login');
                                                                        }
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            40,
                                                                        height:
                                                                            40,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(0x4D000000),
                                                                          image:
                                                                              DecorationImage(
                                                                            fit:
                                                                                BoxFit.none,
                                                                            image:
                                                                                Image.asset(
                                                                              'assets/images/Heart.png',
                                                                            ).image,
                                                                          ),
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          1, 1),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            18,
                                                                            18),
                                                                    child:
                                                                        Container(
                                                                      width: 50,
                                                                      height:
                                                                          50,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(
                                                                            0x80F3F1F1),
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              Color(0x80F3F1F1),
                                                                          width:
                                                                              2,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(30),
                                                                        child: Image
                                                                            .network(
                                                                          getJsonField(
                                                                            propertiesItem,
                                                                            r'''$.attributes.managed_by.data.attributes.company_logo.data.attributes.url''',
                                                                          ),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
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
                                                                        4,
                                                                        14,
                                                                        0,
                                                                        0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  getJsonField(
                                                                    propertiesItem,
                                                                    r'''$.attributes.property_name''',
                                                                  ).toString(),
                                                                  maxLines: 1,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyText1
                                                                      .override(
                                                                        fontFamily:
                                                                            'AvenirArabic',
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        useGoogleFonts:
                                                                            false,
                                                                      ),
                                                                ),
                                                                Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'dw0ntbtl' /* Approved Banks */,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyText1
                                                                      .override(
                                                                        fontFamily:
                                                                            'AvenirArabic',
                                                                        color: Color(
                                                                            0xFF474747),
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
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        4,
                                                                        1,
                                                                        0,
                                                                        14),
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
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .location_on_outlined,
                                                                      color: Color(
                                                                          0xFF130F26),
                                                                      size: 11,
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              4,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Text(
                                                                        getJsonField(
                                                                          propertiesItem,
                                                                          r'''$..attributes.city.data.attributes.city_name''',
                                                                        ).toString(),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'AvenirArabic',
                                                                              fontSize: 13,
                                                                              fontWeight: FontWeight.w300,
                                                                              useGoogleFonts: false,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'daq1tb18' /* ,  */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText1
                                                                          .override(
                                                                            fontFamily:
                                                                                'AvenirArabic',
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.w300,
                                                                            useGoogleFonts:
                                                                                false,
                                                                          ),
                                                                    ),
                                                                    Text(
                                                                      getJsonField(
                                                                        propertiesItem,
                                                                        r'''$..property_district''',
                                                                      ).toString(),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText1
                                                                          .override(
                                                                            fontFamily:
                                                                                'AvenirArabic',
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
                                                                Builder(
                                                                  builder:
                                                                      (context) {
                                                                    final banks =
                                                                        getJsonField(
                                                                      propertiesItem,
                                                                      r'''$.attributes.banks.data''',
                                                                    ).toList();
                                                                    return Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: List.generate(
                                                                          banks
                                                                              .length,
                                                                          (banksIndex) {
                                                                        final banksItem =
                                                                            banks[banksIndex];
                                                                        return Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              0,
                                                                              8,
                                                                              0),
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(11),
                                                                            child:
                                                                                Image.network(
                                                                              getJsonField(
                                                                                banksItem,
                                                                                r'''$.attributes.bank_logo.data.attributes.url''',
                                                                              ),
                                                                              width: 22,
                                                                              height: 22,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }),
                                                                    );
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        4,
                                                                        0,
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
                                                                Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    '5fi3eht5' /* Installment starting from */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .title3
                                                                      .override(
                                                                        fontFamily:
                                                                            'Sofia Pro By Khuzaimah',
                                                                        color: Color(
                                                                            0xFF2971FB),
                                                                        fontSize:
                                                                            11,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        useGoogleFonts:
                                                                            false,
                                                                      ),
                                                                ),
                                                                Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'asvlp34j' /* Total property price */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyText2
                                                                      .override(
                                                                        fontFamily:
                                                                            'AvenirArabic',
                                                                        color: Color(
                                                                            0xFF474747),
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
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        4,
                                                                        1,
                                                                        0,
                                                                        20),
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
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Text(
                                                                      functions
                                                                          .formatAmount(
                                                                              getJsonField(
                                                                        propertiesItem,
                                                                        r'''$..property_initial_installment''',
                                                                      ).toString()),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText1
                                                                          .override(
                                                                            fontFamily:
                                                                                'Sofia Pro By Khuzaimah',
                                                                            color:
                                                                                Color(0xFF2971FB),
                                                                            fontSize:
                                                                                24,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            useGoogleFonts:
                                                                                false,
                                                                          ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              5,
                                                                              10,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'vfqf83co' /*  SAR/Monthly */,
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'AvenirArabic',
                                                                              color: Color(0xFF2971FB),
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w500,
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
                                                                    Text(
                                                                      functions.formatAmountWithoutDecimal(
                                                                          valueOrDefault<
                                                                              String>(
                                                                        getJsonField(
                                                                          columnPropertyResponse
                                                                              .jsonBody,
                                                                          r'''$..property_price''',
                                                                        ).toString(),
                                                                        '0',
                                                                      )),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText2
                                                                          .override(
                                                                            fontFamily:
                                                                                'AvenirArabic',
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            useGoogleFonts:
                                                                                false,
                                                                          ),
                                                                    ),
                                                                    Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'o3rzhl0v' /*  SAR */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText2
                                                                          .override(
                                                                            fontFamily:
                                                                                'AvenirArabic',
                                                                            color:
                                                                                Colors.black,
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
                                                              ],
                                                            ),
                                                          ),
                                                          Divider(
                                                            thickness: 1,
                                                            color: Color(
                                                                0xFFECECEC),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Material(
                      color: Colors.transparent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.12,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x0E000000),
                              offset: Offset(0, -2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(0),
                        ),
                        alignment: AlignmentDirectional(0, -0.35),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'i17ddd6l' /* Installment starting from */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'AvenirArabic',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryColor,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts: false,
                                          ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        AutoSizeText(
                                          functions
                                              .formatAmount(PropertyCall
                                                  .propertyInitialInstallment(
                                                columnPropertyResponse.jsonBody,
                                              ).toString())
                                              .maybeHandleOverflow(
                                                  maxChars: 10),
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'AvenirArabic',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryColor,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 11, 5, 0),
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              'mgi2d0o9' /*  SAR/Monthly */,
                                            ),
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'AvenirArabic',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryColor,
                                                  fontSize: 11,
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
                              if (functions.conditionalVisibility(
                                  PropertyCall.propertyStatus(
                                    columnPropertyResponse.jsonBody,
                                  ).toString(),
                                  'Available'))
                                FFButtonWidget(
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'PROPERTY_DETAILS_PAGE_reserved_ON_TAP');
                                    if (loggedIn) {
                                      logFirebaseEvent('reserved_Bottom-Sheet');
                                      await configurePaymentSdk();
                                    await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.white,
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: MediaQuery.of(context)
                                                .viewInsets,
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.9,
                                              child:
                                                  ReservationBottomSheetWidget(
                                                reservationCost: PropertyCall
                                                    .reservationsCost(
                                                  columnPropertyResponse
                                                      .jsonBody,
                                                ),
                                                propertyId: widget.propertyId,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      logFirebaseEvent('reserved_Navigate-To');
                                      context.pushNamed('Login');
                                    }
                                  },
                                  text: FFLocalizations.of(context).getText(
                                    'dpmrt150' /* Reserve */,
                                  ),
                                  options: FFButtonOptions(
                                    width: 140,
                                    height: 56,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .subtitle2
                                        .override(
                                          fontFamily: 'AvenirArabic',
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          useGoogleFonts: false,
                                        ),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              if (!functions.conditionalVisibility(
                                  PropertyCall.propertyStatus(
                                    columnPropertyResponse.jsonBody,
                                  ).toString(),
                                  'Available'))
                                FFButtonWidget(
                                  onPressed: () {
                                    print('Button pressed ...');
                                  },
                                  text: FFLocalizations.of(context).getText(
                                    'wzirx8i7' /* Booked */,
                                  ),
                                  options: FFButtonOptions(
                                    width: 140,
                                    height: 56,
                                    color: Color(0xFF8C8C8C),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .subtitle2
                                        .override(
                                          fontFamily: 'AvenirArabic',
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          useGoogleFonts: false,
                                        ),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
