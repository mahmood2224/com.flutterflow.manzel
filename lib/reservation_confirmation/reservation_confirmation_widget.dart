import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_radio_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/random_data_util.dart' as random_data;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class ReservationConfirmationWidget extends StatefulWidget {
  const ReservationConfirmationWidget({
    Key? key,
    this.propertyId,
  }) : super(key: key);

  final int? propertyId;

  @override
  _ReservationConfirmationWidgetState createState() =>
      _ReservationConfirmationWidgetState();
}

class _ReservationConfirmationWidgetState
    extends State<ReservationConfirmationWidget> {
  ApiCallResponse? initiateOrder;
  OrdersRecord? createOrder;
  String? paymentMethodsValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'ReservationConfirmation'});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiCallResponse>(
      future: PropertyCall.call(
        propertyId: widget.propertyId,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: SpinKitRipple(
                color: FlutterFlowTheme.of(context).primaryColor,
                size: 50,
              ),
            ),
          );
        }
        final reservationConfirmationPropertyResponse = snapshot.data!;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                alignment: AlignmentDirectional(0, -1),
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, -1),
                    child: Image.network(
                      'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/living-room-ideas-carice-van-houten-living-room-nd2105-nd-atelier-carice-van-houten-050-screen-1600px-copy-1649878018.jpg',
                      width: double.infinity,
                      height: 500,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, 1),
                        child: Container(
                          width: double.infinity,
                          height: 756,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x320E151B),
                                offset: Offset(0, -2),
                              )
                            ],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 22, 0, 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            22, 0, 0, 0),
                                        child: InkWell(
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'RESERVATION_CONFIRMATION_Icon_n0mpifh9_O');
                                            logFirebaseEvent(
                                                'Icon_navigate_to');

                                            context.pushNamed(
                                              'PropertyDetails',
                                              queryParams: {
                                                'propertyId': serializeParam(
                                                  widget.propertyId,
                                                  ParamType.int,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            30, 0, 0, 0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'hc6is5tp' /* Reservation confirmation */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
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
                                Divider(
                                  thickness: 0.5,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      25, 19, 25, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'plhqknku' /* To confirm the reservation, yo... */,
                                          ),
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'AvenirArabic',
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'jwz7tx3y' /* Reservation cost */,
                                          ),
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'AvenirArabic',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        valueOrDefault<String>(
                                          PropertyCall.reservationsCost(
                                            reservationConfirmationPropertyResponse
                                                .jsonBody,
                                          ).toString(),
                                          '?',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'AvenirArabic',
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold,
                                              useGoogleFonts: false,
                                            ),
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'lrvnkupp' /*  SAR */,
                                        ),
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'AvenirArabic',
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold,
                                              useGoogleFonts: false,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      59, 5, 59, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'a57p0brt' /* Note: Reservation cost is non-... */,
                                        ),
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'AvenirArabic',
                                              color: Color(0xFFDC5D5C),
                                              fontWeight: FontWeight.w300,
                                              useGoogleFonts: false,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 50, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'ls77bs9d' /* Select Payment Method */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'AvenirArabic',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              useGoogleFonts: false,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 22, 20, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      FlutterFlowRadioButton(
                                        options: [
                                          FFLocalizations.of(context).getText(
                                            'yzl0bppo' /* Mada/Visa  */,
                                          ),
                                          FFLocalizations.of(context).getText(
                                            '54vch0v9' /* ApplePay */,
                                          )
                                        ].toList(),
                                        onChanged: (val) => setState(
                                            () => paymentMethodsValue = val),
                                        optionHeight: 54,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'AvenirArabic',
                                              color: Colors.black,
                                              useGoogleFonts: false,
                                            ),
                                        selectedTextStyle: FlutterFlowTheme.of(
                                                context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'AvenirArabic',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              useGoogleFonts: false,
                                            ),
                                        buttonPosition:
                                            RadioButtonPosition.left,
                                        direction: Axis.vertical,
                                        radioButtonColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryColor,
                                        inactiveRadioButtonColor:
                                            Color(0x8A000000),
                                        toggleable: false,
                                        horizontalAlignment:
                                            WrapAlignment.start,
                                        verticalAlignment:
                                            WrapCrossAlignment.start,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 100, 20, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if (paymentMethodsValue != null &&
                                          paymentMethodsValue != '')
                                        FFButtonWidget(
                                          onPressed: () async {
                                            logFirebaseEvent(
                                                'RESERVATION_CONFIRMATION_PAGE_pay_ON_TAP');
                                            var _shouldSetState = false;
                                            // CreateOrder
                                            logFirebaseEvent('pay_CreateOrder');

                                            final ordersCreateData =
                                                createOrdersRecordData(
                                              orderId: random_data
                                                  .randomInteger(0, 1000000),
                                              createdAt: getCurrentTimestamp,
                                              updatedAt: getCurrentTimestamp,
                                              userId: currentUserReference,
                                              propertyId: widget.propertyId,
                                              orderStatus: 'Booked',
                                            );
                                            var ordersRecordReference =
                                                OrdersRecord.collection.doc();
                                            await ordersRecordReference
                                                .set(ordersCreateData);
                                            createOrder = OrdersRecord
                                                .getDocumentFromData(
                                                    ordersCreateData,
                                                    ordersRecordReference);
                                            _shouldSetState = true;
                                            // InitiateOrder
                                            logFirebaseEvent(
                                                'pay_InitiateOrder');
                                            initiateOrder =
                                                await InitiateOrderCall.call(
                                              propertyID:
                                                  widget.propertyId.toString(),
                                              userID: currentUserUid,
                                                  version: FFAppState().apiVersion
                                            );
                                            _shouldSetState = true;
                                            if ((initiateOrder?.succeeded ??
                                                true)) {
                                              // OrderConfirmed
                                              logFirebaseEvent(
                                                  'pay_OrderConfirmed');

                                              context.goNamed(
                                                'Confirmation',
                                                queryParams: {
                                                  'propertyId': serializeParam(
                                                    widget.propertyId,
                                                    ParamType.int,
                                                  ),
                                                  'paymentMethod':
                                                      serializeParam(
                                                    paymentMethodsValue,
                                                    ParamType.String,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            } else {
                                              if (_shouldSetState)
                                                setState(() {});
                                              return;
                                            }

                                            if (_shouldSetState)
                                              setState(() {});
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            '8j5d0340' /* Pay */,
                                          ),
                                          options: FFButtonOptions(
                                            width: 335,
                                            height: 52,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryColor,
                                            textStyle: FlutterFlowTheme.of(
                                                    context)
                                                .subtitle2
                                                .override(
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
                                            borderRadius:
                                                BorderRadius.circular(12),
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
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
