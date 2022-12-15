import 'package:firebase_auth/firebase_auth.dart';
import 'package:manzel/common_widgets/manzel_icons.dart';
import 'package:manzel/components/something_went_wrong_widget.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../common_alert_dialog/common_alert_dialog.dart';
import '../components/no_result_widget.dart';
import '../flutter_flow/custom_functions.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:manzel/backend/backend.dart';

class NotificationsWidget extends StatefulWidget {
  const NotificationsWidget({Key? key}) : super(key: key);

  @override
  _NotificationsWidgetState createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<NotificationsRecord>? notificationsListNotificationsRecordList;
  Stream? queryNotifications;
  bool? isInternetAvailable;
  bool isPageLoading = true;
  var notificationsUpdateData;
  List<int> notificationReadCount=[];

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'Notifications'});
    checkInternetStatus();
  }

  Future<void> checkInternetStatus() async {
    isInternetAvailable = await isInternetConnected();
    if ((isInternetAvailable ?? false)) {
      isPageLoading = false;
      setState(() {});
    } else {
      isPageLoading = true;
      setState(() {});
      showDialog(
        context: context,
        builder: (BuildContext context) => CommonAlertDialog(
          onCancel: () {
            Navigator.pop(context);
          },
        ),
      );
    }
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
          isInternetAvailable ?? false?InkWell(
            onTap: () async {
              notificationsListNotificationsRecordList
                  ?.forEach((notification) async {
                await notification.reference
                    .update(createNotificationsRecordData(
                  isRead: 1,
                ));
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Text(
                FFLocalizations.of(context).getText(
                  'markAll' /* Mark All */,
                ),
                style: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'AvenirArabic',
                  color: FlutterFlowTheme.of(context).white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  useGoogleFonts: false,
                ),
              ),
            ),
          ):SizedBox(),
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
                  child: Builder(builder: (context) {
                    if (isPageLoading) {
                      return SizedBox();
                    } else {
                      return StreamBuilder<List<NotificationsRecord>>(
                        stream: queryNotificationsRecord(
                          queryBuilder: (notificationsRecord) =>
                              notificationsRecord
                                  .where('user_id',
                                      isEqualTo: currentUserReference)
                                  .orderBy('created_at', descending: true),
                        ),
                        builder: (context, snapshot) {
                          notificationsListNotificationsRecordList = snapshot.data;
                          notificationsListNotificationsRecordList?.forEach((notification) {
                            notification.reference.get().then((res) {
                              int count= (res.data() as dynamic)['is_read'];
                              notificationReadCount.add(count);
                              print('NotificationReadCount${notificationReadCount[0]}');
                            },
                            );
                          });
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: SpinKitRipple(
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  size: 50,
                                ),
                              ),
                            );
                          }

                          if (notificationsListNotificationsRecordList
                                  ?.isEmpty ??
                              false) {
                            return Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: NoResultWidget(
                                  titleText: functions.emptyListWidgetTitle(
                                      'notifications', FFAppState().locale),
                                  screenName: 'notification',
                                ),
                              ),
                            );
                          } else if (notificationsListNotificationsRecordList ==
                              null) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    FFLocalizations.of(context).getText(
                                      'failure' /* You are logged - in*/,
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Sofia Pro By Khuzaimah',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primaryRed,
                                ),
                              );
                            });
                          }
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            itemCount: notificationsListNotificationsRecordList
                                    ?.length ??
                                0,
                            itemBuilder: (context, notificationsListIndex) {
                              final notificationsListNotificationsRecord =
                                  notificationsListNotificationsRecordList?[
                                      notificationsListIndex];
                              return InkWell(
                                onTap: () async {
                                  logFirebaseEvent(
                                      'NOTIFICATIONS_Container_h34e593u_ON_TAP');
                                  if(notificationsListNotificationsRecord
                                          ?.notificationType ==
                                      'MyProperties'){
                                context.pushNamed(
                                  'MyProperties',
                                );
                              }
                              else if (notificationsListNotificationsRecord
                                      ?.notificationType ==
                                  'Offers') {
                                    logFirebaseEvent('Container_Navigate-To');
                                    context.pushNamed(
                                      'Offers',
                                      queryParams: {
                                        'propertyId': serializeParam(
                                            notificationsListNotificationsRecord
                                                ?.propertyId,
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
                                                ?.orderId
                                                ?.toString(),
                                            ParamType.String),
                                      }.withoutNulls,
                                    );
                                  }

                              logFirebaseEvent('Container_Backend-Call');

                                  notificationsUpdateData =
                                      createNotificationsRecordData(
                                    isRead: 1,
                                  );
                                  bool isInternetAvailable =
                                      await isInternetConnected();
                                  if (isInternetAvailable) {
                                    await notificationsListNotificationsRecord
                                        ?.reference
                                        .update(notificationsUpdateData);
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          CommonAlertDialog(
                                        onCancel: () {
                                          Navigator.pop(context);
                                        },
                                      ),
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
                                      IntrinsicHeight(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (notificationsListNotificationsRecord
                                                    ?.isRead ==
                                                0)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 0, bottom: 10),
                                                child: Container(
                                                  width: 8,
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(5, 0, 0, 0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 15, 15),
                                                      child: Container(
                                                        width: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      9, 0, 0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            11,
                                                                            0,
                                                                            10,
                                                                            0),
                                                                child:
                                                                    Container(
                                                                  width: 35,
                                                                  height: 35,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Color(
                                                                          0xFF8C8C8C),
                                                                    ),
                                                                  ),
                                                                  child: Icon(
                                                                    Manzel
                                                                        .notification,
                                                                    color: Colors
                                                                        .black,
                                                                    size: 20,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
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
                                                                            ?.isRead,
                                                                        'ar',
                                                                        0))
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              notificationsListNotificationsRecord!.messageAr!,
                                                                              style: FlutterFlowTheme.of(context).subtitle1.override(
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
                                                                            ?.isRead,
                                                                        'en',
                                                                        0))
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              notificationsListNotificationsRecord!.messageEn!,
                                                                              style: FlutterFlowTheme.of(context).subtitle1.override(
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
                                                                            ?.isRead,
                                                                        'ar',
                                                                        1))
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              notificationsListNotificationsRecord!.messageAr!,
                                                                              style: FlutterFlowTheme.of(context).subtitle1.override(
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
                                                                            ?.isRead,
                                                                        'en',
                                                                        1))
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              notificationsListNotificationsRecord!.messageEn!,
                                                                              style: FlutterFlowTheme.of(context).subtitle1.override(
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
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Text(
                                                                            functions.notificationsDateTime(FFAppState().locale,
                                                                                notificationsListNotificationsRecord?.createdAt),
                                                                            style: FlutterFlowTheme.of(context).bodyText1.override(
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
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
