import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmationWidget extends StatefulWidget {
  const ConfirmationWidget({
    Key key,
    this.propertyId,
    this.paymentMethod,
  }) : super(key: key);

  final int propertyId;
  final String paymentMethod;

  @override
  _ConfirmationWidgetState createState() => _ConfirmationWidgetState();
}

class _ConfirmationWidgetState extends State<ConfirmationWidget> {
  String uploadedFileUrl = '';
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'Confirmation'});
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
                color: Color(0xFF2971FB),
                size: 50,
              ),
            ),
          );
        }
        final confirmationPropertyResponse = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                    child: StreamBuilder<List<OrdersRecord>>(
                      stream: queryOrdersRecord(
                        queryBuilder: (ordersRecord) => ordersRecord
                            .where('u_id', isEqualTo: currentUserReference)
                            .where('p_id', isEqualTo: widget.propertyId),
                        singleRecord: true,
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
                        List<OrdersRecord> columnOrdersRecordList =
                            snapshot.data;
                        // Return an empty Container when the document does not exist.
                        if (snapshot.data.isEmpty) {
                          return Container();
                        }
                        final columnOrdersRecord =
                            columnOrdersRecordList.isNotEmpty
                                ? columnOrdersRecordList.first
                                : null;
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 70, 0, 30),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(
                                          Icons.check_box_outlined,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                          size: 60,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 19, 0, 0),
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              'fnewib0l' /* Your Booking Confirmed */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily:
                                                      'Sofia Pro By Khuzaimah',
                                                  fontSize: 21,
                                                  fontWeight: FontWeight.bold,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 9, 0, 4),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'is83qb7v' /* Booking ref:  */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText2
                                                        .override(
                                                          fontFamily:
                                                              'Sofia Pro By Khuzaimah',
                                                          color:
                                                              Color(0xFF6B6B6B),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          useGoogleFonts: false,
                                                        ),
                                                  ),
                                                  Text(
                                                    valueOrDefault<String>(
                                                      columnOrdersRecord.orderId
                                                          .toString(),
                                                      'Un-Known',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText2
                                                        .override(
                                                          fontFamily:
                                                              'Sofia Pro By Khuzaimah',
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          useGoogleFonts: false,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: Color(0xFFECECEC),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 21, 20, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 21),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'helm66q2' /* Order Process */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily:
                                                  'Sofia Pro By Khuzaimah',
                                              fontSize: 18,
                                              useGoogleFonts: false,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 40),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 5),
                                            child: Icon(
                                              Icons.check_circle_rounded,
                                              color: Color(0xFF7FC15F),
                                              size: 28,
                                            ),
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
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      '4b2ze33a' /* Reservation & Payment Confirme... */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'Sofia Pro By Khuzaimah',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts: false,
                                                        ),
                                                  ),
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      '6o7gmqky' /* Lorem ipsum dolor sit amet, co... */,
                                                    ),
                                                    maxLines: 2,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'Sofia Pro By Khuzaimah',
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
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 40),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 12, 5),
                                            child: Icon(
                                              Icons.radio_button_off,
                                              color: Colors.black,
                                              size: 28,
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'czklypuv' /* Send deal to Banks */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'Sofia Pro By Khuzaimah',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'qqhhg2ru' /* Lorem ipsum dolor sit amet, co... */,
                                                  ),
                                                  maxLines: 2,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'Sofia Pro By Khuzaimah',
                                                        fontSize: 12,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 15, 0, 15),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 40),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(0, 0,
                                                                    12, 5),
                                                        child: Icon(
                                                          Icons
                                                              .radio_button_off_outlined,
                                                          color: Colors.black,
                                                          size: 28,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'cie1ckkw' /* Completing Documents */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'Sofia Pro By Khuzaimah',
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
                                                                'o23wj00g' /* Lorem ipsum dolor sit amet, co... */,
                                                              ),
                                                              maxLines: 2,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'Sofia Pro By Khuzaimah',
                                                                    fontSize:
                                                                        12,
                                                                    useGoogleFonts:
                                                                        false,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                40, 10, 0, 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        FFButtonWidget(
                                                          onPressed: () async {
                                                            logFirebaseEvent(
                                                                'CONFIRMATION_PAGE_uploadDocuments_ON_TAP');
                                                            logFirebaseEvent(
                                                                'uploadDocuments_Upload-File');
                                                            final selectedFile =
                                                                await selectFile(
                                                                    allowedExtensions: [
                                                                  'pdf'
                                                                ]);
                                                            if (selectedFile !=
                                                                null) {
                                                              showUploadMessage(
                                                                context,
                                                                'Uploading file...',
                                                                showLoading:
                                                                    true,
                                                              );
                                                              final downloadUrl =
                                                                  await uploadData(
                                                                      selectedFile
                                                                          .storagePath,
                                                                      selectedFile
                                                                          .bytes);
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .hideCurrentSnackBar();
                                                              if (downloadUrl !=
                                                                  null) {
                                                                setState(() =>
                                                                    uploadedFileUrl =
                                                                        downloadUrl);
                                                                showUploadMessage(
                                                                  context,
                                                                  'Success!',
                                                                );
                                                              } else {
                                                                showUploadMessage(
                                                                  context,
                                                                  'Failed to upload file',
                                                                );
                                                                return;
                                                              }
                                                            }
                                                          },
                                                          text: FFLocalizations
                                                                  .of(context)
                                                              .getText(
                                                            'ee9tj9d6' /* Upload Documents */,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            width: 200,
                                                            height: 44,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryColor,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .subtitle2
                                                                    .override(
                                                                      fontFamily:
                                                                          'Sofia Pro By Khuzaimah',
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      useGoogleFonts:
                                                                          false,
                                                                    ),
                                                            borderSide:
                                                                BorderSide(
                                                              color: Colors
                                                                  .transparent,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
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
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 30),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 12, 5),
                                            child: Icon(
                                              Icons.radio_button_off_outlined,
                                              color: Colors.black,
                                              size: 28,
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'zrzv4hu9' /* Get banks proposals */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'Sofia Pro By Khuzaimah',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    '3ywj0my8' /* Lorem ipsum dolor sit amet, co... */,
                                                  ),
                                                  maxLines: 2,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'Sofia Pro By Khuzaimah',
                                                        fontSize: 12,
                                                        useGoogleFonts: false,
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
                                      color: Color(0xFFECECEC),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 0, 17),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        '8ptcdhhd' /* Property details */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily:
                                                'Sofia Pro By Khuzaimah',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300,
                                            useGoogleFonts: false,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 0, 20, 25),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 15, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            child: Image.asset(
                                              'assets/images/2.webp',
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          valueOrDefault<String>(
                                            PropertyCall.propertyName(
                                              (confirmationPropertyResponse
                                                      ?.jsonBody ??
                                                  ''),
                                            ).toString(),
                                            'Un-Known',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily:
                                                    'Sofia Pro By Khuzaimah',
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
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 3, 0, 0),
                                              child: Text(
                                                valueOrDefault<String>(
                                                  PropertyCall.propertyCity(
                                                    (confirmationPropertyResponse
                                                            ?.jsonBody ??
                                                        ''),
                                                  ).toString(),
                                                  'Un-known',
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'Sofia Pro By Khuzaimah',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          useGoogleFonts: false,
                                                        ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 3, 0, 0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  '4qmvz3gw' /*  , */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'Sofia Pro By Khuzaimah',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          useGoogleFonts: false,
                                                        ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 3, 0, 0),
                                              child: Text(
                                                valueOrDefault<String>(
                                                  PropertyCall.propertyDistrict(
                                                    (confirmationPropertyResponse
                                                            ?.jsonBody ??
                                                        ''),
                                                  ).toString(),
                                                  'Un-Known',
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'Sofia Pro By Khuzaimah',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          useGoogleFonts: false,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 15, 0, 0),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 9, 0),
                                                        child: Icon(
                                                          Icons.single_bed,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryColor,
                                                          size: 24,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(0, 0,
                                                                    20, 0),
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            PropertyCall
                                                                .propertyBedrooms(
                                                              (confirmationPropertyResponse
                                                                      ?.jsonBody ??
                                                                  ''),
                                                            ).toString(),
                                                            '?',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Sofia Pro By Khuzaimah',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                useGoogleFonts:
                                                                    false,
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 9, 0),
                                                        child: Icon(
                                                          Icons
                                                              .bathtub_outlined,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryColor,
                                                          size: 24,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(0, 0,
                                                                    20, 0),
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            PropertyCall
                                                                .propertyBathrooms(
                                                              (confirmationPropertyResponse
                                                                      ?.jsonBody ??
                                                                  ''),
                                                            ).toString(),
                                                            '?',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Sofia Pro By Khuzaimah',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                useGoogleFonts:
                                                                    false,
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 9, 0),
                                                        child: Icon(
                                                          Icons
                                                              .design_services_outlined,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryColor,
                                                          size: 24,
                                                        ),
                                                      ),
                                                      Text(
                                                        valueOrDefault<String>(
                                                          PropertyCall
                                                              .propertySize(
                                                            (confirmationPropertyResponse
                                                                    ?.jsonBody ??
                                                                ''),
                                                          ).toString(),
                                                          '?',
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Sofia Pro By Khuzaimah',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryColor,
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
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 25, 20, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          '514bcidn' /* Transaction details */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily:
                                                  'Sofia Pro By Khuzaimah',
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
                                    20, 20, 20, 12),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 5),
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'g7t2uz7u' /* Transaction Ref. */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily:
                                                        'Sofia Pro By Khuzaimah',
                                                    color: Color(0xFF6B6B6B),
                                                    fontWeight: FontWeight.w300,
                                                    useGoogleFonts: false,
                                                  ),
                                            ),
                                          ),
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              '48t9kq7r' /* #29877de2887 */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily:
                                                      'Sofia Pro By Khuzaimah',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 5),
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'nfajktl1' /* Payment Method */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily:
                                                        'Sofia Pro By Khuzaimah',
                                                    color: Color(0xFF6B6B6B),
                                                    fontWeight: FontWeight.w300,
                                                    useGoogleFonts: false,
                                                  ),
                                            ),
                                          ),
                                          Text(
                                            widget.paymentMethod,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily:
                                                      'Sofia Pro By Khuzaimah',
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
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 0, 20, 22),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 5),
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'xihd37di' /* Amount */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily:
                                                        'Sofia Pro By Khuzaimah',
                                                    color: Color(0xFF6B6B6B),
                                                    fontWeight: FontWeight.w300,
                                                    useGoogleFonts: false,
                                                  ),
                                            ),
                                          ),
                                          Text(
                                            valueOrDefault<String>(
                                              PropertyCall.reservationsCost(
                                                (confirmationPropertyResponse
                                                        ?.jsonBody ??
                                                    ''),
                                              ).toString(),
                                              'Un-Known',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily:
                                                      'Sofia Pro By Khuzaimah',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 5),
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                's1mfpoki' /* Date & Time */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily:
                                                        'Sofia Pro By Khuzaimah',
                                                    color: Color(0xFF6B6B6B),
                                                    fontWeight: FontWeight.w300,
                                                    useGoogleFonts: false,
                                                  ),
                                            ),
                                          ),
                                          Text(
                                            valueOrDefault<String>(
                                              dateTimeFormat('MMMMEEEEd',
                                                  columnOrdersRecord.createdAt),
                                              'Un-Known',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily:
                                                      'Sofia Pro By Khuzaimah',
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
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 0, 20, 162),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    FFButtonWidget(
                                      onPressed: () {
                                        print('receipt pressed ...');
                                      },
                                      text: FFLocalizations.of(context).getText(
                                        'a5vxpwan' /* View Receipt Transaction */,
                                      ),
                                      icon: Icon(
                                        Icons.sticky_note_2_outlined,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryColor,
                                        size: 20,
                                      ),
                                      options: FFButtonOptions(
                                        width: 230,
                                        height: 45,
                                        color: Colors.white,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .subtitle2
                                            .override(
                                              fontFamily:
                                                  'Sofia Pro By Khuzaimah',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryColor,
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
                ),
                Stack(
                  children: [
                    Material(
                      color: Colors.transparent,
                      elevation: 1,
                      child: Container(
                        width: double.infinity,
                        height: 98,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x0D000000),
                              offset: Offset(0, -2),
                            )
                          ],
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 15, 20, 31),
                          child: FFButtonWidget(
                            onPressed: () async {
                              logFirebaseEvent(
                                  'CONFIRMATION_viewBookingDetails_ON_TAP');
                              // BookingDetails
                              logFirebaseEvent(
                                  'viewBookingDetails_BookingDetails');
                              context.goNamed(
                                'OrderDetails',
                                queryParams: {
                                  'propertId': serializeParam(
                                      widget.propertyId, ParamType.int),
                                }.withoutNulls,
                              );
                            },
                            text: FFLocalizations.of(context).getText(
                              'qlfkupzn' /* Back to Home */,
                            ),
                            options: FFButtonOptions(
                              width: 335,
                              height: 52,
                              color: FlutterFlowTheme.of(context).primaryColor,
                              textStyle: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
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
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
