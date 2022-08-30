import 'dart:async';

import 'package:flutter/material.dart';

import '../flutter_flow/internationalization.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget(
      {Key key, @required this.onComplete, @required this.duration})
      : super(key: key);
  final Function(VoidCallback restart) onComplete;
  final Duration duration;

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer _timer;
  Duration start;

  @override
  void initState() {
    super.initState();
    restart();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  void restart() {
    start = widget.duration;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (start.inSeconds == 0) {
        _timer?.cancel();
        _timer = null;
        widget.onComplete(restart);
      } else {
        start = Duration(seconds: start.inSeconds - 1);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(start.inMinutes.remainder(60));
    final seconds = strDigits(start.inSeconds.remainder(60));
    //return Text('Resend OTP${minutes.toString()}:${seconds.toString()}',style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w700),);
    return RichText(
      text: TextSpan(
        text: FFLocalizations.of(context).getText(
          'ResendTimer' /* Confirm your mobile number */,
        ),
        style: TextStyle(
            fontFamily: 'Sofia Pro By Khuzaimah',
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w300),
        children: <TextSpan>[
          TextSpan(
            text: '${minutes.toString()}:${seconds.toString()}',
            style: TextStyle(
              fontFamily: 'Sofia Pro By Khuzaimah',
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
