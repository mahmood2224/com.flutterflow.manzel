import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingViewWidget extends StatefulWidget {
  const OnboardingViewWidget({Key key}) : super(key: key);

  @override
  _OnboardingViewWidgetState createState() => _OnboardingViewWidgetState();
}

class _OnboardingViewWidgetState extends State<OnboardingViewWidget> {
  PageController pageViewController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng currentUserLocationValue;

  @override
  void initState() {
    super.initState();
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
              height: MediaQuery.of(context).size.height * 0.8,
              child: Stack(
                children: [
                  PageView(
                    controller: pageViewController ??=
                        PageController(initialPage: 0),
                    scrollDirection: Axis.horizontal,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(0),
                            child: Image.asset(
                              'assets/images/ufpbn_1.jpg',
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.64,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 28, 0, 0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                '0rkg3m44' /* The perfect choice for 
your f... */
                                ,
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                    useGoogleFonts: false,
                                    lineHeight: 1.12,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(0),
                            child: Image.asset(
                              'assets/images/2.webp',
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.64,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 28, 0, 0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'bl6z0bqv' /* The perfect choice for 
your f... */
                                ,
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                    useGoogleFonts: false,
                                    lineHeight: 1.12,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(0),
                            child: Image.asset(
                              'assets/images/3.webp',
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.64,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 28, 0, 0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                't9rvb8ym' /* The perfect choice for 
your f... */
                                ,
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                    useGoogleFonts: false,
                                    lineHeight: 1.12,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 1),
                    child: SmoothPageIndicator(
                      controller: pageViewController ??=
                          PageController(initialPage: 0),
                      count: 3,
                      axisDirection: Axis.horizontal,
                      onDotClicked: (i) {
                        pageViewController.animateToPage(
                          i,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      effect: SlideEffect(
                        spacing: 20,
                        radius: 16,
                        dotWidth: 6,
                        dotHeight: 6,
                        dotColor: Color(0xFFDCDCDC),
                        activeDotColor: Colors.black,
                        paintStyle: PaintingStyle.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 27, 16, 18),
              child: FFButtonWidget(
                onPressed: () async {
                  logFirebaseEvent('ONBOARDING_VIEW_PAGE_getStarted_ON_TAP');
                  currentUserLocationValue = await getCurrentUserLocation(
                      defaultLocation: LatLng(0.0, 0.0));
                  // GoTohome
                  logFirebaseEvent('getStarted_GoTohome');
                  context.goNamed('HomeScreen');
                  logFirebaseEvent('getStarted_Update-Local-State');
                  setState(() =>
                      FFAppState().coordinates = currentUserLocationValue);
                },
                text: FFLocalizations.of(context).getText(
                  'bgkoinqg' /* Get Started  */,
                ),
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 56,
                  color: Color(0xFF2971FB),
                  textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'Sofia Pro By Khuzaimah',
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
                context.goNamed('Login');
              },
              child: Text(
                FFLocalizations.of(context).getText(
                  'ua0lzucz' /* Login */,
                ),
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Sofia Pro By Khuzaimah',
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
