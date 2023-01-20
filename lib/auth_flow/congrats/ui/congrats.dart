import 'package:flutter/material.dart';
import 'package:manzel/flutter_flow/flutter_flow_theme.dart';
import 'package:manzel/shared/styles/sizes.dart';
import 'package:manzel/shared/ui/components/app_bar.dart';
import 'package:manzel/shared/ui/components/custom_button.dart';
import 'package:manzel/shared/ui/components/custom_text_field.dart';
import 'package:manzel/shared/validators/general_validator.dart';

class CongratsScreen extends StatefulWidget {
  @override
  State<CongratsScreen> createState() => _CongratsScreenState();
}

class _CongratsScreenState extends State<CongratsScreen> {
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
              SizedBox(height: getHeight(context ,ratio: 0.1),),
              Center(
                  child: Image.asset("assets/images/auth_logo.png",
                      width: getWidth(
                        context,
                        ratio: 0.8,
                      ))),
              SizedBox(height: getHeight(context ,ratio: 0.12),),
              Text("Congrats !" ,style: FlutterFlowTheme.of(context).title1.copyWith(fontSize: 28 , color: FlutterFlowTheme.of(context).primaryColor ),),
              SizedBox(height: getHeight(context ,ratio: 0.1),),
              CustomButton(
                text: "Start",
                onPressed: (){},
              )

            ],
          ),
        ),
      ),
    );
  }
}
