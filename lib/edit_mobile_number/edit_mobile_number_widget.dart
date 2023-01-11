import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:manzel/common_alert_dialog/common_alert_dialog.dart';
import 'package:manzel/common_widgets/manzel_icons.dart';
import 'package:manzel/flutter_flow/custom_functions.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;

class EditMobileNumberWidget extends StatefulWidget {
  const EditMobileNumberWidget({Key? key}) : super(key: key);

  @override
  _EditMobileNumberWidgetState createState() => _EditMobileNumberWidgetState();
}

class _EditMobileNumberWidgetState extends State<EditMobileNumberWidget> {
  TextEditingController? mobileNumberController;
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool? isInternetAvailable;
  FocusNode contactNoFocusNode = FocusNode();
  bool isPhoneNumberValid=true;
  bool isButtonTappable=false;
  String warningMessage ='';
  int count = 0;
  bool isEnterEnglishNumberSnackNotShown = true;

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'EditMobileNumber'});
    mobileNumberController = TextEditingController();
    contactNoFocusNode.addListener(() {
      if(!contactNoFocusNode.hasFocus){
        isPhoneNumberValid= validateMobileNumber(mobileNumberController!.text);
        if(!isPhoneNumberValid){
          warningMessage =  FFLocalizations.of(context).getText(
            'phoneNumberFormat' /* The phone number format should be 05XXXXXXXX  */,
          );
        }
        setState((){});
      }
    });
  }


  @override
  void dispose() {
    mobileNumberController?.dispose();
    super.dispose();
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
            size: 15,
          ),
          onPressed: () async {
            logFirebaseEvent('EDIT_MOBILE_NUMBER_PAGE_back_ON_TAP');
            // Back to onboarding view
            logFirebaseEvent('back_Backtoonboardingview');

            Navigator.pop(context);
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
                            fontFamily: 'Poppins',
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
                              fontFamily: 'Poppins',
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
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                          child: Directionality(
                            textDirection: material.TextDirection.ltr,
                            child: TextFormField(
                              maxLength: 10,
                              controller: mobileNumberController,
                              onChanged:(val){
                                warningMessage='';
                                isButtonTappable = validateMobileNumber(mobileNumberController!.text);
                                if ((count == val.length && val.length < 9)&&isEnterEnglishNumberSnackNotShown) {
                                  warningMessage = FFAppState().locale ==
                                      'en'
                                      ? 'Please enter English numbers!'
                                      : 'الرجاء إدخال الأرقام الإنجليزية!';
                                }
                                count = val.length;
                                setState((){});
                                EasyDebounce.debounce(
                                  'phoneNumberController',
                                  Duration(milliseconds: 2000),
                                      () => setState(() {}),
                                );
                                setState((){});
                              },
                              autofocus: true,
                              focusNode: contactNoFocusNode,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                LengthLimitingTextInputFormatter(10),
                              ],
                              obscureText: false,
                              decoration: InputDecoration(
                                counterText: "",
                                hintText: "05XXXXXXXX",
                                labelText: FFLocalizations.of(context).getText(
                                  'por97wlv' /* Mobile Number */,
                                ),
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      useGoogleFonts: false,
                                    ),
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
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
                                    mobileNumberController!.text.isNotEmpty
                                        ? InkWell(
                                            onTap: () async {
                                              warningMessage='';
                                              mobileNumberController?.clear();
                                              setState(() {});
                                            },
                                            child: Icon(
                                              Manzel.clear,
                                              color: Color(0xFF757575),
                                              size: 15,
                                            ),
                                          )
                                        : null,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
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
              Directionality(
                textDirection: material.TextDirection.ltr,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                      Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(24, 4, 0, 0),
                          child: Text(
                            warningMessage,
                            style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.w300,
                              useGoogleFonts: false,
                            ),
                          )
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
                            if(isButtonTappable&&isLoading.value==false&&(isInternetAvailable??false)){
                              isLoading.value = true;
                              logFirebaseEvent('LOGIN_PAGE_sendOTP_ON_TAP');
                              if (functions.checkPhoneNumberFormat(
                                  mobileNumberController!.text)) {
                                logFirebaseEvent('sendOTP_sendOTP');
                                if (isInternetAvailable ?? false) {
                                  isLoading.value = true;
                                  ApiCallResponse updatePhoneResponse =
                                  await OtpCalls.updatePhone(
                                      newPhoneNumber:
                                      mobileNumberController!.text);
                                  if ((OtpCalls.generateSuccess(
                                      updatePhoneResponse.jsonBody)) ==
                                      'success') {
                                    String verificationKey = OtpCalls.generateKey(
                                        updatePhoneResponse.jsonBody);
                                    context.goNamedAuth(
                                        'ConfirmNewNumberOTP', mounted,
                                        queryParams: {
                                          'phoneNumber':
                                          mobileNumberController!.text,
                                          'verificationKey': verificationKey,
                                          'isFromUpdate': 'true'
                                        });
                                  } else if (updatePhoneResponse.statusCode ==
                                      403) {
                                    functions.unAuthorizedUser(context, mounted);
                                  }
                                  else {
                                    String errorMessage= OtpCalls.phoneNumberError(updatePhoneResponse.jsonBody);
                                    isLoading.value=false;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(errorMessage,
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context).white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            height: 2,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor: FlutterFlowTheme.of(context).primaryText,
                                      ),
                                    );
                                  }
                                } else {
                                  isLoading.value = false;
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
                                // Invalid_phone_number_action
                                logFirebaseEvent(
                                    'sendOTP_Invalid_phone_number_action');
                                isLoading.value = false;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'The phone number format should be +966123456789',
                                      style:
                                      FlutterFlowTheme.of(context).subtitle1,
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                    FlutterFlowTheme.of(context).primaryRed,
                                  ),
                                );
                              }
                            }
                            else if(!isButtonTappable){
                              warningMessage =  FFLocalizations.of(context).getText(
                                'phoneNumberFormat' /* The phone number format should be 05XXXXXXXX  */,
                              );
                              setState((){});
                            }
                            else if(!(isInternetAvailable??false)){
                              isLoading.value=false;
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
                            }

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
                                FlutterFlowTheme.of(context).subtitle2.override(
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
                                  return isButtonTappable?FlutterFlowTheme.of(context)
                                      .primaryColor:Color(0xFF8C8C8C);
                                }
                                return isButtonTappable?FlutterFlowTheme.of(context)
                                    .primaryColor:Color(0xFF8C8C8C);
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
    );
  }
}
