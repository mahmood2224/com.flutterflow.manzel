import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class NoResultWidget extends StatefulWidget {
  const NoResultWidget({
    Key key,
    this.titleText,
    this.screenName,
  }) : super(key: key);

  final String titleText;
  final String screenName;

  @override
  _NoResultWidgetState createState() => _NoResultWidgetState();
}

class _NoResultWidgetState extends State<NoResultWidget> {
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
            if (widget.screenName == 'result')
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                child: Image.asset(
                  'assets/images/NoResultsFound.png',
                  width: 38,
                  height: 37,
                  fit: BoxFit.contain,
                ),
              ),
            if (widget.screenName == 'notification')
              Image.asset(
                'assets/images/NoNotificationFound.png',
                width: 38,
                height: 37,
                fit: BoxFit.contain,
              ),
            if (widget.screenName == 'offer')
              Image.asset(
                'assets/images/offerScreenNoResult.png',
                width: 38,
                height: 37,
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
      ],
    );
  }
}
