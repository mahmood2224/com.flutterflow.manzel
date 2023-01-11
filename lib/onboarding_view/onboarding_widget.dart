import 'package:flutter/material.dart';
import 'package:manzel/flutter_flow/flutter_flow_theme.dart';

class OnBoardingWidget extends StatelessWidget {
  final String title  , text , image ;

  OnBoardingWidget(this.title, this.text, this.image);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: 110,),
        ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: Image.asset(
            image,
            width: MediaQuery.of(context).size.width * .75,
            height: MediaQuery.of(context).size.height * 0.30,
            fit: BoxFit.contain,
          ),
        ),
        Padding(
          padding:
          EdgeInsetsDirectional.fromSTEB(0, 75, 0, 0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context)
                .title1
                .override(
              fontFamily: 'Sofia Pro By Khuzaimah',
              color: Colors.black,
              fontWeight: FontWeight.w800,
              useGoogleFonts: false,
              lineHeight: 1.12,
            ),
          ),
        ),
        Padding(
          padding:
          EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context)
                .subtitle1
                .override(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              useGoogleFonts: false,
              lineHeight: 1.12,
            ),
          ),
        ),
      ],
    );
  }
}
