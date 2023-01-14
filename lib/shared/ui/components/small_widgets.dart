import 'package:flutter/material.dart';
import 'package:manzel/flutter_flow/flutter_flow_theme.dart';

class CustomBackButtonIcon extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 36,
          height: 36,
          child: Center(
            child: Icon(Icons.arrow_back ,size: 16, color: FlutterFlowTheme.of(context).black600,),
          ),
        ),
      ],
    );
  }
}

