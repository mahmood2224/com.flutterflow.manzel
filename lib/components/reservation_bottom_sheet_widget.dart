import 'package:flutter/services.dart';
import 'package:go_sell_sdk_flutter/go_sell_sdk_flutter.dart';
import 'package:go_sell_sdk_flutter/model/models.dart';

import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_radio_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  Map<dynamic, dynamic> tapSDKResult;
  String orderId;

  Future<void> setupSDKSession(int paymentType) async {
    try {
      GoSellSdkFlutter.sessionConfigurations(
          trxMode: TransactionMode.PURCHASE,
          transactionCurrency: "SAR",
          amount: widget.reservationCost.toString(),
          customer: Customer(
              customerId: "", // customer id is important to retrieve cards saved for this customer
              email: currentUserDocument.email ?? '',
              isdNumber: "+966",
              number: '123456789',
              firstName: currentUserDocument.name,
              middleName: "",
              lastName: "",
              metaData: null),
          // paymentItems: <PaymentItem>[
          //   PaymentItem(
          //       name: "item1",
          //       amountPerUnit: 1,
          //       quantity: Quantity(value: 1),
          //       discount: {"type": "F", "value": 10, "maximum_fee": 10, "minimum_fee": 1},
          //       description: "Item 1 Apple",
          //       taxes: [Tax(amount: Amount(type: "F", value: 10, minimumFee: 1, maximumFee: 10), name: "tax1", description: "tax describtion")],
          //       totalAmount: 100),
          // ],
          // // List of taxes
          // taxes: [
          //   Tax(amount: Amount(type: "F", value: 10, minimumFee: 1, maximumFee: 10), name: "tax1", description: "tax describtion"),
          //   Tax(amount: Amount(type: "F", value: 10, minimumFee: 1, maximumFee: 10), name: "tax1", description: "tax describtion")
          // ],
          // List of shippnig
          //  shippings: [
          //   Shipping(name: "shipping 1", amount: 100, description: "shiping description 1"),
          //   Shipping(name: "shipping 2", amount: 150, description: "shiping description 2")
          // ],
          // Post URL
          postURL: "https://tap.company",
          // // Payment description
          // paymentDescription: "paymentDescription",
          // // Payment Metadata
          // paymentMetaData: {
          //   "a": "a meta",
          //   "b": "b meta",
          // },
          // Payment Reference
          // paymentReference: Reference(
          //      payment: "payment", order: orderId),
          // payment Descriptor
         // paymentStatementDescriptor: "paymentStatementDescriptor",
          // Save Card Switch
          isUserAllowedToSaveCard: false,
          // Enable/Disable 3DSecure
          isRequires3DSecure: true,
          // Receipt SMS/Email
          receipt: Receipt(true, false),
          // Authorize Action [Capture - Void]
          authorizeAction: AuthorizeAction(type: AuthorizeActionType.CAPTURE, timeInHours: 10),
          // Destinations
          destinations: null,
          // merchant id
          merchantID: "",
          // Allowed cards
          allowedCadTypes: CardType.ALL,
          applePayMerchantID: "merchant.com.flutterflow.manzel",
          allowsToSaveSameCardMoreThanOnce: false,
          // pass the card holder name to the SDK
          //cardHolderName: "Card Holder NAME",
          // disable changing the card holder name by the user
          allowsToEditCardHolderName: true,
          // select payments you need to show [Default is all, and you can choose between WEB-CARD-APPLEPAY ]
          paymentType: paymentType == 0 ? PaymentType.CARD : PaymentType.DEVICE,
          // Transaction mode
          sdkMode: SDKMode.Sandbox);
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


    print('>>>> ${tapSDKResult['sdk_result']}');
    switch (tapSDKResult['sdk_result']) {
      case "SUCCESS":
      // sdkStatus = "SUCCESS";
      // handleSDKResult();
      // context.pushNamed(
      //   'Confirmation',
      //   queryParams: query
      // );

        transactionApiResponse = await AddTransactionCall.call(
          amountPaid: widget.reservationCost.toString(),
          transactionMethod: paymentMethodValue,
          orderId: int.parse(orderId),
          userId: currentUserReference.id,
          transactionStatus: 'completed',
          transactionId: tapSDKResult['charge_id'],
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
                  int.parse(orderId),
                  ParamType.int),
              'paymentMethod': serializeParam(
                  paymentMethodValue, ParamType.String),
              'transactionId':
              serializeParam(tapSDKResult['charge_id'], ParamType.String),
            }.withoutNulls,
          );
        }
        break;
      case "FAILED":
        transactionApiResponse = await AddTransactionCall.call(
          amountPaid: widget.reservationCost.toString(),
          transactionMethod: paymentMethodValue,
          orderId: int.parse(orderId),
          userId: currentUserReference.id,
          transactionStatus: 'failed',
          transactionId: tapSDKResult['charge_id'],
        );
        if (((transactionApiResponse?.statusCode ?? 200)) ==
            200) {
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
              backgroundColor: Color(0xFF777777),
            ));
    }
          break;
        case "SDK_ERROR":
          print('sdk error............');
          print(tapSDKResult['sdk_error_code']);
          print(tapSDKResult['sdk_error_message']);
          print(tapSDKResult['sdk_error_description']);
          print('sdk error............');
          // sdkErrorCode = tapSDKResult['sdk_error_code'].toString();
          // sdkErrorMessage = tapSDKResult['sdk_error_message'];
          // sdkErrorDescription = tapSDKResult['sdk_error_description'];
          break;

        case "NOT_IMPLEMENTED":
        //  sdkStatus = "NOT_IMPLEMENTED";
          break;
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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  functions.formatAmount(widget.reservationCost?.toString()),
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
                      optionHeight: 56,
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
                        propertyId: widget.propertyId?.toString(),userId: currentUserReference.id,
                      );
                      _shouldSetState = true;
                      if ((addOrderApiResponse?.statusCode ?? 200) == 200) {
                        logFirebaseEvent('Button_Backend-Call');
                        setupSDKSession(paymentMethodValue.toLowerCase() == 'mada/visa' ? 0 : 1);
                        orderId = getJsonField(
                          (addOrderApiResponse?.jsonBody ?? ''),
                          r'''$.result''',
                        );
                        startSDK(context, {
                          'propertyId': serializeParam(
                              widget.propertyId, ParamType.int),
                          'paymentMethod': serializeParam(
                              paymentMethodValue, ParamType.String),
                        }.withoutNulls);

                      } else {
                        logFirebaseEvent('Button_Bottom-Sheet');
                        Navigator.pop(context);
                        logFirebaseEvent('Button_Show-Snack-Bar');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'The property is already booked',
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
                                fontFamily: 'Sofia Pro By Khuzaimah',
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
