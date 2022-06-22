import '../auth/firebase_user_provider.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

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
  TextEditingController searchController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'HomeScreen'});
    searchController = TextEditingController();
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
                width: 375,
                height: 380,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/3.webp',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(30, 164, 188, 184),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'qe91inbs' /* +100 Real Estates  */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts: false,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(30, 197, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'td57ofdl' /* Browse our featured properties... */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                    useGoogleFonts: false,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(14, 294, 14, 32),
                      child: Container(
                        width: 347,
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
                        ),
                        alignment: AlignmentDirectional(0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                                child: TextFormField(
                                  controller: searchController,
                                  onFieldSubmitted: (_) async {
                                    logFirebaseEvent(
                                        'HOME_SCREEN_search_ON_TEXTFIELD_SUBMIT');
                                    logFirebaseEvent('search_Navigate-To');
                                    context.goNamed(
                                      'WhereAreYouLooking',
                                      queryParams: {
                                        'city': serializeParam(
                                            searchController.text,
                                            ParamType.String),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.bottomToTop,
                                        ),
                                      },
                                    );
                                  },
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText:
                                        FFLocalizations.of(context).getText(
                                      'n2rs891m' /* Search here... */,
                                    ),
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Lexend Deca',
                                          color: Color(0xFF57636C),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 0,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 0,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Sofia Pro By Khuzaimah',
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        useGoogleFonts: false,
                                      ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  logFirebaseEvent(
                                      'HOME_SCREEN_PAGE_propertyFilter_ON_TAP');
                                  logFirebaseEvent(
                                      'propertyFilter_Navigate-To');
                                  context.pushNamed('Filter');
                                },
                                text: '',
                                icon: Icon(
                                  Icons.filter_list,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                options: FFButtonOptions(
                                  width: 36,
                                  height: 36,
                                  color: Colors.white,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  borderSide: BorderSide(
                                    color: Color(0xFFD7D7D7),
                                    width: 1,
                                  ),
                                  borderRadius: 33,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (loggedIn ?? true)
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(327, 58, 28, 304),
                        child: InkWell(
                          onTap: () async {
                            logFirebaseEvent(
                                'HOME_SCREEN_notificationsBadge_ON_TAP');
                            logFirebaseEvent('notificationsBadge_Navigate-To');
                            context.pushNamed('Notifications');
                          },
                          child: Badge(
                            badgeContent: Text(
                              FFLocalizations.of(context).getText(
                                'waavnvd4' /* 1 */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            showBadge: true,
                            shape: BadgeShape.circle,
                            badgeColor: Color(0xFFD05C5C),
                            elevation: 4,
                            padding: EdgeInsetsDirectional.fromSTEB(7, 7, 7, 7),
                            position: BadgePosition.topEnd(),
                            animationType: BadgeAnimationType.scale,
                            toAnimate: true,
                            child: Icon(
                              Icons.notifications_none,
                              color: Colors.white,
                              size: 27,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              FutureBuilder<ApiCallResponse>(
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
                  final propertiesListPropertiesResponse = snapshot.data;
                  return Builder(
                    builder: (context) {
                      final properties = PropertiesCall.properties(
                            (propertiesListPropertiesResponse?.jsonBody ?? ''),
                          )?.toList() ??
                          [];
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: List.generate(properties.length,
                              (propertiesIndex) {
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
                                  context.goNamed(
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
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CachedNetworkImage(
                                        imageUrl: getJsonField(
                                          propertiesItem,
                                          r'''$..property_images.data[0].attributes.name''',
                                        ),
                                        width: 343,
                                        height: 250,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          4, 14, 0, 0),
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
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          4, 2, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            getJsonField(
                                              propertiesItem,
                                              r'''$..property_initial_installment''',
                                            ).toString(),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily:
                                                      'Sofia Pro By Khuzaimah',
                                                  color: Color(0xFF2971FB),
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.bold,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'l38if619' /*  SAR/Monthly */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily:
                                                      'Sofia Pro By Khuzaimah',
                                                  color: Color(0xFF2971FB),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          4, 4, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              getJsonField(
                                                propertiesItem,
                                                r'''$.attributes.property_name''',
                                              ).toString(),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'Sofia Pro By Khuzaimah',
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        useGoogleFonts: false,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 2, 0, 25),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            color: Colors.black,
                                            size: 12,
                                          ),
                                          Text(
                                            getJsonField(
                                              propertiesItem,
                                              r'''$..property_city''',
                                            ).toString(),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily:
                                                      'Sofia Pro By Khuzaimah',
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w300,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'efcxmcgl' /* ,  */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily:
                                                      'Sofia Pro By Khuzaimah',
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w300,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                          Text(
                                            getJsonField(
                                              propertiesItem,
                                              r'''$..property_district''',
                                            ).toString(),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily:
                                                      'Sofia Pro By Khuzaimah',
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w300,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 0.5,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
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
    );
  }
}
