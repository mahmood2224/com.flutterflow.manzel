import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzel/auth_flow/auth_cubit/auth_cubit.dart';
import 'package:manzel/flutter_flow/flutter_flow_theme.dart';

class OtpTimerWidget extends StatefulWidget {

  @override
  State<OtpTimerWidget> createState() => _OtpTimerWidgetState();
}

class _OtpTimerWidgetState extends State<OtpTimerWidget> {
  late final AuthCubit _cubit ;
  int seconds = 45 ;
  Timer? _timer ;
  @override
  void initState() {
    _cubit = BlocProvider.of<AuthCubit>(context);
    _startTimer();
    super.initState();
  }

  _startTimer(){
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if(seconds == 0 ){
        _timer?.cancel();
        return;
      }
      if(mounted)
        setState(()=>seconds-=1) ;
    });
  }
  @override
  Widget build(BuildContext context) {
    return seconds == 0 ? InkWell(
        onTap: (){
          _cubit.generateOtp();
        },
        child: Text("Resend Code" ,style: FlutterFlowTheme.of(context).title3.copyWith(color: FlutterFlowTheme.of(context).primaryColor ,decoration: TextDecoration.underline ,fontSize: 14),)): Text.rich(
      TextSpan(text: "Resend code in ", children: [
        TextSpan(
            text: "$seconds",
            style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryColor)),
        TextSpan(
            text: " s ",
            style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryColor))
      ]),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
