import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class NoResultsFoundWidget extends StatefulWidget {
  const NoResultsFoundWidget({
    Key key,
    this.titleText,
    this.subtitleText,
    this.isButtonVisible,
    this.screenName,
  }) : super(key: key);

  final String titleText;
  final String subtitleText;
  final bool isButtonVisible;
  final String screenName;

  @override
  _NoResultsFoundWidgetState createState() => _NoResultsFoundWidgetState();
}

class _NoResultsFoundWidgetState extends State<NoResultsFoundWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if ((widget.screenName == 'Result'))
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                child: Image.asset(
                  'assets/images/NoResultsFound.png',
                  width: 38,
                  height: 37,
                  fit: BoxFit.contain,
                ),
              ),
            if ((widget.screenName == 'Notification'))
              Image.asset(
                'assets/images/NoNotificationFound.png',
                width: 38,
                height: 37,
                fit: BoxFit.contain,
              ),
            if ((widget.screenName == 'myPropertiesBooked'))
              Image.asset(
                'assets/images/myPropertiesBooked.png',
                width: 37,
                height: 36,
                fit: BoxFit.cover,
              ),
            if ((widget.screenName == 'myPropertiesFavorite'))
              Image.asset(
                'assets/images/myPropertiesFavorite.png',
                width: 37,
                height: 36,
                fit: BoxFit.cover,
              ),
          ],
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 9, 0, 0),
                child: Text(
                  widget.titleText,
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Sofia Pro By Khuzaimah',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        useGoogleFonts: false,
                      ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  widget.subtitleText,
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyText2,
                ),
              ),
            ],
          ),
        ),
        if ((widget.isButtonVisible == true))
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
            child: FFButtonWidget(
              onPressed: () async {
                logFirebaseEvent('NO_RESULTS_FOUND_EXPLORE_OUR_PROPERTIES_');
                logFirebaseEvent('Button_Navigate-To');
                context.pushNamed('HomeScreen');
              },
              text: FFLocalizations.of(context).getText(
                '1yep0j1q' /* Explore our properties */,
              ),
              options: FFButtonOptions(
                width: 215,
                height: 46,
                color: FlutterFlowTheme.of(context).primaryColor,
                textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                      fontFamily: 'Sofia Pro By Khuzaimah',
                      color: Colors.white,
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
    );
  }
}
