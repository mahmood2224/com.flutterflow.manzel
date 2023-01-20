import 'package:flutter/material.dart';
import 'package:manzel/flutter_flow/flutter_flow_theme.dart';

class CustomCheckBox extends StatelessWidget {
  bool value  = false ;
  Function(bool value) onChanged ;

  CustomCheckBox({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>onChanged(!value),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        width: 14,
        height: 14,
        decoration: BoxDecoration(
          color: value ? FlutterFlowTheme.of(context).primaryColor : Colors.white,
          border: Border.all(color: FlutterFlowTheme.of(context).primaryColor ,width: 1),
          borderRadius: BorderRadius.circular(3)
        ),
        child: value ? Center(child: Icon(Icons.check ,color: Colors.white,size: 8,)) : Container(),
      ),
    );
  }
}
