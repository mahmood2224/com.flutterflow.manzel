import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/no_result_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsWidget extends StatefulWidget {
  const NotificationsWidget({Key? key}) : super(key: key);

  @override
  _NotificationsWidgetState createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'Notifications'});
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
            'nm3bcvix' /* Notifications */,
          ),
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'AvenirArabic',
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                useGoogleFonts: false,
              ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
            child: InkWell(
              onTap: () async {
                logFirebaseEvent('NOTIFICATIONS_PAGE_cancel_ON_TAP');
                logFirebaseEvent('cancel_Close-Dialog,-Drawer,-Etc');
                Navigator.pop(context);
              },
              child: Icon(
                Icons.clear_sharp,
                color: Colors.black,
                size: 24,
              ),
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: StreamBuilder<List<NotificationsRecord>>(
                    stream: queryNotificationsRecord(
                      queryBuilder: (notificationsRecord) => notificationsRecord
                          .where('user_id', isEqualTo: currentUserReference)
                          .orderBy('created_at', descending: true),
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
                      List<NotificationsRecord>
                          notificationsListNotificationsRecordList =
                          snapshot.data!;
                      if (notificationsListNotificationsRecordList.isEmpty) {
                        return Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: NoResultWidget(
                              titleText: functions.emptyListWidgetTitle(
                                  'notifications', FFAppState().locale),
                              screenName: 'notification',
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount:
                            notificationsListNotificationsRecordList.length,
                        itemBuilder: (context, notificationsListIndex) {
                          final notificationsListNotificationsRecord =
                              notificationsListNotificationsRecordList[
                                  notificationsListIndex];
                          return InkWell(
                            onTap: () async {
                              logFirebaseEvent(
                                  'NOTIFICATIONS_Container_h34e593u_ON_TAP');
                              logFirebaseEvent('Container_Backend-Call');

                              final notificationsUpdateData =
                                  createNotificationsRecordData(
                                isRead: 1,
                              );
                              await notificationsListNotificationsRecord
                                  .reference
                                  .update(notificationsUpdateData);
                              if (notificationsListNotificationsRecord
                                      .notificationType ==
                                  'Offers') {
                                logFirebaseEvent('Container_Navigate-To');

                                context.pushNamed(
                                  'Offers',
                                  queryParams: {
                                    'propertyId': serializeParam(
                                        notificationsListNotificationsRecord
                                            .propertyId,
                                        ParamType.String),
                                  }.withoutNulls,
                                );
                              } else {
                                logFirebaseEvent('Container_Navigate-To');

                                context.pushNamed(
                                  'BookingDetails',
                                  queryParams: {
                                    'orderId': serializeParam(
                                        notificationsListNotificationsRecord
                                            .orderId
                                            ?.toString(),
                                        ParamType.String),
                                  }.withoutNulls,
                                );
                              }
                            },
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).white,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if (notificationsListNotificationsRecord
                                              .isRead ==
                                          0)
                                        Container(
                                          width: 8,
                                          height: 88,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryColor,
                                          ),
                                        ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  11, 0, 0, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 15, 15),
                                                child: Container(
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 9, 0, 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10,
                                                                        0,
                                                                        0,
                                                                        0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                if (functions.notificationConditionalVisibilty(
                                                                    FFAppState()
                                                                        .locale,
                                                                    notificationsListNotificationsRecord
                                                                        .isRead,
                                                                    'ar',
                                                                    0))
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          notificationsListNotificationsRecord
                                                                              .messageAr!,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .subtitle1
                                                                              .override(
                                                                                fontFamily: 'AvenirArabic',
                                                                                color: Colors.black,
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w600,
                                                                                useGoogleFonts: false,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                if (functions.notificationConditionalVisibilty(
                                                                    FFAppState()
                                                                        .locale,
                                                                    notificationsListNotificationsRecord
                                                                        .isRead,
                                                                    'en',
                                                                    0))
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          notificationsListNotificationsRecord
                                                                              .messageEn!,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .subtitle1
                                                                              .override(
                                                                                fontFamily: 'AvenirArabic',
                                                                                color: Colors.black,
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w600,
                                                                                useGoogleFonts: false,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                if (functions.notificationConditionalVisibilty(
                                                                    FFAppState()
                                                                        .locale,
                                                                    notificationsListNotificationsRecord
                                                                        .isRead,
                                                                    'ar',
                                                                    1))
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          notificationsListNotificationsRecord
                                                                              .messageAr!,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .subtitle1
                                                                              .override(
                                                                                fontFamily: 'AvenirArabic',
                                                                                color: Colors.black,
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w300,
                                                                                useGoogleFonts: false,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                if (functions.notificationConditionalVisibilty(
                                                                    FFAppState()
                                                                        .locale,
                                                                    notificationsListNotificationsRecord
                                                                        .isRead,
                                                                    'en',
                                                                    1))
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          notificationsListNotificationsRecord
                                                                              .messageEn!,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .subtitle1
                                                                              .override(
                                                                                fontFamily: 'AvenirArabic',
                                                                                color: Colors.black,
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w300,
                                                                                useGoogleFonts: false,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          6,
                                                                          0,
                                                                          0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Text(
                                                                        functions.notificationsDateTime(
                                                                            FFAppState().locale,
                                                                            notificationsListNotificationsRecord.createdAt),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'AvenirArabic',
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w300,
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
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                thickness: 1,
                                                indent: 11,
                                                color: Color(0xFFECECEC),
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
                          );
                        },
                      );
                    },
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
