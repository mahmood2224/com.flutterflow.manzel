import '../auth/auth_util.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../custom_code/actions/index.dart' as actions;
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController phoneNumberController;
  bool changeLanguage;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Login'});
    phoneNumberController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () async {
            logFirebaseEvent('LOGIN_PAGE_back_ON_TAP');
            logFirebaseEvent('back_Navigate-Back');
            context.pop();
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 20, 0),
            child: InkWell(
              onTap: () async {
                logFirebaseEvent('LOGIN_PAGE_changeLanguage_ON_TAP');
                // changeLanguage
                logFirebaseEvent('changeLanguage_changeLanguage');
                changeLanguage = await actions.isEnglish(
                  FFLocalizations.of(context).languageCode,
                );
                if (changeLanguage) {
                  // changeToArabic
                  logFirebaseEvent('changeLanguage_changeToArabic');
                  setAppLanguage(context, 'ar');
                } else {
                  // changeToEnglish
                  logFirebaseEvent('changeLanguage_changeToEnglish');
                  setAppLanguage(context, 'en');
                }

                setState(() {});
              },
              child: Text(
                FFLocalizations.of(context).getVariableText(
                  enText: 'English',
                  arText: 'العربية',
                ),
                textAlign: TextAlign.end,
                style: FlutterFlowTheme.of(context).title1.override(
                      fontFamily: 'Sofia Pro By Khuzaimah',
                      fontSize: 16,
                      useGoogleFonts: false,
                    ),
              ),
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 20, 24, 0),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      'cp1d00ba' /* Enter your mobile number */,
                    ),
                    style: FlutterFlowTheme.of(context).title1.override(
                          fontFamily: 'Sofia Pro By Khuzaimah',
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          useGoogleFonts: false,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 5, 24, 0),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      '364dhoh3' /* We'll send a verification code... */,
                    ),
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Sofia Pro By Khuzaimah',
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          useGoogleFonts: false,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                  child: Container(
                    width: double.infinity,
                    height: 65,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBtnText,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: TextFormField(
                              controller: phoneNumberController,
                              onChanged: (_) => EasyDebounce.debounce(
                                'phoneNumberController',
                                Duration(milliseconds: 2000),
                                () => setState(() {}),
                              ),
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                prefixText: FFLocalizations.of(context).getText(
                                  'f4tpckti' /* +966 */,),
                              labelText: FFLocalizations.of(context).getText(
                                '4m2r1iwr' /* Mobile Number */,
                              ),
                              labelStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    useGoogleFonts: false,
                                  ),
                              // hintText: FFLocalizations.of(context).getText(
                              //   'f4tpckti' /* +966 */,
                              // ),
                              hintStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts: false,
                                  ),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              suffixIcon: phoneNumberController.text.isNotEmpty
                                  ? InkWell(
                                      onTap: () => setState(
                                        () => phoneNumberController?.clear(),
                                      ),
                                      child: Icon(
                                        Icons.clear,
                                        color: Color(0xFF757575),
                                        size: 22,
                                      ),
                                    )
                                  : null,
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Sofia Pro By Khuzaimah',
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: false,
                                    ),
                            maxLines: 1,
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 110, 24, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      FFLocalizations.of(context).getText(
                        'gr1za5xy' /* By clicking continue, you agre... */,
                      ),
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Sofia Pro By Khuzaimah',
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            useGoogleFonts: false,
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 2, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      onTap: () async {
                        logFirebaseEvent('LOGIN_PAGE_terms_ON_TAP');
                        // termsAndConditions
                        logFirebaseEvent('terms_termsAndConditions');
                        context.goNamed('TermsConditions');
                      },
                      child: Text(
                        FFLocalizations.of(context).getText(
                          '5t0jhzug' /* terms & conditions */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Sofia Pro By Khuzaimah',
                              color: FlutterFlowTheme.of(context).primaryColor,
                              fontWeight: FontWeight.w500,
                              useGoogleFonts: false,
                            ),
                      ),
                    ),
                    Text(
                      FFLocalizations.of(context).getText(
                        '5ard5tmn' /*  &  */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Sofia Pro By Khuzaimah',
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            useGoogleFonts: false,
                          ),
                    ),
                    InkWell(
                      onTap: () async {
                        logFirebaseEvent('LOGIN_PAGE_terms_ON_TAP');
                        // termsAndConditions
                        logFirebaseEvent('terms_termsAndConditions');
                        context.goNamed('TermsConditions');
                      },
                      child: Text(
                        FFLocalizations.of(context).getText(
                          'irbrz9hi' /* privacy policy */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Sofia Pro By Khuzaimah',
                              color: FlutterFlowTheme.of(context).primaryColor,
                              fontWeight: FontWeight.w500,
                              useGoogleFonts: false,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 13, 16, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          logFirebaseEvent('LOGIN_PAGE_sendOTP_ON_TAP');
                          if (functions.checkPhoneNumberFormat(
                              phoneNumberController.text)) {
                            // sendOTP
                            logFirebaseEvent('sendOTP_sendOTP');
                            final phoneNumberVal =   functions.getFormattedMobileNumber(
                                phoneNumberController.text);
                            if (phoneNumberVal == null ||
                                phoneNumberVal.isEmpty ||
                                !phoneNumberVal.startsWith('+')) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Phone Number is required and has to start with +.'),
                                ),
                              );
                              return;
                            }
                            await beginPhoneAuth(
                              context: context,
                              phoneNumber: phoneNumberVal,
                              onCodeSent: () async {
                                context.goNamedAuth('ConfirmNewNumberOTP', mounted,queryParams:{'phoneNumber': phoneNumberVal});
                                },
                              );
                            } else {
                              // Invalid_phone_number_action
                              logFirebaseEvent(
                                  'sendOTP_Invalid_phone_number_action');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'The phone number format should be +966123456789',
                                    style:
                                        FlutterFlowTheme.of(context).subtitle1,
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor: Color(0xFF777777),
                                ),
                              );
                            }
                          },
                          text: FFLocalizations.of(context).getText(
                            'l3ozn1az' /* Continue */,
                          ),
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 56,
                            color: Color(0xFF2971FB),
                            textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Sofia Pro By Khuzaimah',
                                      color: Colors.white,
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
