import '../backend/api_requests/api_calls.dart';
import '../components/no_results_found_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class WhereAreYouLookingWidget extends StatefulWidget {
  const WhereAreYouLookingWidget({
    Key key,
    this.city,
  }) : super(key: key);

  final String city;

  @override
  _WhereAreYouLookingWidgetState createState() =>
      _WhereAreYouLookingWidgetState();
}

class _WhereAreYouLookingWidgetState extends State<WhereAreYouLookingWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'WhereAreYouLooking'});
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
                padding: EdgeInsetsDirectional.fromSTEB(14, 22, 14, 0),
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
                                    fontFamily: 'Sofia Pro By Khuzaimah',
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
                              Icons.clear,
                              color: Colors.black,
                              size: 24,
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
                  child: FutureBuilder<ApiCallResponse>(
                    future: SearchPageCitiesCall.call(
                      locale: FFAppState().locale,
                      populate: 'city',
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
                      final listViewSearchPageCitiesResponse = snapshot.data;
                      return Builder(
                        builder: (context) {
                          final cities = getJsonField(
                            listViewSearchPageCitiesResponse.jsonBody,
                            r'''$.results''',
                          ).toList();
                          if (cities.isEmpty) {
                            return Center(
                              child: Container(
                                width: 280,
                                height: 169,
                                child: NoResultsFoundWidget(
                                  titleText: 'No cities found',
                                  subtitleText: '                      ',
                                  isBottonVisible: false,
                                  screenName: 'Result',
                                ),
                              ),
                            );
                          }
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: cities.length,
                            itemBuilder: (context, citiesIndex) {
                              final citiesItem = cities[citiesIndex];
                              return Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 33, 0, 0),
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
                                      }.withoutNulls,
                                    );
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
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
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 46,
                                                  height: 46,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFEEEEEE),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    child: Image.network(
                                                      valueOrDefault<String>(
                                                        getJsonField(
                                                          citiesItem,
                                                          r'''$.image''',
                                                        ),
                                                        'https://cdn.pixabay.com/photo/2020/01/27/14/38/bedroom-4797364_1280.jpg',
                                                      ),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.46,
                                                      height: 46,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10, 0, 0, 0),
                                                    child: Container(
                                                      width: 100,
                                                      height: 100,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            getJsonField(
                                                              citiesItem,
                                                              r'''$.name''',
                                                            ).toString(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText2
                                                                .override(
                                                                  fontFamily:
                                                                      'Sofia Pro By Khuzaimah',
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Text(
                                                                getJsonField(
                                                                  citiesItem,
                                                                  r'''$.count''',
                                                                ).toString(),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText2
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
                                                                      lineHeight:
                                                                          1,
                                                                    ),
                                                              ),
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'wptanz77' /*  properties available */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily:
                                                                          'Sofia Pro By Khuzaimah',
                                                                      color: Color(
                                                                          0xFF676767),
                                                                      useGoogleFonts:
                                                                          false,
                                                                    ),
                                                              ),
                                                            ],
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
                                            Icons.arrow_forward_ios_outlined,
                                            color: Colors.black,
                                            size: 20,
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
                      );
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
