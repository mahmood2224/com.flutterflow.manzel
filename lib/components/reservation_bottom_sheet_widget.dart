import 'package:flutter/services.dart';
import 'package:go_sell_sdk_flutter/go_sell_sdk_flutter.dart';
import 'package:go_sell_sdk_flutter/model/models.dart';
import 'package:manzel/common_widgets/manzel_icons.dart';

import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../common_widgets/overlay.dart';
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
    Key? key,
    this.reservationCost,
    this.propertyId,
    this.orderId
  }) : super(key: key);

  final int? reservationCost;
  final int? propertyId;
  final int? orderId;

  @override
  _ReservationBottomSheetWidgetState createState() =>
      _ReservationBottomSheetWidgetState();
}

class _ReservationBottomSheetWidgetState
    extends State<ReservationBottomSheetWidget> {
  ApiCallResponse? addOrderApiResponse;
  ApiCallResponse? transactionApiResponse;
  String? paymentMethodValue;
  Map<dynamic, dynamic>? tapSDKResult;
  OverlayEntry? entry;

  Future<void> setupSDKSession(int paymentType) async {
    try {
      GoSellSdkFlutter.sessionConfigurations(
          trxMode: TransactionMode.PURCHASE,
          transactionCurrency: "SAR",
          amount: widget.reservationCost.toString(),
          customer: Customer(
              customerId: "", // customer id is important to retrieve cards saved for this customer
              email: currentUserDocument?.email ?? '',
              isdNumber: "+966",
              number: '123456789',
              firstName: currentUserDocument?.name ?? '',
              middleName: "",
              lastName: "",
              metaData: null),
          paymentItems: <PaymentItem>[],
          // // List of taxes
          taxes: [],
          // List of shippnig
          shippings: [],
          // Post URL
          postURL: "https://tap.company",
          // Payment description
          paymentDescription: "${widget.propertyId} number property purchased",
          // Payment Metadata
          paymentMetaData: {},
          // Payment Reference
          paymentReference: Reference(
              payment: "payment", order: widget.orderId.toString()),
          // payment Descriptor
          paymentStatementDescriptor: "paymentStatementDescriptor",
          // Save Card Switch
          isUserAllowedToSaveCard: false,
          // Enable/Disable 3DSecure
          isRequires3DSecure: true,
          // Receipt SMS/Email
          receipt: Receipt(false, false),
          // Authorize Action [Capture - Void]
          authorizeAction: AuthorizeAction(type: AuthorizeActionType.CAPTURE, timeInHours: 10),
          // Destinations
          //   destinations: null,
          // merchant id
          merchantID: "",
          // Allowed cards
          allowedCadTypes: CardType.ALL,
          applePayMerchantID: "merchant.com.flutterflow.manzel",
          allowsToSaveSameCardMoreThanOnce: false,
          // pass the card holder name to the SDK
          cardHolderName: "",
          // disable changing the card holder name by the user
          allowsToEditCardHolderName: true,
          // select payments you need to show [Default is all, and you can choose between WEB-CARD-APPLEPAY ]
          paymentType: paymentType == 0 ? PaymentType.CARD : PaymentType.DEVICE,
          // Transaction mode
          sdkMode: SDKMode.Production);
    } on PlatformException {
      // platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      //   tapSDKResult = {};
    });
  }

  Future<void> startSDK(BuildContext context, Map<String, String> query,) async {


    tapSDKResult = await GoSellSdkFlutter.startPaymentSDK;


    print('>>>> ${tapSDKResult!['sdk_result']}');
    switch (tapSDKResult!['sdk_result']) {
      case "SUCCESS":
      // sdkStatus = "SUCCESS";
      // handleSDKResult();
      // context.pushNamed(
      //   'Confirmation',
      //   queryParams: query
      // );

        transactionApiResponse = await AddTransactionCall.call(
          amountPaid: widget.reservationCost.toString(),
          transactionMethod: ((paymentMethodValue?.toLowerCase() == 'mada' || paymentMethodValue?.toLowerCase() == 'مدى' ) ?"Mada":"ApplePay"),
          orderId: widget.orderId,
          userId: currentUserReference?.id,
          transactionStatus: 'completed',
          transactionId: tapSDKResult!['charge_id'],
          authorazationToken: FFAppState().authToken
        );

        if (((transactionApiResponse?.statusCode ?? 200)) ==
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
                  widget.orderId,
                  ParamType.int),
              'paymentMethod': serializeParam(
                  paymentMethodValue, ParamType.String),
              'transactionId':
              serializeParam(tapSDKResult!['charge_id'], ParamType.String),
              'transactionCase': serializeParam("SUCCESS", ParamType.String),
            }.withoutNulls,
          );

        }else{
          Navigator.pop(context);
          logFirebaseEvent('Button_Navigate-To');
          context.goNamed(
            'Confirmation',
            queryParams: {
              'propertyId': serializeParam(
                  widget.propertyId, ParamType.int),
              'orderId': serializeParam(
                  widget.orderId,
                  ParamType.int),
              'paymentMethod': serializeParam(
                  paymentMethodValue, ParamType.String),
              'transactionId':
              serializeParam(tapSDKResult!['charge_id'], ParamType.String),
              'transactionCase': serializeParam("FAILURE", ParamType.String),
            }.withoutNulls,
          );
        }
        entry!.remove();
        break;
      case "FAILED":
        transactionApiResponse = await AddTransactionCall.call(
          amountPaid: widget.reservationCost.toString(),
          transactionMethod: ((paymentMethodValue?.toLowerCase() == 'mada' || paymentMethodValue?.toLowerCase() == 'مدى' ) ?"Mada":"ApplePay"),
          orderId: widget.orderId,
          userId: currentUserReference?.id,
          transactionStatus: 'failed',
          transactionId: tapSDKResult!['charge_id'],
          authorazationToken: FFAppState().authToken,
        );
        // if (((transactionApiResponse?.statusCode ?? 200)) ==
        //     200) {
        Navigator.pop(context);
        logFirebaseEvent('Button_Navigate-To');
        context.goNamed(
          'Confirmation',
          queryParams: {
            'propertyId': serializeParam(
                widget.propertyId, ParamType.int),
            'orderId': serializeParam(
                widget.orderId,
                ParamType.int),
            'paymentMethod': serializeParam(
                paymentMethodValue, ParamType.String),
            'transactionId':
            serializeParam(tapSDKResult!['charge_id'], ParamType.String),
          }.withoutNulls,
        );
        entry!.remove();
   // }
          break;
        case "SDK_ERROR":
          print('sdk error............');
          print(tapSDKResult!['sdk_error_code']);
          print(tapSDKResult!['sdk_error_message']);
          print(tapSDKResult!['sdk_error_description']);
          print('sdk error............');
          // sdkErrorCode = tapSDKResult['sdk_error_code'].toString();
          // sdkErrorMessage = tapSDKResult['sdk_error_message'];
          // sdkErrorDescription = tapSDKResult['sdk_error_description'];
          Navigator.pop(context);
          logFirebaseEvent('Button_Show-Snack-Bar');
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Payment Failed',
                  style: TextStyle(
                    fontFamily: 'Sofia Pro By Khuzaimah',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                duration: Duration(milliseconds: 4000),
                backgroundColor: FlutterFlowTheme.of(context).primaryRed,
              ));
          entry!.remove();
          break;

        case "NOT_IMPLEMENTED":
        //  sdkStatus = "NOT_IMPLEMENTED";
          Navigator.pop(context);
          logFirebaseEvent('Button_Show-Snack-Bar');
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Payment Failed',
                  style: TextStyle(
                    fontFamily: 'Sofia Pro By Khuzaimah',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                duration: Duration(milliseconds: 4000),
                backgroundColor: FlutterFlowTheme.of(context).primaryRed,
              ));
          entry!.remove();
          break;
      default:
        entry!.remove();

      }

  }

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
                        Manzel.clear,
                        color: Colors.black,
                        size: 20,
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 3, 0),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      'njswqwdn' /* agree to our  */,
                    ),
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'AvenirArabic',
                          fontSize: 13,
                          useGoogleFonts: false,
                        ),
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
                            height: MediaQuery.of(context).size.height * 0.95,
                            child: TermsConditionsBottomSheetWidget(
                              pageType: 5,
                            ),
                          ),
                        );
                      },
                    ).then((value) => setState(() {}));
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
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                          child: Image.asset(
                            'assets/images/MadaPay.png',
                            height: 30,
                            width: 80,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: SvgPicture.asset(
                            'assets/images/apple.svg',
                            width: 80,
                            height: 28,
                            fit: BoxFit.scaleDown,
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
                  List<OrdersRecord> buttonOrdersRecordList = snapshot.data!;
                  return FFButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent(
                          'RESERVATION_BOTTOM_SHEET_PAY_BTN_ON_TAP');
                      var _shouldSetState = false;
                      logFirebaseEvent('Button_Backend-Call');
    _shouldSetState = true;
                        logFirebaseEvent('Button_Backend-Call');
                        setupSDKSession((paymentMethodValue?.toLowerCase() == 'mada' || paymentMethodValue?.toLowerCase() == 'مدى' ) ? 0 : 1);
                        entry = showOverlay(context);
                        startSDK(context, {
                          'propertyId': serializeParam(
                              widget.propertyId, ParamType.int),
                          'paymentMethod': serializeParam(
                              paymentMethodValue, ParamType.String),
                        }.withoutNulls);


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
OverlayEntry showOverlay(BuildContext context) {
  var overlayState = Overlay.of(context);
  var overlayEntry = OverlayEntry(
    builder: (context) => CircularProgressOverlay(),
  );
  overlayState?.insert(overlayEntry);
  return overlayEntry;
}
