import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:manzel/backend/api_requests/api_calls.dart';
import 'package:manzel/common_widgets/manzel_icons.dart';
import '../auth/auth_util.dart';
import '../common_alert_dialog/common_alert_dialog.dart';
import '../common_widgets/overlay.dart';
import '../components/terms_conditions_bottom_sheet_widget.dart';
import '../flutter_flow/custom_functions.dart';
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
import 'package:flutter/material.dart' as material;

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController? phoneNumberController;
  bool? changeLanguage;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  OverlayEntry? entry;
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  int count = 0;
  bool? isInternetAvailable;
  bool isApiCalled = false;
  bool isEnterEnglishNumberSnackNotShown = true;

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Login'});
    phoneNumberController = TextEditingController();
    checkInternetStatus();
  }

  Future<void> checkInternetStatus() async {
    isInternetAvailable = await isInternetConnected();
    if (!(isInternetAvailable ?? false)) {
      showDialog(
        context: context,
        builder: (BuildContext context) => CommonAlertDialog(
          onCancel: () {
            Navigator.pop(context);
          },
        ),
      );
    }
    setState(() {});
  }

  @override
  void dispose() {
    phoneNumberController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
        automaticallyImplyLeading: false,
        leading: RotatedBox(
          quarterTurns: FFAppState().locale == 'en' ? 0 : 2,
          child: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Manzel.back_icon,
              color: Colors.black,
              size: 15,
            ),
            onPressed: () async {
              logFirebaseEvent('LOGIN_PAGE_back_ON_TAP');
              logFirebaseEvent('back_Navigate-Back');
              context.pop();
            },
          ),
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
                if (changeLanguage!) {
                  // changeToArabic
                  logFirebaseEvent('changeLanguage_changeToArabic');
                  setAppLanguage(context, 'ar');
                  logFirebaseEvent('changeLanguage_Update-Local-State');
                  setState(() => FFAppState().locale = 'en');
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

                setState(() {});
              },
              child: Text(
                FFLocalizations.of(context).getVariableText(
                  enText: 'العربية',
                  arText: 'English',
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
                                EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                            child: Directionality(
                              textDirection: material.TextDirection.ltr,
                              child: TextFormField(
                                maxLength: 9,
                                //buildCounter: Container(),
                                controller: phoneNumberController,
                                onChanged: (val) {
                                  EasyDebounce.debounce(
                                    'phoneNumberController',
                                    Duration(milliseconds: 2000),
                                    () => setState(() {}),
                                  );
                                  if ((count == val.length && val.length < 9)&&isEnterEnglishNumberSnackNotShown) {
                                    isEnterEnglishNumberSnackNotShown=false;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          duration: Duration(milliseconds: 3000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryRed,
                                            content: Text(FFAppState().locale ==
                                                    'en'
                                                ? 'Please enter English numbers!'
                                                : 'الرجاء إدخال الأرقام الإنجليزية!')));
                                  }
                                  count = val.length;

                                //  count++;
                                },
                                autofocus: true,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                                obscureText: false,
                                decoration: InputDecoration(
                                  counterText: "",
                                  hintText: "05XXXXXXXX",
                                  // prefixText:
                                  //     FFLocalizations.of(context).getText(
                                  //   'f4tpckti' /* +966 */,
                                  // ),
                                  labelText:
                                      FFLocalizations.of(context).getText(
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
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  suffixIcon:
                                      phoneNumberController!.text.isNotEmpty
                                          ? InkWell(
                                              onTap: () async {
                                                phoneNumberController?.clear();
                                                setState(() {});
                                              },
                                              child: Icon(
                                                Manzel.clear,
                                                color: Color(0xFF757575),
                                                size: 12,
                                              ),
                                            )
                                          : null,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
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
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: FlutterFlowTheme.of(context).white,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: MediaQuery.of(context).viewInsets,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.95,
                                  child: TermsConditionsBottomSheetWidget(
                                    pageType: 5,
                                  ),
                                ),
                              );
                            },
                          ).then((value) => setState(() {}));
                        },
                        child: Text(
                          FFLocalizations.of(context).getText(
                            '5t0jhzug' /* terms and conditions */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'AvenirArabic',
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
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
                              fontFamily: 'AvenirArabic',
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
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: FlutterFlowTheme.of(context).white,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: MediaQuery.of(context).viewInsets,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.95,
                                  child: TermsConditionsBottomSheetWidget(
                                    pageType: 6,
                                  ),
                                ),
                              );
                            },
                          ).then((value) => setState(() {}));
                        },
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'irbrz9hi' /* privacy policy */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'AvenirArabic',
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
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
                        child: Container(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () async {
                              isInternetAvailable = await isInternetConnected();
                              setState(() {});
                              isLoading.value = true;
                              logFirebaseEvent('LOGIN_PAGE_sendOTP_ON_TAP');
                              if (functions.checkPhoneNumberFormat(
                                  phoneNumberController!.text)) {
                                // sendOTP
                                logFirebaseEvent('sendOTP_sendOTP');
                                final phoneNumberVal =
                                    functions.getFormattedMobileNumber(
                                        phoneNumberController!.text);
                                if (phoneNumberVal == null ||
                                    phoneNumberVal.isEmpty ||
                                    !phoneNumberVal.startsWith('+')) {
                                  isLoading.value = false;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Phone Number is required and has to start with +.'),
                                    ),
                                  );

                                  return;
                                }
                                //entry = showOverlay(context);
                                if (isInternetAvailable ?? false) {
                                  isApiCalled = true;
                                  setState(() {});
                                  ApiCallResponse generateOtpResponse =
                                      await OtpCalls.generateOtp(
                                          phoneNumber:
                                              phoneNumberController!.text);
                                  if ((generateOtpResponse.statusCode == 200) &&
                                      (OtpCalls.generateSuccess(
                                              generateOtpResponse.jsonBody)) ==
                                          'success') {
                                    String verificationKey =
                                        OtpCalls.generateKey(
                                            generateOtpResponse.jsonBody);
                                    context.goNamedAuth(
                                        'ConfirmNewNumberOTP', mounted,
                                        queryParams: {
                                          'phoneNumber':
                                              phoneNumberController!.text,
                                          'verificationKey': verificationKey
                                        });
                                    isApiCalled = false;
                                    setState(() {});
                                  }
                                  else if((generateOtpResponse.statusCode == 403)){
                                    unAuthorizedUser(context,mounted);
                                  }

                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CommonAlertDialog(
                                      onCancel: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                }
                              } else {
                                isApiCalled = false;
                                setState(() {});
                                // Invalid_phone_number_action
                                logFirebaseEvent(
                                    'sendOTP_Invalid_phone_number_action');
                                isLoading.value = false;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'The phone number format should be +966123456789',
                                      style: FlutterFlowTheme.of(context)
                                          .subtitle1,
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor: Color(0xFF777777),
                                  ),
                                );
                              }
                            },
                            child: ValueListenableBuilder<bool>(
                              builder: (BuildContext context, bool value,
                                  Widget? child) {
                                return (isLoading.value && isApiCalled)
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
                                                        Colors.white),
                                                strokeWidth: 5,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : AutoSizeText(
                                        FFLocalizations.of(context).getText(
                                          'l3ozn1az' /* Continue */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .subtitle2
                                            .override(
                                              fontSize: 18,
                                              fontFamily: 'AvenirArabic',
                                              color: Colors.white,
                                              useGoogleFonts: false,
                                            ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
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
                                          color: Colors.white,
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
                                    return FlutterFlowTheme.of(context)
                                        .primaryColor;
                                  }
                                  return FlutterFlowTheme.of(context)
                                      .primaryColor;
                                },
                              ),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    )),
                              ),
                            ),
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

  OverlayEntry showOverlay(BuildContext context) {
    var overlayState = Overlay.of(context);
    var overlayEntry = OverlayEntry(
      builder: (context) => CircularProgressOverlay(),
    );
    overlayState?.insert(overlayEntry);
    return overlayEntry;
  }
}
