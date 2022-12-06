import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:manzel/backend/api_requests/api_calls.dart';
import 'package:manzel/backend/backend.dart';
import 'package:manzel/common_widgets/manzel_icons.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';
import '../../enviorment/env_variables.dart';
import '../auth/auth_util.dart';
import '../common_alert_dialog/common_alert_dialog.dart';
import '../common_widgets/overlay.dart';
import '../common_widgets/timer_widget.dart';
import '../flutter_flow/custom_functions.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart' as material;

import '../notification_handler/firebase_cloud_messaging.dart';

class ConfirmNewNumberOTPWidget extends StatefulWidget {
  final String? phoneNumber;
  final String? isFromUpdate;
  final String? verificationKey;

  const ConfirmNewNumberOTPWidget(
      {Key? key, this.phoneNumber, this.isFromUpdate, this.verificationKey})
      : super(key: key);

  @override
  _ConfirmNewNumberOTPWidgetState createState() =>
      _ConfirmNewNumberOTPWidgetState();
}

class _ConfirmNewNumberOTPWidgetState extends State<ConfirmNewNumberOTPWidget> {
  TextEditingController? enterOTPController;
  int _otpResendTimes = 3;
  bool? isFromUpdate;
  final ValueNotifier<bool> _showResendOtp = ValueNotifier(false);
  String _phoneAuthVerificationCode = '';
  ValueNotifier<String> _showOtpError = ValueNotifier('');
  final scaffoldKey = GlobalKey<ScaffoldState>();
  OverlayEntry? entry;
  var userCredential;
  bool? isInternetAvailable;
  var idToken;
  String? veriKey;

  void resendOTP() async {
    if (isFromUpdate ?? false) {
      String newPhoneNumber = widget.phoneNumber ?? '';
      ApiCallResponse? response = await OtpCalls.updatePhone(
          idToken: idToken, newPhoneNumber: newPhoneNumber);
      if(response.statusCode==403){
        unAuthorizedUser(context,mounted);
      }
    } else {
      ApiCallResponse? generateOtpResponse =
          await OtpCalls.generateOtp(phoneNumber: widget.phoneNumber ?? '');
      if(generateOtpResponse.statusCode==403){
        unAuthorizedUser(context,mounted);
      }
      veriKey = OtpCalls.generateKey(generateOtpResponse.jsonBody);
      setState(() {});
    }
    if (_otpResendTimes > 0) {
      _showResendOtp.value = false;
      _otpResendTimes--;
    }
  }

  @override
  void initState() {
    super.initState();
    enterOTPController = TextEditingController();
    isFromUpdate = widget.isFromUpdate == "true" ? true : false;
    veriKey = widget.verificationKey;
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'ConfirmNewNumberOTP'});
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
            Manzel.clear,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () async {
            logFirebaseEvent('CONFIRM_NEW_NUMBER_O_T_P_back_ON_TAP');
            // Back to login
            logFirebaseEvent('back_Backtologin');

            context.pop();
          },
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 20, 24, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'nzqyszrd' /* Confirm your mobile number */,
                        ),
                        style: FlutterFlowTheme.of(context).title1.override(
                              fontFamily: 'Sofia Pro By Khuzaimah',
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              useGoogleFonts: false,
                            ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          '0qmluaen' /* We've sent you a 6 digital cod... */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Sofia Pro By Khuzaimah',
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              useGoogleFonts: false,
                            ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 5, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      AuthUserStreamWidget(
                        child: Directionality(
                            textDirection: material.TextDirection.ltr,
                            child: Text(
                              widget.phoneNumber ?? '1234567890',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    useGoogleFonts: false,
                                  ),
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 58, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Directionality(
                            textDirection: material.TextDirection.ltr,
                            child: Pinput(
                              onCompleted: (String otp) async {
                                // print(otp);
                                // if (otp.length == 6) {
                                //   _showOtpError.value = "Working";
                                // }
                                entry = showOverlay(context);
                                if (isFromUpdate ?? false) {
                                  ApiCallResponse verifyOtpResponse= await OtpCalls.verifyPhone(phoneNumber: widget.phoneNumber??'',otp:otp,key:veriKey??'');
                                  if((verifyOtpResponse.statusCode==200)){
                                    String tokenFromOtpSuccess = OtpCalls.tokenFromOtp(verifyOtpResponse.jsonBody);
                                    try {
                                      //DateTime loginDate = DateTime.now();
                                      userCredential =
                                      await FirebaseAuth.instance.signInWithCustomToken(tokenFromOtpSuccess);
                                      final user = await FirebaseAuth
                                          .instance.currentUser;
                                      final idToken =
                                      await user?.getIdToken();
                                      FFAppState().authToken = idToken!;
                                    } on FirebaseAuthException catch (e) {
                                      switch (e.code) {
                                        case "invalid-custom-token":
                                          print("The supplied token is not a Firebase custom auth token.");
                                          break;
                                        case "custom-token-mismatch":
                                          print("The supplied token is for a different Firebase project.");
                                          break;
                                        default:
                                          print("Unkown error.");
                                      }
                                    }

                                  }
                                  entry?.remove();
                                 context.pop();
                                }
                                else {
                                  ApiCallResponse verifyOtpResponse= await OtpCalls.verifyOtp(phoneNumber: widget.phoneNumber??'',otp:otp,key:veriKey??'');
                                  if((verifyOtpResponse.statusCode==200)){
                                    String tokenFromOtpSuccess = OtpCalls.tokenFromOtp(verifyOtpResponse.jsonBody);
                                    try {
                                      DateTime loginDate = DateTime.now();
                                      userCredential = await FirebaseAuth.instance.signInWithCustomToken(tokenFromOtpSuccess);
                                      if(userCredential!=null){
                                        final user = userCredential.user;
                                        var record =
                                            await maybeCreateUser(user);
                                        print(record);
                                        Future.delayed(
                                            const Duration(milliseconds:200),
                                                () async {
                                              if (currentUserDocument!.status!.isEmpty ||
                                                  currentUserDocument!.status!
                                                      .toLowerCase() ==
                                                      'active') {
                                                logFirebaseEvent('login');
                                                final userUpdateData =
                                                await createUserRecordData(
                                                    status: 'Active',
                                                    language:
                                                        FFLocalizations.of(
                                                                context)
                                                            .languageCode,
                                                    lastLogin: loginDate,
                                                    deviceToken:await FirebaseMessagingUtils
                                                        .getPushNotificationToken() ,
                                                    isDeleted: 0);
                                            if (currentUserDocument!
                                                .status!.isEmpty) {
                                              logFirebaseEvent('sign_up');
                                              userUpdateData.addAll({
                                                'created_time': loginDate
                                              });
                                              userUpdateData.addAll({
                                                'last_login': loginDate
                                              });
                                            }

                                            await currentUserReference
                                                ?.update(userUpdateData);

                                            if (currentUserDisplayName
                                                    .isEmpty &&
                                                currentUserDocument!
                                                    .name!.isEmpty) {
                                              final _sendbird = await SendbirdSdk(
                                                  appId:
                                                      "${EnvVariables.instance.sendbirdAppId}");
                                              final _ = await _sendbird
                                                  .connect(currentUserUid);
                                              context.goNamedAuth(
                                                  'AddingInformation', mounted);
                                            } else {
                                              context.goNamedAuth(
                                                  'HomeScreen', mounted);
                                            }
                                            }  else {
                                               await showDialog(
                                                 context: context,
                                                 builder: (alertDialogContext) {
                                                   return AlertDialog(
                                                     title: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                    'OTPBlocked',
                                                  )),
                                                  content: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                    'OTPBlockedText',
                                                  )),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () async {
                                                        await signOut();
                                                        Navigator.pop(
                                                            alertDialogContext);
                                                        context.pop();
                                                      },
                                                      child: Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                        'OTPOk',
                                                      )),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        });
                                      }
                                      context.goNamedAuth(
                                          'HomeScreen', mounted);
                                    } on FirebaseAuthException catch (e) {
                                      switch (e.code) {
                                        case "invalid-custom-token":
                                          print(
                                              "The supplied token is not a Firebase custom auth token.");
                                          break;
                                        case "custom-token-mismatch":
                                          print(
                                              "The supplied token is for a different Firebase project.");
                                          break;
                                        default:
                                          print("Unkown error.");
                                      }
                                    }
                                  } else if (verifyOtpResponse.statusCode ==
                                      403) {
                                    unAuthorizedUser(context,mounted);
                                   // context.goNamedAuth('Login', mounted);
                                  }
                                  entry?.remove();
                                  if (userCredential == null) {
                                    _showOtpError.value =
                                        "You entered OTP incorrect";
                                    return;
                                  }


                                }
                              },
                              autofocus: true,
                              length: 6,
                              useNativeKeyboard: true,
                              keyboardType: TextInputType.number,
                              controller: enterOTPController,
                              defaultPinTheme: PinTheme(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffD7D7D7),
                                ),
                                textStyle: TextStyle(fontSize: 30),
                                height: 45,
                                width: 18,
                              ),
                              focusedPinTheme: PinTheme(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffD7D7D7),
                                ),
                                textStyle: TextStyle(fontSize: 0),
                                height: 45,
                                width: 18,
                              ),
                              submittedPinTheme: PinTheme(
                                height: 45,
                                width: 18,
                                textStyle: TextStyle(
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Sofia Pro By Khuzaimah'),
                              ),
                              preFilledWidget: Container(
                                height: 12,
                                width: 12,
                                decoration: BoxDecoration(
                                  color: Color(0xffD7D7D7),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(93, 19, 16, 0),
                ),
                ValueListenableBuilder(
                  valueListenable: _showOtpError,
                  builder: (context, String value, child) {
                    return Text(
                      "${value}",
                      style: TextStyle(
                          fontFamily: 'Sofia Pro By Khuzaimah',
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                          color: Color(0xffdc5d5c)),
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 140, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: ValueListenableBuilder(
                            valueListenable: _showResendOtp,
                            builder: (context, bool value, _) {
                              return Visibility(
                                visible: value,
                                replacement: TimerWidget(
                                    duration: Duration(seconds: 40),
                                    onComplete: (VoidCallback restart) {
                                      _showResendOtp.value = true;
                                    }),
                                child: GestureDetector(
                                  onTap: resendOTP,
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'Resend',
                                    ),
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontFamily: 'Sofia Pro By Khuzaimah',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              );
                            }),
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

  OverlayEntry showOverlay(BuildContext context) {
    var overlayState = Overlay.of(context);
    var overlayEntry = OverlayEntry(
      builder: (context) => CircularProgressOverlay(),
    );
    overlayState?.insert(overlayEntry);
    return overlayEntry;
  }

  @override
  void dispose() {
    enterOTPController?.dispose();
    super.dispose();
  }
}
