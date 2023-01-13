import 'package:flutter/material.dart';
import 'package:manzel/flutter_flow/flutter_flow_theme.dart';
import 'package:manzel/shared/styles/sizes.dart';
import 'package:manzel/shared/ui/components/custom_button.dart';
import 'package:manzel/shared/ui/components/custom_check_box.dart';
import 'package:manzel/shared/ui/components/custom_text_field.dart';
import 'package:manzel/shared/validators/auth_validator.dart';

//TODO apply translation
class registerScreen extends StatefulWidget {
  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  TextEditingController _phone = TextEditingController();

  TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool agree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).white,
      body: Container(
        width: getWidth(context),
        height: getHeight(context),
        padding: PAGE_EDGES_PADDING_ALL,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image.asset("assets/images/auth_logo.png",
                      width: getWidth(
                        context,
                        ratio: 0.8,
                      ))),
              SizedBox(
                height: getHeight(context, ratio: 0.02),
              ),
              Center(
                child: Text(
                  "Sign Up",
                  style: FlutterFlowTheme.of(context).title3.copyWith(color: Colors.black),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              CustomTextField(
                controller: _phone,
                label: "phone",
                validator: AuthValidator.validateNumber,
                required: true,
                hint: "05xxxx xxxx",
                prefixIconWidget: Row(
                  children: [
                    SizedBox(width: 8,),
                    Image.asset("assets/images/saudi_flag.png" ,width: 21,height: 15,),
                    SizedBox(width: 4,),
                    Icon(Icons.keyboard_arrow_down ,size: 25 , color: Colors.black26,)
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              CustomTextField(
                controller: _password,
                label: "Email",
                validator: AuthValidator.validateEmail,
                hint: "Please enter your email address",
                required: true,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  CustomCheckBox(
                      value: agree,
                      onChanged: (value) =>
                          setState(() => agree = value )),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Remember me",
                    style: FlutterFlowTheme.of(context)
                        .title3
                        .copyWith(fontSize: 11, fontWeight: FontWeight.w500 ,color: Colors.black),
                  )
                ],
              ),
              SizedBox(
                height: getHeight(context ,ratio: 0.05),
              ),
              Center(
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "By clicking continue, you agree",
                      style: FlutterFlowTheme.of(context)
                          .title3
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w300 ,color: Colors.black),
                    ),
                    Text(
                      "to our terms & conditions & privacy policy",
                      style: FlutterFlowTheme.of(context).title3.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: FlutterFlowTheme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getHeight(context ,ratio: 0.07),
              ),
              CustomButton(
                text: "Continue",
                validationKey: _formKey,
                onPressed: (){
                  //TODO run the API here
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
