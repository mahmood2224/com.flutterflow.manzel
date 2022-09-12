import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class AbsherVerificationWidget extends StatefulWidget {
  const AbsherVerificationWidget({Key? key}) : super(key: key);

  @override
  _AbsherVerificationWidgetState createState() =>
      _AbsherVerificationWidgetState();
}

class _AbsherVerificationWidgetState extends State<AbsherVerificationWidget> {
  TextEditingController? birthdayController;

  TextEditingController? idNumberController;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    birthdayController = TextEditingController();
    idNumberController = TextEditingController();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'AbsherVerification'});
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
            'rtnjo9zy' /* Absher Verification */,
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
                logFirebaseEvent('ABSHER_VERIFICATION_PAGE_backIcon_ON_TAP');
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
                  percent: 0.25,
                  width: 338,
                  lineHeight: 4,
                  animation: true,
                  progressColor: Color(0xFF81D05C),
                  backgroundColor: Color(0xFFF8F8F8),
                  barRadius: Radius.circular(6),
                  padding: EdgeInsets.zero,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 33, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'ch5dgyyj' /* Absher Verification */,
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
                            '820iwo6l' /* To verify your identity, you s... */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'AvenirArabic',
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
                  padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: idNumberController,
                          onChanged: (_) => EasyDebounce.debounce(
                            'idNumberController',
                            Duration(milliseconds: 2000),
                            () => setState(() {}),
                          ),
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: FFLocalizations.of(context).getText(
                              'sagsx4yq' /* ID Number */,
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
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: TextFormField(
                          controller: birthdayController,
                          onChanged: (_) => EasyDebounce.debounce(
                            'birthdayController',
                            Duration(milliseconds: 2000),
                            () => setState(() {}),
                          ),
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: FFLocalizations.of(context).getText(
                              'qpey20he' /* Birthday */,
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
                            suffixIcon: Icon(
                              Icons.date_range_outlined,
                              color: Color(0xFF6B6B6B),
                              size: 20,
                            ),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'AvenirArabic',
                                    fontWeight: FontWeight.w300,
                                    useGoogleFonts: false,
                                  ),
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 400, 0, 30),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          logFirebaseEvent(
                              'ABSHER_VERIFICATION_goToConfirmAbsher_ON');
                          // goToConfirmAbsher
                          logFirebaseEvent(
                              'goToConfirmAbsher_goToConfirmAbsher');

                          context.pushNamed('ConfirmAbsher');
                        },
                        text: FFLocalizations.of(context).getText(
                          's2h8gxw5' /* Continue */,
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
