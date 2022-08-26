import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CancelReserveBottomSheetWidget extends StatefulWidget {
  const CancelReserveBottomSheetWidget({
    Key key,
    this.orderId,
  }) : super(key: key);

  final String orderId;

  @override
  _CancelReserveBottomSheetWidgetState createState() =>
      _CancelReserveBottomSheetWidgetState();
}

class _CancelReserveBottomSheetWidgetState
    extends State<CancelReserveBottomSheetWidget> {
  ApiCallResponse cancelOrder;

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
            onPressed: () async {
              logFirebaseEvent('CANCEL_RESERVE_BOTTOM_SHEET_CANCEL_RESER');
              logFirebaseEvent('Button_Alert-Dialog');
              var confirmDialogResponse = await showDialog<bool>(
                    context: context,
                    builder: (alertDialogContext) {
                      return AlertDialog(
                        title: Text('Cancel Reserve'),
                        content: Text(
                            'Are you sure you want to cancel your reservation?'),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.pop(alertDialogContext, false),
                            child: Text('No'),
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.pop(alertDialogContext, true),
                            child: Text('Yes'),
                          ),
                        ],
                      );
                    },
                  ) ??
                  false;
              if (confirmDialogResponse) {
                logFirebaseEvent('Button_Backend-Call');
                cancelOrder = await CancelOrderCall.call(
                  orderId: widget.orderId,
                  userId: currentUserUid,
                );
                if ((cancelOrder?.statusCode ?? 200) == 200) {
                  logFirebaseEvent('Button_Bottom-Sheet');
                  Navigator.pop(context);
                  logFirebaseEvent('Button_Close-Dialog,-Drawer,-Etc');
                  Navigator.pop(context);
                } else {
                  logFirebaseEvent('Button_Bottom-Sheet');
                  Navigator.pop(context);
                  logFirebaseEvent('Button_Show-Snack-Bar');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        functions.snackBarMessage('error', FFAppState().locale),
                        style: TextStyle(
                          color: FlutterFlowTheme.of(context).white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          height: 2,
                        ),
                      ),
                      duration: Duration(milliseconds: 4000),
                      backgroundColor: FlutterFlowTheme.of(context).primaryText,
                    ),
                  );
                }
              } else {
                logFirebaseEvent('Button_Bottom-Sheet');
                Navigator.pop(context);
              }

              setState(() {});
            },
            text: FFLocalizations.of(context).getText(
              'wb43h3r4' /* Cancel Reserve */,
            ),
            options: FFButtonOptions(
              width: double.infinity,
              height: 61,
              color: Color(0xB2F5F5F5),
              textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                    fontFamily: 'AvenirArabic',
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
          padding: EdgeInsetsDirectional.fromSTEB(8, 9, 8, 50),
          child: FFButtonWidget(
            onPressed: () async {
              logFirebaseEvent('CANCEL_RESERVE_BOTTOM_SHEET_CANCEL_BTN_O');
              logFirebaseEvent('Button_Bottom-Sheet');
              Navigator.pop(context);
            },
            text: FFLocalizations.of(context).getText(
              't7s7qd09' /* Cancel */,
            ),
            options: FFButtonOptions(
              width: 130,
              height: 61,
              color: Color(0xFFF5F5F5),
              textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                    fontFamily: 'AvenirArabic',
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
