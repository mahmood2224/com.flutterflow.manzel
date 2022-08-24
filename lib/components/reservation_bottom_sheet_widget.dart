import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../components/terms_conditions_bottom_sheet_widget.dart';
import '../flutter_flow/flutter_flow_radio_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ReservationBottomSheetWidget extends StatefulWidget {
  const ReservationBottomSheetWidget({
    Key key,
    this.reservationCost,
    this.propertyId,
  }) : super(key: key);

  final int reservationCost;
  final int propertyId;

  @override
  _ReservationBottomSheetWidgetState createState() =>
      _ReservationBottomSheetWidgetState();
}

class _ReservationBottomSheetWidgetState
    extends State<ReservationBottomSheetWidget> {
  ApiCallResponse addOrderApiResponse;
  ApiCallResponse transactionApiResponse;
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
                                      fontFamily: 'AvenirArabic',
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
                    fontFamily: 'AvenirArabic',
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
                        fontFamily: 'AvenirArabic',
                        fontSize: 13,
                        useGoogleFonts: false,
                      ),
                ),
                InkWell(
                  onTap: () async {
                    logFirebaseEvent(
                        'RESERVATION_BOTTOM_SHEET_Text_qhlvmiqm_O');
                    logFirebaseEvent('Text_Bottom-Sheet');
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: FlutterFlowTheme.of(context).white,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 1,
                            child: TermsConditionsBottomSheetWidget(
                              pageType: 5,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    FFLocalizations.of(context).getText(
                      '0gizrv8a' /* terms & conditions  */,
                    ),
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'AvenirArabic',
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
                    fontFamily: 'AvenirArabic',
                    fontSize: 18,
                    useGoogleFonts: false,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  functions.formatAmount(widget.reservationCost?.toString()),
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'AvenirArabic',
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
                          fontFamily: 'AvenirArabic',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts: false,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            FFLocalizations.of(context).getText(
              'sohxgusa' /* Note: Reservation cost is non-... */,
            ),
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'AvenirArabic',
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
                    fontFamily: 'AvenirArabic',
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
                      optionHeight: 56,
                      textStyle:
                          FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily: 'AvenirArabic',
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                useGoogleFonts: false,
                                lineHeight: 2,
                              ),
                      selectedTextStyle: FlutterFlowTheme.of(context)
                          .bodyText1
                          .override(
                            fontFamily: 'AvenirArabic',
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                          child: Image.asset(
                            'assets/images/visa:mada.png',
                            height: 20,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: SvgPicture.asset(
                            'assets/images/apple.svg',
                            width: 80,
                            height: 25,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (paymentMethodValue != null && paymentMethodValue != '')
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 100, 20, 20),
              child: StreamBuilder<List<OrdersRecord>>(
                stream: queryOrdersRecord(
                  queryBuilder: (ordersRecord) => ordersRecord
                      .where('property_id', isEqualTo: widget.propertyId)
                      .where('order_status', isEqualTo: 'Booked'),
                  limit: 2,
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
                  List<OrdersRecord> buttonOrdersRecordList = snapshot.data;
                  return FFButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent(
                          'RESERVATION_BOTTOM_SHEET_PAY_BTN_ON_TAP');
                      var _shouldSetState = false;
                      logFirebaseEvent('Button_Backend-Call');
                      addOrderApiResponse = await AddOrderCall.call(
                        propertyId: widget.propertyId?.toString(),
                        userId: '6TCZMQHGHJYXZEycWKX89PT4cwp1',
                      );
                      _shouldSetState = true;
                      if ((addOrderApiResponse?.statusCode ?? 200) == 200) {
                        logFirebaseEvent('Button_Backend-Call');
                        transactionApiResponse = await AddTransactionCall.call(
                          amountPaid: widget.reservationCost?.toString(),
                          transactionMethod: paymentMethodValue,
                          orderId: getJsonField(
                            (addOrderApiResponse?.jsonBody ?? ''),
                            r'''$.result''',
                          ),
                          userId: '6TCZMQHGHJYXZEycWKX89PT4cwp1',
                          transactionStatus: 'Completed',
                          transactionId: '6436464',
                        );
                        _shouldSetState = true;
                        if ((transactionApiResponse?.statusCode ?? 200) ==
                            200) {
                          logFirebaseEvent('Button_Bottom-Sheet');
                          Navigator.pop(context);
                          logFirebaseEvent('Button_Navigate-To');
                          context.goNamed(
                            'Confirmation',
                            queryParams: {
                              'propertyId': serializeParam(
                                  widget.propertyId, ParamType.int),
                              'orderId': serializeParam(
                                  getJsonField(
                                    (addOrderApiResponse?.jsonBody ?? ''),
                                    r'''$.result''',
                                  ).toString(),
                                  ParamType.String),
                              'paymentMethod': serializeParam(
                                  paymentMethodValue, ParamType.String),
                              'transactionId':
                                  serializeParam('', ParamType.String),
                            }.withoutNulls,
                          );
                        }
                      } else {
                        logFirebaseEvent('Button_Bottom-Sheet');
                        Navigator.pop(context);
                        logFirebaseEvent('Button_Show-Snack-Bar');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              functions.snackBarMessage(
                                  'reservationConfirmed', FFAppState().locale),
                              style: TextStyle(
                                color: Color(0xFFA5A5A5),
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor: Color(0x00000000),
                          ),
                        );
                        if (_shouldSetState) setState(() {});
                        return;
                      }

                      if (_shouldSetState) setState(() {});
                    },
                    text: FFLocalizations.of(context).getText(
                      'p50ponkb' /* Pay */,
                    ),
                    options: FFButtonOptions(
                      width: 130,
                      height: 52,
                      color: FlutterFlowTheme.of(context).primaryColor,
                      textStyle:
                          FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'AvenirArabic',
                                color: Colors.white,
                                fontSize: 18,
                                useGoogleFonts: false,
                              ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
