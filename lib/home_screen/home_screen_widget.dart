import 'package:video_player/video_player.dart';
import '../auth/auth_util.dart';
import '../auth/firebase_user_provider.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import 'package:manzel/common_widgets/manzel_icons.dart';
import '../components/no_result_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'dart:async';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../flutter_flow/flutter_flow_widgets.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({
    Key? key,
    this.city,
    this.type,
    this.installmentRange,
    this.furnishing,
  }) : super(key: key);

  final String? city;
  final String? type;
  final double? installmentRange;
  final String? furnishing;

  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  Completer<ApiCallResponse>? _apiRequestCompleter;
  PageController? pageViewController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentItem = 0;

  bool isPaused = false;
  bool? autoplayVal;
  List<VideoPlayerController> homeScreenPlayers = [];
  ValueNotifier<bool> isMuted = ValueNotifier<bool>(true);

  //ValueNotifier<bool> isPaused = ValueNotifier<bool>(false);

  //FlickMultiManager flickMultiManager;
  Set<VideoPlayerController>? videoControllerSet;

  VideoPlayerController? _currentController;
  int currentPropertyindex = 0;

  Map<String, VideoPlayerController> videocontrollerMap = {};

  static const _pageSize = 20;
  final PagingController<int, dynamic> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    // On page load action.
    videoPlayers.clear();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('HOME_SCREEN_PAGE_HomeScreen_ON_PAGE_LOAD');
      logFirebaseEvent('HomeScreen_Set-App-Language');
      setAppLanguage(context, FFAppState().locale);
       Future.delayed(const Duration(milliseconds: 500), () {
        setAppLanguage(context, FFAppState().locale);
       });
    });

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'HomeScreen'});
    _pagingController.addPageRequestListener((pageKey) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _fetchPage(pageKey);
      });
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final apiResponse = await PropertiesCall.call(
        // city: FFAppState().filterCity,
        // furnishingType: FFAppState().filterFurnishingType,
        // propertyType: FFAppState().filterPropertyType,
        pageNumber: pageKey.toString(),
        pageSize: _pageSize.toString(),
        locale: FFAppState().locale,
      );
      final newItems = getJsonField(
            (apiResponse?.jsonBody ?? ''),
            r'''$.data''',
          )?.toList() ??
          [];
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        // 3.1 Use this for offset based pagination
        // final nextPageKey = pageKey + newItems.length;
        // 3.2 Use this for page based pagination
        final nextPageKey = ++pageKey;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      constraints: BoxConstraints(
                        maxWidth: double.infinity,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x3F000000),
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Image.asset(
                          'assets/images/home_bg.png',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, -0.7),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/manzel_logo.png',
                              width: 43,
                              height: 31,
                              fit: BoxFit.cover,
                            ),
                            if (loggedIn)
                              StreamBuilder<List<NotificationsRecord>>(
                                stream: queryNotificationsRecord(
                                  queryBuilder: (notificationsRecord) =>
                                      notificationsRecord
                                          .where('user_id',
                                              isEqualTo: currentUserReference)
                                          .where('is_read', isEqualTo: 0),
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: Icon(
                                        Manzel.notification,
                                        color: Colors.white,
                                        size: 26,
                                      ),
                                    );
                                  }
                                  List<NotificationsRecord>
                                      notificationsBadgeNotificationsRecordList =
                                      snapshot.data!;
                                  return InkWell(
                                    onTap: () async {
                                      videoPlayers[currentPropertyindex!]
                                          ?.pause();
                                      logFirebaseEvent(
                                          'HOME_SCREEN_notificationsBadge_ON_TAP');
                                      logFirebaseEvent(
                                          'notificationsBadge_Navigate-To');
                                      context.pushNamed('Notifications');
                                    },
                                    child: Badge(
                                      badgeContent: Text(
                                        valueOrDefault<String>(
                                          functions.notificationBadgeCount(
                                              notificationsBadgeNotificationsRecordList
                                                  .toList()),
                                          '0',
                                        ),
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'AvenirArabic',
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              useGoogleFonts: false,
                                            ),
                                      ),
                                      showBadge: functions.notificationBadgeCount(
                                              notificationsBadgeNotificationsRecordList
                                                  .toList()) !=
                                          '0',
                                      shape: BadgeShape.circle,
                                      badgeColor: Color(0xFFD05C5C),
                                      elevation: 4,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          7, 7, 7, 7),
                                      position: BadgePosition.topEnd(),
                                      animationType: BadgeAnimationType.scale,
                                      toAnimate: true,
                                      child: Icon(
                                        Manzel.notification,
                                        color: Colors.white,
                                        size: 26,
                                      ),
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, 0.75),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(14, 0, 14, 0),
                        child: InkWell(
                          onTap: () async {
                            videoPlayers[currentPropertyindex].pause();
                            logFirebaseEvent(
                                'HOME_SCREEN_PAGE_Text_iowqhltc_ON_TAP');
                            logFirebaseEvent('Text_Navigate-To');
                            context.pushNamed(
                              'WhereAreYouLooking',
                              queryParams: {
                                'homeScreenLength': serializeParam(
                                    videoPlayers.length ?? 0, ParamType.int)
                              }.withoutNulls,
                              extra: <String, dynamic>{
                                kTransitionInfoKey: TransitionInfo(
                                  hasTransition: true,
                                  transitionType:
                                      PageTransitionType.bottomToTop,
                                ),
                              },
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 54,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  color: Color(0x41000000),
                                  offset: Offset(0, 3),
                                )
                              ],
                              borderRadius: BorderRadius.circular(8),
                              shape: BoxShape.rectangle,
                            ),
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(23, 0, 12, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      'qnr0o42y' /* Where are you looking? */,
                                    ),
                                    textAlign: TextAlign.start,
                                    style:
                                        FlutterFlowTheme.of(context).bodyText1,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 10, 0),
                                        child: Container(
                                          width: 36,
                                          height: 36,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Color(0xFFF4F4F4),
                                              width: 1,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.map_outlined,
                                            color: Colors.black,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          videoPlayers[currentPropertyindex]
                                              .pause();
                                          logFirebaseEvent(
                                              'HOME_SCREEN_Container_13mjruev_ON_TAP');
                                          logFirebaseEvent(
                                              'Container_Navigate-To');
                                          context.pushNamed(
                                            'Filter',
                                            queryParams: {
                                              'homeScreenLength':
                                                  serializeParam(
                                                      videoPlayers.length ?? 0,
                                                      ParamType.int)
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType
                                                        .bottomToTop,
                                              ),
                                            },
                                          );
                                        },
                                        child: Container(
                                          width: 36,
                                          height: 36,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Color(0xFFF4F4F4),
                                              width: 1,
                                            ),
                                          ),
                                          child: Icon(
                                            Manzel.filter,
                                            color: Colors.black,
                                            size: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(15, 15, 16, 3),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.max,
              //     children: [
              //       Image.asset(
              //         'assets/images/Swap.png',
              //         width: 20,
              //         height: 20,
              //         fit: BoxFit.cover,
              //       ),
              //       Padding(
              //         padding: EdgeInsetsDirectional.fromSTEB(7, 0, 0, 0),
              //         child: Text(
              //           FFLocalizations.of(context).getText(
              //             'fei6w05f' /* Sort By */,
              //           ),
              //           style: FlutterFlowTheme.of(context).bodyText2.override(
              //                 fontFamily: 'AvenirArabic',
              //                 color: Colors.black,
              //                 fontWeight: FontWeight.w500,
              //                 useGoogleFonts: false,
              //               ),
              //         ),
              //       ),
              //       Padding(
              //         padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
              //         child: Container(
              //           width: 101,
              //           height: 30,
              //           decoration: BoxDecoration(
              //             color: Color(0x192971FB),
              //             borderRadius: BorderRadius.circular(100),
              //             border: Border.all(
              //               color: Color(0xFF2971FB),
              //               width: 1,
              //             ),
              //           ),
              //           child: Padding(
              //             padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
              //             child: Text(
              //               FFLocalizations.of(context).getText(
              //                 'jxwg61ha' /* Near to me */,
              //               ),
              //               textAlign: TextAlign.center,
              //               style:
              //                   FlutterFlowTheme.of(context).subtitle2.override(
              //                         fontFamily: 'AvenirArabic',
              //                         color: Color(0xFF2971FB),
              //                         fontSize: 13,
              //                         fontWeight: FontWeight.bold,
              //                         useGoogleFonts: false,
              //                       ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // FutureBuilder<ApiCallResponse>(
              //   future: PropertiesCall.call(
              //     city: FFAppState().filterCity,
              //     furnishingType: FFAppState().filterFurnishingType,
              //     propertyType: FFAppState().filterPropertyType,
              //   ),
              //   builder: (context, snapshot) {
              //     // Customize what your widget looks like when it's loading.
              //     if (!snapshot.hasData) {
              //       return Center(
              //         child: SizedBox(
              //           width: 50,
              //           height: 50,
              //           child: SpinKitRipple(
              //             color: Color(0xFF2971FB),
              //             size: 50,
              //           ),
              //         ),
              //       );
              //     }
              //  final listViewPropertiesResponse = snapshot.data;
              //   return Builder(
              //     builder: (context) {
              //       final properties = PropertiesCall.properties(
              //             (listViewPropertiesResponse?.jsonBody ?? ''),
              //           )?.toList() ??
              //           [];
              //       if (properties.isEmpty) {
              // return Center(
              // child: NoResultsFoundWidget(
              // titleText: 'No results found',
              // subtitleText: '     abc',
              // isBottonVisible: false,
              // screenName: 'Results',
              // ),
              // );
              // }
              //
              PagedListView<int, dynamic>(
                physics: NeverScrollableScrollPhysics(),
                pagingController: _pagingController,
                padding: EdgeInsets.zero,
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                builderDelegate: PagedChildBuilderDelegate<dynamic>(
                  itemBuilder: (context, propertiesItem, propertiesIndex) {
                    print('PROPERTIES INDEX >>>>>>>>>>>>>>$propertiesIndex');
                    Future.delayed(Duration(seconds: 2));
                    // ListView.builder(
                    // padding: EdgeInsets.zero,
                    // shrinkWrap: true,
                    // scrollDirection: Axis.vertical,
                    // itemCount: properties.length,
                    // itemBuilder: (context, propertiesIndex) {
                    //   final propertiesItem = properties[propertiesIndex];
                    //   return

                    // if (propertiesIndex == (videocontrollerMap.length) + 1) {
                    //   Future.delayed(const Duration(seconds: 8), () {
                    //     if (_currentController != null &&
                    //         videoControllerSet!.isNotEmpty) {
                    //       _currentController = videoControllerSet?.first;
                    //       _currentController?.play();
                    //     }
                    //   });
                    //}
                    return Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                      child: InkWell(
                        onTap: () async {
                          if (!functions.conditionalVisibility(
                              getJsonField(
                                propertiesItem,
                                r'''$.attributes.property_status''',
                              ).toString(),
                              'Soon')) {
                            videoPlayers[currentPropertyindex].pause();
                            logFirebaseEvent(
                                'HOME_SCREEN_PAGE_propertyCard_ON_TAP');
                            // propertyDetails
                            logFirebaseEvent('propertyCard_propertyDetails');
                            context.pushNamed(
                              'PropertyDetails',
                              queryParams: {
                                'propertyId': serializeParam(
                                    getJsonField(
                                      propertiesItem,
                                      r'''$.id''',
                                    ),
                                    ParamType.int),
                                'path': serializeParam(
                                    getJsonField(
                                      propertiesItem,
                                      r'''$.attributes.video_manifest_uri''',
                                    ),
                                    ParamType.String),
                              }.withoutNulls,
                            );
                          }
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Stack(
                                children: [
                                  if (functions
                                      .videoPlayerVisibilty(getJsonField(
                                    propertiesItem,
                                    r'''$.attributes.video_manifest_uri''',
                                  )))
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.95,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.4,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: VisibilityDetector(
                                          key: Key(propertiesIndex.toString()),
                                          onVisibilityChanged: (visibility) {
                                            if (visibility.visibleFraction *
                                                        100 ==
                                                    100 &&
                                                this.mounted) {
                                              if (!(videoPlayers[
                                                      propertiesIndex]
                                                  .value
                                                  .isInitialized)) {
                                                videoPlayers[propertiesIndex]
                                                    .initialize()
                                                    .then((value) {
                                                  isPaused = false;
                                                  isMuted.value
                                                      ? videoPlayers[
                                                              propertiesIndex]
                                                          .setVolume(0)
                                                      : videoPlayers[
                                                              propertiesIndex]
                                                          .setVolume(100);
                                                  currentPropertyindex =
                                                      propertiesIndex;
                                                  videoPlayers[propertiesIndex]
                                                      .play();
                                                  setState(() {
                                                    videoPlayers
                                                        .forEach((otherPlayer) {
                                                      if (otherPlayer !=
                                                          videoPlayers[
                                                              propertiesIndex]) {
                                                        if (otherPlayer.value
                                                            .isInitialized) {
                                                          otherPlayer
                                                              .setVolume(0.0);
                                                          otherPlayer.pause();
                                                          // var dataSource = otherPlayer.dataSource;
                                                          // otherPlayer.dispose();
                                                          // otherPlayer =
                                                          //     VideoPlayerController.network(dataSource);

                                                        } else {
                                                          otherPlayer
                                                              .initialize()
                                                              .then((value) =>
                                                                  otherPlayer
                                                                      .pause());
                                                          isPaused = false;
                                                          isMuted.value
                                                              ? videoPlayers[
                                                                      propertiesIndex]
                                                                  .setVolume(0)
                                                              : videoPlayers[
                                                                      propertiesIndex]
                                                                  .setVolume(
                                                                      100);
                                                          isPaused = false;
                                                          isMuted.value
                                                              ? videoPlayers[
                                                                      propertiesIndex]
                                                                  .setVolume(0)
                                                              : videoPlayers[
                                                                      propertiesIndex]
                                                                  .setVolume(
                                                                      100);
                                                        }
                                                      }
                                                    });
                                                    print(
                                                        'propertyindex - $propertiesIndex');
                                                  });
                                                  ;
                                                });

                                                print(
                                                    "propertiesIndex.toString() : ${propertiesIndex.toString()},visibility.visibleFraction*100 = ${visibility.visibleFraction * 100}");
                                                // Future.delayed(const Duration(
                                                //     seconds: 6), () {
                                                //   _currentController =
                                                //   videocontrollerMap[(propertiesIndex)
                                                //       .toString()];
                                                //   _currentController?.play();
                                                // });
                                                // setState(() {
                                                //   if (_currentController !=
                                                //       null) {
                                                //     _currentController =
                                                //         videocontrollerMap[
                                                //             (propertiesIndex)
                                                //                 .toString()];
                                                //     _currentController?.play();
                                                //     videoControllerSet!
                                                //         .forEach((otherPlayer) {
                                                //       if (otherPlayer !=
                                                //               _currentController &&
                                                //           otherPlayer
                                                //               .value.isPlaying) {
                                                //         setState(() {
                                                //           otherPlayer.pause();
                                                //         });
                                                //       }
                                                //     });
                                                //     print(
                                                //         "Object_Key : ${ObjectKey(FlutterFlowVideoPlayer).toString()}");
                                                //   }
                                                // });
                                              } else {
                                                isPaused = false;
                                                isMuted.value
                                                    ? videoPlayers[
                                                            propertiesIndex]
                                                        .setVolume(0)
                                                    : videoPlayers[
                                                            propertiesIndex]
                                                        .setVolume(100);
                                                videoPlayers[propertiesIndex]
                                                    .play();
                                                currentPropertyindex =
                                                    propertiesIndex;
                                                setState(() {
                                                  videoPlayers
                                                      .forEach((otherPlayer) {
                                                    if (otherPlayer !=
                                                        videoPlayers[
                                                            propertiesIndex]) {
                                                      if (otherPlayer.value
                                                          .isInitialized) {
                                                        otherPlayer
                                                            .setVolume(0.0);
                                                        otherPlayer.pause();
                                                        // var dataSource = otherPlayer.dataSource;
                                                        // otherPlayer.dispose();
                                                        // otherPlayer =
                                                        //     VideoPlayerController.network(dataSource);

                                                      }
                                                    }
                                                  });
                                                });
                                              }
                                              //autoplayVal = false;
                                            }
                                            //onVisibilityChanged: (visibilityInfo) {
                                            // var visiblePercentage =
                                            //     visibilityInfo.visibleFraction *
                                            //         100;
                                            // debugPrint(
                                            //     'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible');
                                          },

                                          //child: InkWell(
                                          // onTap: () {
                                          //   isMuted?isMuted = false:isMuted = true;
                                          //   isMutedIcon.value = true;
                                          //   ValueListenableBuilder<bool>(
                                          //     builder: (BuildContext context,
                                          //         bool value, Widget? child) {
                                          //       return Align(
                                          //         alignment :,
                                          //         Container(
                                          //         height: 50,
                                          //         width: 50,
                                          //         decoration: BoxDecoration(
                                          //           color: isMutedIcon.value
                                          //               ? Colors.black
                                          //                   .withOpacity(0.5)
                                          //               : Colors.black
                                          //                   .withOpacity(0.0),
                                          //           shape: BoxShape.circle,
                                          //         ),
                                          //         child: Icon(
                                          //           Icons.volume_mute_rounded,
                                          //           color: isMutedIcon.value
                                          //               ? Colors.white
                                          //                   .withOpacity(1.0)
                                          //               : Colors.black
                                          //                   .withOpacity(0.0),
                                          //           size: 40,
                                          //         ),
                                          //       ),);
                                          //     },
                                          //     valueListenable: isMutedIcon,
                                          //   );
                                          //   Future.delayed(
                                          //           Duration(seconds: 2))
                                          //       .then((value) {
                                          //     isMutedIcon.value = false;
                                          //   });
                                          //
                                          // },
                                          child: FlutterFlowVideoPlayer(
                                            // videoControllerSet =
                                            //     videoControllerValue;
                                            //
                                            // print(
                                            //     "videoControllerSet : ${videoControllerSet}");
                                            // print(
                                            //     "videoControllerSet_items : ${videoControllerSet?.length}");
                                            // //print("videoControllerSet.last :  ${videoControllerSet.last}");
                                            // //print("propertiesIndex : ${propertiesIndex.toString()}");
                                            // //print("videocontrollerMap : ${videocontrollerMap.length}");
                                            // videocontrollerMap[propertiesIndex
                                            //         .toString()] =
                                            //     videoControllerSet!.last;
                                            // print(
                                            //     "videocontrollerMap : ${videocontrollerMap.length}");
                                            // _currentController =
                                            //     videocontrollerMap['0'];
                                            //

                                            path: getJsonField(
                                              propertiesItem,
                                              r'''$.attributes.video_manifest_uri''',
                                            ),
                                            videoType: VideoType.network,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                95,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.8,
                                            aspectRatio: 1.7,
                                            autoPlay: false,
                                            looping: true,
                                            showControls: false,
                                            allowFullScreen: true,
                                            allowPlaybackSpeedMenu: false,
                                          ),
                                        ),
                                        //),
                                      ),
                                    ),
                                  //),
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: InkWell(
                                      onTap: () {
                                        //print("pause value>>>>>>>>>>>>> $isPaused");
                                        isPaused = isPaused ? false : true;

                                        isPaused
                                            ? videoPlayers[propertiesIndex]
                                                .pause()
                                            : videoPlayers[propertiesIndex]
                                                .play();
                                        setState(() {});
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        // color: Colors.transparent,
                                        // child: ValueListenableBuilder(
                                        //   builder: (BuildContext context,
                                        //       bool value, Widget? child) {
                                        //     return
                                        child: Center(
                                          child: Container(
                                            //margin: EdgeInsets.all(100),

                                            constraints: BoxConstraints(
                                                minWidth: 50, maxWidth: 50),
                                            decoration: BoxDecoration(
                                              color: isPaused
                                                  ? Colors.black
                                                      .withOpacity(1.0)
                                                  : Colors.black
                                                      .withOpacity(0.0),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              isPaused
                                                  ? Icons.play_arrow_rounded
                                                  : Icons.pause,
                                              color: isPaused
                                                  ? Colors.white
                                                      .withOpacity(1.0)
                                                  : Colors.white
                                                      .withOpacity(0.0),
                                              size: 40,
                                            ),
                                            // );
                                            //},
                                            //valueListenable: isPaused,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if((videoPlayers??[]).length>=1)
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: ((propertiesIndex) ==
                                                (currentPropertyindex))
                                        ? Container()
                                        :  Container(
                                                //margin: EdgeInsets.all(100),

                                                constraints: BoxConstraints(
                                                    minWidth: 50, maxWidth: 50),
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(1.0),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.play_arrow_rounded,
                                                  color: Colors.white
                                                      .withOpacity(1.0),
                                                  size: 40,
                                                ),
                                              )
                                           ,
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.9, 0.8),
                                    child: InkWell(
                                      child: ValueListenableBuilder(
                                        builder: (BuildContext context,
                                            bool value, Widget? child) {
                                          return Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              isMuted.value
                                                  ? Icons.volume_off_rounded
                                                  : Icons.volume_up_rounded,
                                              color:
                                                  Colors.white.withOpacity(1.0),
                                              size: 20,
                                            ),
                                          );
                                        },
                                        valueListenable: isMuted,
                                      ),
                                      onTap: () {
                                        if (videoPlayers[propertiesIndex] !=
                                            null) {
                                          if (videoPlayers[propertiesIndex]
                                                  .value
                                                  .volume >
                                              0) {
                                            videoPlayers[propertiesIndex]
                                                .setVolume(0);
                                            isMuted.value = true;
                                          } else {
                                            videoPlayers[propertiesIndex]
                                                .setVolume(100);
                                            isMuted.value = false;
                                          }
                                          //   setState(() {

                                          //     Future.delayed(
                                          //             Duration(seconds: 3))
                                          //         .then((value) {
                                          //       isMutedIcon.value = false;
                                          //       setState(() {});
                                          //     });
                                          //   });
                                          // } else {
                                          //   videoPlayers[propertiesIndex]
                                          //       ?.setVolume(100);
                                          //   setState(() {
                                          //     isMuted = false;
                                          //     Future.delayed(
                                          //             Duration(seconds: 3))
                                          //         .then((value) {
                                          //       isMutedIcon.value = false;
                                          //       setState(() {});
                                          //     });
                                          //   });
                                          // }
                                        }
                                      },
                                    ),
                                  ),
                                  if (!functions
                                      .videoPlayerVisibilty(getJsonField(
                                    propertiesItem,
                                    r'''$.attributes.video_manifest_uri''',
                                  )))
                                    Builder(
                                      builder: (context) {
                                        final propertyImages = getJsonField(
                                          propertiesItem,
                                          r'''$..property_images.data''',
                                        ).toList();

                                        return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          child: Stack(
                                            children: [
                                              PageView.builder(
                                                controller:
                                                    pageViewController ??=
                                                        PageController(
                                                            initialPage: min(
                                                                0,
                                                                propertyImages
                                                                        .length -
                                                                    1)),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    propertyImages.length,
                                                itemBuilder: (context,
                                                    propertyImagesIndex) {
                                                  final propertyImagesItem =
                                                      propertyImages[
                                                          propertyImagesIndex];
                                                  return Visibility(
                                                    visible: !functions
                                                        .videoPlayerVisibilty(
                                                            getJsonField(
                                                      propertyImagesItem,
                                                      r'''$.attributes.video_manifest_uri''',
                                                    )),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: CachedNetworkImage(
                                                        imageUrl: getJsonField(
                                                          propertyImagesItem,
                                                          r'''$.attributes.url''',
                                                        ),
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.3,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0, 0.7),
                                                child: SmoothPageIndicator(
                                                  controller:
                                                      pageViewController ??=
                                                          PageController(
                                                              initialPage: min(
                                                                  0,
                                                                  propertyImages
                                                                          .length -
                                                                      1)),
                                                  count: propertyImages.length,
                                                  axisDirection:
                                                      Axis.horizontal,
                                                  onDotClicked: (i) {
                                                    pageViewController!
                                                        .animateToPage(
                                                      i,
                                                      duration: Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.ease,
                                                    );
                                                  },
                                                  effect: SlideEffect(
                                                    spacing: 8,
                                                    radius: 3,
                                                    dotWidth: 6,
                                                    dotHeight: 6,
                                                    dotColor: Color(0x80FFFFFF),
                                                    activeDotColor:
                                                        Colors.white,
                                                    paintStyle:
                                                        PaintingStyle.fill,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  Align(
                                    alignment: AlignmentDirectional(1, -0.95),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 12, 15, 0),
                                      child: InkWell(
                                        onTap: () async {
                                          logFirebaseEvent(
                                              'HOME_SCREEN_Container_jprwonvd_ON_TAP');
                                          if (loggedIn) {
                                            logFirebaseEvent(
                                                'Container_Backend-Call');
                                            await BookmarkPropertyCall.call(
                                              userId: currentUserUid,
                                              propertyId:
                                                  valueOrDefault<String>(
                                                getJsonField(
                                                  propertiesItem,
                                                  r'''$.id''',
                                                ).toString(),
                                                '0',
                                              ),
                                            );
                                          } else {
                                            videoPlayers[propertiesIndex]
                                                .pause();
                                            logFirebaseEvent(
                                                'Container_Navigate-To');
                                            context.pushNamed('Login');
                                          }
                                        },
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Color(0x4D000000),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Manzel.favorite,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(-0.9, 1),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 18, 18),
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Color(0x80F3F1F1),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Color(0x80F3F1F1),
                                            width: 2,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Image.network(
                                            getJsonField(
                                              propertiesItem,
                                              r'''$.attributes.managed_by.data.attributes.company_logo.data.attributes.url''',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // if (functions.conditionalVisibility(
                                  //     getJsonField(
                                  //       propertiesItem,
                                  //       r'''$.attributes.property_status''',
                                  //     ).toString(),
                                  //     'Available'))
                                  //   Align(
                                  //     alignment:
                                  //         AlignmentDirectional(-0.9, -0.89),
                                  //     child: Container(
                                  //       width: 80,
                                  //       height: 26,
                                  //       decoration: BoxDecoration(
                                  //         color: Color(0xFF81D05C),
                                  //         borderRadius:
                                  //             BorderRadius.circular(7),
                                  //       ),
                                  //       child: Row(
                                  //         mainAxisSize: MainAxisSize.max,
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.center,
                                  //         children: [
                                  //           Padding(
                                  //             padding: EdgeInsetsDirectional
                                  //                 .fromSTEB(10, 1, 10, 1),
                                  //             child: Text(
                                  //               FFLocalizations.of(context)
                                  //                   .getText(
                                  //                 '2cud1oqj' /* Available */,
                                  //               ),
                                  //               style:
                                  //                   FlutterFlowTheme.of(context)
                                  //                       .bodyText1
                                  //                       .override(
                                  //                         fontFamily:
                                  //                             'AvenirArabic',
                                  //                         color: FlutterFlowTheme
                                  //                                 .of(context)
                                  //                             .white,
                                  //                         fontSize: 13,
                                  //                         fontWeight:
                                  //                             FontWeight.w500,
                                  //                         useGoogleFonts: false,
                                  //                       ),
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  if (functions.conditionalVisibility(
                                      getJsonField(
                                        propertiesItem,
                                        r'''$.attributes.property_status''',
                                      ).toString(),
                                      'Booked'))
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-0.9, -0.89),
                                      child: Container(
                                        width: 80,
                                        height: 26,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFD7D7D7),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 1, 10, 1),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'qtso45vv' /* Booked */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'AvenirArabic',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .white,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts: false,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  if (functions.conditionalVisibility(
                                      getJsonField(
                                        propertiesItem,
                                        r'''$.attributes.property_status''',
                                      ).toString(),
                                      'Soon'))
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-0.9, -0.89),
                                      child: Container(
                                        width: 80,
                                        height: 26,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF2971FB),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 1, 10, 1),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'juw40663' /* Coming soon */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'AvenirArabic',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .white,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(4, 14, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    getJsonField(
                                      propertiesItem,
                                      r'''$.attributes.property_name''',
                                    ).toString(),
                                    maxLines: 1,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'AvenirArabic',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          useGoogleFonts: false,
                                        ),
                                  ),
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      'etpebw43' /* Approved Banks */,
                                    ),
                                    textAlign: TextAlign.end,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'AvenirArabic',
                                          color: Color(0xFF474747),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          useGoogleFonts: false,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(4, 1, 0, 14),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Manzel.location_pin,
                                        color: Color(0xFF130F26),
                                        size: 11,
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 0, 0, 0),
                                        child: Text(
                                          getJsonField(
                                            propertiesItem,
                                            r'''$..attributes.city.data.attributes.city_name''',
                                          ).toString(),
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
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            3, 0, 3, 0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'efcxmcgl' /* ,  */,
                                          ),
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
                                      Text(
                                        getJsonField(
                                          propertiesItem,
                                          r'''$..property_district''',
                                        ).toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'AvenirArabic',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300,
                                              useGoogleFonts: false,
                                            ),
                                      ),
                                    ],
                                  ),
                                  // Generated code for this Row Widget...
                                  Builder(
                                    builder: (context) {
                                      final banks = getJsonField(
                                        propertiesItem,
                                        r'''$.attributes.banks.data''',
                                      ).toList();
                                      return Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: List.generate(banks.length,
                                            (banksIndex) {
                                          final banksItem = banks[banksIndex];
                                          return Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 2, 0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Color(0xFF8C8C8C),
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(11),
                                                child: Image.network(
                                                  getJsonField(
                                                    banksItem,
                                                    r'''$.attributes.bank_logo.data.attributes.url''',
                                                  ),
                                                  width: 22,
                                                  height: 22,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      '998is2ya' /* Installment starting from */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .title3
                                        .override(
                                          fontFamily: 'Sofia Pro By Khuzaimah',
                                          color: Color(0xFF2971FB),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          useGoogleFonts: false,
                                        ),
                                  ),
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      'gqe4w739' /* Total property price */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText2
                                        .override(
                                          fontFamily: 'AvenirArabic',
                                          color: Color(0xFF474747),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          useGoogleFonts: false,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(4, 1, 0, 20),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        valueOrDefault<String>(
                                          functions.formatAmount(getJsonField(
                                            propertiesItem,
                                            r'''$.attributes.property_initial_installment''',
                                          ).toString()),
                                          '0',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily:
                                                  'Sofia Pro By Khuzaimah',
                                              color: Color(0xFF2971FB),
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              useGoogleFonts: false,
                                            ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5, 10, 0, 0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'l38if619' /*  SAR/Monthly */,
                                          ),
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'AvenirArabic',
                                                color: Color(0xFF2971FB),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 3, 0),
                                        child: Text(
                                          valueOrDefault<String>(
                                            functions
                                                .formatAmountWithoutDecimal(
                                                    valueOrDefault<String>(
                                              getJsonField(
                                                propertiesItem,
                                                r'''$..property_price''',
                                              ).toString(),
                                              '0',
                                            )),
                                            '0',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText2
                                              .override(
                                                fontFamily: 'AvenirArabic',
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'dhoik8q5' /*  SAR */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText2
                                            .override(
                                              fontFamily: 'AvenirArabic',
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              useGoogleFonts: false,
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
                          ],
                        ),
                      ),
                      //),
                      //  },

                      // );
                      //  },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future waitForApiRequestCompleter({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = _apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
