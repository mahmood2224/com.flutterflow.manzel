import 'package:manzel/onboarding_view/onboarding_widget.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingViewWidget extends StatefulWidget {
  const OnboardingViewWidget({Key? key}) : super(key: key);

  @override
  _OnboardingViewWidgetState createState() => _OnboardingViewWidgetState();
}

class _OnboardingViewWidgetState extends State<OnboardingViewWidget> {
  PageController? pageViewController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('tutorial_begin');
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('ONBOARDING_VIEW_OnboardingView_ON_LOAD');
      if(mounted)
        setAppLanguage(context, FFAppState().locale);
      logFirebaseEvent('OnboardingView_Update-Local-State');
    });
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'OnboardingView'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.62,
              child: PageView(
                controller: pageViewController ??=
                    PageController(initialPage: 0),
                scrollDirection: Axis.horizontal,
                children: [
                  OnBoardingWidget(FFLocalizations.of(context).getText(
                    'on_boarding_1_text_title',
                  ),
                      FFLocalizations.of(context).getText(
                        'on_boarding_1_text_body',
                      ),
                      'assets/images/onboarding_3.png'),
                  OnBoardingWidget(FFLocalizations.of(context).getText(
                    'on_boarding_2_text_title' /* The dream home */,
                  ),
                      FFLocalizations.of(context).getText(
                        'on_boarding_2_text_body',
                      ), 'assets/images/onboarding_4.png'),
                  OnBoardingWidget(FFLocalizations.of(context).getText(
                    'on_boarding_3_text_title' /* The dream home */,
                  ),
                      FFLocalizations.of(context).getText(
                        'on_boarding_3_text_body',
                      ), 'assets/images/onboarding_5.png')
                ],
              ),
            ),
            const SizedBox(height: 30,),
            SmoothPageIndicator(
              controller: pageViewController ??=
                  PageController(initialPage: 0),
              count: 3,
              axisDirection: Axis.horizontal,
              onDotClicked: (i) {
                pageViewController!.animateToPage(
                  i,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
              effect: SlideEffect(
                spacing: 20,
                radius: 16,
                dotWidth: 12,
                dotHeight: 12,
                dotColor: Colors.black,
                activeDotColor: FlutterFlowTheme.of(context)
                    .primaryColor,
                paintStyle: PaintingStyle.stroke,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 50, 16, 18),
              child: FFButtonWidget(
                onPressed: () async {
                  if(pageViewController?.page == 2){
                    logFirebaseEvent('tutorial_complete');
                    logFirebaseEvent('ONBOARDING_VIEW_PAGE_getStarted_ON_TAP');
                    // GoTohome
                    logFirebaseEvent('getStarted_GoTohome');

                    context.goNamed('HomeScreen');

                    logFirebaseEvent('getStarted_Update-Local-State');
                    setState(() => FFAppState().isInitailLaunch = false);

                  }else {
                    pageViewController!.animateToPage(
                      pageViewController!.offset.toInt()+1,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }
                },
                text: FFLocalizations.of(context).getText(
                  'continue' /* Get Started  */,
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

                logFirebaseEvent('ONBOARDING_VIEW_PAGE_goToLogin_ON_TAP');
                // Go to Login
                logFirebaseEvent('goToLogin_GotoLogin');

                context.pushNamed('Login');

                logFirebaseEvent('goToLogin_Update-Local-State');
                setState(() => FFAppState().isInitailLaunch = false);
              },
              child: Text(
                FFLocalizations.of(context).getText(
                  'skip' ,
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
    );
  }
}
