import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manzel/auth_flow/choose_verification/data/models/verification_card_builder.dart';
import 'package:manzel/flutter_flow/flutter_flow_theme.dart';
import 'package:manzel/shared/styles/sizes.dart';

//TODO apply translation
class VerificationCard extends StatelessWidget {
  bool isSelected = false ; 
  Widget? child ;
  VerificationCardBuilder? builderModel ;
  Function(bool value ) onChange;

  VerificationCard({required this.isSelected, this.child, required this.onChange , this.builderModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      onTap: ()=> onChange(!this.isSelected),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        width: getWidth(context) - 40,
        padding: PAGE_EDGES_PADDING_ALL,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).white,
          border: Border.all(color: isSelected? FlutterFlowTheme.of(context).primaryColor : Colors.black12 ,width: 2),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius:1
            )
          ]
        ),
        child: _getBody(context),
      ),
    );
  }

  _getBody(BuildContext context){
    if(child != null)
      return child ;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryColor.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: builderModel?.iconWidget ??
                Image.asset(builderModel?.iconsString??"" ,width: 28, height: 28,),
          ),
        ),
        SizedBox(width: 16,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(builderModel?.label??"" , style: FlutterFlowTheme.of(context).labelText,),
            Text(builderModel?.text??"" ,style: FlutterFlowTheme.of(context).title3.copyWith( fontSize:  15 , fontWeight: FontWeight.w500 ,color: Colors.black),),
          ],
        )
      ],
    );
  }
}
