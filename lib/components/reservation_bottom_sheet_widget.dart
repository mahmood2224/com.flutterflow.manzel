import '../flutter_flow/flutter_flow_radio_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class ReservationBottomSheetWidget extends StatefulWidget {
  const ReservationBottomSheetWidget({
    Key key,
    this.reservationCost,
  }) : super(key: key);

  final int reservationCost;

  @override
  _ReservationBottomSheetWidgetState createState() =>
      _ReservationBottomSheetWidgetState();
}

class _ReservationBottomSheetWidgetState
    extends State<ReservationBottomSheetWidget> {
  String paymentMethodValue;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            height: 75,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x80000000),
                  offset: Offset(0, 1),
                )
              ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(17),
                topRight: Radius.circular(17),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.04, 22, 0, 0),
                  child: Container(
                    width: 24.06,
                    height: 23.76,
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.2,
                      maxHeight: double.infinity,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: InkWell(
                      onTap: () async {
                        logFirebaseEvent(
                            'RESERVATION_BOTTOM_SHEET_Icon_hapf6xse_O');
                        logFirebaseEvent('Icon_Bottom-Sheet');
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.clear,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 22, 0, 0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'jaefs5yd' /* Reservation confirmation */,
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Sofia Pro By Khuzaimah',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: false,
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
            padding: EdgeInsetsDirectional.fromSTEB(25, 19, 25, 0),
            child: Text(
              FFLocalizations.of(context).getText(
                'pdty4a6r' /* To confirm the reservation, yo... */,
              ),
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Sofia Pro By Khuzaimah',
                    fontSize: 13,
                    useGoogleFonts: false,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(25, 0, 25, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  FFLocalizations.of(context).getText(
                    'njswqwdn' /* agree to our  */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Sofia Pro By Khuzaimah',
                        fontSize: 13,
                        useGoogleFonts: false,
                      ),
                ),
                InkWell(
                  onTap: () async {
                    logFirebaseEvent(
                        'RESERVATION_BOTTOM_SHEET_Text_qhlvmiqm_O');
                    logFirebaseEvent('Text_Navigate-To');
                    context.pushNamed(
                      'TermsConditions',
                      extra: <String, dynamic>{
                        kTransitionInfoKey: TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                          duration: Duration(milliseconds: 0),
                        ),
                      },
                    );
                  },
                  child: Text(
                    FFLocalizations.of(context).getText(
                      '0gizrv8a' /* terms & conditions  */,
                    ),
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Sofia Pro By Khuzaimah',
                          color: Color(0xFF2971FB),
                          fontSize: 13,
                          useGoogleFonts: false,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(121, 43, 121, 0),
            child: Text(
              FFLocalizations.of(context).getText(
                'iyjhj02m' /* Reservation cost */,
              ),
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Sofia Pro By Khuzaimah',
                    fontSize: 18,
                    useGoogleFonts: false,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.reservationCost.toString(),
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Sofia Pro By Khuzaimah',
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts: false,
                        ),
                  ),
                  Text(
                    FFLocalizations.of(context).getText(
                      'ovajaogv' /* .00 */,
                    ),
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Sofia Pro By Khuzaimah',
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts: false,
                        ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        'wqlgaavg' /* SAR */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Sofia Pro By Khuzaimah',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: false,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            FFLocalizations.of(context).getText(
              'sohxgusa' /* Note: Reservation cost is non-... */,
            ),
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Sofia Pro By Khuzaimah',
                  color: Color(0xFFDC5D5C),
                  fontSize: 13,
                  useGoogleFonts: false,
                ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 52, 20, 0),
            child: Text(
              FFLocalizations.of(context).getText(
                'p0n3wi8y' /* Select Payment Method */,
              ),
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Sofia Pro By Khuzaimah',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    useGoogleFonts: false,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 22, 20, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FlutterFlowRadioButton(
                      options: [
                        FFLocalizations.of(context).getText(
                          '0pkqdf0l' /* Mada/Visa */,
                        ),
                        FFLocalizations.of(context).getText(
                          'icwlzrr6' /* ApplePay */,
                        )
                      ].toList(),
                      onChanged: (value) {
                        setState(() => paymentMethodValue = value);
                      },
                      optionHeight: 25,
                      textStyle:
                          FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily: 'Sofia Pro By Khuzaimah',
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                useGoogleFonts: false,
                                lineHeight: 2,
                              ),
                      selectedTextStyle: FlutterFlowTheme.of(context)
                          .bodyText1
                          .override(
                            fontFamily: 'Sofia Pro By Khuzaimah',
                            color: FlutterFlowTheme.of(context).primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            useGoogleFonts: false,
                          ),
                      textPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                      buttonPosition: RadioButtonPosition.left,
                      direction: Axis.vertical,
                      radioButtonColor:
                          FlutterFlowTheme.of(context).primaryColor,
                      inactiveRadioButtonColor: Color(0x8A000000),
                      toggleable: true,
                      horizontalAlignment: WrapAlignment.start,
                      verticalAlignment: WrapCrossAlignment.start,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.asset(
                          'assets/images/visa:mada.png',
                          height: 20,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Image.asset(
                            'assets/images/applepay.png',
                            height: 20,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          if ((paymentMethodValue != null && paymentMethodValue != ''))
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 100, 20, 20),
              child: FFButtonWidget(
                onPressed: () {
                  print('Button pressed ...');
                },
                text: FFLocalizations.of(context).getText(
                  'p50ponkb' /* Button */,
                ),
                options: FFButtonOptions(
                  width: 130,
                  height: 52,
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
    );
  }
}
