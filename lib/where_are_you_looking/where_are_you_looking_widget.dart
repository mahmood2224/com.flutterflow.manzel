import 'package:manzel/common_alert_dialog/common_alert_dialog.dart';
import 'package:manzel/common_widgets/manzel_icons.dart';

import '../backend/api_requests/api_calls.dart';
import '../components/no_result_widget.dart';
import '../components/something_went_wrong_widget.dart';
import '../flutter_flow/custom_functions.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class WhereAreYouLookingWidget extends StatefulWidget {
  const WhereAreYouLookingWidget({
    Key? key,
    this.city,
    this.homeScreenLength,
  }) : super(key: key);

  final String? city;
  final int? homeScreenLength;

  @override
  _WhereAreYouLookingWidgetState createState() =>
      _WhereAreYouLookingWidgetState();
}

class _WhereAreYouLookingWidgetState extends State<WhereAreYouLookingWidget> {
  ApiCallResponse? listViewSearchPageCitiesResponse;
  bool isLoading = true;
  bool? isInternetAvailable;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List? citiesList;

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'WhereAreYouLooking'});
    bookedPropertiesCall();
  }

  Future<void> bookedPropertiesCall() async {
    isInternetAvailable = await isInternetConnected();
    if (isInternetAvailable ?? false) {
      isLoading = false;
      setState((){});
      listViewSearchPageCitiesResponse = await SearchPageCitiesCall.call(
        locale: FFAppState().locale,
        populate: 'city',
      );
      citiesList = getJsonField(
        listViewSearchPageCitiesResponse?.jsonBody,
        r'''$.results''',
      ).toList();
      isLoading = false;
      setState(() {});
    } else {
      listViewSearchPageCitiesResponse=null;
      isLoading = false;
      setState(() {});
      showDialog(
        context: context,
        builder: (BuildContext context) => CommonAlertDialog(
          onCancel: () {
            Navigator.pop(context);
          },
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
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(14, 22, 14, 22),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 17,
                        color: Color(0x0B000000),
                        offset: Offset(0, 3),
                        spreadRadius: 0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(23, 0, 0, 0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'qlysszro' /* Where are you  looking ? */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'AvenirArabic',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w300,
                                    useGoogleFonts: false,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 9, 0),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 9,
                                color: Color(0x06000000),
                              )
                            ],
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xFFF4F4F4),
                              width: 1,
                            ),
                          ),
                          child: InkWell(
                            onTap: () async {
                              logFirebaseEvent(
                                  'WHERE_ARE_YOU_LOOKING_Icon_dyncjlz2_ON_T');
                              logFirebaseEvent('Icon_Navigate-Back');
                              context.pop();
                            },
                            child: Icon(
                              Manzel.clear,
                              color: Colors.black,
                              size: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 25, 0),
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
                      } else if (listViewSearchPageCitiesResponse?.statusCode ==
                              200 &&
                          listViewSearchPageCitiesResponse != null) {
                        return Builder(
                          builder: (context) {
                            if (citiesList?.isEmpty ?? false) {
                              return Center(
                                child: Container(
                                  width: 280,
                                  height: 169,
                                  child: NoResultWidget(
                                    titleText: functions.emptyListWidgetTitle(
                                        'cityList', FFAppState().locale),
                                    screenName: 'result',
                                  ),
                                ),
                              );
                            }
                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: citiesList?.length,
                              itemBuilder: (context, citiesIndex) {
                                final citiesItem = citiesList?[citiesIndex];
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 15, 0, 0),
                                  child: InkWell(
                                    onTap: () async {
                                      logFirebaseEvent(
                                          'WHERE_ARE_YOU_LOOKING_Container_errzn6go');
                                      logFirebaseEvent('Container_Navigate-To');
                                      context.pushNamed(
                                        'SearchCityResult',
                                        queryParams: {
                                          'cityName': serializeParam(
                                              getJsonField(
                                                citiesItem,
                                                r'''$.name''',
                                              ).toString(),
                                              ParamType.String),
                                          'propertiesAvailable': serializeParam(
                                              getJsonField(
                                                citiesItem,
                                                r'''$.count''',
                                              ),
                                              ParamType.int),
                                          'homeScreenLength': serializeParam(
                                              widget.homeScreenLength,
                                              ParamType.int),
                                        }.withoutNulls,
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 52,
                                          decoration: BoxDecoration(),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  width: 100,
                                                  height: 100,
                                                  decoration: BoxDecoration(),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 46,
                                                        height: 46,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            child: getJsonField(
                                                                        citiesItem,
                                                                        r'''$.image''') ==
                                                                    ''
                                                                ? Image.network(
                                                                    getJsonField(
                                                                      citiesItem,
                                                                      r'''$.image''',
                                                                    ),
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.46,
                                                                    height: 46,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )
                                                                : Icon(
                                                                    Manzel
                                                                        .location_pin,
                                                                    size: 33,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                  )),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(10,
                                                                      0, 0, 0),
                                                          child: Container(
                                                            width: 100,
                                                            height: 100,
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  getJsonField(
                                                                    citiesItem,
                                                                    r'''$.name''',
                                                                  ).toString(),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyText2
                                                                      .override(
                                                                        fontFamily:
                                                                            'AvenirArabic',
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        useGoogleFonts:
                                                                            false,
                                                                      ),
                                                                ),
                                                                Expanded(
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        getJsonField(
                                                                          citiesItem,
                                                                          r'''$.count''',
                                                                        ).toString(),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText2
                                                                            .override(
                                                                              fontFamily: 'AvenirArabic',
                                                                              color: Color(0xFF6B6B6B),
                                                                              fontWeight: FontWeight.w300,
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
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'wptanz77' /* properties available  */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'AvenirArabic',
                                                                                color: Color(0xFF676767),
                                                                                useGoogleFonts: false,
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
                                              Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
                                                  color: Colors.black,
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider()
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      } else if (listViewSearchPageCitiesResponse?.statusCode !=
                              null &&
                          listViewSearchPageCitiesResponse != null) {
                        return SomethingWentWrongWidget(
                          onTryAgain: () {
                          },
                        );
                      }
                      return SizedBox();
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
}
