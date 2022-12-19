// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:manzel/common_widgets/manzel_icons.dart';
// import 'package:manzel/components/something_went_wrong_widget.dart';
// import 'package:rxdart/subjects.dart';
// import 'package:universal_io/prefer_universal/io.dart';
//
// import '../auth/auth_util.dart';
// import '../backend/backend.dart';
// import '../common_alert_dialog/common_alert_dialog.dart';
// import '../components/no_result_widget.dart';
// import '../flutter_flow/custom_functions.dart';
// import '../flutter_flow/flutter_flow_theme.dart';
// import '../flutter_flow/flutter_flow_util.dart';
// import '../flutter_flow/custom_functions.dart' as functions;
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:manzel/backend/backend.dart';
//
// class NotificationsWidget extends StatefulWidget {
//   const NotificationsWidget({Key? key}) : super(key: key);
//
//   @override
//   _NotificationsWidgetState createState() => _NotificationsWidgetState();
// }
//
// class _NotificationsWidgetState extends State<NotificationsWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//
//   //List<NotificationsRecord>? notificationsListNotificationsRecordList;
//   List notificationsListNotificationsRecordList = [];
//   Stream? queryNotifications;
//   bool? isInternetAvailable;
//   bool isPageLoading = true;
//   var notificationsUpdateData;
//   List<int> notificationReadCount = [];
//   // NotificationListBloc? notificationListBloc;
//   ScrollController controller = ScrollController();
//   List notificationDetails = [];
//   bool isPaginatedNotificationsLoading = false;
//
//   bool showIndicator = false;
//   List<DocumentSnapshot> documentList=[];
//
//   BehaviorSubject<List> notificationController= BehaviorSubject<List>();
//
//   BehaviorSubject<bool> showIndicatorController = BehaviorSubject<bool>();
//
//   // FirebaseProvider firebaseProvider=FirebaseProvider();
//
//   Stream get getShowIndicatorStream => showIndicatorController.stream;
//
//   Stream<List> get notificationStream => notificationController.stream;
//
//   Future<List<DocumentSnapshot>> fetchFirstList() async {
//     return (await FirebaseFirestore.instance
//         .collection("Notifications")
//         .orderBy('created_at',descending: true)
//         .limit(9).get()).docs;
//   }
//
//   Future<List<DocumentSnapshot>> fetchNextList(
//       List<DocumentSnapshot> documentList) async {
//     return (await FirebaseFirestore.instance
//         .collection("Notifications")
//         .orderBy('created_at',descending: true).startAfterDocument(documentList[documentList.length - 1])
//         .limit(10)
//         .get()).docs;
//   }
//
//   /*This method will automatically fetch first 10 elements from the document list */
//   Future fetchFirstNotifications() async {
//     try {
//       documentList = await fetchFirstList();
//       print(documentList);
//       List notificationsListNotificationsRecordList=[];
//       await Future.forEach (documentList,(dynamic notification) async{
//         await notification.reference.get().then((res) {
//           documentList.forEach((notification) {
//             //     int count= (res.data() as dynamic)['is_read'];
//             //     notificationReadCount.add(count);
//             //     print('NotificationReadCount${notificationReadCount[0]}');
//             // notification.data()
//           });
//           notificationsListNotificationsRecordList.add(res.data());
//           // int count= (res.data() as dynamic)['is_read'];
//           // notificationReadCount.add(count);
//           //print('NotificationReadCount${notificationReadCount[0]}');
//         },
//         );
//       });
//       notificationController.sink.add(notificationsListNotificationsRecordList);
//       try {
//         if (documentList.length == 0) {
//           notificationController.sink.addError("No Data Available");
//         }
//       } catch (e) {}
//     } on SocketException {
//       notificationController.sink.addError(SocketException("No Internet Connection"));
//     } catch (e) {
//       print(e.toString());
//       notificationController.sink.addError(e);
//     }
//   }
//
// /*This will automatically fetch the next 10 elements from the list*/
//   fetchNextNotifications() async {
//     setState(() {
//       isPaginatedNotificationsLoading = true;
//     });
//     try {
//       updateIndicator(true);
//       List<DocumentSnapshot> newDocumentList =
//       await fetchNextList(documentList);
//       documentList.addAll(newDocumentList);
//       notificationController.sink.add(documentList);
//       setState(() {
//         isPaginatedNotificationsLoading = false;
//       });
//       try {
//         if (documentList.length == 0) {
//           notificationController.sink.addError("No Data Available");
//           updateIndicator(false);
//         }
//       } catch (e) {
//         updateIndicator(false);
//       }
//     } on SocketException {
//       notificationController.sink.addError(SocketException("No Internet Connection"));
//       updateIndicator(false);
//     } catch (e) {
//       updateIndicator(false);
//       print(e.toString());
//       notificationController.sink.addError(e);
//     }
//   }
//
// /*For updating the indicator below every list and paginate*/
//   updateIndicator(bool value) async {
//     showIndicator = value;
//     showIndicatorController.sink.add(value);
//   }
//
//   void dispose() {
//     notificationController.close();
//     showIndicatorController.close();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     logFirebaseEvent('screen_view',
//         parameters: {'screen_name': 'Notifications'});
//     checkInternetStatus();
//     // notificationListBloc = NotificationListBloc();
//     fetchFirstNotifications();
//     controller.addListener(_scrollListener);
//   }
//
//   // Future fetchFirstTenNotifications() async{
//   //   var response = await FirebaseProvider().fetchFirstList();
//   //   List notifications= response.toList();
//   //   print(notifications);
//   //   print(response);
//   //   queryNotificationsRecord(
//   //     queryBuilder: (notificationsRecord) =>
//   //         notificationsRecord
//   //             .where('user_id',
//   //             isEqualTo: currentUserReference)
//   //             .orderBy('created_at', descending: true),
//   //   );
//   // }
//
//   Future<void> checkInternetStatus() async {
//     isInternetAvailable = await isInternetConnected();
//     if ((isInternetAvailable ?? false)) {
//       isPageLoading = false;
//       setState(() {});
//     } else {
//       isPageLoading = true;
//       setState(() {});
//       showDialog(
//         context: context,
//         builder: (BuildContext context) => CommonAlertDialog(
//           onCancel: () {
//             Navigator.pop(context);
//           },
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         title: Text(
//           FFLocalizations.of(context).getText(
//             'nm3bcvix' /* Notifications */,
//           ),
//           style: FlutterFlowTheme.of(context).title2.override(
//             fontFamily: 'AvenirArabic',
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.w500,
//             useGoogleFonts: false,
//           ),
//         ),
//         actions: [
//           isInternetAvailable ?? false
//               ? InkWell(
//             onTap: () async {
//               notificationsListNotificationsRecordList
//                   ?.forEach((notification) async {
//                 await notification.reference
//                     .update(createNotificationsRecordData(
//                   isRead: 1,
//                 ));
//               });
//             },
//             child: Container(
//               margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//               padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: FlutterFlowTheme.of(context).primaryColor,
//                 borderRadius: BorderRadius.circular(7),
//               ),
//               child: Text(
//                 FFLocalizations.of(context).getText(
//                   'markAll' /* Mark All */,
//                 ),
//                 style: FlutterFlowTheme.of(context).bodyText1.override(
//                   fontFamily: 'AvenirArabic',
//                   color: FlutterFlowTheme.of(context).white,
//                   fontSize: 13,
//                   fontWeight: FontWeight.w500,
//                   useGoogleFonts: false,
//                 ),
//               ),
//             ),
//           )
//               : SizedBox(),
//           Padding(
//             padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
//             child: InkWell(
//               onTap: () async {
//                 logFirebaseEvent('NOTIFICATIONS_PAGE_cancel_ON_TAP');
//                 logFirebaseEvent('cancel_Close-Dialog,-Drawer,-Etc');
//                 Navigator.pop(context);
//               },
//               child: Icon(
//                 Icons.clear_sharp,
//                 color: Colors.black,
//                 size: 24,
//               ),
//             ),
//           ),
//         ],
//         centerTitle: false,
//         elevation: 0,
//       ),
//       backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
//       body: SafeArea(
//         child: GestureDetector(
//           onTap: () => FocusScope.of(context).unfocus(),
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
//                   child: Builder(builder: (context) {
//                     if (isPageLoading) {
//                       return SizedBox();
//                     } else {
//                       return StreamBuilder<List>(
//                         stream: notificationStream,
//                         // queryNotificationsRecord(
//                         //   queryBuilder: (notificationsRecord) =>
//                         //       notificationsRecord
//                         //           .where('user_id',
//                         //               isEqualTo: currentUserReference)
//                         //           .orderBy('created_at', descending: true),
//                         // ),
//                         builder: (context, snapshot) {
//                           if (!snapshot.hasData) {
//                             return Center(
//                               child: SizedBox(
//                                 width: 50,
//                                 height: 50,
//                                 child: SpinKitRipple(
//                                   color:
//                                   FlutterFlowTheme.of(context).primaryColor,
//                                   size: 50,
//                                 ),
//                               ),
//                             );
//                           } else {
//                             notificationsListNotificationsRecordList =
//                                 snapshot.data ?? [];
//                             // Future.forEach (notificationDetails,(dynamic notification) async{
//                             //   await notification.reference.get().then((res) {
//                             //     notificationsListNotificationsRecordList.add(res.data());
//                             //     int count= (res.data() as dynamic)['is_read'];
//                             //     notificationReadCount.add(count);
//                             //     print('NotificationReadCount${notificationReadCount[0]}');
//                             //   },
//                             //   );
//                             // });
//                             if (notificationsListNotificationsRecordList
//                                 ?.isEmpty ??
//                                 false) {
//                               return Center(
//                                 child: Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   height:
//                                   MediaQuery.of(context).size.height * 0.7,
//                                   child: NoResultWidget(
//                                     titleText: functions.emptyListWidgetTitle(
//                                         'notifications', FFAppState().locale),
//                                     screenName: 'notification',
//                                   ),
//                                 ),
//                               );
//                             } else if (notificationsListNotificationsRecordList ==
//                                 null) {
//                               WidgetsBinding.instance.addPostFrameCallback((_) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                     content: Text(
//                                       FFLocalizations.of(context).getText(
//                                         'failure' /* You are logged - in*/,
//                                       ),
//                                       style: TextStyle(
//                                         fontFamily: 'Sofia Pro By Khuzaimah',
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 18,
//                                       ),
//                                     ),
//                                     duration: Duration(milliseconds: 4000),
//                                     backgroundColor:
//                                     FlutterFlowTheme.of(context).primaryRed,
//                                   ),
//                                 );
//                               });
//                             }
//                             return Column(
//                               children: [
//                                 Expanded(
//                                   child: ListView.builder(
//                                     shrinkWrap: true,
//                                     controller: controller,
//                                     padding: EdgeInsets.zero,
//                                     scrollDirection: Axis.vertical,
//                                     itemCount:
//                                     notificationsListNotificationsRecordList
//                                         .length ??
//                                         0,
//                                     itemBuilder:
//                                         (context, notificationsListIndex) {
//                                       final notificationsListNotificationsRecord =
//                                       notificationsListNotificationsRecordList[
//                                       notificationsListIndex];
//                                       return InkWell(
//                                         onTap: () async {
//                                           logFirebaseEvent(
//                                               'NOTIFICATIONS_Container_h34e593u_ON_TAP');
//                                           if (notificationsListNotificationsRecord[
//                                           'notification_type'] ==
//                                               'MyProperties') {
//                                             context.pushNamed(
//                                               'MyProperties',
//                                             );
//                                           } else if (notificationsListNotificationsRecord[
//                                           'notification_type'] ==
//                                               'Offers') {
//                                             logFirebaseEvent(
//                                                 'Container_Navigate-To');
//                                             context.pushNamed(
//                                               'Offers',
//                                               queryParams: {
//                                                 'propertyId': serializeParam(
//                                                     notificationsListNotificationsRecord[
//                                                     'property_id'],
//                                                     ParamType.String),
//                                               }.withoutNulls,
//                                             );
//                                           } else {
//                                             logFirebaseEvent(
//                                                 'Container_Navigate-To');
//                                             context.pushNamed(
//                                               'BookingDetails',
//                                               queryParams: {
//                                                 'orderId': serializeParam(
//                                                     notificationsListNotificationsRecord[
//                                                     'order_id']
//                                                         ?.toString(),
//                                                     ParamType.String),
//                                               }.withoutNulls,
//                                             );
//                                           }
//
//                                           logFirebaseEvent(
//                                               'Container_Backend-Call');
//
//                                           notificationsUpdateData =
//                                               createNotificationsRecordData(
//                                                 isRead: 1,
//                                               );
//                                           bool isInternetAvailable =
//                                           await isInternetConnected();
//                                           if (isInternetAvailable) {
//                                             var collection = FirebaseFirestore
//                                                 .instance
//                                                 .collection('Notifications')
//                                                 .get();
//
//                                             CollectionReference users =
//                                             FirebaseFirestore.instance
//                                                 .collection(
//                                                 'Notifications');
//                                             users
//                                                 .doc(currentUserUid)
//                                                 .update({'is_read': '1'})
//                                                 .then((value) =>
//                                                 print("User Updated"))
//                                                 .catchError((error) => print(
//                                                 "Failed to update user: $error"));
//                                             // collection.doc(currentUserDocument?.uid).update({'is_read': 1}).then((result){
//                                             //    print("new USer true");
//                                             //  }).catchError((onError){
//                                             //    print("onError");
//                                             //  });
//
//                                             //}
//                                             // FirebaseFirestore.instance
//                                             //     .collection("Notifications").doc().update(data)
//
//                                             // await notificationsListNotificationsRecord
//                                             //     ?.reference
//                                             //     .update(notificationsUpdateData);
//                                           } else {
//                                             showDialog(
//                                               context: context,
//                                               builder: (BuildContext context) =>
//                                                   CommonAlertDialog(
//                                                     onCancel: () {
//                                                       Navigator.pop(context);
//                                                     },
//                                                   ),
//                                             );
//                                           }
//                                         },
//                                         child: Container(
//                                           width: 100,
//                                           decoration: BoxDecoration(
//                                             color: FlutterFlowTheme.of(context)
//                                                 .white,
//                                           ),
//                                           child: Column(
//                                             mainAxisSize: MainAxisSize.max,
//                                             children: [
//                                               IntrinsicHeight(
//                                                 child: Row(
//                                                   mainAxisSize:
//                                                   MainAxisSize.max,
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                                   children: [
//                                                     if (notificationsListNotificationsRecord[
//                                                     'is_read'] ==
//                                                         0)
//                                                       Padding(
//                                                         padding:
//                                                         const EdgeInsets
//                                                             .only(
//                                                             top: 0,
//                                                             bottom: 10),
//                                                         child: Container(
//                                                           width: 8,
//                                                           height:
//                                                           double.infinity,
//                                                           decoration:
//                                                           BoxDecoration(
//                                                             color: FlutterFlowTheme
//                                                                 .of(context)
//                                                                 .primaryColor,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     Expanded(
//                                                       child: Padding(
//                                                         padding:
//                                                         EdgeInsetsDirectional
//                                                             .fromSTEB(
//                                                             5, 0, 0, 0),
//                                                         child: Column(
//                                                           mainAxisSize:
//                                                           MainAxisSize.max,
//                                                           crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .stretch,
//                                                           children: [
//                                                             Padding(
//                                                               padding:
//                                                               EdgeInsetsDirectional
//                                                                   .fromSTEB(
//                                                                   0,
//                                                                   0,
//                                                                   15,
//                                                                   15),
//                                                               child: Container(
//                                                                 width: 100,
//                                                                 decoration:
//                                                                 BoxDecoration(
//                                                                   color: Colors
//                                                                       .white,
//                                                                 ),
//                                                                 child: Padding(
//                                                                   padding: EdgeInsetsDirectional
//                                                                       .fromSTEB(
//                                                                       0,
//                                                                       9,
//                                                                       0,
//                                                                       0),
//                                                                   child: Row(
//                                                                     mainAxisSize:
//                                                                     MainAxisSize
//                                                                         .max,
//                                                                     crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .start,
//                                                                     children: [
//                                                                       Padding(
//                                                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                                                             11,
//                                                                             0,
//                                                                             10,
//                                                                             0),
//                                                                         child:
//                                                                         Container(
//                                                                           width:
//                                                                           35,
//                                                                           height:
//                                                                           35,
//                                                                           decoration:
//                                                                           BoxDecoration(
//                                                                             color:
//                                                                             Colors.white,
//                                                                             shape:
//                                                                             BoxShape.circle,
//                                                                             border:
//                                                                             Border.all(
//                                                                               color: Color(0xFF8C8C8C),
//                                                                             ),
//                                                                           ),
//                                                                           child:
//                                                                           Icon(
//                                                                             Manzel.notification,
//                                                                             color:
//                                                                             Colors.black,
//                                                                             size:
//                                                                             20,
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                       Expanded(
//                                                                         child:
//                                                                         Column(
//                                                                           mainAxisSize:
//                                                                           MainAxisSize.max,
//                                                                           crossAxisAlignment:
//                                                                           CrossAxisAlignment.start,
//                                                                           children: [
//                                                                             if (functions.notificationConditionalVisibilty(
//                                                                                 FFAppState().locale,
//                                                                                 notificationsListNotificationsRecord['is_read'],
//                                                                                 'ar',
//                                                                                 0))
//                                                                               Row(
//                                                                                 mainAxisSize: MainAxisSize.max,
//                                                                                 children: [
//                                                                                   Expanded(
//                                                                                     child: Text(
//                                                                                       notificationsListNotificationsRecord['message_en'],
//                                                                                       style: FlutterFlowTheme.of(context).subtitle1.override(
//                                                                                         fontFamily: 'AvenirArabic',
//                                                                                         color: Colors.black,
//                                                                                         fontSize: 14,
//                                                                                         fontWeight: FontWeight.w600,
//                                                                                         useGoogleFonts: false,
//                                                                                       ),
//                                                                                     ),
//                                                                                   ),
//                                                                                 ],
//                                                                               ),
//                                                                             if (functions.notificationConditionalVisibilty(
//                                                                                 FFAppState().locale,
//                                                                                 notificationsListNotificationsRecord['is_read'],
//                                                                                 'en',
//                                                                                 0))
//                                                                               Row(
//                                                                                 mainAxisSize: MainAxisSize.max,
//                                                                                 children: [
//                                                                                   Expanded(
//                                                                                     child: Text(
//                                                                                       notificationsListNotificationsRecord['message_en'],
//                                                                                       style: FlutterFlowTheme.of(context).subtitle1.override(
//                                                                                         fontFamily: 'AvenirArabic',
//                                                                                         color: Colors.black,
//                                                                                         fontSize: 14,
//                                                                                         fontWeight: FontWeight.w600,
//                                                                                         useGoogleFonts: false,
//                                                                                       ),
//                                                                                     ),
//                                                                                   ),
//                                                                                 ],
//                                                                               ),
//                                                                             if (functions.notificationConditionalVisibilty(
//                                                                                 FFAppState().locale,
//                                                                                 notificationsListNotificationsRecord['is_read'],
//                                                                                 'ar',
//                                                                                 1))
//                                                                               Row(
//                                                                                 mainAxisSize: MainAxisSize.max,
//                                                                                 children: [
//                                                                                   Expanded(
//                                                                                     child: Text(
//                                                                                       notificationsListNotificationsRecord['message_en'],
//                                                                                       style: FlutterFlowTheme.of(context).subtitle1.override(
//                                                                                         fontFamily: 'AvenirArabic',
//                                                                                         color: Colors.black,
//                                                                                         fontSize: 14,
//                                                                                         fontWeight: FontWeight.w300,
//                                                                                         useGoogleFonts: false,
//                                                                                       ),
//                                                                                     ),
//                                                                                   ),
//                                                                                 ],
//                                                                               ),
//                                                                             if (functions.notificationConditionalVisibilty(
//                                                                                 FFAppState().locale,
//                                                                                 notificationsListNotificationsRecord['is_read'],
//                                                                                 'en',
//                                                                                 1))
//                                                                               Row(
//                                                                                 mainAxisSize: MainAxisSize.max,
//                                                                                 children: [
//                                                                                   Expanded(
//                                                                                     child: Text(
//                                                                                       notificationsListNotificationsRecord['message_en'],
//                                                                                       style: FlutterFlowTheme.of(context).subtitle1.override(
//                                                                                         fontFamily: 'AvenirArabic',
//                                                                                         color: Colors.black,
//                                                                                         fontSize: 14,
//                                                                                         fontWeight: FontWeight.w300,
//                                                                                         useGoogleFonts: false,
//                                                                                       ),
//                                                                                     ),
//                                                                                   ),
//                                                                                 ],
//                                                                               ),
//                                                                             Padding(
//                                                                               padding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
//                                                                               child: Row(
//                                                                                 mainAxisSize: MainAxisSize.max,
//                                                                                 children: [
//                                                                                   // Text(
//                                                                                   //   functions.notificationsDateTime(FFAppState().locale,
//                                                                                   //       notificationsListNotificationsRecord['created_at']),
//                                                                                   //   style: FlutterFlowTheme.of(context).bodyText1.override(
//                                                                                   //     fontFamily: 'AvenirArabic',
//                                                                                   //     color: FlutterFlowTheme.of(context).secondaryText,
//                                                                                   //     fontSize: 12,
//                                                                                   //     fontWeight: FontWeight.w300,
//                                                                                   //     useGoogleFonts: false,
//                                                                                   //   ),
//                                                                                   // ),
//                                                                                 ],
//                                                                               ),
//                                                                             ),
//                                                                           ],
//                                                                         ),
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             Divider(
//                                                               thickness: 1,
//                                                               indent: 11,
//                                                               color: Color(
//                                                                   0xFFECECEC),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                                 if(isPaginatedNotificationsLoading&&notificationsListNotificationsRecordList.isNotEmpty)
//                                   CircularProgressIndicator()
//                               ],
//                             );
//                             // if(isPaginatedNotificationsLoading){
//                             //   return CircularProgressIndicator(
//                             //     color: Colors.red,
//                             //   );
//                             // }
//                             // else{
//                             //   return SizedBox.shrink();
//                             // }
//                           }
//                         },
//                       );
//                     }
//                   }),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _scrollListener() {
//
//     if (controller.offset >= controller.position.maxScrollExtent &&
//         !controller.position.outOfRange) {
//       setState(() {
//         isPaginatedNotificationsLoading = true;
//       });
//       print("at the end of list");
//       // setState(() {
//       //   isPaginatedNotificationsLoading = true;
//       // });
//       fetchNextNotifications();
//       // setState(() {
//       //   isPaginatedNotificationsLoading = false;
//       // });
//     }
//   }
// }
//
// // class FirebaseProvider {
// //
// // }
// // class NotificationListBloc {
// //
// //
// //
// //
// //   NotificationListBloc() {
// //
// //   }
// //
// //
// //
// //
// // }
// //
// // class Notification {
// //   String? messageEn;
// //   int? isRead;
// //   String? notificationType;
// //   int? propertyId;
// //   int? orderId;
// //
// //   Notification({this.messageEn,this.isRead,this.notificationType,this.propertyId,this.orderId});
// // }
//
//
//






import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:manzel/multi_video_player/flick_auto_hide_child.dart';
import 'package:provider/provider.dart';
import './multi_manager/flick_multi_manager.dart';

class FeedPlayerPortraitControls extends StatefulWidget {
   FeedPlayerPortraitControls(
      {Key? key, this.flickMultiManager, this.flickManager})
      : super(key: key);

  final FlickMultiManager? flickMultiManager;
  final FlickManager? flickManager;
  bool isPlayButtonVisible = false;
  @override
  State<FeedPlayerPortraitControls> createState() => _FeedPlayerPortraitControlsState();
}

class _FeedPlayerPortraitControlsState extends State<FeedPlayerPortraitControls> {
  @override
  Widget build(BuildContext context) {

    FlickDisplayManager displayManager =
        Provider.of<FlickDisplayManager>(context);
    FlickVideoManager videoManager = Provider.of<FlickVideoManager>(context);

    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Stack(
        children: <Widget>[
          if(!videoManager.isPlaying)
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                width: 50,
                // constraints:
                // BoxConstraints(minWidth: 50, maxWidth: 50),
                decoration: BoxDecoration(
                  color:
                      Colors.black.withOpacity(1.0),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color:
                      Colors.white.withOpacity(1.0),
                     // :
                    //Colors.white.withOpacity(0.0),
                  size: 40,
                ),
              ),
            ),
          FlickShowControlsAction(
            handleVideoTap: () {
              widget.flickMultiManager?.togglePlay(widget.flickManager!);
              displayManager.handleShowPlayerControls();
            },
            child: FlickSeekVideoAction(
              child: Center(child: FlickVideoBuffer()),
            ),
          ),
          Positioned(
           bottom: 10,
            right: 10,
            child: Container(
              height: 30,
              width: 30,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(20),
              ),
              child: FlickSoundToggle(
                toggleMute: () => widget.flickMultiManager?.toggleMute(),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
