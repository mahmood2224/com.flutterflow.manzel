import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum MessageType { SUCCESS, ERROR }
void showInSnackBar(
    {required String value,
      required BuildContext context ,
      Color? color}) {
  if(value.isEmpty) return;
  Flushbar(
    message: value,
    flushbarPosition: FlushbarPosition.BOTTOM,
    backgroundColor: color??Colors.red,
    isDismissible: true,
    duration: Duration(seconds: 2),
  ).show(context);
}
showAlertMessage(BuildContext context,{required String message ,Color? backgroundColor }){
  showInSnackBar(value: message, context: context , color: backgroundColor);
}
