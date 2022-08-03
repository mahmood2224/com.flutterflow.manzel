import '../backend/api_requests/api_calls.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetailsWidget extends StatefulWidget {
  const OrderDetailsWidget({
    Key key,
    this.propertId,
  }) : super(key: key);

  final int propertId;

  @override
  _OrderDetailsWidgetState createState() => _OrderDetailsWidgetState();
}

class _OrderDetailsWidgetState extends State<OrderDetailsWidget> {
  String uploadedFileUrl = '';
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'OrderDetails'});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiCallResponse>(
      future: PropertyCall.call(
        propertyId: widget.propertId,
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
        final orderDetailsPropertyResponse = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primaryColor,
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 0,
              borderWidth: 0,
              buttonSize: 60,
              fillColor: Colors.transparent,
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () async {
                logFirebaseEvent('ORDER_DETAILS_arrow_back_rounded_ICN_ON_');
                // back
                logFirebaseEvent('IconButton_back');
                context.pop();
              },
            ),
            title: Text(
              valueOrDefault<String>(
                PropertyCall.propertyName(
                  orderDetailsPropertyResponse.jsonBody,
                ).toString(),
                'Un-Known',
              ),
              style: FlutterFlowTheme.of(context).title2.override(
                    fontFamily: 'Sofia Pro By Khuzaimah',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    useGoogleFonts: false,
                  ),
            ),
            actions: [
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.keyboard_control_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  print('IconButton pressed ...');
                },
              ),
            ],
            centerTitle: true,
            elevation: 2,
          ),
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 23, 16, 0),
                      child: Container(
                        width: 343,
                        height: 167,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15,
                              color: Color(0x1A2971FB),
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15, 19, 15, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: Image.network(
                                          PropertyCall.propertyImg(
                                            orderDetailsPropertyResponse
                                                .jsonBody,
                                          ),
                                          width: 80,
                                          height: 75,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15, 0, 0, 0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 5),
                                              child: Text(
                                                valueOrDefault<String>(
                                                  PropertyCall.propertyName(
                                                    orderDetailsPropertyResponse
                                                        .jsonBody,
                                                  ).toString(),
                                                  'Un-Known',
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'Sofia Pro By Khuzaimah',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          useGoogleFonts: false,
                                                        ),
                                              ),
                                            ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'obc5bmtb' /* Riyadh, Alyasmeen */,
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
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 15, 0, 0),
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
                                                              orderDetailsPropertyResponse
                                                                  .jsonBody,
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
                                                              orderDetailsPropertyResponse
                                                                  .jsonBody,
                                                            ).toString(),
                                                            '?',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Sofia Pro By Khuzaimah',
                                                                color: Color(
                                                                    0xFF2971FB),
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
                                                          color:
                                                              Color(0xFF2971FB),
                                                          size: 24,
                                                        ),
                                                      ),
                                                      Text(
                                                        valueOrDefault<String>(
                                                          PropertyCall
                                                              .propertySize(
                                                            orderDetailsPropertyResponse
                                                                .jsonBody,
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
                                                                  color: Color(
                                                                      0xFF2971FB),
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
                              indent: 10,
                              endIndent: 10,
                              color: Color(0xFFECECEC),
                            ),
                            InkWell(
                              onTap: () async {
                                logFirebaseEvent(
                                    'ORDER_DETAILS_PAGE_Text_idmwcq2x_ON_TAP');
                                // PropertyDetails
                                logFirebaseEvent('Text_PropertyDetails');
                                context.goNamed(
                                  'PropertyDetails',
                                  queryParams: {
                                    'propertyId': serializeParam(
                                        widget.propertId, ParamType.int),
                                  }.withoutNulls,
                                );
                              },
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  'dghbf6mg' /* View Property Details */,
                                ),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Sofia Pro By Khuzaimah',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: false,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 32, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  FFLocalizations.of(context).getText(
                                    '6on06i4j' /* Order Process */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Sofia Pro By Khuzaimah',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300,
                                        useGoogleFonts: false,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 15, 16, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 15),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 12, 5),
                                        child: Icon(
                                          Icons.check_circle_rounded,
                                          color: Color(0xFF7FC15F),
                                          size: 28,
                                        ),
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'nkd2c7wt' /* Reservation & Payment Confirme... */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily:
                                                  'Sofia Pro By Khuzaimah',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              useGoogleFonts: false,
                                            ),
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
                                      0, 15, 0, 15),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 12, 5),
                                        child: Icon(
                                          Icons.radio_button_off,
                                          color: Colors.black,
                                          size: 28,
                                        ),
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'l5s89kan' /* Send deal to Banks */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily:
                                                  'Sofia Pro By Khuzaimah',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              useGoogleFonts: false,
                                            ),
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
                                      0, 15, 0, 15),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 12, 5),
                                                  child: Icon(
                                                    Icons
                                                        .radio_button_off_outlined,
                                                    color: Colors.black,
                                                    size: 28,
                                                  ),
                                                ),
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'mll46yo8' /* Completing Documents */,
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
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(40, 10, 0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  FFButtonWidget(
                                                    onPressed: () async {
                                                      logFirebaseEvent(
                                                          'ORDER_DETAILS_uploadDocuments_ON_TAP');
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
                                                          showLoading: true,
                                                        );
                                                        final downloadUrl =
                                                            await uploadData(
                                                                selectedFile
                                                                    .storagePath,
                                                                selectedFile
                                                                    .bytes);
                                                        ScaffoldMessenger.of(
                                                                context)
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
                                                    text: FFLocalizations.of(
                                                            context)
                                                        .getText(
                                                      'dm8dxmsv' /* Upload Documents */,
                                                    ),
                                                    options: FFButtonOptions(
                                                      width: 200,
                                                      height: 44,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
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
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                useGoogleFonts:
                                                                    false,
                                                              ),
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
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
                                Divider(
                                  thickness: 1,
                                  color: Color(0xFFECECEC),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 15, 0, 15),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 12, 5),
                                        child: Icon(
                                          Icons.radio_button_off_outlined,
                                          color: Colors.black,
                                          size: 28,
                                        ),
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'hojjvz6d' /* Get banks proposals */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily:
                                                  'Sofia Pro By Khuzaimah',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              useGoogleFonts: false,
                                            ),
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
                                      0, 15, 0, 15),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 12, 5),
                                        child: Icon(
                                          Icons.radio_button_off_outlined,
                                          color: Colors.black,
                                          size: 28,
                                        ),
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'oqjt6apm' /* Close Deal */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily:
                                                  'Sofia Pro By Khuzaimah',
                                              fontSize: 16,
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
