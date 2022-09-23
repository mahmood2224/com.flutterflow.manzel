import '../auth/auth_util.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ConfirmAbsherWidget extends StatefulWidget {
  const ConfirmAbsherWidget({Key? key}) : super(key: key);

  @override
  _ConfirmAbsherWidgetState createState() => _ConfirmAbsherWidgetState();
}

class _ConfirmAbsherWidgetState extends State<ConfirmAbsherWidget> {
  TextEditingController? enterOTPController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    enterOTPController = TextEditingController();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'ConfirmAbsher'});
  }

  @override
  void dispose() {
    enterOTPController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 0,
          borderWidth: 0,
          buttonSize: 30,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () async {
            logFirebaseEvent('CONFIRM_ABSHER_arrow_back_ICN_ON_TAP');
            // goBack
            logFirebaseEvent('IconButton_goBack');
            context.pop();
          },
        ),
        title: Text(
          FFLocalizations.of(context).getText(
            'qh014cm1' /* Absher Verification */,
          ),
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Sofia Pro By Khuzaimah',
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                useGoogleFonts: false,
              ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 0,
              borderWidth: 0,
              buttonSize: 30,
              icon: Icon(
                Icons.close_rounded,
                color: Colors.black,
                size: 20,
              ),
              onPressed: () async {
                logFirebaseEvent('CONFIRM_ABSHER_PAGE_backIcon_ON_TAP');
                // goBack
                logFirebaseEvent('backIcon_goBack');
                context.pop();
              },
            ),
          ),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LinearPercentIndicator(
                  percent: 0.5,
                  width: 338,
                  lineHeight: 4,
                  animation: true,
                  progressColor: Color(0xFF81D05C),
                  backgroundColor: Color(0xFFF8F8F8),
                  barRadius: Radius.circular(6),
                  padding: EdgeInsets.zero,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 33, 0, 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'jbeldlu4' /* OTP Absher */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'AvenirArabic',
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              useGoogleFonts: false,
                            ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          FFLocalizations.of(context).getText(
                            't6diss1v' /* We've sent you a 6 digital cod... */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'AvenirArabic',
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
                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      AuthUserStreamWidget(
                        child: Text(
                          currentPhoneNumber,
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'AvenirArabic',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    useGoogleFonts: false,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: enterOTPController,
                          onChanged: (_) => EasyDebounce.debounce(
                            'enterOTPController',
                            Duration(milliseconds: 2000),
                            () => setState(() {}),
                          ),
                          onFieldSubmitted: (_) async {
                            logFirebaseEvent(
                                'CONFIRM_ABSHER_enterOTP_ON_TEXTFIELD_SUB');
                            // verifySMSCode
                            logFirebaseEvent('enterOTP_verifySMSCode');
                            GoRouter.of(context).prepareAuthEvent();
                            final smsCodeVal = enterOTPController!.text;
                            if (smsCodeVal == null || smsCodeVal.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Enter SMS verification code.'),
                                ),
                              );
                              return;
                            }
                            final phoneVerifiedUser = await verifySmsCode(
                              context: context,
                              smsCode: smsCodeVal,
                            );
                            if (phoneVerifiedUser == null) {
                              return;
                            }

                            context.goNamedAuth('HomeScreen', mounted);
                          },
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: FFLocalizations.of(context).getText(
                              '8b44886a' /* Enter the OTP number */,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'AvenirArabic',
                                    fontWeight: FontWeight.w300,
                                    useGoogleFonts: false,
                                  ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 130, 0, 30),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FFButtonWidget(
                        onPressed: () {
                          print('goToConfirmAbsher pressed ...');
                        },
                        text: FFLocalizations.of(context).getText(
                          'd7rdpmot' /* Continue */,
                        ),
                        options: FFButtonOptions(
                          width: 343,
                          height: 56,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'AvenirArabic',
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
