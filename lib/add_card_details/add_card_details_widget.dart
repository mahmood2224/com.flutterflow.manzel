import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCardDetailsWidget extends StatefulWidget {
  const AddCardDetailsWidget({Key key}) : super(key: key);

  @override
  _AddCardDetailsWidgetState createState() => _AddCardDetailsWidgetState();
}

class _AddCardDetailsWidgetState extends State<AddCardDetailsWidget> {
  TextEditingController cardNumberController1;
  TextEditingController cardNumberController2;
  TextEditingController cardNumberController3;
  TextEditingController cardNumberController4;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    cardNumberController1 = TextEditingController();
    cardNumberController2 = TextEditingController();
    cardNumberController3 = TextEditingController();
    cardNumberController4 = TextEditingController();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'AddCardDetails'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 14, 15, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(),
                      child: InkWell(
                        onTap: () async {
                          logFirebaseEvent(
                              'ADD_CARD_DETAILS_Icon_id5z0f8p_ON_TAP');
                          logFirebaseEvent('Icon_Navigate-To');
                          context.pushNamed(
                            'KYC',
                            extra: <String, dynamic>{
                              kTransitionInfoKey: TransitionInfo(
                                hasTransition: true,
                                transitionType: PageTransitionType.fade,
                                duration: Duration(milliseconds: 0),
                              ),
                            },
                          );
                        },
                        child: Icon(
                          Icons.clear_sharp,
                          color: Colors.black,
                          size: 24,
                        ),
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
                      'Add your credit card',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
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
                padding: EdgeInsetsDirectional.fromSTEB(20, 3, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Please fill in the fields below to submit your booking',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Sofia Pro By Khuzaimah',
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              useGoogleFonts: false,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
                child: Container(
                  width: double.infinity,
                  height: 55,
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
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: TextFormField(
                            controller: cardNumberController1,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: FFLocalizations.of(context).getText(
                                '192j9655' /* Card Number */,
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
                                's7o0t1vo' /* 0000 0000 0000 0000 */,
                              ),
                              hintStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    color: Color(0xFFA5A5A5),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts: false,
                                  ),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Sofia Pro By Khuzaimah',
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
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 23, 0),
                        child: Container(
                          width: double.infinity,
                          height: 55,
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 0, 0),
                                  child: TextFormField(
                                    controller: cardNumberController2,
                                    autofocus: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText:
                                          FFLocalizations.of(context).getText(
                                        'i8uaihjd' /* Expiry Date */,
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
                                        '6xvwrsr6' /* MM/YY */,
                                      ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily:
                                                'Sofia Pro By Khuzaimah',
                                            color: Color(0xFFA5A5A5),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts: false,
                                          ),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
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
                                    keyboardType: TextInputType.datetime,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 55,
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
                                    EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: TextFormField(
                                  controller: cardNumberController3,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText:
                                        FFLocalizations.of(context).getText(
                                      'r8lh7z72' /* CVV */,
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
                                    hintText:
                                        FFLocalizations.of(context).getText(
                                      'u48o2mqd' /* 0000 */,
                                    ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Sofia Pro By Khuzaimah',
                                          color: Color(0xFFA5A5A5),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          useGoogleFonts: false,
                                        ),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
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
                                  keyboardType: TextInputType.phone,
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
                child: Container(
                  width: double.infinity,
                  height: 55,
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
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: TextFormField(
                            controller: cardNumberController4,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: FFLocalizations.of(context).getText(
                                'aecvo7l3' /* Cardhoder name */,
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
                                '3ud350pw' /*   */,
                              ),
                              hintStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    color: Color(0xFFA5A5A5),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts: false,
                                  ),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 123, 16, 0),
                child: FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent('ADD_CARD_DETAILS_PAGE_SUBMIT_BTN_ON_TAP');
                    logFirebaseEvent('Button_Navigate-To');
                    context.pushNamed(
                      'Confirmation',
                      queryParams: {
                        'propertyId': serializeParam(0, ParamType.int),
                        'paymentMethod': serializeParam('', ParamType.String),
                        'orderId': serializeParam(0, ParamType.int),
                      }.withoutNulls,
                    );
                  },
                  text: 'Submit',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 56,
                    color: FlutterFlowTheme.of(context).primaryColor,
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Sofia Pro By Khuzaimah',
                          color: Colors.white,
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
      ),
    );
  }
}
