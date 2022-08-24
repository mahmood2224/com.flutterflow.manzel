import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsConditionsBottomSheetWidget extends StatefulWidget {
  const TermsConditionsBottomSheetWidget({
    Key key,
    this.pageType,
  }) : super(key: key);

  final int pageType;

  @override
  _TermsConditionsBottomSheetWidgetState createState() =>
      _TermsConditionsBottomSheetWidgetState();
}

class _TermsConditionsBottomSheetWidgetState
    extends State<TermsConditionsBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBtnText,
      ),
      child: FutureBuilder<ApiCallResponse>(
        future: TermsConitionsAndPrivacyPoliciesCall.call(
          pageType: widget.pageType,
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
          final columnTermsConitionsAndPrivacyPoliciesResponse = snapshot.data;
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).white,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                        child: InkWell(
                          onTap: () async {
                            logFirebaseEvent(
                                'TERMS_CONDITIONS_BOTTOM_SHEET_Icon_hhw3c');
                            logFirebaseEvent('Icon_Bottom-Sheet');
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                valueOrDefault<String>(
                                  getJsonField(
                                    columnTermsConitionsAndPrivacyPoliciesResponse
                                        .jsonBody,
                                    r'''$.data.attributes.title''',
                                  ).toString(),
                                  'null',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'AvenirArabic',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: false,
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
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                  child: Html(
                    data: valueOrDefault<String>(
                      getJsonField(
                        columnTermsConitionsAndPrivacyPoliciesResponse.jsonBody,
                        r'''$.data.attributes.description''',
                      ).toString(),
                      'null',
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
