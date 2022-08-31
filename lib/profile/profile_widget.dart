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
  const ProfileWidget({Key key}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  bool changeLanguage;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
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
                                currentUserDisplayName,
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
                            context.goNamed('EditPersonallInfo');
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
                            context.goNamed('Login');
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
                          if (changeLanguage) {
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
                            await currentUserReference.update(userUpdateData);
                          }

                          setState(() {});
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
                      );
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
                      );
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
                      );
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
                if (loggedIn)
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            logFirebaseEvent('PROFILE_PAGE_logout_ON_TAP');
                            // Logout
                            logFirebaseEvent('logout_Logout');
                            GoRouter.of(context).prepareAuthEvent();
                            await signOut();
                            context.goNamedAuth('OnboardingView', mounted);
                          },
                          text: FFLocalizations.of(context).getText(
                            '2csoqw0t' /* Logout */,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
