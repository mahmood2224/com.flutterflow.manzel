import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CancelReserveBottomSheetWidget extends StatefulWidget {
  const CancelReserveBottomSheetWidget({Key key}) : super(key: key);

  @override
  _CancelReserveBottomSheetWidgetState createState() =>
      _CancelReserveBottomSheetWidgetState();
}

class _CancelReserveBottomSheetWidgetState
    extends State<CancelReserveBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
          child: FFButtonWidget(
            onPressed: () {
              print('Button pressed ...');
            },
            text: FFLocalizations.of(context).getText(
              'wb43h3r4' /* Cancel Reserve */,
            ),
            options: FFButtonOptions(
              width: double.infinity,
              height: 42,
              color: Color(0xB2F5F5F5),
              textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                    fontFamily: 'Sofia Pro By Khuzaimah',
                    color: Color(0xFFD05C5C),
                    useGoogleFonts: false,
                  ),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(13),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8, 9, 8, 18),
          child: FFButtonWidget(
            onPressed: () {
              print('Button pressed ...');
            },
            text: FFLocalizations.of(context).getText(
              't7s7qd09' /* Cancel */,
            ),
            options: FFButtonOptions(
              width: 130,
              height: 42,
              color: Color(0xFFF5F5F5),
              textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                    fontFamily: 'Sofia Pro By Khuzaimah',
                    color: FlutterFlowTheme.of(context).customColor4,
                    useGoogleFonts: false,
                  ),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(13),
            ),
          ),
        ),
      ],
    );
  }
}
