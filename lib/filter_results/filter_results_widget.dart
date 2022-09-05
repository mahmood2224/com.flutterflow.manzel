import '../auth/firebase_user_provider.dart';
import '../backend/api_requests/api_calls.dart';
import '../components/no_result_widget.dart';
import '../flutter_flow/flutter_flow_choice_chips.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FilterResultsWidget extends StatefulWidget {
  const FilterResultsWidget({
    Key key,
    this.cityName,
    this.furnishingType,
    this.propertyType,
    this.minInstallment,
    this.maxInstallment,
  }) : super(key: key);

  final String cityName;
  final String furnishingType;
  final String propertyType;
  final String minInstallment;
  final String maxInstallment;

  @override
  _FilterResultsWidgetState createState() => _FilterResultsWidgetState();
}

class _FilterResultsWidgetState extends State<FilterResultsWidget> {
  List<String> filteredParametesValues;
  PageController pageViewController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'filterResults'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        automaticallyImplyLeading: true,
        leading: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Color(0xFFF3F2F2),
                width: 1,
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
              child: InkWell(
                onTap: () async {
                  logFirebaseEvent('FILTER_RESULTS_PAGE_Icon_n6g5zub7_ON_TAP');
                  logFirebaseEvent('Icon_Close-Dialog,-Drawer,-Etc');
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    FFLocalizations.of(context).getText(
                      'kmjdnh1c' /* Filter results  */,
                    ),
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'AvenirArabic',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts: false,
                        ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  FutureBuilder<ApiCallResponse>(
                    future: PropertiesCall.call(
                      city: FFAppState().filterCity,
                      furnishingType: functions.listToApiParameters(
                          FFAppState().filterFurnishingType.toList()),
                      propertyType: functions.listToApiParameters(
                          FFAppState().filterPropertyType.toList()),
                      locale: FFAppState().locale,
                      minimumPrice: functions
                          .sliderToApi(FFAppState().filterMinPrice.toDouble())
                          .toString(),
                      maximumPrice: functions
                          .sliderToApi(FFAppState().filterMaxPrice.toDouble())
                          .toString(),
                      populate:
                          '*,banks.Bank_logo,managed_by.Company_logo,property_images,city',
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
                      final textPropertiesResponse = snapshot.data;
                      return Text(
                        functions.countJsonData(PropertiesCall.properties(
                          textPropertiesResponse.jsonBody,
                        )),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'AvenirArabic',
                              color: Color(0xFF6B6B6B),
                              useGoogleFonts: false,
                            ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        'wpcx1tpl' /* properties found */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'AvenirArabic',
                            color: Color(0xFF6B6B6B),
                            useGoogleFonts: false,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                              child: FlutterFlowChoiceChips(
                                initiallySelected:
                                    filteredParametesValues != null
                                        ? filteredParametesValues
                                        : [],
                                options:
                                    (functions.filteredResultChioceChipsBuilder(
                                                FFAppState().filterCity,
                                                FFAppState()
                                                    .filterPropertyType
                                                    .toList(),
                                                FFAppState()
                                                    .filterFurnishingType
                                                    .toList(),
                                                FFAppState().locale) ??
                                            [])
                                        .map((label) => ChipData(label))
                                        .toList(),
                                onChanged: (val) => setState(
                                    () => filteredParametesValues = val),
                                selectedChipStyle: ChipStyle(
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'AvenirArabic',
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        useGoogleFonts: false,
                                      ),
                                  iconColor: Colors.white,
                                  iconSize: 0,
                                  elevation: 2,
                                ),
                                unselectedChipStyle: ChipStyle(
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'AvenirArabic',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBtnText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        useGoogleFonts: false,
                                      ),
                                  iconColor: FlutterFlowTheme.of(context)
                                      .primaryBtnText,
                                  iconSize: 0,
                                  elevation: 1,
                                ),
                                chipSpacing: 8,
                                multiselect: true,
                                initialized: filteredParametesValues != null,
                                alignment: WrapAlignment.center,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 14, 0, 0),
                  child: FutureBuilder<ApiCallResponse>(
                    future: PropertiesCall.call(
                      locale: FFAppState().locale,
                      city: FFAppState().filterCity,
                      furnishingType: functions.listToApiParameters(
                          FFAppState().filterFurnishingType.toList()),
                      propertyType: functions.listToApiParameters(
                          FFAppState().filterPropertyType.toList()),
                      minimumPrice: FFAppState().filterMinPrice.toString(),
                      maximumPrice: FFAppState().filterMaxPrice.toString(),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: NoResultWidget(
                                  titleText: functions.emptyListWidgetTitle(
                                      'filterResult', FFAppState().locale),
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
                              final propertiesItem =
                                  properties[propertiesIndex];
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 25),
                                child: InkWell(
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'FILTER_RESULTS_PAGE_propertyCard_ON_TAP');
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        child: Stack(
                                          children: [
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
                                                        BorderRadius.circular(
                                                            30),
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
                                            if (!functions.videoPlayerVisibilty(
                                                getJsonField(
                                              propertiesItem,
                                              r'''$.attributes.video_manifest_uri''',
                                            )))
                                              Builder(
                                                builder: (context) {
                                                  final propertyImages =
                                                      getJsonField(
                                                    propertiesItem,
                                                    r'''$..property_images.data''',
                                                  ).toList();
                                                  return Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height:
                                                        MediaQuery.of(context)
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
                                                              propertyImages
                                                                  .length,
                                                          itemBuilder: (context,
                                                              propertyImagesIndex) {
                                                            final propertyImagesItem =
                                                                propertyImages[
                                                                    propertyImagesIndex];
                                                            return ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl:
                                                                    getJsonField(
                                                                  propertyImagesItem,
                                                                  r'''$.attributes.url''',
                                                                ),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.3,
                                                                fit: BoxFit
                                                                    .cover,
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
                                                                        propertyImages.length -
                                                                            1)),
                                                            count:
                                                                propertyImages
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
                                                                curve:
                                                                    Curves.ease,
                                                              );
                                                            },
                                                            effect: SlideEffect(
                                                              spacing: 8,
                                                              radius: 3,
                                                              dotWidth: 6,
                                                              dotHeight: 6,
                                                              dotColor: Color(
                                                                  0x80FFFFFF),
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
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.35,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Visibility(
                                                visible: functions
                                                    .videoPlayerVisibilty(
                                                        getJsonField(
                                                  propertiesItem,
                                                  r'''$.attributes.video_manifest_uri''',
                                                )),
                                                child: FlutterFlowVideoPlayer(
                                                  path: getJsonField(
                                                    propertiesItem,
                                                    r'''$.attributes.video_manifest_uri''',
                                                  ),
                                                  videoType: VideoType.network,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      1,
                                                  aspectRatio: 1.70,
                                                  autoPlay: true,
                                                  looping: true,
                                                  showControls: false,
                                                  allowFullScreen: true,
                                                  allowPlaybackSpeedMenu: false,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1, -0.95),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 12, 15, 0),
                                                child: InkWell(
                                                  onTap: () async {
                                                    logFirebaseEvent(
                                                        'FILTER_RESULTS_Container_kslgg6qy_ON_TAP');
                                                    if (!loggedIn) {
                                                      logFirebaseEvent(
                                                          'Container_Navigate-To');
                                                      context
                                                          .pushNamed('Login');
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
                                            if (functions.conditionalVisibility(
                                                getJsonField(
                                                  propertiesItem,
                                                  r'''$.attributes.property_status''',
                                                ).toString(),
                                                'Coming soon'))
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -0.99, -0.8),
                                                child: FFButtonWidget(
                                                  onPressed: () {
                                                    print('Button pressed ...');
                                                  },
                                                  text: FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    'llrt5ozo' /* Coming soon */,
                                                  ),
                                                  options: FFButtonOptions(
                                                    color: Color(0xCD2971FB),
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .subtitle2
                                                        .override(
                                                          fontFamily:
                                                              'AvenirArabic',
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          useGoogleFonts: false,
                                                        ),
                                                    borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                            if (functions.conditionalVisibility(
                                                getJsonField(
                                                  propertiesItem,
                                                  r'''$.attributes.property_status''',
                                                ).toString(),
                                                'Available'))
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -0.99, -0.8),
                                                child: FFButtonWidget(
                                                  onPressed: () {
                                                    print('Button pressed ...');
                                                  },
                                                  text: FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    'plfdsrsb' /* Available */,
                                                  ),
                                                  options: FFButtonOptions(
                                                    color: Color(0xFF81D05C),
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .subtitle2
                                                        .override(
                                                          fontFamily:
                                                              'AvenirArabic',
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          useGoogleFonts: false,
                                                        ),
                                                    borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                            if (functions.conditionalVisibility(
                                                getJsonField(
                                                  propertiesItem,
                                                  r'''$.attributes.property_status''',
                                                ).toString(),
                                                'Booked'))
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -0.99, -0.8),
                                                child: FFButtonWidget(
                                                  onPressed: () {
                                                    print('Button pressed ...');
                                                  },
                                                  text: FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    'kevbc07d' /* Booked */,
                                                  ),
                                                  options: FFButtonOptions(
                                                    color: Color(0xB2F5F5F5),
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .subtitle2
                                                        .override(
                                                          fontFamily:
                                                              'AvenirArabic',
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          useGoogleFonts: false,
                                                        ),
                                                    borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
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
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'AvenirArabic',
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    useGoogleFonts: false,
                                                  ),
                                            ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'y61ahqus' /* Approved Banks */,
                                              ),
                                              textAlign: TextAlign.end,
                                              style: FlutterFlowTheme.of(
                                                      context)
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
                                                    'n8poxzbo' /* ,  */,
                                                  ),
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
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: List.generate(
                                                      banks.length,
                                                      (banksIndex) {
                                                    final banksItem =
                                                        banks[banksIndex];
                                                    return Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 8, 0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(11),
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
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '4ib4fmbw' /* Installment starting from */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
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
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'df86lsot' /* Total property price */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
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
                                            4, 1, 0, 25),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  valueOrDefault<String>(
                                                    functions.formatAmount(
                                                        valueOrDefault<String>(
                                                      getJsonField(
                                                        propertiesItem,
                                                        r'''$.attributes.property_initial_installment''',
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
                                                      'xk3izs5s' /*  SAR/Monthly */,
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
                                                  valueOrDefault<String>(
                                                    functions
                                                        .formatAmountWithoutDecimal(
                                                            valueOrDefault<
                                                                String>(
                                                      getJsonField(
                                                        propertiesItem,
                                                        r'''$..property_price''',
                                                      ).toString(),
                                                      '0',
                                                    )),
                                                    '0',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
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
                                                    '66rkg6uk' /*  SAR */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
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
      ),
    );
  }
}
