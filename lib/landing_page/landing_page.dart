import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:manzel/flutter_flow/flutter_flow_theme.dart';
import 'package:manzel/flutter_flow/flutter_flow_util.dart';
import 'package:manzel/flutter_flow/flutter_flow_widgets.dart';
import 'package:manzel/flutter_flow/internationalization.dart';
import 'package:manzel/helper/asset_provider.dart';
class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => LandingPageState();
}



class LandingPageState extends State<LandingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .1,),
              Image.asset(assetsImages+"onboarding_2.png",
                width: MediaQuery.of(context).size.width * .75,
                height: MediaQuery.of(context).size.width * .75,
              ),
              SizedBox(height: 30,),
              Image.asset(assetsImages+"language.png",height: 115,width: 200,),
              SizedBox(height: MediaQuery.of(context).size.height * .04,),

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 50, 16, 18),
                child: FFButtonWidget(
                  onPressed: () async {
                    changeLanguageAndNavigate(context , true);
                  },
                  text: FFLocalizations.of(context).getText(
                    'ar_lang'
                  ),
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 56,
                    color: FlutterFlowTheme.of(context).primaryColor,
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      useGoogleFonts: false,
                    ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  changeLanguageAndNavigate(context,false);
                },
                child: Text(
                  FFLocalizations.of(context).getText(
                    'en_lang' ,
                  ),
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    useGoogleFonts: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeLanguageAndNavigate(BuildContext context , bool changeLanguage) {
    if (changeLanguage) {
      // changeToArabic
      logFirebaseEvent('changeLanguage_changeToArabic');
      setAppLanguage(context, 'ar');
      logFirebaseEvent('changeLanguage_Update-Local-State');
      setState(() => FFAppState().locale = 'ar');
      logFirebaseEvent('changeLanguage_Update-Local-State');
      setState(() => FFAppState().locale = 'ar');
    } else {
      // changeToEnglish
      logFirebaseEvent('changeLanguage_changeToEnglish');
      setAppLanguage(context, 'en');
      logFirebaseEvent('changeLanguage_Update-Local-State');
      setState(() => FFAppState().locale = 'en');
      logFirebaseEvent('changeLanguage_Update-Local-State');
      setState(() => FFAppState().locale = 'en');
    }
    context.goNamed("onBoardingView");
  }
}
