import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';

import '../auth/auth_util.dart';
import '../common_widgets/timer_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmNewNumberOTPWidget extends StatefulWidget {
  const ConfirmNewNumberOTPWidget({Key key}) : super(key: key);

  @override
  _ConfirmNewNumberOTPWidgetState createState() =>
      _ConfirmNewNumberOTPWidgetState();
}

class _ConfirmNewNumberOTPWidgetState extends State<ConfirmNewNumberOTPWidget> {
  TextEditingController enterOTPController;
  int _otpResendTimes = 3;
  final ValueNotifier<bool> _showResendOtp = ValueNotifier(false);
  String _phoneAuthVerificationCode = '';
  ValueNotifier<String> _showOtpError = ValueNotifier('');
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void resendOTP() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: currentPhoneNumber,
      timeout: Duration(seconds: 5),
      verificationCompleted: (phoneAuthCredential) async {
        await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      },
      verificationFailed: (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${e.message}'),
        ));
      },
      codeSent: (verificationId, _) {
        _phoneAuthVerificationCode = verificationId;
      },
      codeAutoRetrievalTimeout: (_) {},
    );
    if (_otpResendTimes > 0) {
      _showResendOtp.value = false;
      _otpResendTimes--;
    }
  }

  @override
  void initState() {
    super.initState();
    enterOTPController = TextEditingController();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'ConfirmNewNumberOTP'});
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
            Icons.clear_rounded,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () async {
            logFirebaseEvent('CONFIRM_NEW_NUMBER_O_T_P_back_ON_TAP');
            // Back to login
            logFirebaseEvent('back_Backtologin');
            context.pushNamed('EditMobileNumber');
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
                      child: Text(
                        currentPhoneNumber,
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Sofia Pro By Khuzaimah',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Pinput(
                        onCompleted: (String otp) async {
                          // print(otp);
                          // if (otp.length == 6) {
                          //   _showOtpError.value = "Working";
                          // }
                          final phoneVerifiedUser = await verifySmsCode(
                            context: context,
                            smsCode: otp,
                          );
                          if (phoneVerifiedUser == null) {
                            _showOtpError.value = "You entered OTP incorrect";
                            return;
                          }
                          if(phoneVerifiedUser.displayName == null){
                            context.goNamedAuth('AddingInformation', mounted);
                          }else {
                            context.goNamedAuth('HomeScreen', mounted);
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
                          height: 12,
                          width: 12,
                        ),
                        focusedPinTheme: PinTheme(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffD7D7D7),
                          ),
                          textStyle: TextStyle(fontSize: 0),
                          height: 12,
                          width: 12,
                        ),
                        submittedPinTheme: PinTheme(
                          height: 45,
                          width: 16,
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
                      ),
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
                padding: EdgeInsetsDirectional.fromSTEB(16, 160, 16, 0),
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
                              // child: RichText(
                              //   text: TextSpan(
                              //     recognizer: TapGestureRecognizer()
                              //       ..onTap = resendOTP,
                              //     text: 'Resend Otp',
                              //     style: TextStyle(
                              //         decoration: TextDecoration.underline,
                              //         fontFamily: 'Sofia Pro By Khuzaimah',
                              //         fontSize: 16,
                              //         fontWeight: FontWeight.w700),
                              //   ),
                              // ),
                              child: GestureDetector(
                                onTap: resendOTP,
                                child: Text(
                                  'Resend Otp',
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
    );
  }
}