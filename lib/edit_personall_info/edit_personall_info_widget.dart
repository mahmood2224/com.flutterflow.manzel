import 'package:go_sell_sdk_flutter/go_sell_sdk_flutter.dart';
import 'package:manzel/auth/firebase_user_provider.dart';
import 'package:manzel/common_alert_dialog/common_alert_dialog.dart';
import 'package:manzel/common_widgets/manzel_icons.dart';
import 'package:manzel/components/something_went_wrong_widget.dart';
import 'package:manzel/flutter_flow/custom_functions.dart';

import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../components/reservation_bottom_sheet_widget.dart';
import '../flutter_flow/flutter_flow_choice_chips.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
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
  ApiCallResponse? bankList;
  String? bankValue;
  ApiCallResponse? emplymentList;
  String? privateSectorValue;
  String? monthlyIncomeValue;
  String? choiceChipsValue;
  TextEditingController? emailController;
  TextEditingController? fullNameController;
  bool? isInternetAvailable;
  bool isEmploymentLoading = true;
  bool isBankLoading = true;
  int alertCalled = 0;
  bool? thisEmailExists;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool? isProfileUpdated;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: currentUserEmail);
    fullNameController = TextEditingController(
        text: valueOrDefault(currentUserDocument?.name, ''));
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'EditPersonallInfo'});
    emplymentTypeCall();
    getBanksCall();
  }

  Future<void> emplymentTypeCall() async {
    isEmploymentLoading = true;
    setState(() {});
    isInternetAvailable = await isInternetConnected();
    if (isInternetAvailable ?? false) {
      emplymentList = await EmplymentTypeCall.call(
        locale: FFAppState().locale,
      );
      isEmploymentLoading = false;
      setState(() {});
    } else {
      isEmploymentLoading = false;
      setState(() {});
      alertCalled++;
      setState(() {});
      if (alertCalled <= 1)
        showDialog(
          context: context,
          builder: (BuildContext context) => CommonAlertDialog(
            onCancel: () {
              alertCalled = 0;
              setState(() {});
              Navigator.pop(context);
            },
          ),
        );
    }
  }

  Future<void> getBanksCall() async {
    isBankLoading = true;
    setState(() {});
    isInternetAvailable = await isInternetConnected();
    if (isInternetAvailable ?? false) {
      bankList = await GetBanksCall.call(
        locale: FFAppState().locale,
      );
      isBankLoading = false;
      setState(() {});
    } else if (loggedIn) {
      isBankLoading = false;
      setState(() {});
      alertCalled++;
      setState(() {});
      if (alertCalled <= 1)
        showDialog(
          context: context,
          builder: (BuildContext context) => CommonAlertDialog(
            onCancel: () {
              alertCalled = 0;
              setState(() {});
              Navigator.pop(context);
            },
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
              logFirebaseEvent('EDIT_PERSONALL_INFO_PAGE_back_ON_TAP');
              logFirebaseEvent('back_Close-Dialog,-Drawer,-Etc');
              isProfileUpdated = false;
              Navigator.pop(context, isProfileUpdated);
            },
          ),
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
                    height: 65,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBtnText,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color(0xFFA5A5A5),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                            child: AuthUserStreamWidget(
                              child: TextFormField(
                                controller: fullNameController,
                                autofocus: false,
                                obscureText: false,
                                onTap: () {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  labelText:
                                      FFLocalizations.of(context).getText(
                                    'umn1n8pc' /* Full Name */,
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
                                  hintText: FFLocalizations.of(context).getText(
                                    '1fogeuqq' /* Your name */,
                                  ),
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
                    height: 65,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBtnText,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color(0xFFA5A5A5),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                            child: TextFormField(
                              onTap: () {
                                setState(() {});
                              },
                              controller: emailController,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: FFLocalizations.of(context).getText(
                                  'pv48mvfw' /* Email */,
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
                                hintText: FFLocalizations.of(context).getText(
                                  'u4lpnyfc' /* Email */,
                                ),
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
                          style: FlutterFlowTheme.of(context)
                              .subtitle1
                              .override(
                                fontFamily: 'AvenirArabic',
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
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
                  padding: EdgeInsetsDirectional.fromSTEB(20, 4, 20, 25),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: AuthUserStreamWidget(
                          child: Directionality(
                            textDirection: material.TextDirection.ltr,
                            child: Text(
                              currentPhoneNumber,
                              style: FlutterFlowTheme.of(context)
                                  .subtitle1
                                  .override(
                                    fontFamily: 'AvenirArabic',
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts: false,
                                  ),
                            ),
                          ),
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
                                child: Builder(
                                  builder: (context) {
                                    if (isEmploymentLoading) {
                                      return Center(
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: SpinKitRipple(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryColor,
                                            size: 50,
                                          ),
                                        ),
                                      );
                                    } else if (emplymentList != null &&
                                        emplymentList?.statusCode == 200) {
                                      return FlutterFlowDropDown(
                                        initialOption: privateSectorValue ??=
                                            functions
                                                .editProfileDropDownInitalVal(
                                                    (EmplymentTypeCall
                                                        .emplymentData(
                                                      emplymentList!.jsonBody,
                                                    ) as List),
                                                    valueOrDefault(
                                                        currentUserDocument
                                                            ?.employmentStatus,
                                                        '')),
                                        options:
                                            (EmplymentTypeCall.emplymentTypes(
                                          (emplymentList?.jsonBody ?? ''),
                                        ) as List)
                                                .map<String>(
                                                    (s) => s.toString())
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
                                    }
                                    else if (emplymentList != null &&
                                        emplymentList?.statusCode != 200) {
                                      return SomethingWentWrongWidget(
                                          onTryAgain: () {
                                        emplymentTypeCall();
                                      });
                                    }
                                    return SizedBox();
                                  },
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
                                child: FlutterFlowDropDown(
                                  initialOption: monthlyIncomeValue ??=
                                      functions.monthlyIncome(
                                          'initialValue',
                                          valueOrDefault(
                                              currentUserDocument
                                                  ?.monthlyIncome,
                                              ''),
                                          FFAppState().locale),
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
                              child: AuthUserStreamWidget(
                                child: Builder(
                                  builder: (context) {
                                    // Customize what your widget looks like when it's loading.
                                    if (isBankLoading) {
                                      return Center(
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: SpinKitRipple(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryColor,
                                            size: 50,
                                          ),
                                        ),
                                      );
                                    } else if (bankList != null &&
                                        bankList?.statusCode == 200) {
                                      return FlutterFlowDropDown(
                                        initialOption: bankValue ??= functions
                                            .editProfileDropDownInitalVal(
                                                (GetBanksCall.bankData(
                                                  bankList!.jsonBody,
                                                ) as List),
                                                valueOrDefault(
                                                    currentUserDocument?.bank,
                                                    '')),
                                        options: (GetBanksCall.bankNames(
                                          (bankList?.jsonBody ?? ''),
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
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
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
                                    } else if (bankList != null &&
                                        bankList?.statusCode != 200) {
                                      return SomethingWentWrongWidget(
                                          onTryAgain: () {
                                        getBanksCall();
                                      });
                                    }
                                    return SizedBox();
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
                              child: AuthUserStreamWidget(
                                child: FlutterFlowChoiceChips(
                                  initiallySelected: choiceChipsValue != null
                                      ? [choiceChipsValue!]
                                      : [
                                          functions.sakaniLoanInitialValue(
                                              valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.sakaniLoanCoverage,
                                                  false),
                                              FFAppState().locale)
                                        ],
                                  options: [
                                    ChipData(
                                        FFLocalizations.of(context).getText(
                                      'ag8peu33' /* Yes */,
                                    )),
                                    ChipData(
                                        FFLocalizations.of(context).getText(
                                      'cxroduir' /* No */,
                                    ))
                                  ],
                                  onChanged: (val) => setState(
                                      () => choiceChipsValue = val?.first),
                                  selectedChipStyle: ChipStyle(
                                    backgroundColor:
                                        FlutterFlowTheme.of(context)
                                            .primaryColor,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'AvenirArabic',
                                          color: FlutterFlowTheme.of(context)
                                              .white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          useGoogleFonts: false,
                                        ),
                                    iconColor: Color(0x00000000),
                                    iconSize: 18,
                                    labelPadding:
                                        EdgeInsetsDirectional.fromSTEB(
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
                                    labelPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            38, 3, 38, 3),
                                    elevation: 4,
                                  ),
                                  chipSpacing: 20,
                                  rowSpacing: 60,
                                  multiselect: false,
                                  initialized: choiceChipsValue != null,
                                  alignment: WrapAlignment.start,
                                ),
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
                          if ((bankValue == null || bankValue == '') &&
                                  (privateSectorValue == null ||
                                      privateSectorValue == '') ||
                              (monthlyIncomeValue == null ||
                                      monthlyIncomeValue == '') &&
                                  (choiceChipsValue == null ||
                                      choiceChipsValue == '') ||
                              (emailController!.text == null ||
                                  emailController!.text == '') ||
                              (fullNameController!.text == null ||
                                  fullNameController!.text == '')) {
                            if (isInternetAvailable ?? false) {
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    CommonAlertDialog(
                                  onCancel: () {
                                    alertCalled = 0;
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  onSettings: () {},
                                ),
                              );
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  FFLocalizations.of(context).getText(
                                    'allFields' /* Please fill all the information fields */,
                                  ),
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context).white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor:
                                    FlutterFlowTheme.of(context).primaryRed,
                              ),
                            );
                          } else {
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
                                  name: fullNameController!.text,
                                  monthlyIncome: functions.monthlyIncome(
                                      'getIndex',
                                      monthlyIncomeValue,
                                      FFAppState().locale),
                                  employmentStatus:
                                      functions.editProfileindexReturn(
                                          (EmplymentTypeCall.emplymentData(
                                            (emplymentList?.jsonBody ?? ''),
                                          ) as List),
                                          privateSectorValue),
                                  bank: functions.editProfileindexReturn(
                                      (GetBanksCall.bankData(
                                        (bankList?.jsonBody ?? ''),
                                      ) as List),
                                      bankValue),
                                  sakaniLoanCoverage:
                                      functions.sakaniLoan(choiceChipsValue),
                                );

                                await FirebaseFirestore.instance.collection('User').where(
                                    'email', isEqualTo: emailController?.text).get().then(
                                      (res) {
                                    var data = res.docs;
                                    print("Successfully completed ${data.length}");
                                    if(data.length>1){
                                      thisEmailExists=true;
                                      setState((){});
                                    }else{
                                      thisEmailExists=false;
                                      setState((){});
                                    }
                                  },
                                  onError: (e) => print("Error completing: $e"),);

                                if (isInternetAvailable ?? false) {
                                  if((thisEmailExists??false)){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Email Already Exists',
                                          style:
                                          FlutterFlowTheme.of(context).subtitle1,
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor: FlutterFlowTheme.of(
                                            context)
                                            .primaryRed,
                                      ),
                                    );
                                  }else{
                                    await currentUserReference!
                                        .update(userUpdateData);
                                    logFirebaseEvent(
                                        'updatePersonalInfo_Close-Dialog,-Drawer,');
                                    isProfileUpdated = true;
                                   // Navigator.pop(context, isProfileUpdated);
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
                                logFirebaseEvent(
                                    'updatePersonalInfo_Show-Snack-Bar');
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
                            } else {
                              // updatePersonaInfo
                              logFirebaseEvent(
                                  'updatePersonalInfo_updatePersonaInfo');

                              final userUpdateData = createUserRecordData(
                                email: emailController!.text,
                                name: fullNameController!.text,
                                monthlyIncome: functions.monthlyIncome(
                                    'getIndex',
                                    monthlyIncomeValue,
                                    FFAppState().locale),
                                employmentStatus:
                                    functions.editProfileindexReturn(
                                        (EmplymentTypeCall.emplymentData(
                                          (emplymentList?.jsonBody ?? ''),
                                        ) as List),
                                        privateSectorValue),
                                bank: functions.editProfileindexReturn(
                                    (GetBanksCall.bankData(
                                      (bankList?.jsonBody ?? ''),
                                    ) as List),
                                    bankValue),
                                sakaniLoanCoverage:
                                    functions.sakaniLoan(choiceChipsValue),
                              );

                              await FirebaseFirestore.instance.collection('User').where(
                                  'email', isEqualTo: emailController?.text).get().then(
                                    (res) {
                                  var data = res.docs;
                                  print("Successfully completed ${data.length}");
                                  if(data.length>1){
                                    thisEmailExists=true;
                                    setState((){});
                                  }else{
                                    thisEmailExists=false;
                                    setState((){});
                                  }
                                },
                                onError: (e) => print("Error completing: $e"),);
                              if (isInternetAvailable ?? false) {
                                if((thisEmailExists??false)){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                       'Email Already Exists',
                                        style:
                                        FlutterFlowTheme.of(context).subtitle1,
                                      ),
                                      duration: Duration(milliseconds: 4000),
                                      backgroundColor: FlutterFlowTheme.of(
                                          context)
                                          .primaryRed,
                                    ),
                                  );
                                }else{
                                  await currentUserReference!
                                      .update(userUpdateData);
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

                              logFirebaseEvent(
                                  'updatePersonalInfo_Close-Dialog,-Drawer,');
                              Navigator.pop(context);
                            }
                          }
                        },
                        text: FFLocalizations.of(context).getText(
                          '91pyvwfe' /* Submit */,
                        ),
                        options: FFButtonOptions(
                          width: 343,
                          height: 56,
                          // emailController!.text,
                          // fullNameController!.text,
                          // bankValue,
                          // privateSectorValue,
                          // monthlyIncomeValue,
                          // choiceChipsValue
                          color: ((bankValue != null && bankValue != '') &&
                                  (privateSectorValue != null &&
                                      privateSectorValue != '') &&
                                  (monthlyIncomeValue != null &&
                                      monthlyIncomeValue != '') &&
                                  (choiceChipsValue != null &&
                                      choiceChipsValue != '') &&
                                  (emailController!.text != null &&
                                      emailController!.text != '') &&
                                  (fullNameController!.text != null &&
                                      fullNameController!.text != ''))
                              ? FlutterFlowTheme.of(context).primaryColor
                              : Color(0xFF8C8C8C),
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

  Future<void> configurePaymentSdk() async {
    GoSellSdkFlutter.configureApp(
      bundleId: 'com.flutterflow.manzel',
      productionSecreteKey: 'sk_live_o4Z3j8HafuOCG9PNJ1eVrvsz',
      sandBoxsecretKey: 'sk_test_2r5JvPVafKxklSn6LRpqWycQ',
      lang: FFAppState().locale,
    );
  }

  @override
  void dispose() {
    emailController?.dispose();
    fullNameController?.dispose();
    super.dispose();
  }
}
