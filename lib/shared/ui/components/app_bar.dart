import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manzel/flutter_flow/flutter_flow_theme.dart';
import 'package:manzel/shared/ui/components/small_widgets.dart';
PreferredSize customAppBar(BuildContext context,
    {String title = "",
    Widget? titleWidget,
      bool withIcons = false,
      Function? onBack ,
    Color? backgroundColor,
    GlobalKey<ScaffoldState>? scaffoldKey,
    List<Widget>? actions,
    Widget? leading,
    PreferredSizeWidget? bottom}) {
  return PreferredSize(
    child: Container(
      child: AppBar(
          elevation: 0.0,
          bottom: bottom,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: titleWidget ??
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
          ),
          actions: actions ?? [],
          leading: leading ??
              (canPop(context)
                  ? InkWell(
                      onTap: () {
                        if(onBack == null )
                          Navigator.of(context).pop(true);
                        else
                          onBack();
                      },
                      child: CustomBackButtonIcon())
                  : null),
          backgroundColor: backgroundColor ?? FlutterFlowTheme.of(context).white,
          iconTheme: IconThemeData(
            color: FlutterFlowTheme.of(context).primaryColor,
            size: 18, //change your color here
          )),
    ),
    preferredSize: Size.fromHeight(bottom == null ? 60 : 75),
  );
}

canPop(BuildContext context) {
  return Navigator.canPop(context);
}
