import '../auth/auth_util.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class EditMobileNumberWidget extends StatefulWidget {
  const EditMobileNumberWidget({Key key}) : super(key: key);

  @override
  _EditMobileNumberWidgetState createState() => _EditMobileNumberWidgetState();
}

class _EditMobileNumberWidgetState extends State<EditMobileNumberWidget> {
  TextEditingController mobileNumberController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'EditMobileNumber'});
    mobileNumberController = TextEditingController(
        text: FFLocalizations.of(context).getText(
      'dkoyvgce' /* +966 */,
    ));
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
            logFirebaseEvent('EDIT_MOBILE_NUMBER_PAGE_back_ON_TAP');
            // Back to onboarding view
            logFirebaseEvent('back_Backtoonboardingview');
            context.pushNamed('EditPersonallInfo');
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
                        '095f9xno' /* Edit mobile number */,
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
                padding: EdgeInsetsDirectional.fromSTEB(16, 5, 24, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        FFLocalizations.of(context).getText(
                          '4eszxwjq' /* We'll send a verification code... */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Sofia Pro By Khuzaimah',
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
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
                      child: TextFormField(
                        controller: mobileNumberController,
                        onChanged: (_) => EasyDebounce.debounce(
                          'mobileNumberController',
                          Duration(milliseconds: 2000),
                          () => setState(() {}),
                        ),
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: FFLocalizations.of(context).getText(
                            'por97wlv' /* Mobile Number */,
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
                          prefixIcon: Icon(
                            Icons.local_phone_outlined,
                            color: FlutterFlowTheme.of(context).secondaryText,
                          ),
                          suffixIcon: mobileNumberController.text.isNotEmpty
                              ? InkWell(
                                  onTap: () => setState(
                                    () => mobileNumberController?.clear(),
                                  ),
                                  child: Icon(
                                    Icons.clear,
                                    color: Color(0xFF757575),
                                    size: 22,
                                  ),
                                )
                              : null,
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Sofia Pro By Khuzaimah',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              useGoogleFonts: false,
                            ),
                        maxLines: 1,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 170, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        logFirebaseEvent(
                            'EDIT_MOBILE_NUMBER_PAGE_sendOTP_ON_TAP');
                        if (functions.checkPhoneNumberFormat(
                            mobileNumberController.text)) {
                          // sendOTP
                          logFirebaseEvent('sendOTP_sendOTP');
                          final phoneNumberVal = mobileNumberController.text;
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
                              context.goNamedAuth('ConfirmOTP', mounted);
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
                                style: FlutterFlowTheme.of(context).subtitle1,
                              ),
                              duration: Duration(milliseconds: 4000),
                              backgroundColor: Color(0xFF777777),
                            ),
                          );
                        }
                      },
                      text: FFLocalizations.of(context).getText(
                        'v8y7fwba' /* Continue */,
                      ),
                      options: FFButtonOptions(
                        width: 343,
                        height: 56,
                        color: Color(0xFF2971FB),
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
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
