import 'package:flutter/material.dart';
import 'package:manzel/flutter_flow/flutter_flow_theme.dart';



import 'Loading.dart';


class CustomButton extends StatelessWidget {
  String? text ;
  Function onPressed ;
  double? width ;
  double? height ;
  double? textSize ;
  BoxDecoration? decoration;
  Color? textColor ;
  bool? loading ;
  Color? background ;
  Border? border ;
  bool outLine ;
  Widget? icon ;
  Widget? textWidget ;
  double? borderRadius;
  BorderRadius? borderRadiusObject ;
  bool isSpaceBetween ;
  GlobalKey<FormState> ? validationKey ;

  CustomButton({ this.validationKey,this.borderRadius,this.outLine = false,this.borderRadiusObject,this.textSize = 16,this.text,this.textWidget, this.icon, this.background , this.border,required this.onPressed, this.width, this.height ,this.decoration ,this.textColor,this.loading =false , this.isSpaceBetween = false });

  @override
  Widget build(BuildContext context) {
    return (this.loading??false) ? Loading():InkWell(
      onTap: (){
        // hideKeyboard(context);
        if(validationKey != null ) {
          if (validationKey?.currentState?.validate() ?? false)
            this.onPressed();
        }
        else {
          this.onPressed();
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        width: width ,
        height: height ?? 50,
        padding: EdgeInsets.symmetric(horizontal: this.isSpaceBetween ? 16 : 0 ),
        decoration: decoration ?? BoxDecoration(
          color:this.outLine ? FlutterFlowTheme.of(context).background: this.background ?? FlutterFlowTheme.of(context).primaryColor,
          borderRadius:this.borderRadiusObject ??BorderRadius.circular(borderRadius ?? 12),
          border: this.outLine? Border.all(color: FlutterFlowTheme.of(context).primaryColor): this.border
        ),
        child:Row(
          mainAxisAlignment: this.isSpaceBetween ? MainAxisAlignment.spaceBetween :MainAxisAlignment.center,
          children: [
            this.textWidget!= null ? this.textWidget??Container() :Text(text??"" , style: TextStyle(color:this.outLine? FlutterFlowTheme.of(context).primaryColor: textColor??Colors.white , fontSize: this.textSize , fontWeight: FontWeight.bold),),
            this.icon!= null && (this.text?.isNotEmpty??false) ? SizedBox(width: 8,) : Container(),
            this.icon??Container(),
          ],
        )
      ),
    );
  }
}
