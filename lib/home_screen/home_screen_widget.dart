import '../auth/auth_util.dart';
import '../auth/firebase_user_provider.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../components/no_result_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({
    Key key,
    this.city,
    this.type,
    this.installmentRange,
    this.furnishing,
  }) : super(key: key);

  final String city;
  final String type;
  final double installmentRange;
  final String furnishing;

  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  PageController pageViewController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('HOME_SCREEN_PAGE_HomeScreen_ON_PAGE_LOAD');
      logFirebaseEvent('HomeScreen_Update-Local-State');
      setState(
          () => FFAppState().locale = FFLocalizations.of(context).languageCode);
    });

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'HomeScreen'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      constraints: BoxConstraints(
                        maxWidth: double.infinity,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x3F000000),
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Image.asset(
                          'assets/images/home_bg.png',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, -0.7),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/images/d9t74_.svg',
                              width: 43,
                              height: 31,
                              fit: BoxFit.none,
                            ),
                            if (loggedIn)
                              StreamBuilder<List<NotificationsRecord>>(
                                stream: queryNotificationsRecord(
                                  queryBuilder: (notificationsRecord) =>
                                      notificationsRecord
                                          .where('user_id',
                                              isEqualTo: currentUserReference)
                                          .where('is_read', isEqualTo: 0),
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
                                  List<NotificationsRecord>
                                      notificationsBadgeNotificationsRecordList =
                                      snapshot.data;
                                  return InkWell(
                                    onTap: () async {
                                      logFirebaseEvent(
                                          'HOME_SCREEN_notificationsBadge_ON_TAP');
                                      logFirebaseEvent(
                                          'notificationsBadge_Navigate-To');
                                      context.pushNamed('Notifications');
                                    },
                                    child: Badge(
                                      badgeContent: Text(
                                        valueOrDefault<String>(
                                          functions.notificationBadgeCount(
                                              notificationsBadgeNotificationsRecordList
                                                  .toList()),
                                          '0',
                                        ),
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'AvenirArabic',
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              useGoogleFonts: false,
                                            ),
                                      ),
                                      showBadge: functions.notificationBadgeCount(
                                              notificationsBadgeNotificationsRecordList
                                                  .toList()) !=
                                          '0',
                                      shape: BadgeShape.circle,
                                      badgeColor: Color(0xFFD05C5C),
                                      elevation: 4,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          7, 7, 7, 7),
                                      position: BadgePosition.topEnd(),
                                      animationType: BadgeAnimationType.scale,
                                      toAnimate: true,
                                      child: Icon(
                                        Icons.notifications_none,
                                        color: Colors.white,
                                        size: 26,
                                      ),
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, 0.75),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(14, 0, 14, 0),
                        child: Container(
                          width: double.infinity,
                          height: 54,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                color: Color(0x41000000),
                                offset: Offset(0, 3),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                            shape: BoxShape.rectangle,
                          ),
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(23, 0, 12, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'HOME_SCREEN_PAGE_Text_iowqhltc_ON_TAP');
                                    logFirebaseEvent('Text_Navigate-To');
                                    context.pushNamed(
                                      'WhereAreYouLooking',
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.bottomToTop,
                                        ),
                                      },
                                    );
                                  },
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'qnr0o42y' /* Where are you looking? */,
                                    ),
                                    textAlign: TextAlign.start,
                                    style:
                                        FlutterFlowTheme.of(context).bodyText1,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 10, 0),
                                      child: Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Color(0xFFF4F4F4),
                                            width: 1,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.map_outlined,
                                          color: Colors.black,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'HOME_SCREEN_Container_13mjruev_ON_TAP');
                                        logFirebaseEvent(
                                            'Container_Navigate-To');
                                        context.pushNamed(
                                          'Filter',
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: TransitionInfo(
                                              hasTransition: true,
                                              transitionType: PageTransitionType
                                                  .bottomToTop,
                                            ),
                                          },
                                        );
                                      },
                                      child: Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Color(0xFFF4F4F4),
                                            width: 1,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.filter_list_rounded,
                                          color: Colors.black,
                                          size: 18,
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
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
                child: FutureBuilder<ApiCallResponse>(
                  future: PropertiesCall.call(),
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
                    final listViewPropertiesResponse = snapshot.data;
                    return Builder(
                      builder: (context) {
                        final properties = PropertiesCall.properties(
                          listViewPropertiesResponse.jsonBody,
                        ).toList();
                        if (properties.isEmpty) {
                          return Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: NoResultWidget(
                                titleText: functions.emptyListWidgetTitle(
                                    'homeScreen', FFAppState().locale),
                                screenName: 'result',
                              ),
                            ),
                          );
                        }
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: properties.length,
                          itemBuilder: (context, propertiesIndex) {
                            final propertiesItem = properties[propertiesIndex];
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12, 12, 12, 12),
                              child: InkWell(
                                onTap: () async {
                                  logFirebaseEvent(
                                      'HOME_SCREEN_PAGE_propertyCard_ON_TAP');
                                  // propertyDetails
                                  logFirebaseEvent(
                                      'propertyCard_propertyDetails');
                                  context.pushNamed(
                                    'PropertyDetails',
                                    queryParams: {
                                      'propertyId': serializeParam(
                                          getJsonField(
                                            propertiesItem,
                                            r'''$.id''',
                                          ),
                                          ParamType.int),
                                    }.withoutNulls,
                                  );
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      child: Stack(
                                        children: [
                                          Builder(
                                            builder: (context) {
                                              final propertyImages =
                                                  getJsonField(
                                                propertiesItem,
                                                r'''$..property_images.data''',
                                              ).toList();
                                              return Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.3,
                                                child: Stack(
                                                  children: [
                                                    PageView.builder(
                                                      controller: pageViewController ??=
                                                          PageController(
                                                              initialPage: min(
                                                                  0,
                                                                  propertyImages
                                                                          .length -
                                                                      1)),
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount:
                                                          propertyImages.length,
                                                      itemBuilder: (context,
                                                          propertyImagesIndex) {
                                                        final propertyImagesItem =
                                                            propertyImages[
                                                                propertyImagesIndex];
                                                        return ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                getJsonField(
                                                              propertyImagesItem,
                                                              r'''$.attributes.url''',
                                                            ),
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
                                                            fit: BoxFit.cover,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, 0.7),
                                                      child:
                                                          SmoothPageIndicator(
                                                        controller: pageViewController ??=
                                                            PageController(
                                                                initialPage: min(
                                                                    0,
                                                                    propertyImages
                                                                            .length -
                                                                        1)),
                                                        count: propertyImages
                                                            .length,
                                                        axisDirection:
                                                            Axis.horizontal,
                                                        onDotClicked: (i) {
                                                          pageViewController
                                                              .animateToPage(
                                                            i,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    500),
                                                            curve: Curves.ease,
                                                          );
                                                        },
                                                        effect: SlideEffect(
                                                          spacing: 8,
                                                          radius: 3,
                                                          dotWidth: 6,
                                                          dotHeight: 6,
                                                          dotColor:
                                                              Color(0x80FFFFFF),
                                                          activeDotColor:
                                                              Colors.white,
                                                          paintStyle:
                                                              PaintingStyle
                                                                  .fill,
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
                                                AlignmentDirectional(1, -1),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 12, 15, 0),
                                              child: InkWell(
                                                onTap: () async {
                                                  logFirebaseEvent(
                                                      'HOME_SCREEN_Container_jprwonvd_ON_TAP');
                                                  if (loggedIn) {
                                                    logFirebaseEvent(
                                                        'Container_Backend-Call');
                                                    await BookmarkPropertyCall
                                                        .call(
                                                      userId: currentUserUid,
                                                      propertyId:
                                                          valueOrDefault<
                                                              String>(
                                                        getJsonField(
                                                          propertiesItem,
                                                          r'''$.id''',
                                                        ).toString(),
                                                        '0',
                                                      ),
                                                    );
                                                  } else {
                                                    logFirebaseEvent(
                                                        'Container_Navigate-To');
                                                    context.pushNamed('Login');
                                                  }
                                                },
                                                child: Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: Color(0x4D000000),
                                                    image: DecorationImage(
                                                      fit: BoxFit.none,
                                                      image: Image.asset(
                                                        'assets/images/Heart.png',
                                                      ).image,
                                                    ),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(1, 1),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 18, 18),
                                              child: Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: Color(0x80F3F1F1),
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Color(0x80F3F1F1),
                                                    width: 2,
                                                  ),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  child: Image.network(
                                                    getJsonField(
                                                      propertiesItem,
                                                      r'''$.attributes.managed_by.data.attributes.company_logo.data.attributes.url''',
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          4, 14, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            getJsonField(
                                              propertiesItem,
                                              r'''$.attributes.property_name''',
                                            ).toString(),
                                            maxLines: 1,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'AvenirArabic',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'etpebw43' /* Approved Banks */,
                                            ),
                                            textAlign: TextAlign.end,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'AvenirArabic',
                                                  color: Color(0xFF474747),
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          4, 1, 0, 14),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.location_on_outlined,
                                                color: Color(0xFF130F26),
                                                size: 11,
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(4, 0, 0, 0),
                                                child: Text(
                                                  getJsonField(
                                                    propertiesItem,
                                                    r'''$..attributes.city.data.attributes.city_name''',
                                                  ).toString(),
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
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'efcxmcgl' /* ,  */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
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
                                              Text(
                                                getJsonField(
                                                  propertiesItem,
                                                  r'''$..property_district''',
                                                ).toString(),
                                                style:
                                                    FlutterFlowTheme.of(context)
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
                                            ],
                                          ),
                                          Builder(
                                            builder: (context) {
                                              final banks = getJsonField(
                                                propertiesItem,
                                                r'''$.attributes.banks.data''',
                                              ).toList();
                                              return Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: List.generate(
                                                    banks.length, (banksIndex) {
                                                  final banksItem =
                                                      banks[banksIndex];
                                                  return Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 8, 0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              11),
                                                      child: Image.network(
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
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          4, 0, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              '998is2ya' /* Installment starting from */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .title3
                                                .override(
                                                  fontFamily:
                                                      'Sofia Pro By Khuzaimah',
                                                  color: Color(0xFF2971FB),
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'gqe4w739' /* Total property price */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText2
                                                .override(
                                                  fontFamily: 'AvenirArabic',
                                                  color: Color(0xFF474747),
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          4, 1, 0, 20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                functions
                                                    .formatAmount(getJsonField(
                                                  propertiesItem,
                                                  r'''$..property_initial_installment''',
                                                ).toString()),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'Sofia Pro By Khuzaimah',
                                                          color:
                                                              Color(0xFF2971FB),
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          useGoogleFonts: false,
                                                        ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(5, 10, 0, 0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'l38if619' /*  SAR/Monthly */,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'AvenirArabic',
                                                        color:
                                                            Color(0xFF2971FB),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                functions
                                                    .formatAmount(getJsonField(
                                                  propertiesItem,
                                                  r'''$..property_price''',
                                                ).toString()),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText2
                                                        .override(
                                                          fontFamily:
                                                              'AvenirArabic',
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          useGoogleFonts: false,
                                                        ),
                                              ),
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'dhoik8q5' /*  SAR */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText2
                                                        .override(
                                                          fontFamily:
                                                              'AvenirArabic',
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          useGoogleFonts: false,
                                                        ),
                                              ),
                                            ],
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
