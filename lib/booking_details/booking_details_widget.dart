import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../components/cancel_reserve_bottom_sheet_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingDetailsWidget extends StatefulWidget {
  const BookingDetailsWidget({
    Key key,
    this.orderId,
    this.orderStatus,
  }) : super(key: key);

  final String orderId;
  final String orderStatus;

  @override
  _BookingDetailsWidgetState createState() => _BookingDetailsWidgetState();
}

class _BookingDetailsWidgetState extends State<BookingDetailsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'BookingDetails'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        automaticallyImplyLeading: true,
        leading: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
          child: InkWell(
            onTap: () async {
              logFirebaseEvent('BOOKING_DETAILS_Icon_yxvmcr6s_ON_TAP');
              logFirebaseEvent('Icon_Close-Dialog,-Drawer,-Etc');
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              FFLocalizations.of(context).getText(
                'trw95gom' /* Booking Ref. :  */,
              ),
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'AvenirArabic',
                    color: FlutterFlowTheme.of(context).white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    useGoogleFonts: false,
                  ),
            ),
            Text(
              widget.orderId,
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'AvenirArabic',
                    color: FlutterFlowTheme.of(context).white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    useGoogleFonts: false,
                  ),
            ),
          ],
        ),
        actions: [
          Visibility(
            visible:
                functions.cancelReverveButtonVisibility(valueOrDefault<String>(
              widget.orderStatus,
              'accepted',
            )),
            child: Align(
              alignment: AlignmentDirectional(0, -0.75),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 20.33, 0),
                child: InkWell(
                  onTap: () async {
                    logFirebaseEvent('BOOKING_DETAILS_Icon_ayh07hly_ON_TAP');
                    logFirebaseEvent('Icon_Bottom-Sheet');
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Color(0x64040404),
                      barrierColor: Color(0x66040404),
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 1,
                            child: CancelReserveBottomSheetWidget(
                              orderId: widget.orderId,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: FaIcon(
                    FontAwesomeIcons.ellipsisH,
                    color: FlutterFlowTheme.of(context).white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<ApiCallResponse>(
          future: OrderDetailsCall.call(
            orderId: widget.orderId,
            userid: currentUserUid,
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
            final columnOrderDetailsResponse = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 32, 16, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          FFLocalizations.of(context).getText(
                            '8eahonhl' /* Order Process */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'AvenirArabic',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    useGoogleFonts: false,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 15, 16, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 21),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (functions.orderProcessStatus(
                                      getJsonField(
                                        columnOrderDetailsResponse.jsonBody,
                                        r'''$.result.order_status''',
                                      ).toString(),
                                      'reserved',
                                      'checked'))
                                    Icon(
                                      Icons.check_circle_rounded,
                                      color: Color(0xFF7FC15F),
                                      size: 28,
                                    ),
                                  if (functions.orderProcessStatus(
                                      getJsonField(
                                        columnOrderDetailsResponse.jsonBody,
                                        r'''$.result.order_status''',
                                      ).toString(),
                                      'reserved',
                                      'unchecked'))
                                    Icon(
                                      Icons.radio_button_off,
                                      color: Colors.black,
                                      size: 28,
                                    ),
                                  if (functions.orderProcessStatus(
                                      getJsonField(
                                        columnOrderDetailsResponse.jsonBody,
                                        r'''$.result.order_status''',
                                      ).toString(),
                                      'reserved',
                                      'pending'))
                                    Icon(
                                      Icons.pending_sharp,
                                      color: Color(0xFFF0A637),
                                      size: 28,
                                    ),
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'w2795v66' /* Property Reserved */,
                                        ),
                                        maxLines: 2,
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
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 21),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (functions
                                      .offerStatusPaymentCompletedCheck(
                                          getJsonField(
                                            columnOrderDetailsResponse.jsonBody,
                                            r'''$.result.transaction_data.transaction_id''',
                                          ).toString(),
                                          getJsonField(
                                            columnOrderDetailsResponse.jsonBody,
                                            r'''$.result.order_status''',
                                          ).toString()))
                                    Icon(
                                      Icons.check_circle_rounded,
                                      color: Color(0xFF7FC15F),
                                      size: 28,
                                    ),
                                  if (!functions
                                      .offerStatusPaymentCompletedCheck(
                                          getJsonField(
                                            columnOrderDetailsResponse.jsonBody,
                                            r'''$.result.transaction_data.transaction_id''',
                                          ).toString(),
                                          getJsonField(
                                            columnOrderDetailsResponse.jsonBody,
                                            r'''$.result.order_status''',
                                          ).toString()))
                                    Icon(
                                      Icons.radio_button_off,
                                      color: Colors.black,
                                      size: 28,
                                    ),
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'm30m3lz9' /* Payment Confirmed */,
                                        ),
                                        maxLines: 2,
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
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 21),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 2),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (functions.orderProcessStatus(
                                                  getJsonField(
                                                    columnOrderDetailsResponse
                                                        .jsonBody,
                                                    r'''$.result.order_status''',
                                                  ).toString(),
                                                  'collect_offers',
                                                  'checked'))
                                                Icon(
                                                  Icons.check_circle_rounded,
                                                  color: Color(0xFF7FC15F),
                                                  size: 28,
                                                ),
                                              if (functions.orderProcessStatus(
                                                  getJsonField(
                                                    columnOrderDetailsResponse
                                                        .jsonBody,
                                                    r'''$.result.order_status''',
                                                  ).toString(),
                                                  'collect_offers',
                                                  'unchecked'))
                                                Icon(
                                                  Icons.radio_button_off,
                                                  color: Colors.black,
                                                  size: 28,
                                                ),
                                              if (functions.orderProcessStatus(
                                                  getJsonField(
                                                    columnOrderDetailsResponse
                                                        .jsonBody,
                                                    r'''$.result.order_status''',
                                                  ).toString(),
                                                  'collect_offers',
                                                  'pending'))
                                                Icon(
                                                  Icons.pending_sharp,
                                                  color: Color(0xFFF0A637),
                                                  size: 28,
                                                ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(12, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'zpv0x3sj' /* Collecting Offers */,
                                                        ),
                                                        maxLines: 2,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'AvenirArabic',
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          logFirebaseEvent(
                                                              'BOOKING_DETAILS_Container_arq4cwwe_ON_TA');
                                                          logFirebaseEvent(
                                                              'Container_Navigate-To');
                                                          context.pushNamed(
                                                            'Offers',
                                                            queryParams: {
                                                              'propertyId':
                                                                  serializeParam(
                                                                      getJsonField(
                                                                        columnOrderDetailsResponse
                                                                            .jsonBody,
                                                                        r'''$.result.property_id''',
                                                                      )
                                                                          .toString(),
                                                                      ParamType
                                                                          .String),
                                                            }.withoutNulls,
                                                          );
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  getJsonField(
                                                                    columnOrderDetailsResponse
                                                                        .jsonBody,
                                                                    r'''$.result.offer_count''',
                                                                  ).toString(),
                                                                  '0',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily:
                                                                          'AvenirArabic',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      useGoogleFonts:
                                                                          false,
                                                                    ),
                                                              ),
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'hho1grz4' /* / */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily:
                                                                          'AvenirArabic',
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      useGoogleFonts:
                                                                          false,
                                                                    ),
                                                              ),
                                                              Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  functions
                                                                      .bookingScreenCountOffers(
                                                                          getJsonField(
                                                                    columnOrderDetailsResponse
                                                                        .jsonBody,
                                                                    r'''$.result.bank_ids''',
                                                                  )),
                                                                  '0',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily:
                                                                          'AvenirArabic',
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      useGoogleFonts:
                                                                          false,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  if (functions
                                                      .conditionalVisibility(
                                                          getJsonField(
                                                            columnOrderDetailsResponse
                                                                .jsonBody,
                                                            r'''$.result.order_status''',
                                                          ).toString(),
                                                          'collect_offers'))
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'xa9e1t5y' /* Waiting for banks to submit of... */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'AvenirArabic',
                                                                fontSize: 12,
                                                                useGoogleFonts:
                                                                    false,
                                                              ),
                                                        ),
                                                        Text(
                                                          valueOrDefault<
                                                              String>(
                                                            getJsonField(
                                                              columnOrderDetailsResponse
                                                                  .jsonBody,
                                                              r'''$.result.offer_count''',
                                                            ).toString(),
                                                            '0',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'AvenirArabic',
                                                                fontSize: 12,
                                                                useGoogleFonts:
                                                                    false,
                                                              ),
                                                        ),
                                                        Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'awjba3l0' /* / */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'AvenirArabic',
                                                                fontSize: 12,
                                                                useGoogleFonts:
                                                                    false,
                                                              ),
                                                        ),
                                                        Text(
                                                          valueOrDefault<
                                                              String>(
                                                            functions
                                                                .bookingScreenCountOffers(
                                                                    getJsonField(
                                                              columnOrderDetailsResponse
                                                                  .jsonBody,
                                                              r'''$.result.bank_ids''',
                                                            )),
                                                            '0',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'AvenirArabic',
                                                                fontSize: 12,
                                                                useGoogleFonts:
                                                                    false,
                                                              ),
                                                        ),
                                                        Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'mehsn231' /* ) */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'AvenirArabic',
                                                                fontSize: 12,
                                                                useGoogleFonts:
                                                                    false,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 21),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (functions.orderProcessStatus(
                                      getJsonField(
                                        columnOrderDetailsResponse.jsonBody,
                                        r'''$.result.order_status''',
                                      ).toString(),
                                      'waiting_offer_acceptance',
                                      'checked'))
                                    Icon(
                                      Icons.check_circle_rounded,
                                      color: Color(0xFF7FC15F),
                                      size: 28,
                                    ),
                                  if (functions.orderProcessStatus(
                                      getJsonField(
                                        columnOrderDetailsResponse.jsonBody,
                                        r'''$.result.order_status''',
                                      ).toString(),
                                      'waiting_offer_acceptance',
                                      'unchecked'))
                                    Icon(
                                      Icons.radio_button_off,
                                      color: Colors.black,
                                      size: 28,
                                    ),
                                  if (functions.orderProcessStatus(
                                      getJsonField(
                                        columnOrderDetailsResponse.jsonBody,
                                        r'''$.result.order_status''',
                                      ).toString(),
                                      'waiting_offer_acceptance',
                                      'pending'))
                                    Icon(
                                      Icons.pending_sharp,
                                      color: Color(0xFFF0A637),
                                      size: 28,
                                    ),
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          '3a3j0qu5' /* Offer Accepted */,
                                        ),
                                        maxLines: 2,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'AvenirArabic',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              useGoogleFonts: false,
                                            ),
                                      ),
                                      if (functions.conditionalVisibility(
                                          getJsonField(
                                            columnOrderDetailsResponse.jsonBody,
                                            r'''$.result.order_status''',
                                          ).toString(),
                                          'waiting_offer_acceptance'))
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'ver0de4k' /* Waiting for you to accept one ... */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'AvenirArabic',
                                                fontSize: 12,
                                                useGoogleFonts: false,
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
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 21),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (functions.orderProcessStatus(
                                      getJsonField(
                                        columnOrderDetailsResponse.jsonBody,
                                        r'''$.result.order_status''',
                                      ).toString(),
                                      'offer_accepted',
                                      'checked'))
                                    Icon(
                                      Icons.check_circle_rounded,
                                      color: Color(0xFF7FC15F),
                                      size: 28,
                                    ),
                                  if (functions.orderProcessStatus(
                                      getJsonField(
                                        columnOrderDetailsResponse.jsonBody,
                                        r'''$.result.order_status''',
                                      ).toString(),
                                      'offer_accepted',
                                      'unchecked'))
                                    Icon(
                                      Icons.radio_button_off,
                                      color: Colors.black,
                                      size: 28,
                                    ),
                                  if (functions.orderProcessStatus(
                                      getJsonField(
                                        columnOrderDetailsResponse.jsonBody,
                                        r'''$.result.order_status''',
                                      ).toString(),
                                      'offer_accepted',
                                      'pending'))
                                    Icon(
                                      Icons.pending_sharp,
                                      color: Color(0xFFF0A637),
                                      size: 28,
                                    ),
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'oqathjmt' /* Transfer Ownership */,
                                        ),
                                        maxLines: 2,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'AvenirArabic',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              useGoogleFonts: false,
                                            ),
                                      ),
                                      if (functions.conditionalVisibility(
                                          getJsonField(
                                            columnOrderDetailsResponse.jsonBody,
                                            r'''$.result.order_status''',
                                          ).toString(),
                                          'offer_accepted'))
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'k64pcuyr' /* Transferring the ownership of ... */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'AvenirArabic',
                                                fontSize: 12,
                                                useGoogleFonts: false,
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
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 21),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (functions.orderProcessStatus(
                                      getJsonField(
                                        columnOrderDetailsResponse.jsonBody,
                                        r'''$.result.order_status''',
                                      ).toString(),
                                      'ownership_transferred',
                                      'checked'))
                                    Icon(
                                      Icons.check_circle_rounded,
                                      color: Color(0xFF7FC15F),
                                      size: 28,
                                    ),
                                  if (functions.orderProcessStatus(
                                      getJsonField(
                                        columnOrderDetailsResponse.jsonBody,
                                        r'''$.result.order_status''',
                                      ).toString(),
                                      'ownership_transferred',
                                      'unchecked'))
                                    Icon(
                                      Icons.radio_button_off,
                                      color: Colors.black,
                                      size: 28,
                                    ),
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'nhrc354h' /* Completed */,
                                        ),
                                        maxLines: 2,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'AvenirArabic',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              useGoogleFonts: false,
                                            ),
                                      ),
                                      if (functions.conditionalVisibility(
                                          getJsonField(
                                            columnOrderDetailsResponse.jsonBody,
                                            r'''$.result.order_status''',
                                          ).toString(),
                                          'ownership_transferred'))
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'ubpscf43' /* Ownership transferred successf... */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'AvenirArabic',
                                                fontSize: 12,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (functions.conditionalVisibility(
                            getJsonField(
                              columnOrderDetailsResponse.jsonBody,
                              r'''$.result.order_status''',
                            ).toString(),
                            'cancelled'))
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 21),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFF0000),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 5),
                                        child: Icon(
                                          Icons.clear,
                                          color: FlutterFlowTheme.of(context)
                                              .white,
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'dd079ljk' /* Cancelled */,
                                          ),
                                          maxLines: 2,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'AvenirArabic',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'mtbhr1iu' /* You have Cancelled the reserva... */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'AvenirArabic',
                                                fontSize: 12,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (functions.conditionalVisibility(
                            getJsonField(
                              columnOrderDetailsResponse.jsonBody,
                              r'''$.result.order_status''',
                            ).toString(),
                            'disqualified'))
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFF0000),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 5),
                                        child: Icon(
                                          Icons.clear,
                                          color: FlutterFlowTheme.of(context)
                                              .white,
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            '5lptumrw' /* Disqualified */,
                                          ),
                                          maxLines: 2,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'AvenirArabic',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'zaua3lqi' /* You have been disqualified fro... */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'AvenirArabic',
                                                fontSize: 12,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    indent: 20,
                    endIndent: 2,
                    color: Color(0xFFE5E5E5),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 25, 20, 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          FFLocalizations.of(context).getText(
                            'nxmc61bl' /* Property details */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'AvenirArabic',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    useGoogleFonts: false,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                  valueOrDefault<String>(
                                    getJsonField(
                                      columnOrderDetailsResponse.jsonBody,
                                      r'''$.result.property_data.data.attributes.property_images.data[0].attributes.url''',
                                    ),
                                    'https://media.istockphoto.com/photos/luxurious-beautiful-modern-villa-with-front-yard-garden-picture-id1283532143?b=1&k=20&m=1283532143&s=170667a&w=0&h=Vd_WTUbHxnc_NZNwMr1UnS0xVW1FjtUxKJUtCoL4Fgk=',
                                  ),
                                  width: 80,
                                  height: 75,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              valueOrDefault<String>(
                                getJsonField(
                                  columnOrderDetailsResponse.jsonBody,
                                  r'''$.result.property_name''',
                                ).toString(),
                                'null',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'AvenirArabic',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.black,
                                  size: 18,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 3, 0, 0),
                                  child: Text(
                                    valueOrDefault<String>(
                                      getJsonField(
                                        columnOrderDetailsResponse.jsonBody,
                                        r'''$.result.property_data.property_city''',
                                      ).toString(),
                                      'null',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'AvenirArabic',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          useGoogleFonts: false,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 3, 0, 0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'sfe2y1t7' /* ,  */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'AvenirArabic',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          useGoogleFonts: false,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 3, 0, 0),
                                  child: Text(
                                    valueOrDefault<String>(
                                      getJsonField(
                                        columnOrderDetailsResponse.jsonBody,
                                        r'''$.result.property_data.property_district''',
                                      ).toString(),
                                      'null',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'AvenirArabic',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          useGoogleFonts: false,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 9, 0),
                                            child: Icon(
                                              Icons.single_bed,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryColor,
                                              size: 24,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 20, 0),
                                            child: Text(
                                              valueOrDefault<String>(
                                                getJsonField(
                                                  columnOrderDetailsResponse
                                                      .jsonBody,
                                                  r'''$.result.property_data.property_bedrooms''',
                                                ).toString(),
                                                '0',
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily:
                                                        'Sofia Pro By Khuzaimah',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    useGoogleFonts: false,
                                                  ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 9, 0),
                                            child: Icon(
                                              Icons.bathtub_outlined,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryColor,
                                              size: 24,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 20, 0),
                                            child: Text(
                                              valueOrDefault<String>(
                                                getJsonField(
                                                  columnOrderDetailsResponse
                                                      .jsonBody,
                                                  r'''$.result.property_data.property_bathrooms''',
                                                ).toString(),
                                                '0',
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily:
                                                        'Sofia Pro By Khuzaimah',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryColor,
                                                    fontWeight: FontWeight.w500,
                                                    useGoogleFonts: false,
                                                  ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 9, 0),
                                            child: Icon(
                                              Icons.design_services_outlined,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryColor,
                                              size: 24,
                                            ),
                                          ),
                                          Text(
                                            getJsonField(
                                              columnOrderDetailsResponse
                                                  .jsonBody,
                                              r'''$.result.property_data.property_size''',
                                            ).toString(),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily:
                                                      'Sofia Pro By Khuzaimah',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              '6ry49rxz' /*  sqm */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'AvenirArabic',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 25),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                logFirebaseEvent(
                                    'BOOKING_DETAILS_VIEW_MORE_BTN_ON_TAP');
                                logFirebaseEvent('Button_Navigate-To');
                                context.pushNamed(
                                  'PropertyDetails',
                                  queryParams: {
                                    'propertyId': serializeParam(
                                        getJsonField(
                                          columnOrderDetailsResponse.jsonBody,
                                          r'''$.result.property_id''',
                                        ),
                                        ParamType.int),
                                  }.withoutNulls,
                                );
                              },
                              text: FFLocalizations.of(context).getText(
                                '6cg0ue0u' /* View More */,
                              ),
                              options: FFButtonOptions(
                                width: 130,
                                height: 40,
                                color: Colors.white,
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'AvenirArabic',
                                      color: Color(0xFF2971FB),
                                      fontWeight: FontWeight.w800,
                                      useGoogleFonts: false,
                                    ),
                                borderSide: BorderSide(
                                  color: Color(0xFF2971FB),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
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
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 25, 20, 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'qkoz8020' /* Transaction details */,
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
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
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 5),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          '0ck5hck8' /* Payment Method */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'AvenirArabic',
                                              color: Color(0xFF6B6B6B),
                                              fontWeight: FontWeight.w300,
                                              useGoogleFonts: false,
                                            ),
                                      ),
                                    ),
                                    Text(
                                      valueOrDefault<String>(
                                        getJsonField(
                                          columnOrderDetailsResponse.jsonBody,
                                          r'''$.result.transaction_data.transaction_method''',
                                        ).toString(),
                                        'null',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'AvenirArabic',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts: false,
                                            lineHeight: 1.5,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 5),
                                    child: Text(
                                      FFLocalizations.of(context).getText(
                                        'qxs4ycvd' /* Transaction Ref. */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'AvenirArabic',
                                            color: Color(0xFF6B6B6B),
                                            fontWeight: FontWeight.w300,
                                            useGoogleFonts: false,
                                          ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'snmoyj94' /* # */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'AvenirArabic',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              useGoogleFonts: false,
                                            ),
                                      ),
                                      Expanded(
                                        child: AutoSizeText(
                                          valueOrDefault<String>(
                                            getJsonField(
                                              columnOrderDetailsResponse
                                                  .jsonBody,
                                              r'''$.result.id''',
                                            ).toString(),
                                            '000000',
                                          ),
                                          maxLines: 2,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'AvenirArabic',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 22),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 5),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'zagvs0yx' /* Amount */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'AvenirArabic',
                                              color: Color(0xFF6B6B6B),
                                              fontWeight: FontWeight.w300,
                                              useGoogleFonts: false,
                                            ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          valueOrDefault<String>(
                                            functions.formatAmount(
                                                valueOrDefault<String>(
                                              getJsonField(
                                                columnOrderDetailsResponse
                                                    .jsonBody,
                                                r'''$.result.transaction_data.paid_amount''',
                                              ).toString(),
                                              '0',
                                            )),
                                            '0',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'AvenirArabic',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            '17eaou67' /* SAR */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'AvenirArabic',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 5),
                                    child: Text(
                                      FFLocalizations.of(context).getText(
                                        'x0ed6u9h' /* Date & Time */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'AvenirArabic',
                                            color: Color(0xFF6B6B6B),
                                            fontWeight: FontWeight.w300,
                                            useGoogleFonts: false,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    valueOrDefault<String>(
                                      functions
                                          .formatDateTime(valueOrDefault<int>(
                                        getJsonField(
                                          columnOrderDetailsResponse.jsonBody,
                                          r'''$.result.transaction_data.created_at._seconds''',
                                        ),
                                        0,
                                      )),
                                      '0',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'AvenirArabic',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          useGoogleFonts: false,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 22, 20, 30),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FFButtonWidget(
                          onPressed: () {
                            print('receipt pressed ...');
                          },
                          text: FFLocalizations.of(context).getText(
                            'i7w1em00' /* View Receipt Transaction */,
                          ),
                          icon: Icon(
                            Icons.sticky_note_2_outlined,
                            color: FlutterFlowTheme.of(context).primaryColor,
                            size: 20,
                          ),
                          options: FFButtonOptions(
                            width: 230,
                            height: 45,
                            color: Colors.white,
                            textStyle: FlutterFlowTheme.of(context)
                                .subtitle2
                                .override(
                                  fontFamily: 'AvenirArabic',
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  useGoogleFonts: false,
                                ),
                            borderSide: BorderSide(
                              color: Color(0x1A2971FB),
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
            );
          },
        ),
      ),
    );
  }
}
