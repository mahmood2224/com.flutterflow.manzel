import 'package:flutter/material.dart';
import 'package:manzel/auth_flow/choose_verification/data/enum/choose_verification.enum.dart';
import 'package:manzel/auth_flow/choose_verification/data/models/verification_card_builder.dart';
import 'package:manzel/auth_flow/choose_verification/ui/widgets/card.dart';
import 'package:manzel/flutter_flow/flutter_flow_theme.dart';
import 'package:manzel/flutter_flow/flutter_flow_util.dart';
import 'package:manzel/shared/styles/sizes.dart';
import 'package:manzel/shared/ui/components/app_bar.dart';
import 'package:manzel/shared/ui/components/custom_button.dart';

//TODO apply translation
class ChooseVreificationScreen extends StatefulWidget {

  @override
  State<ChooseVreificationScreen> createState() => _ChooseVreificationScreenState();
}

class _ChooseVreificationScreenState extends State<ChooseVreificationScreen> {
  VerificationType _type = VerificationType.none;
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
        padding: PAGE_EDGES_PADDING_ALL,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: getHeight(context ,ratio: 0.01,)),
              Text("We'll send a verification code to Your contact so you can login or create an account" ,style: FlutterFlowTheme.of(context).title3Black, textAlign: TextAlign.center,),
              SizedBox(height: getHeight(context ,ratio: 0.01,)),
              Image.asset("assets/images/verification_image.png" , width: getWidth(context ,ratio: 0.6),),
              SizedBox(height: getHeight(context ,ratio: 0.01,)),
              VerificationCard(
                isSelected: _type == VerificationType.phone,
                builderModel: VerificationCardBuilder(
                  label: "via SMS:",
                  text: "05XXXXX215",
                  iconsString: "assets/images/sms_verify.png"
                ),
                onChange: (value){
                  if(value)
                    setState(()=>_type = VerificationType.phone);
                },
              ),
              SizedBox(height: 16,),
              VerificationCard(
                isSelected: _type == VerificationType.email,
                builderModel: VerificationCardBuilder(
                    label: "via email:",
                    text: "05XXXXX215",
                    iconsString: "assets/images/mail_verify.png"
                ),
                onChange: (value){
                  if(value)
                    setState(()=>_type = VerificationType.email);
                },
              ),
              SizedBox(height: getHeight(context ,ratio: 0.07),),
              CustomButton(
                text: "Continue",
                onPressed: (){
                  context.goNamed("otp");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
