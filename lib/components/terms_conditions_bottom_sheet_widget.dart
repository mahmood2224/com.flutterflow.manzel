import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsConditionsBottomSheetWidget extends StatefulWidget {
  const TermsConditionsBottomSheetWidget({Key key}) : super(key: key);

  @override
  _TermsConditionsBottomSheetWidgetState createState() =>
      _TermsConditionsBottomSheetWidgetState();
}

class _TermsConditionsBottomSheetWidgetState
    extends State<TermsConditionsBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
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
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 24,
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
                          FFLocalizations.of(context).getText(
                            'dn9pwlw2' /* Terms & Conditions */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
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
              data: 'paragraph</p>',
            ),
          ),
        ),
      ],
    );
  }
}
