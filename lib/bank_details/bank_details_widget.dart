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
    Key key,
    this.bankId,
    this.propertyId,
  }) : super(key: key);

  final int bankId;
  final int propertyId;

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
              Column(
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
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 22, 0, 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            22, 0, 0, 0),
                                        child: InkWell(
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'BANK_DETAILS_PAGE_Icon_w5gr2oec_ON_TAP');
                                            logFirebaseEvent(
                                                'Icon_Navigate-Back');
                                            context.pop();
                                          },
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            80, 0, 0, 0),
                                        child: Text(
                                          valueOrDefault<String>(
                                            PropertyCall.bankName(
                                              (columnPropertyResponse
                                                      ?.jsonBody ??
                                                  ''),
                                            ).toString(),
                                            'Un-Known',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily:
                                                    'Sofia Pro By Khuzaimah',
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
                                    children: [
                                      Image.network(
                                        'data:image/jpeg;base64,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',
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
                                            PropertyCall.bankDescription(
                                              (columnPropertyResponse
                                                      ?.jsonBody ??
                                                  ''),
                                            ).toString(),
                                            'Un-Known',
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
                                            PropertyCall.bankRules(
                                              (columnPropertyResponse
                                                      ?.jsonBody ??
                                                  ''),
                                            ).toString(),
                                            'Un-Known',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily:
                                                    'Sofia Pro By Khuzaimah',
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
                                        text:
                                            FFLocalizations.of(context).getText(
                                          'fohz964z' /* Close */,
                                        ),
                                        options: FFButtonOptions(
                                          width: 335,
                                          height: 46,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .subtitle2
                                                  .override(
                                                    fontFamily:
                                                        'Sofia Pro By Khuzaimah',
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w800,
                                                    useGoogleFonts: false,
                                                  ),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          borderRadius: 12,
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
            ],
          ),
        ),
      ),
    );
  }
}
