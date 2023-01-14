import 'package:flutter/material.dart';
import 'package:manzel/flutter_flow/flutter_flow_theme.dart';
import 'package:manzel/flutter_flow/flutter_flow_util.dart';
import 'package:manzel/shared/styles/sizes.dart';
import 'package:manzel/shared/ui/components/app_bar.dart';
import 'package:manzel/shared/ui/components/custom_button.dart';
import 'package:manzel/shared/ui/components/custom_text_field.dart';
import 'package:manzel/shared/validators/general_validator.dart';

class CompleteProfileScreen extends StatefulWidget {
  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  TextEditingController _name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Container(
        padding: PAGE_EDGES_PADDING_ALL,
        width: getWidth(context),
        height:getHeight(context),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Fill Your Profile" ,style: FlutterFlowTheme.of(context).title2.copyWith(color: Colors.black),),
              SizedBox(height: getHeight(context ,ratio: 0.07),),
              CustomTextField(
                controller: _name,
                label: "Full Name",
                required: true,
                validator: GeneralValidator.requiredValidator,
                hint: "Full Name",
              ),
              SizedBox(height: getHeight(context ,ratio: 0.55),),
              CustomButton(
                  text: "Continue",
                  onPressed: (){
                    context.goNamed("congrats_screen");
                  })
            ],
          ),
        ),
      ),
    );
  }
}
