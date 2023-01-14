import 'package:flutter/material.dart';
import 'package:manzel/flutter_flow/flutter_flow_theme.dart';
import 'package:manzel/flutter_flow/flutter_flow_util.dart';
import 'package:manzel/shared/styles/sizes.dart';
import 'package:manzel/shared/ui/components/app_bar.dart';
import 'package:manzel/shared/ui/components/custom_button.dart';
import 'package:manzel/shared/utils/directions.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

//TODO apply translation
class OtpScreen extends StatefulWidget {
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController _code = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Verification", actions: [
        Padding(
          padding: PAGE_EDGES_PADDING_ALL,
          child: Icon(
            Icons.close,
            color: Colors.black,
          ),
        )
      ]),
      body: Container(
        width: getWidth(context),
        height: getHeight(context),
        padding: PAGE_EDGES_PADDING_HORIZONTAL,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: getHeight(
                context,
                ratio: 0.05,
              )),
              Text(
                "We'll send a verification code to Your contact so you can login or create an account",
                style: FlutterFlowTheme.of(context).title3.copyWith(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: getHeight(context, ratio: 0.2),
              ),
              Text(
                "Code has been send to +0565******39",
                style: FlutterFlowTheme.of(context).title3.copyWith(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: getHeight(context, ratio: 0.05),
              ),
              Directionality(
                textDirection: getTextDirectionLTR(),
                child: PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(6),
                      fieldHeight: 44,
                      fieldWidth: 48,
                      inactiveColor: Colors.black12,
                      selectedColor: Colors.black12,
                      activeFillColor: Colors.white,
                      activeColor: FlutterFlowTheme.of(context).primaryColor,
                      selectedFillColor: Colors.white,
                      inactiveFillColor: Colors.white),
                  animationDuration: Duration(milliseconds: 300),
                  enableActiveFill: true,
                  cursorColor: Colors.black26,
                  controller: _code,
                  onCompleted: (v) {},
                  onChanged: (value) {},
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                  appContext: context,
                ),
              ),
              SizedBox(
                height: getHeight(context, ratio: 0.05),
              ),
              Text.rich(
                TextSpan(text: "Resend code in ",
                    children: [
                  TextSpan(
                      text: "45",
                      style: TextStyle(
                          color: FlutterFlowTheme.of(context).primaryColor  )),
                      TextSpan(
                          text: " s",
                          style: TextStyle(
                              color: FlutterFlowTheme.of(context).primaryColor  ))
                ]),
              ),
              SizedBox(
                height: getHeight(context, ratio: 0.25),
              ),
              CustomButton(
                text : "Get Started",
                onPressed: (){
                  context.goNamed("complete_profile");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
