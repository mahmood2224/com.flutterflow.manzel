import 'package:flutter/material.dart';
import 'package:manzel/flutter_flow/flutter_flow_theme.dart';
import 'package:manzel/flutter_flow/flutter_flow_widgets.dart';
import 'package:manzel/flutter_flow/internationalization.dart';

class SomethingWentWrongWidget extends StatelessWidget {
  final VoidCallback onTryAgain;
  const SomethingWentWrongWidget({
    Key? key, required this.onTryAgain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: new BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Column(
          children: [
            Text(
              FFLocalizations.of(context).getText(
                'somethingWent' /* Something Went Wrong  */,
              ),
              style: FlutterFlowTheme.of(context).subtitle2.override(
                fontFamily: 'AvenirArabic',
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                useGoogleFonts: false,
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              width: 100,
              child: FFButtonWidget(
                onPressed: onTryAgain,
                text: FFLocalizations.of(context).getText(
                  'tryAgain' /* Try Again */,
                ),
                options: FFButtonOptions(
                  height: 38,
                  padding: EdgeInsetsDirectional.fromSTEB(9, 0, 0, 0),
                  color: FlutterFlowTheme.of(context).primaryColor,
                  textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                    fontFamily: 'AvenirArabic',
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    useGoogleFonts: false,
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
