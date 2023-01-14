import 'package:flutter/material.dart';

import 'package:manzel/flutter_flow/flutter_flow_util.dart';
class SplashViewWidget extends StatefulWidget {
  BuildContext context ;
  final AppStateNotifier? appStateNotifier;

  SplashViewWidget(this.context ,{this.appStateNotifier});

  @override
  State<SplashViewWidget> createState() => SplashViewWidgetState();
}



class SplashViewWidgetState extends State<SplashViewWidget> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage("assets/images/splash_bg.png"),
                fit: BoxFit.fill
              )
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: Image.asset(
                "assets/images/manzel_logo_3.png"),
          )
        ],
      ),
    );
  }
}
