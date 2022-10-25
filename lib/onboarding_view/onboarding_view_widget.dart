import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
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
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
    await versionCheck(context);
      logFirebaseEvent('ONBOARDING_VIEW_OnboardingView_ON_LOAD');
      Future.delayed(const Duration(milliseconds: 100), () {
        setAppLanguage(context, FFAppState().locale);
      if (FFAppState().isInitailLaunch) {
        logFirebaseEvent('OnboardingView_Update-Local-State');
        setState(() =>
            FFAppState().locale = FFLocalizations.of(context).languageCode);
      } else {
        logFirebaseEvent('OnboardingView_Navigate-To');

        context.goNamed('HomeScreen');
      }

      logFirebaseEvent('OnboardingView_Update-Local-State');
    //   setState(
    //       () => FFAppState().locale = FFLocalizations.of(context).languageCode);

     });


    });
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'OnboardingView'});
  }
  Future<void> showUpdateDialog(
      BuildContext context, bool isForceUpdate, String packageName) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            FFAppState().locale == 'en'
                ? "New Update Available"
                : " تحديث جديد متاح ",
            style: FlutterFlowTheme.of(context).subtitle2.override(
              fontFamily: 'AvenirArabic',
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              useGoogleFonts: false,
            ),
          ),
          content: Text(
            FFAppState().locale == 'en'
                ? 'Your version of app is out of date kindly update'
                : 'يتوفر تحديث جديد لتطبيق منزل، يرجى تحديث التطبيق الى الإصدار الأحدث',
            style: FlutterFlowTheme.of(context).subtitle2.override(
              fontFamily: 'AvenirArabic',
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w300,
              useGoogleFonts: false,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  final appPackageName = packageName;

                  if (Platform.isAndroid) {
                    launchURL(
                        "https://play.google.com/store/apps/details?id=$appPackageName");
                  } else if (Platform.isIOS) {
                    launchURL(
                        'https://apps.apple.com/sa/app/%D9%85%D9%86%D8%B2%D9%84/id1630341481');
                  }
                },
                child: Text(
                  FFAppState().locale == 'en' ? 'Update' : 'تحديث',
                  style: FlutterFlowTheme.of(context).subtitle2.override(
                    fontFamily: 'AvenirArabic',
                    color: FlutterFlowTheme.of(context).primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    useGoogleFonts: false,
                  ),
                )),
            isForceUpdate
                ? SizedBox.shrink()
                : TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                FFAppState().locale == 'en' ? 'Later' : 'في وقت لاحق',
                style: FlutterFlowTheme.of(context).subtitle2.override(
                  fontFamily: 'AvenirArabic',
                  color: FlutterFlowTheme.of(context).primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  useGoogleFonts: false,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> versionCheck(BuildContext context) async {
    // Future.delayed(Duration(milliseconds: 100));
    PackageInfo info = await PackageInfo.fromPlatform();
    final appPackageName = info.packageName;
    RemoteConfig remoteConfig = await RemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 5),
      minimumFetchInterval: Duration.zero,
    ));
    await remoteConfig.fetch();
    await remoteConfig.activate();
    await remoteConfig.fetchAndActivate();
    final remote_config_settings =
    await remoteConfig.getValue('application_version').asString();
    final current_remote_version_JSON =
    jsonDecode(remote_config_settings) as Map;
    FFAppState().buildNo = int.parse(info.buildNumber);
    FFAppState().buildVersion = info.version;
    bool isAndriod = Platform.isAndroid ? true : false;
    //Minimum required version
    final min_required_version = remoteConfig.getString(isAndriod
        ? 'minimum_supported_version_android'
        : 'minimum_app_supported_version_iOS');
    //android_version or iOS version inside application_version JSON
    final recent_version = current_remote_version_JSON[
    isAndriod ? 'android_version' : 'iOS_version'];
    //Build Number
    final current_remote_build = current_remote_version_JSON[
    isAndriod ? 'android_build_number' : 'i0S_build_number'];
    //Backend version
    final current_remote_backend_version =
    current_remote_version_JSON['supported_backend_version'];
    //Force Update
    final isForceUpdate = current_remote_version_JSON['is_force_update'];
    //Installed App version
    final installed_app_version = info.version;
    //Individual decimal Value of all the version
    final arr_required_version = min_required_version.split('.');
    final arr_current_version = recent_version.split('.');
    final arr_installed_version = installed_app_version.split('.');
    //for minimum required version
    if (installed_app_version == recent_version) {
      if (FFAppState().apiVersion != current_remote_backend_version) {
        FFAppState().apiVersion = current_remote_backend_version;
        return;
      }
    } else {
      if (isForceUpdate) {
        showUpdateDialog(context, true, appPackageName);
        return;
      } else if (min_required_version != installed_app_version) {
        if (int.parse(arr_required_version[0]) >
            int.parse(arr_installed_version[0])) {
          showUpdateDialog(context, true, appPackageName);
          return;
        } else if (int.parse(arr_required_version[1]) >
            int.parse(arr_installed_version[1])) {
          showUpdateDialog(context, true, appPackageName);
          return;
        } else if (int.parse(arr_required_version[2]) >
            int.parse(arr_installed_version[2])) {
          showUpdateDialog(context, true, appPackageName);
          return;
        }
        else if (recent_version != installed_app_version) {
          if (int.parse(arr_current_version[0]) >
              int.parse(arr_installed_version[0])) {
            showUpdateDialog(context, false, appPackageName);
            return;
          } else if (int.parse(arr_current_version[1]) >
              int.parse(arr_installed_version[1])) {
            showUpdateDialog(context, false, appPackageName);
            return;
          } else if (int.parse(arr_current_version[2]) >
              int.parse(arr_installed_version[2])) {
            showUpdateDialog(context, false, appPackageName);
            return;
          }
        } else if (current_remote_build != int.parse(info.buildNumber)) {
          showUpdateDialog(context, false, appPackageName);
        }
      }
    }

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
                              'assets/images/onboardingImageCompressed.png',
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.64,
                              fit: BoxFit.cover,
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
                              'assets/images/onboardingImageCompressed.png',
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.64,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 28, 0, 0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'bl6z0bqv' /* The dream home */,
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
                              'assets/images/onboardingImageCompressed.png',
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.64,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 28, 0, 0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                't9rvb8ym' /* The dream become true */,
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
                        pageViewController!.animateToPage(
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
                  logFirebaseEvent('tutorial_complete');
                  logFirebaseEvent('ONBOARDING_VIEW_PAGE_getStarted_ON_TAP');
                  // GoTohome
                  logFirebaseEvent('getStarted_GoTohome');

                  context.goNamed('HomeScreen');

                  logFirebaseEvent('getStarted_Update-Local-State');
                  setState(() => FFAppState().isInitailLaunch = false);
                },
                text: FFLocalizations.of(context).getText(
                  'bgkoinqg' /* Get Started  */,
                ),
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 56,
                  color: FlutterFlowTheme.of(context).primaryColor,
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

                context.pushNamed('Login');

                logFirebaseEvent('goToLogin_Update-Local-State');
                setState(() => FFAppState().isInitailLaunch = false);
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
