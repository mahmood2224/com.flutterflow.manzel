import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
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
      backgroundColor: Colors.white,
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
                        color: Color(0x40D7D7D7),
                        offset: Offset(0, 3),
                        spreadRadius: 0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white,
                    ),
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
                            color: FlutterFlowTheme.of(context).primaryBtnText,
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
                  padding: EdgeInsetsDirectional.fromSTEB(20, 33, 25, 0),
                  child: FutureBuilder<ApiCallResponse>(
                    future: SearchPageCitiesCall.call(),
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
                                (listViewSearchPageCitiesResponse?.jsonBody ??
                                    ''),
                                r'''$.results''',
                              )?.toList() ??
                              [];
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: cities.length,
                            itemBuilder: (context, citiesIndex) {
                              final citiesItem = cities[citiesIndex];
                              return Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 25),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.18,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFEEEEEE),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: Image.network(
                                                    valueOrDefault<String>(
                                                      getJsonField(
                                                        citiesItem,
                                                        r'''$.image''',
                                                      ),
                                                      'data:image/jpeg;base64,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',
                                                    ),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.18,
                                                    height: 100,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(10, 0, 0, 0),
                                                  child: Container(
                                                    width: 100,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                    ),
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
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                useGoogleFonts:
                                                                    false,
                                                                lineHeight: 2,
                                                              ),
                                                        ),
                                                        Text(
                                                          functions
                                                              .searchPagePropertyText(
                                                                  getJsonField(
                                                            citiesItem,
                                                            r'''$.count''',
                                                          )),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText2
                                                              .override(
                                                                fontFamily:
                                                                    'Sofia Pro By Khuzaimah',
                                                                color: Color(
                                                                    0xFF6B6B6B),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                useGoogleFonts:
                                                                    false,
                                                                lineHeight: 1,
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
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBtnText,
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
