import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPersonallInfoWidget extends StatefulWidget {
  const EditPersonallInfoWidget({Key key}) : super(key: key);

  @override
  _EditPersonallInfoWidgetState createState() =>
      _EditPersonallInfoWidgetState();
}

class _EditPersonallInfoWidgetState extends State<EditPersonallInfoWidget> {
  TextEditingController emailController;
  TextEditingController fullNameController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: currentUserEmail);
    fullNameController = TextEditingController(text: currentUserDisplayName);
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'EditPersonallInfo'});
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
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () async {
            logFirebaseEvent('EDIT_PERSONALL_INFO_PAGE_back_ON_TAP');
            logFirebaseEvent('back_Navigate-To');
            context.pushNamed('Profile');
          },
        ),
        title: Text(
          FFLocalizations.of(context).getText(
            'w7fbktqj' /* Edit Personal Info */,
          ),
          style: FlutterFlowTheme.of(context).title1.override(
                fontFamily: 'Sofia Pro By Khuzaimah',
                fontSize: 18,
                fontWeight: FontWeight.normal,
                useGoogleFonts: false,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 26, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: AuthUserStreamWidget(
                        child: TextFormField(
                          controller: fullNameController,
                          onChanged: (_) => EasyDebounce.debounce(
                            'fullNameController',
                            Duration(milliseconds: 2000),
                            () => setState(() {}),
                          ),
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: FFLocalizations.of(context).getText(
                              'lrqyceei' /* Full name */,
                            ),
                            hintText: FFLocalizations.of(context).getText(
                              '9gp42g0b' /* Your name */,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFA5A5A5),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFA5A5A5),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts: false,
                                  ),
                          keyboardType: TextInputType.name,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: emailController,
                        onChanged: (_) => EasyDebounce.debounce(
                          'emailController',
                          Duration(milliseconds: 2000),
                          () => setState(() {}),
                        ),
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: FFLocalizations.of(context).getText(
                            'vxe1d85b' /* Email */,
                          ),
                          hintText: FFLocalizations.of(context).getText(
                            'mgxrufe9' /* Email */,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFA5A5A5),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFA5A5A5),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Sofia Pro By Khuzaimah',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              useGoogleFonts: false,
                            ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
                indent: 20,
                endIndent: 20,
                color: Color(0xFFECECEC),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      FFLocalizations.of(context).getText(
                        'kpcecp9o' /* Mobile number */,
                      ),
                      style: FlutterFlowTheme.of(context).subtitle1.override(
                            fontFamily: 'Sofia Pro By Khuzaimah',
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            useGoogleFonts: false,
                          ),
                    ),
                    InkWell(
                      onTap: () async {
                        logFirebaseEvent(
                            'EDIT_PERSONALL_INFO_editMobile_ON_TAP');
                        logFirebaseEvent('editMobile_Navigate-To');
                        context.goNamed('EditMobileNumber');
                      },
                      child: Text(
                        FFLocalizations.of(context).getText(
                          'lbyulmrk' /* Edit */,
                        ),
                        style: FlutterFlowTheme.of(context).subtitle1.override(
                              fontFamily: 'Sofia Pro By Khuzaimah',
                              color: Color(0xFF2971FB),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              useGoogleFonts: false,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 4, 20, 24),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AuthUserStreamWidget(
                      child: Text(
                        currentPhoneNumber,
                        style: FlutterFlowTheme.of(context).subtitle1.override(
                              fontFamily: 'Sofia Pro By Khuzaimah',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              useGoogleFonts: false,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 330, 16, 30),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        logFirebaseEvent(
                            'EDIT_PERSONALL_INFO_updatePersonalInfo_O');
                        // updatePersonaInfo
                        logFirebaseEvent(
                            'updatePersonalInfo_updatePersonaInfo');

                        final userUpdateData = createUserRecordData(
                          email: emailController.text,
                          displayName: fullNameController.text,
                          phoneNumber: currentPhoneNumber,
                        );
                        await currentUserReference.update(userUpdateData);
                        logFirebaseEvent('updatePersonalInfo_Navigate-To');
                        context.pushNamed('Profile');
                      },
                      text: FFLocalizations.of(context).getText(
                        '91pyvwfe' /* Save changes */,
                      ),
                      options: FFButtonOptions(
                        width: 343,
                        height: 56,
                        color: Color(0xFF2971FB),
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle1.override(
                                  fontFamily: 'Sofia Pro By Khuzaimah',
                                  color: Colors.white,
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
