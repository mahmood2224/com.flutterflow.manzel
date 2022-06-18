import '../auth/auth_util.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PersonalEmploymentDetailsWidget extends StatefulWidget {
  const PersonalEmploymentDetailsWidget({Key key}) : super(key: key);

  @override
  _PersonalEmploymentDetailsWidgetState createState() =>
      _PersonalEmploymentDetailsWidgetState();
}

class _PersonalEmploymentDetailsWidgetState
    extends State<PersonalEmploymentDetailsWidget> {
  String bankValue;
  String monthlyIncomeValue;
  String privateSectorValue;
  TextEditingController emailController;
  TextEditingController fullNameController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: currentUserEmail);
    fullNameController = TextEditingController(text: currentUserDisplayName);
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'PersonalEmploymentDetails'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          FFLocalizations.of(context).getText(
            '56kjw7e5' /* Personal & Employment Details */,
          ),
          textAlign: TextAlign.start,
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
                logFirebaseEvent('PERSONAL_EMPLOYMENT_DETAILS_backIcon_ON_');
                // goToKYC
                logFirebaseEvent('backIcon_goToKYC');
                context.pushNamed('KYC');
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
                  percent: 0.75,
                  width: 338,
                  lineHeight: 4,
                  animation: true,
                  progressColor: Color(0xFF81D05C),
                  backgroundColor: Color(0xFFF8F8F8),
                  barRadius: Radius.circular(6),
                  padding: EdgeInsets.zero,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 11, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          FFLocalizations.of(context).getText(
                            '8gduxe32' /* We need to collect some inform... */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    useGoogleFonts: false,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          FFLocalizations.of(context).getText(
                            '3pne660j' /* Personal details */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w300,
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
                        child: AuthUserStreamWidget(
                          child: TextFormField(
                            controller: fullNameController,
                            onChanged: (_) => EasyDebounce.debounce(
                              'fullNameController',
                              Duration(milliseconds: 2000),
                              () => setState(() {}),
                            ),
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: FFLocalizations.of(context).getText(
                                'f40bwimn' /* Full Name */,
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
                                      fontWeight: FontWeight.w300,
                                      useGoogleFonts: false,
                                    ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: TextFormField(
                          controller: emailController,
                          onChanged: (_) => EasyDebounce.debounce(
                            'emailController',
                            Duration(milliseconds: 2000),
                            () => setState(() {}),
                          ),
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: FFLocalizations.of(context).getText(
                              'rypubckx' /* Email */,
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
                                    fontWeight: FontWeight.w300,
                                    useGoogleFonts: false,
                                  ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 22, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                'm513rsgp' /* Employment details */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .subtitle1
                                  .override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w300,
                                    useGoogleFonts: false,
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
                            AuthUserStreamWidget(
                              child: FlutterFlowDropDown(
                                initialOption: monthlyIncomeValue ??=
                                    valueOrDefault(
                                        currentUserDocument?.monthlyIncome, ''),
                                options: [
                                  FFLocalizations.of(context).getText(
                                    'pky5i3u5' /* 2000 - 5000 SAR */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    '1ucut902' /* 5000 - 10000 SAR */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    'tiwdj1lc' /* 10000 - 30000 SAR */,
                                  )
                                ],
                                onChanged: (val) =>
                                    setState(() => monthlyIncomeValue = val),
                                width: 335,
                                height: 55,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Sofia Pro By Khuzaimah',
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: false,
                                    ),
                                hintText: FFLocalizations.of(context).getText(
                                  'r31pneec' /* Monthly income */,
                                ),
                                fillColor: Colors.white,
                                elevation: 2,
                                borderColor: Color(0xFFA5A5A5),
                                borderWidth: 1,
                                borderRadius: 8,
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    12, 4, 12, 4),
                                hidesUnderline: true,
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
                            FlutterFlowDropDown(
                              initialOption: privateSectorValue ??=
                                  FFLocalizations.of(context).getText(
                                'ueg5zdc6' /* Private Sector */,
                              ),
                              options: [
                                FFLocalizations.of(context).getText(
                                  'rbeky186' /* Private Sector */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'yfeu3no3' /* Goverment sector */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'tli98cm2' /* Hafiz */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'yfkb666m' /* Retired */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'v1163114' /* Self Employment */,
                                ),
                                FFLocalizations.of(context).getText(
                                  '1fyb88yc' /* Student */,
                                ),
                                FFLocalizations.of(context).getText(
                                  '5vzz34pm' /* Unemployed */,
                                )
                              ],
                              onChanged: (val) =>
                                  setState(() => privateSectorValue = val),
                              width: 335,
                              height: 55,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts: false,
                                  ),
                              hintText: FFLocalizations.of(context).getText(
                                '35o1hqb9' /* Employment status */,
                              ),
                              fillColor: Colors.white,
                              elevation: 2,
                              borderColor: Color(0xFFA5A5A5),
                              borderWidth: 1,
                              borderRadius: 8,
                              margin:
                                  EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                              hidesUnderline: true,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            AuthUserStreamWidget(
                              child: FlutterFlowDropDown(
                                initialOption: bankValue ??= valueOrDefault(
                                    currentUserDocument?.bank, ''),
                                options: [
                                  FFLocalizations.of(context).getText(
                                    '730iu6wb' /* AlRajhi Bank */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    'zmhh0w3q' /* Alinma Bank */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    '4h360xlf' /* Alahli Bank */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    'omiqb5pp' /* SAAB Bank */,
                                  )
                                ],
                                onChanged: (val) =>
                                    setState(() => bankValue = val),
                                width: 335,
                                height: 55,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Sofia Pro By Khuzaimah',
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: false,
                                    ),
                                hintText: FFLocalizations.of(context).getText(
                                  'jfgvqahn' /* Salary bank */,
                                ),
                                fillColor: Colors.white,
                                elevation: 2,
                                borderColor: Color(0xFFA5A5A5),
                                borderWidth: 1,
                                borderRadius: 8,
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    12, 4, 12, 4),
                                hidesUnderline: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 22, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'araxruq2' /* Does the Sakani loan cover you... */,
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
                  padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 17),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                        child: FFButtonWidget(
                          onPressed: () {
                            print('yesBtn pressed ...');
                          },
                          text: FFLocalizations.of(context).getText(
                            '7adrd83m' /* Yes */,
                          ),
                          options: FFButtonOptions(
                            width: 102,
                            height: 44,
                            color: Colors.white,
                            textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Sofia Pro By Khuzaimah',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: false,
                                    ),
                            borderSide: BorderSide(
                              color: Color(0xFFD9D9D9),
                              width: 1,
                            ),
                            borderRadius: 12,
                          ),
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () {
                          print('noBtn pressed ...');
                        },
                        text: FFLocalizations.of(context).getText(
                          'q1kks67n' /* No */,
                        ),
                        options: FFButtonOptions(
                          width: 102,
                          height: 44,
                          color: Colors.white,
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts: false,
                                  ),
                          borderSide: BorderSide(
                            color: Color(0xFFD9D9D9),
                            width: 1,
                          ),
                          borderRadius: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FFButtonWidget(
                        onPressed: () {
                          print('submitInfo pressed ...');
                        },
                        text: FFLocalizations.of(context).getText(
                          'u22s8pus' /* Continue */,
                        ),
                        options: FFButtonOptions(
                          width: 343,
                          height: 56,
                          color: FlutterFlowTheme.of(context).primaryColor,
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
                          borderRadius: 12,
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
