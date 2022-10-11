import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class BankDetailsWidget extends StatefulWidget {
  const BankDetailsWidget({
    Key? key,
    this.bankId,
    this.propertyId,
  }) : super(key: key);

  final int? bankId;
  final int? propertyId;

  @override
  _BankDetailsWidgetState createState() => _BankDetailsWidgetState();
}

class _BankDetailsWidgetState extends State<BankDetailsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'bankDetails'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            alignment: AlignmentDirectional(0, -1),
            children: [
              Align(
                alignment: AlignmentDirectional(0, -1),
                child: Image.network(
                  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/living-room-ideas-carice-van-houten-living-room-nd2105-nd-atelier-carice-van-houten-050-screen-1600px-copy-1649878018.jpg',
                  width: double.infinity,
                  height: 500,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(18, 52, 18, 0),
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
                                'BANK_DETAILS_PAGE_backIcon_ON_TAP');
                            // back
                            logFirebaseEvent('backIcon_back');
                            context.pop();
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
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
                            onPressed: () {
                              print('shareIcon pressed ...');
                            },
                          ),
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
                          onPressed: () {
                            print('saveIcon pressed ...');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, 1),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 150, 0, 0),
                        child: Container(
                          width: double.infinity,
                          height: 700,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x320E151B),
                                offset: Offset(0, -2),
                              )
                            ],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: FutureBuilder<ApiCallResponse>(
                            future: BankDetailsCall.call(
                              bankId: widget.bankId,
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
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
                              }
                              final columnBankDetailsResponse = snapshot.data!;
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 22, 0, 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  22, 0, 0, 0),
                                          child: InkWell(
                                            onTap: () async {
                                              logFirebaseEvent(
                                                  'BANK_DETAILS_PAGE_Icon_w5gr2oec_ON_TAP');
                                              logFirebaseEvent(
                                                  'Icon_Navigate-To');

                                              context.goNamed(
                                                'PropertyDetails',
                                                queryParams: {
                                                  'propertyId': serializeParam(
                                                      widget.propertyId,
                                                      ParamType.int),
                                                }.withoutNulls,
                                              );
                                            },
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.black,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  80, 0, 0, 0),
                                          child: Text(
                                            valueOrDefault<String>(
                                              BankDetailsCall.bankName(
                                                columnBankDetailsResponse
                                                    .jsonBody,
                                              ).toString(),
                                              'Un-Known',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'AvenirArabic',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  useGoogleFonts: false,
                                                ),
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
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 15, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          BankDetailsCall.bankLogo(
                                            columnBankDetailsResponse.jsonBody,
                                          ),
                                          width: 130,
                                          height: 94,
                                          fit: BoxFit.cover,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 15, 20, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            valueOrDefault<String>(
                                              BankDetailsCall.bankDescription(
                                                columnBankDetailsResponse
                                                    .jsonBody,
                                              ).toString(),
                                              'Un-Known',
                                            ),
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
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 15, 20, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            valueOrDefault<String>(
                                              BankDetailsCall.bankRules(
                                                columnBankDetailsResponse
                                                    .jsonBody,
                                              ).toString(),
                                              'Un-Known',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'AvenirArabic',
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 57, 20, 20),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FFButtonWidget(
                                          onPressed: () async {
                                            logFirebaseEvent(
                                                'BANK_DETAILS_PAGE_closeBtn_ON_TAP');
                                            logFirebaseEvent(
                                                'closeBtn_Navigate-Back');
                                            context.pop();
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            'fohz964z' /* Close */,
                                          ),
                                          options: FFButtonOptions(
                                            width: 335,
                                            height: 46,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryColor,
                                            textStyle: FlutterFlowTheme.of(
                                                    context)
                                                .subtitle2
                                                .override(
                                                  fontFamily: 'AvenirArabic',
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w800,
                                                  useGoogleFonts: false,
                                                ),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
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
    );
  }
}
