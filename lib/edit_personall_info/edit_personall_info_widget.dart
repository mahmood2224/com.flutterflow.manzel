import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_choice_chips.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPersonallInfoWidget extends StatefulWidget {
  const EditPersonallInfoWidget({
    Key? key,
    this.screenName,
  }) : super(key: key);

  final String? screenName;

  @override
  _EditPersonallInfoWidgetState createState() =>
      _EditPersonallInfoWidgetState();
}

class _EditPersonallInfoWidgetState extends State<EditPersonallInfoWidget> {
  TextEditingController? emailController;

  TextEditingController? fullNameController;

  String? bankValue;
  String? monthlyIncomeValue;
  String? privateSectorValue;
  String? choiceChipsValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: currentUserEmail);
    fullNameController = TextEditingController(
        text: valueOrDefault(currentUserDocument?.name, ''));
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
            logFirebaseEvent('back_Close-Dialog,-Drawer,-Etc');
            Navigator.pop(context);
          },
        ),
        title: Text(
          FFLocalizations.of(context).getText(
            'w7fbktqj' /* Edit Personal Info */,
          ),
          style: FlutterFlowTheme.of(context).title1.override(
                fontFamily: 'AvenirArabic',
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 26, 20, 0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color(0xFFA5A5A5),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 12, 12, 8),
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
                                  labelText:
                                      FFLocalizations.of(context).getText(
                                    'lrqyceei' /* Full name */,
                                  ),
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Sofia Pro By Khuzaimah',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        useGoogleFonts: false,
                                      ),
                                  hintText: FFLocalizations.of(context).getText(
                                    '9gp42g0b' /* Your name */,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
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
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'AvenirArabic',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: false,
                                      lineHeight: 1,
                                    ),
                                maxLines: 1,
                                keyboardType: TextInputType.name,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 25),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color(0xFFA5A5A5),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 12, 12, 8),
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
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Sofia Pro By Khuzaimah',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      useGoogleFonts: false,
                                      lineHeight: 1,
                                    ),
                                hintText: FFLocalizations.of(context).getText(
                                  'mgxrufe9' /* Email */,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'AvenirArabic',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts: false,
                                    lineHeight: 1,
                                  ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                              fontFamily: 'AvenirArabic',
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
                          style:
                              FlutterFlowTheme.of(context).subtitle1.override(
                                    fontFamily: 'AvenirArabic',
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
                  padding: EdgeInsetsDirectional.fromSTEB(20, 4, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: AuthUserStreamWidget(
                          child: Text(
                            currentPhoneNumber,
                            style:
                                FlutterFlowTheme.of(context).subtitle1.override(
                                      fontFamily: 'AvenirArabic',
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: false,
                                    ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'jj84j3p5' /* Employment details */,
                            ),
                            style:
                                FlutterFlowTheme.of(context).subtitle1.override(
                                      fontFamily: 'AvenirArabic',
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300,
                                      useGoogleFonts: false,
                                    ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: AuthUserStreamWidget(
                                child: FlutterFlowDropDown(
                                  initialOption: monthlyIncomeValue ??=
                                      valueOrDefault(
                                          currentUserDocument?.monthlyIncome,
                                          ''),
                                  options: [
                                    FFLocalizations.of(context).getText(
                                      '4w16yzqb' /* 2000 - 5000 SAR */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      'him4ym4p' /* 5000 - 10000 SAR */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      'pb50wqi5' /* 10000 - 30000 SAR */,
                                    )
                                  ],
                                  onChanged: (val) =>
                                      setState(() => monthlyIncomeValue = val),
                                  width: 335,
                                  height: 55,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'AvenirArabic',
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        useGoogleFonts: false,
                                      ),
                                  hintText: FFLocalizations.of(context).getText(
                                    'ae71fn4w' /* Monthly income */,
                                  ),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 15,
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
                              child: FutureBuilder<ApiCallResponse>(
                                future: EmplymentTypeCall.call(
                                  locale: FFAppState().locale,
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: SpinKitRipple(
                                          color: Color(0xFF2971FB),
                                          size: 50,
                                        ),
                                      ),
                                    );
                                  }
                                  final privateSectorEmplymentTypeResponse =
                                      snapshot.data!;
                                  return FlutterFlowDropDown(
                                    initialOption: privateSectorValue ??=
                                        FFLocalizations.of(context).getText(
                                      '1x1hia9l' /* Private Sector */,
                                    ),
                                    options: (EmplymentTypeCall.emplymentTypes(
                                      privateSectorEmplymentTypeResponse
                                          .jsonBody,
                                    ) as List)
                                        .map<String>((s) => s.toString())
                                        .toList()
                                        .toList(),
                                    onChanged: (val) => setState(
                                        () => privateSectorValue = val),
                                    width: 335,
                                    height: 55,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'AvenirArabic',
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          useGoogleFonts: false,
                                        ),
                                    hintText:
                                        FFLocalizations.of(context).getText(
                                      'gerdd7rv' /* Employment status */,
                                    ),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 15,
                                    ),
                                    fillColor: Colors.white,
                                    elevation: 2,
                                    borderColor: Color(0xFFA5A5A5),
                                    borderWidth: 1,
                                    borderRadius: 8,
                                    margin: EdgeInsetsDirectional.fromSTEB(
                                        12, 4, 12, 4),
                                    hidesUnderline: true,
                                  );
                                },
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
                                child: FutureBuilder<ApiCallResponse>(
                                  future: GetBanksCall.call(
                                    locale: FFAppState().locale,
                                  ),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: SpinKitRipple(
                                            color: Color(0xFF2971FB),
                                            size: 50,
                                          ),
                                        ),
                                      );
                                    }
                                    final bankGetBanksResponse = snapshot.data!;
                                    return FlutterFlowDropDown(
                                      initialOption: bankValue ??=
                                          valueOrDefault(
                                              currentUserDocument?.bank, ''),
                                      options: (GetBanksCall.bankNames(
                                        bankGetBanksResponse.jsonBody,
                                      ) as List)
                                          .map<String>((s) => s.toString())
                                          .toList()
                                          .toList(),
                                      onChanged: (val) =>
                                          setState(() => bankValue = val),
                                      width: 335,
                                      height: 55,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'AvenirArabic',
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts: false,
                                          ),
                                      hintText:
                                          FFLocalizations.of(context).getText(
                                        'nfhf8rho' /* Salary bank */,
                                      ),
                                      fillColor: Colors.white,
                                      elevation: 2,
                                      borderColor: Color(0xFFA5A5A5),
                                      borderWidth: 1,
                                      borderRadius: 8,
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          12, 4, 12, 4),
                                      hidesUnderline: true,
                                    );
                                  },
                                ),
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
                                'doqco3ap' /* Does the Sakani loan cover you... */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'AvenirArabic',
                                    fontSize: 17,
                                    useGoogleFonts: false,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: FlutterFlowChoiceChips(
                                initiallySelected: [
                                  if (choiceChipsValue != null)
                                    choiceChipsValue!
                                ],
                                options: [
                                  ChipData(FFLocalizations.of(context).getText(
                                    'ag8peu33' /* Yes */,
                                  )),
                                  ChipData(FFLocalizations.of(context).getText(
                                    'cxroduir' /* No */,
                                  ))
                                ],
                                onChanged: (val) => setState(
                                    () => choiceChipsValue = val?.first),
                                selectedChipStyle: ChipStyle(
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'AvenirArabic',
                                        color:
                                            FlutterFlowTheme.of(context).white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        useGoogleFonts: false,
                                      ),
                                  iconColor: Color(0x00000000),
                                  iconSize: 18,
                                  labelPadding: EdgeInsetsDirectional.fromSTEB(
                                      38, 3, 38, 3),
                                  elevation: 4,
                                ),
                                unselectedChipStyle: ChipStyle(
                                  backgroundColor: Colors.white,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'AvenirArabic',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        useGoogleFonts: false,
                                      ),
                                  iconColor: Color(0x00000000),
                                  iconSize: 18,
                                  labelPadding: EdgeInsetsDirectional.fromSTEB(
                                      38, 3, 38, 3),
                                  elevation: 4,
                                ),
                                chipSpacing: 20,
                                rowSpacing: 60,
                                multiselect: false,
                                alignment: WrapAlignment.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 30),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          logFirebaseEvent(
                              'EDIT_PERSONALL_INFO_updatePersonalInfo_O');
                          if (widget.screenName == 'PropertyDetails') {
                            if (functions.profileCompletetionCheck(
                                emailController!.text,
                                fullNameController!.text,
                                bankValue,
                                privateSectorValue,
                                monthlyIncomeValue,
                                choiceChipsValue)) {
                              // updatePersonaInfo
                              logFirebaseEvent(
                                  'updatePersonalInfo_updatePersonaInfo');

                              final userUpdateData = createUserRecordData(
                                email: emailController!.text,
                                phoneNumber: currentPhoneNumber,
                                name: fullNameController!.text,
                                monthlyIncome: monthlyIncomeValue,
                                employmentStatus: privateSectorValue,
                                bank: bankValue,
                              );
                              await currentUserReference!
                                  .update(userUpdateData);
                              logFirebaseEvent(
                                  'updatePersonalInfo_Close-Dialog,-Drawer,');
                              Navigator.pop(context);
                            } else {
                              logFirebaseEvent(
                                  'updatePersonalInfo_Show-Snack-Bar');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Please fill all the information fields',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context).white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                              );
                            }
                          } else {
                            // updatePersonaInfo
                            logFirebaseEvent(
                                'updatePersonalInfo_updatePersonaInfo');

                            final userUpdateData = createUserRecordData(
                              email: emailController!.text,
                              phoneNumber: currentPhoneNumber,
                              name: fullNameController!.text,
                              monthlyIncome: monthlyIncomeValue,
                              employmentStatus: privateSectorValue,
                              bank: bankValue,
                            );
                            await currentUserReference!.update(userUpdateData);
                            logFirebaseEvent(
                                'updatePersonalInfo_Close-Dialog,-Drawer,');
                            Navigator.pop(context);
                          }
                        },
                        text: FFLocalizations.of(context).getText(
                          '91pyvwfe' /* Submit */,
                        ),
                        options: FFButtonOptions(
                          width: 343,
                          height: 56,
                          color: Color(0xFF2971FB),
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle1.override(
                                    fontFamily: 'AvenirArabic',
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
      ),
    );
  }
}
