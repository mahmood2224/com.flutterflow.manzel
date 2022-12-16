import 'package:manzel/common_alert_dialog/common_alert_dialog.dart';
import 'package:manzel/flutter_flow/custom_functions.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/terms_conditions_bottom_sheet_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart' as material;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class AddingInformationWidget extends StatefulWidget {
  const AddingInformationWidget({Key? key}) : super(key: key);

  @override
  _AddingInformationWidgetState createState() =>
      _AddingInformationWidgetState();
}

class _AddingInformationWidgetState extends State<AddingInformationWidget> {
  TextEditingController? fullNameController;
  bool? isInternetAvailable;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  FocusNode nameNoFocusNode = FocusNode();
  bool isNameValid = true;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'AddingInformation'});
    nameNoFocusNode.addListener(() {
      if(!nameNoFocusNode.hasFocus){
        isNameValid= isNameValidFunction(fullNameController!.text);
        setState((){});
      }
    });
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
  }

  @override
  void dispose() {
    fullNameController?.dispose();
    super.dispose();
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 30, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          '3zqs9v1q' /* Add your information */,
                        ),
                        style: FlutterFlowTheme.of(context).title1.override(
                              fontFamily: 'Sofia Pro By Khuzaimah',
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              useGoogleFonts: false,
                            ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 26, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 0, 0),
                                  child: TextFormField(
                                    controller: fullNameController,
                                    onChanged: (value) async {
                                      isNameValid= isNameValidFunction(value);
                                      //focus node error handling
                                      //button handling

                                      setState(() {});
                                    },
                                    autofocus: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText:
                                          FFLocalizations.of(context).getText(
                                        '2xw55n00' /* Full name */,
                                      ),
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily:
                                                'Sofia Pro By Khuzaimah',
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            useGoogleFonts: false,
                                          ),
                                      hintText:
                                          FFLocalizations.of(context).getText(
                                        'iegnrogi' /*   */,
                                      ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily:
                                                'Sofia Pro By Khuzaimah',
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts: false,
                                          ),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Sofia Pro By Khuzaimah',
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          useGoogleFonts: false,
                                        ),
                                    maxLines: 1,
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Directionality(
                  textDirection: material.TextDirection.ltr,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (!isNameValid)
                        Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(24, 4, 0, 0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'pleaseEnterValidName' /* Please enter a valid Phone num... */,
                              ),
                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily: 'Sofia Pro By Khuzaimah',
                                color: Colors.red,
                                fontWeight: FontWeight.w300,
                                useGoogleFonts: false,
                              ),
                            )
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 110, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'dr5dq8mr' /* By clicking continue, you agre... */,
                        ),
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
                          logFirebaseEvent(
                              'ADDING_INFORMATION_PAGE_terms_ON_TAP');
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
                            't1oedq2h' /* terms & conditions  */,
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
                      InkWell(
                        onTap: () async {
                          logFirebaseEvent(
                              'ADDING_INFORMATION_PAGE_and_ON_TAP');
                          // termsAndConditions
                          logFirebaseEvent('and_termsAndConditions');

                          context.goNamed('TermsConditions');
                        },
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'uzfzq8tl' /* &  */,
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
                      InkWell(
                        onTap: () async {
                          logFirebaseEvent(
                              'ADDING_INFORMATION_privacyPolicy_ON_TAP');
                          // termsAndConditions
                          logFirebaseEvent('privacyPolicy_termsAndConditions');
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
                            'c1o6ckwl' /* privacy policy */,
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 13, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            isInternetAvailable = await isInternetConnected();
                            logFirebaseEvent(
                                'ADDING_INFORMATION_submitInfo_ON_TAP');
                            if (fullNameController!.text == null ||
                                fullNameController!.text == '') {
                              logFirebaseEvent('submitInfo_Show-Snack-Bar');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    FFLocalizations.of(context).getText(
                                      'pleaseEnterFull' /* Please enter full name */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .subtitle1,
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor: Color(0xFF777777),
                                ),
                              );
                            } else {
                              if((isInternetAvailable??false)){
                                // submitInfo
                                logFirebaseEvent('submitInfo_submitInfo');
                                if(isNameValid){
                                  final userUpdateData = createUserRecordData(
                                    name: fullNameController!.text,
                                  );
                                  await currentUserReference!
                                      .update(userUpdateData);
                                  logFirebaseEvent('submitInfo_Navigate-To');
                                  context.go('/');
                                }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        FFLocalizations.of(context).getText(
                                          'allFields' /* Please fill all the information fields */,
                                        ),
                                        style: TextStyle(
                                          color:
                                          FlutterFlowTheme.of(context).white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 4000),
                                      backgroundColor:
                                      FlutterFlowTheme.of(context).primaryRed,
                                    ),
                                  );
                                }
                               // context.goNamed('HomeScreen');
                              }
                              else{
                                checkInternetStatus();
                              }
                            }
                          },
                          text: FFLocalizations.of(context).getText(
                            'fnkwu8bx' /* Continue */,
                          ),
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 56,
                            color:  isNameValid ? FlutterFlowTheme.of(context).primaryColor
                        : Color(0xFF8C8C8C),
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
