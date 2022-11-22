import 'dart:io';
import 'dart:math' as math;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:manzel/common_alert_dialog/common_alert_dialog.dart';
import 'package:manzel/common_widgets/manzel_icons.dart';
import 'package:manzel/flutter_flow/custom_functions.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../auth/auth_util.dart';
import '../auth/firebase_user_provider.dart';
import '../backend/backend.dart';
import '../components/help_and_support_bottom_sheet_widget.dart';
import '../components/terms_conditions_bottom_sheet_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../custom_code/actions/index.dart' as actions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart' as material;

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  bool? changeLanguage;
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static const String kWhatsAppAndroid = 'https://api.whatsapp.com/send?phone=';
  static const String kWhatsAppIOS = 'https://wa.me/';
  int? appVersion;
  int? appBuildNo;

  @override
  void initState() {
    super.initState();
    //buildInfo();
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Profile'});
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (loggedIn)
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 30, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            AuthUserStreamWidget(
                              child: Text(
                                valueOrDefault(currentUserDocument?.name, ''),
                                style: FlutterFlowTheme.of(context)
                                    .title1
                                    .override(
                                      fontFamily: 'AvenirArabic',
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800,
                                      useGoogleFonts: false,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 10, 216, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            AuthUserStreamWidget(
                              child: Directionality(
                                  textDirection: material.TextDirection.ltr,
                                  child: Text(
                                    currentPhoneNumber,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Sofia Pro By Khuzaimah',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300,
                                          useGoogleFonts: false,
                                        ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 40, 282, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                'zpi4cs66' /* Account */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .subtitle1
                                  .override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                    useGoogleFonts: false,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 25, 26, 0),
                        child: InkWell(
                          onTap: () async {
                            logFirebaseEvent(
                                'PROFILE_PAGE_Row_ekepkdfw_ON_TAP');
                            // editPersonalInfo
                            logFirebaseEvent('Row_editPersonalInfo');

                            context.goNamed(
                              'EditPersonallInfo',
                              queryParams: {
                                'screenName':
                                    serializeParam('Profile', ParamType.String),
                              }.withoutNulls,
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  '9iofccrl' /* Personal info */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Sofia Pro By Khuzaimah',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: false,
                                    ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.black,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                if (!loggedIn)
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            logFirebaseEvent('PROFILE_PAGE_logIn_ON_TAP');
                            // login
                            logFirebaseEvent('logIn_login');

                            context.pushNamed('Login');
                          },
                          text: FFLocalizations.of(context).getText(
                            'vjemd3mv' /* Login */,
                          ),
                          options: FFButtonOptions(
                            width: 335,
                            height: 48,
                            color: Colors.white,
                            textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Sofia Pro By Khuzaimah',
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: false,
                                    ),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 50, 217, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'f0scnkco' /* Help & Support */,
                        ),
                        style: FlutterFlowTheme.of(context).subtitle1.override(
                              fontFamily: 'Sofia Pro By Khuzaimah',
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              useGoogleFonts: false,
                            ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 25, 26, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          '6mgqpd1r' /* Language */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Sofia Pro By Khuzaimah',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              useGoogleFonts: false,
                            ),
                      ),
                      InkWell(
                        onTap: () async {
                          logFirebaseEvent(
                              'PROFILE_PAGE_currentLanguage_ON_TAP');
                          // changeLanguage
                          logFirebaseEvent('currentLanguage_changeLanguage');
                          changeLanguage = await actions.isEnglish(
                            FFLocalizations.of(context).languageCode,
                          );
                          if (changeLanguage!) {
                            logFirebaseEvent(
                                'currentLanguage_Update-Local-State');
                            setState(() => FFAppState().locale = 'en');
                            logFirebaseEvent(
                                'currentLanguage_Update-Local-State');
                            setState(() => FFAppState().locale = 'ar');
                            // changeToArabic
                            logFirebaseEvent('currentLanguage_changeToArabic');
                            setAppLanguage(context, 'ar');
                          } else {
                            logFirebaseEvent(
                                'currentLanguage_Update-Local-State');
                            setState(() => FFAppState().locale = 'en');
                            logFirebaseEvent(
                                'currentLanguage_Update-Local-State');
                            setState(() => FFAppState().locale = 'en');
                            // changeToEnglish
                            logFirebaseEvent('currentLanguage_changeToEnglish');
                            setAppLanguage(context, 'en');
                          }

                          if (loggedIn) {
                            logFirebaseEvent('currentLanguage_Wait-Delay');
                            await Future.delayed(
                                const Duration(milliseconds: 100));
                            logFirebaseEvent('currentLanguage_Backend-Call');

                            final userUpdateData = createUserRecordData(
                              language:
                                  FFLocalizations.of(context).languageCode,
                            );
                            await currentUserReference!.update(userUpdateData);
                          }
                          if (mounted) setState(() {});
                        },
                        child: Text(
                          FFLocalizations.of(context).getVariableText(
                            enText: 'العربية',
                            arText: 'English',
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    useGoogleFonts: false,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 25, 26, 0),
                  child: InkWell(
                    onTap: () async {
                      bool isInternetAvailable = await isInternetConnected();
                      if(isInternetAvailable){
                        logFirebaseEvent('PROFILE_PAGE_Row_u1wgoua7_ON_TAP');
                        logFirebaseEvent('Row_Bottom-Sheet');
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: FlutterFlowTheme.of(context).white,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: MediaQuery.of(context).viewInsets,
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.95,
                                child: HelpAndSupportBottomSheetWidget(),
                              ),
                            );
                          },
                        ).then((value) => setState(() {}));
                      }
                      else{
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => CommonAlertDialog(
                            onCancel: () {
                              Navigator.pop(context);
                            },
                          ),
                        );
                      }

                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          FFLocalizations.of(context).getText(
                            'ltqtegrk' /* Help Center */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts: false,
                                  ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 25, 26, 0),
                  child: InkWell(
                    onTap: () async {
    bool isInternetAvailable = await isInternetConnected();
    if(isInternetAvailable){
      logFirebaseEvent('PROFILE_PAGE_Row_m107mnbe_ON_TAP');
      logFirebaseEvent('Row_Bottom-Sheet');
      await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: TermsConditionsBottomSheetWidget(
                pageType: 7,
              ),
            ),
          );
        },
      ).then((value) => setState(() {}));
    }else{
      showDialog(
        context: context,
        builder: (BuildContext context) => CommonAlertDialog(
          onCancel: () {
            Navigator.pop(context);
          },
        ),
      );
    }

                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          FFLocalizations.of(context).getText(
                            'hyxsohqj' /* About manzel */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts: false,
                                  ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 25, 26, 0),
                  child: InkWell(
                    onTap: () async {
    bool isInternetAvailable = await isInternetConnected();
    if(isInternetAvailable){
      logFirebaseEvent('PROFILE_PAGE_Row_szhcvid3_ON_TAP');
      logFirebaseEvent('Row_Bottom-Sheet');
      await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: FlutterFlowTheme.of(context).white,
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.95,
              child: TermsConditionsBottomSheetWidget(
                pageType: 5,
              ),
            ),
          );
        },
      ).then((value) => setState(() {}));
    }else{
      showDialog(
        context: context,
        builder: (BuildContext context) => CommonAlertDialog(
          onCancel: () {
            Navigator.pop(context);
          },
        ),
      );
    }

                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          FFLocalizations.of(context).getText(
                            'n8o0zh47' /* Terms & Conditions */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts: false,
                                  ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                  child: FFButtonWidget(
                    onPressed: () async{
    bool isInternetAvailable = await isInternetConnected();
    if(isInternetAvailable){
                        print('Button pressed ...');
                        openWhatsapp(context);
                      }
                      else{
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => CommonAlertDialog(
                            onCancel: () {
                              Navigator.pop(context);
                            },
                          ),
                        );
                      }


                    },
                    text: FFLocalizations.of(context).getText(
                      'u6lrslui' /* Chat Manzel in Whatsapp */,
                    ),
                    icon: Transform(
                      alignment: Alignment.center,
                      transform: FFAppState().locale == 'en'
                          ? Matrix4.rotationY(0)
                          : Matrix4.rotationY(math.pi),
                      child: Icon(
                        Manzel.whatsApp_icon,
                        size: 26,
                      ),
                    ),
                    options: FFButtonOptions(
                      elevation: 1,
                      width: 335,
                      height: 52,
                      color: Colors.white,
                      textStyle:
                          FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'AvenirArabic',
                                color: Color(0xFF4FB26D),
                                fontWeight: FontWeight.w500,
                                useGoogleFonts: false,
                              ),
                      borderSide: BorderSide(
                        color: Color(0xFF4FB26D),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                if (loggedIn)
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 31, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 335,
                          height: 48,
                          color: Colors.white,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (FFAppState().locale == 'en') {
                                logFirebaseEvent('Button_Alert-Dialog');
                                var confirmDialogResponse =
                                    await showDialog<bool>(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: Text('Confirm Logout'),
                                              content: Text(
                                                  'Are you sure you want to logout?'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext,
                                                            false),
                                                    child: Text('No')),
                                                TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext,
                                                            true),
                                                    child: Text('Yes')),
                                              ],
                                            );
                                          },
                                        ) ??
                                        false;
                                if (confirmDialogResponse) {
                                  isLoading.value = true;
                                  logFirebaseEvent(
                                      'PROFILE_PAGE_logout_ON_TAP');
                                  // Logout
                                  logFirebaseEvent('logout_Logout');
                                  GoRouter.of(context).prepareAuthEvent();
                                  await signOut();
                                  isLoading.value = false;
                                  context.goNamedAuth(
                                      'OnboardingView', mounted);
                                }
                              } else {
                                logFirebaseEvent('Button_Alert-Dialog');
                                var confirmDialogResponse = await showDialog<
                                        bool>(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title: Text('قم بتأكيد تسجيل الخروج'),
                                          content: Text(
                                              'هل أنت متأكد أنك تريد تسجيل الخروج؟'),
                                          actions: [
                                            TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, false),
                                                child: Text('لا')),
                                            TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, true),
                                                child: Text('نعم')),
                                          ],
                                        );
                                      },
                                    ) ??
                                    false;
                                if (confirmDialogResponse) {
                                  isLoading.value = true;
                                  logFirebaseEvent(
                                      'PROFILE_PAGE_logout_ON_TAP');
                                  // Logout
                                  logFirebaseEvent('logout_Logout');
                                  GoRouter.of(context).prepareAuthEvent();
                                  await signOut();
                                  isLoading.value = false;
                                  context.goNamedAuth(
                                      'OnboardingView', mounted);
                                }
                              }
                              ;
                            },
                            child: ValueListenableBuilder<bool>(
                              builder: (BuildContext context, bool value,
                                  Widget? child) {
                                return isLoading.value
                                    ? Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        Colors.black),
                                                strokeWidth: 5,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : AutoSizeText(
                                        FFLocalizations.of(context).getText(
                                          '2csoqw0t' /* Logout */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .subtitle2
                                            .override(
                                              fontFamily:
                                                  'Sofia Pro By Khuzaimah',
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              useGoogleFonts: false,
                                            ),
                                        maxLines: 1,
                                      );
                              },
                              valueListenable: isLoading,
                            ),
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                (states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    FlutterFlowTheme.of(context)
                                        .subtitle2
                                        .override(
                                          fontFamily: 'AvenirArabic',
                                          color: Colors.black,
                                          useGoogleFonts: false,
                                        );
                                  }
                                  FlutterFlowTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'AvenirArabic',
                                        color: Colors.white,
                                        useGoogleFonts: false,
                                      );
                                },
                              ),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                (states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return Colors.white;
                                  }
                                  return Colors.white;
                                },
                              ),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(22, 10, 0, 31),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        FFLocalizations.of(context)
                            .getText('appBuild' /* Appbuild */),
                        style: FlutterFlowTheme.of(context).subtitle2.override(
                              fontFamily: 'Sofia Pro By Khuzaimah',
                              color: Color(0xFFA5A5A5),
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              useGoogleFonts: false,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3, right: 3),
                        child: Text(
                          "${FFAppState().buildVersion}",
                          style:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    color: Color(0xFFA5A5A5),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    useGoogleFonts: false,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(
                          "(${FFAppState().buildNo})",
                          style:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    color: Color(0xFFA5A5A5),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    useGoogleFonts: false,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> buildInfo() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    appVersion = await int.parse(info.version);
    appBuildNo = await int.parse(info.buildNumber);
  }

  static void openWhatsapp(BuildContext context) async {
    var whatsapp = '+966550385531';
    var whatsappUrlAndroid = Uri.parse('$kWhatsAppAndroid$whatsapp&text=hi');
    var whatsappUrlIos = Uri.parse('$kWhatsAppIOS$whatsapp');
    if (Platform.isIOS) {
      if (await canLaunchUrl(whatsappUrlIos)) {
        await launchUrl(whatsappUrlIos, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Cannot open whatsapp',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.white))));
      }
    } else {
      bool canLaunch = await canLaunchUrl(whatsappUrlAndroid);
      if (canLaunch) {
        await launchUrl(whatsappUrlAndroid,
            mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          'Cannot open whatsapp',
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Colors.white),
        )));
      }
    }
  }
}
