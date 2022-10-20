import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:go_sell_sdk_flutter/go_sell_sdk_flutter.dart';
import 'package:manzel/common_widgets/manzel_icons.dart';
import 'package:manzel/edit_personall_info/edit_personall_info_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:manzel/profile/profile_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import '../auth/auth_util.dart';
import '../auth/firebase_user_provider.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../common_widgets/overlay.dart';
import '../components/bank_details_bottom_sheet_widget.dart';
import '../components/reservation_bottom_sheet_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_static_map.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/lat_lng.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart' as material;
import 'package:map_launcher/map_launcher.dart' as $ml;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

enum VideoType {
  asset,
  network,
}

// Set<VideoPlayerController> _videoPlayers = Set();

class PropertyDetailsWidget extends StatefulWidget {
  const PropertyDetailsWidget({
    Key? key,
    this.propertyId,
    this.path,
    this.jsonData,
  }) : super(key: key);

  final int? propertyId;
  final String? path;
  final dynamic? jsonData;

  @override
  _PropertyDetailsWidgetState createState() => _PropertyDetailsWidgetState();
}

class _PropertyDetailsWidgetState extends State<PropertyDetailsWidget> {
  PageController? pageViewController;
  UserSavedRecord? saveProperty;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static const String kWhatsAppAndroid = 'https://api.whatsapp.com/send?phone=';
  static const String kWhatsAppIOS = 'https://wa.me/';
  ApiCallResponse? addOrderApiResponse;
  var columnPropertyResponse;

  late ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);

  // VideoPlayerController? _currentController;
  // VideoPlayerController? videoPlayerController;
  // VideoPlayerController? _videoPlayerController;
  // ChewieController? _chewieController;
  // bool _loggedError = false;

  @override
  void initState() {
    super.initState();
    //initializePlayer();
    if (widget?.jsonData != null) {
      isLoading.value = true;
      columnPropertyResponse = widget.jsonData;
      isLoading.value = false;
    } else {
      makeProeprtyApiCall();

    }
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'PropertyDetails'});
  }

  Future<void> makeProeprtyApiCall() async {
    isLoading.value = true;
    //Future.delayed(Duration(seconds: 5));
    final callResult = await PropertyCall.call(
      propertyId: widget.propertyId,
      locale: FFAppState().locale,
    );
    final callResultToJson = callResult.jsonBody['data'];
    columnPropertyResponse = callResultToJson;
    print("++++");
    isLoading.value = false;
  }

  // void enterFullScreen() {
  //   _chewieController?.enterFullScreen();
  // }
  // @override
  // void dispose() {
  //   _videoPlayers.remove(_videoPlayerController);
  //   _videoPlayerController?.dispose();
  //   _chewieController?.dispose();
  //   _currentController = null;
  //   super.dispose();
  // }
  //
  //
  // Future initializePlayer() async {
  //
  //   _videoPlayerController = VideoPlayerController.network(widget.path!);
  //
  //     await _videoPlayerController?.initialize();
  //   _chewieController = ChewieController(
  //     videoPlayerController: _videoPlayerController!,
  //     deviceOrientationsOnEnterFullScreen: [
  //       DeviceOrientation.landscapeLeft,
  //       DeviceOrientation.landscapeRight,
  //     ],
  //     deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
  //     aspectRatio: MediaQuery.of(context).size.width/(MediaQuery.of(context).size.height*0.35),
  //     autoPlay: true,
  //     looping: true,
  //     showControls: true,
  //     allowFullScreen: true,
  //     allowPlaybackSpeedChanging: false,
  //
  //   );
  //   setState(() {});
  //
  //  _videoPlayers.add(_videoPlayerController!);
  //
  //   _videoPlayerController?.addListener(() {
  //     if (_videoPlayerController!.value.hasError && !_loggedError) {
  //       print(
  //           'Error playing video: ${_videoPlayerController!.value.errorDescription}');
  //       _loggedError = true;
  //     }
  //Stop all other players when one video is playing.
  // if (_videoPlayerController.value.isPlaying) {
  //   _videoPlayers.forEach((otherPlayer) {
  //     if (otherPlayer != _videoPlayerController &&
  //         otherPlayer.value.isPlaying) {
  //       setState(() {
  //         otherPlayer.pause();
  //
  //       });
  //      }
  //    });
  // }
  //});}

  Future<void> configurePaymentSdk() async {
    GoSellSdkFlutter.configureApp(
      bundleId: 'com.flutterflow.manzel',
      productionSecreteKey: 'sk_live_o4Z3j8HafuOCG9PNJ1eVrvsz',
      sandBoxsecretKey: 'sk_test_2r5JvPVafKxklSn6LRpqWycQ',
      lang: FFAppState().locale,
    );
  }

   @override
  void dispose() {
    pageViewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: GestureDetector(
        // onTap: () => FocusScope.of(context).unfocus(),
        // child: FutureBuilder<ApiCallResponse>(
        //   future: PropertyCall.call(
        //     propertyId: widget.propertyId,
        //     locale: FFAppState().locale,
        //   ),
        child: ValueListenableBuilder<bool>(
          builder: (BuildContext context, bool value, Widget? child) {
            return isLoading.value
                ? Center(
                  child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              // valueColor: AlwaysStoppedAnimation(Colors.black),
                              // strokeWidth: 5,
                            ),
                          )
                        ],
                      ),
                    ),
                )
                : Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    child: Stack(
                                      children: [
                                        if (!functions
                                            .videoPlayerVisibilty(getJsonField(
                                          columnPropertyResponse,
                                          r'''$.attributes.video_poster_image''',
                                        )))
                                          Builder(
                                            builder: (context) {
                                              final images =
                                                  PropertyCall.propertyImages(
                                                columnPropertyResponse,
                                              ).toList();
                                              return Container(
                                                width: double.infinity,
                                                height: 300,
                                                child: Stack(
                                                  children: [
                                                    PageView.builder(
                                                      controller:
                                                          pageViewController ??=
                                                              PageController(
                                                                  initialPage: min(
                                                                      0,
                                                                      images.length -
                                                                          1)),
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: images.length,
                                                      itemBuilder: (context,
                                                          imagesIndex) {
                                                        final imagesItem =
                                                            images[imagesIndex];
                                                        return CachedNetworkImage(
                                                          imageUrl:
                                                              getJsonField(
                                                            imagesItem,
                                                            r'''$.attributes.formats.medium.url''',
                                                          ),
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              double.infinity,
                                                          fit: BoxFit.cover,
                                                        );
                                                      },
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, 0.9),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(0, 0,
                                                                    0, 10),
                                                        child:
                                                            SmoothPageIndicator(
                                                          controller: pageViewController ??=
                                                              PageController(
                                                                  initialPage: min(
                                                                      0,
                                                                      images.length -
                                                                          1)),
                                                          count: images.length,
                                                          axisDirection:
                                                              Axis.horizontal,
                                                          onDotClicked: (i) {
                                                            pageViewController!
                                                                .animateToPage(
                                                              i,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      500),
                                                              curve:
                                                                  Curves.ease,
                                                            );
                                                          },
                                                          effect: SlideEffect(
                                                            spacing: 8,
                                                            radius: 16,
                                                            dotWidth: 6,
                                                            dotHeight: 6,
                                                            dotColor: Color(
                                                                0xFF9E9E9E),
                                                            activeDotColor:
                                                                Colors.white,
                                                            paintStyle:
                                                                PaintingStyle
                                                                    .fill,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),

                                        InkWell(
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'PROPERTY_DETAILS_Image_8m4roe7z_ON_TAP');
                                            logFirebaseEvent(
                                                'Image_Navigate-To');

                                            context.pushNamed(
                                              'propertyVideo',
                                              queryParams: {
                                                'videoURL': serializeParam(
                                                    getJsonField(
                                                      columnPropertyResponse,
                                                      r'''$.attributes.video_manifest_uri''',
                                                    ),
                                                    ParamType.String),
                                                'propertyName': serializeParam(
                                                    PropertyCall.propertyName(
                                                      columnPropertyResponse,
                                                    ).toString(),
                                                    ParamType.String),
                                              }.withoutNulls,
                                            );
                                          },
                                          child: Image.network(
                                            getJsonField(
                                              columnPropertyResponse,
                                              r'''$.attributes.video_poster_image''',
                                            ),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.35,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        if (functions
                                            .videoPlayerVisibilty(getJsonField(
                                          columnPropertyResponse,
                                          r'''$.attributes.video_poster_image''',
                                        )))
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: InkWell(
                                              onTap: () async {
                                                logFirebaseEvent(
                                                    'PROPERTY_DETAILS_Image_8m4roe7z_ON_TAP');
                                                logFirebaseEvent(
                                                    'Image_Navigate-To');

                                                context.pushNamed(
                                                  'propertyVideo',
                                                  queryParams: {
                                                    'videoURL': serializeParam(
                                                        getJsonField(
                                                          columnPropertyResponse,
                                                          r'''$.attributes.video_manifest_uri''',
                                                        ),
                                                        ParamType.String),
                                                    'propertyName':
                                                        serializeParam(
                                                            PropertyCall
                                                                .propertyName(
                                                              columnPropertyResponse,
                                                            ).toString(),
                                                            ParamType.String),
                                                  }.withoutNulls,
                                                );
                                              },
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(1),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.play_arrow_rounded,
                                                  color: Colors.white
                                                      .withOpacity(1.0),
                                                  size: 40,
                                                ),
                                              ),
                                            ),
                                          ),

                                        //                               InkWell(
                                        //                                 child: Container(
                                        //                                   width: MediaQuery.of(context).size.width,
                                        //                                   height:
                                        //                                       MediaQuery.of(context).size.height,
                                        //                                   decoration: BoxDecoration(),
                                        //                                   child: Visibility(
                                        //                                     visible: functions
                                        //                                         .videoPlayerVisibilty(getJsonField(
                                        //                                       columnPropertyResponse,
                                        //                                       r'''$.attributes.video_manifest_uri''',
                                        //                                     )),
                                        //                                     child: Align(
                                        //                                       alignment: Alignment.topRight,
                                        //
                                        //
                                        // child: VisibilityDetector(
                                        // key: ObjectKey(Chewie),
                                        // onVisibilityChanged: (visibility) {
                                        // if (visibility.visibleFraction *
                                        // 100 != 100 && this.mounted) {
                                        //   if(_chewieController!=null){
                                        // _chewieController?.pause();}}else{if(_chewieController!=null){_chewieController?.play();}}
                                        //
                                        // },
                                        //
                                        //
                                        //
                                        // //         child: FlutterFlowVideoPlayer(
                                        // // onTap: (videoControllerValue) {
                                        // //         print("detail_screen controller set length  = ${videoControllerValue.length}");
                                        // //         _currentController = videoControllerValue.last;
                                        // //         },
                                        // //                                         path: getJsonField(
                                        // //                                           columnPropertyResponse,
                                        // //                                           r'''$.attributes.video_manifest_uri''',
                                        // //                                         ),
                                        // //           height: MediaQuery.of(context).size.width/1.7777,
                                        // //           width: MediaQuery.of(context)
                                        // //               .size.width,
                                        // //                                         videoType: VideoType.network,
                                        // //                                         autoPlay: true,
                                        // //                                         looping: true,
                                        // //                                         showControls: false,
                                        // //                                         //aspectRatio:  (MediaQuery.of(context).size.height*0.74 /MediaQuery.of(context).size.width),
                                        // //                                         allowFullScreen: true,
                                        // //                                         allowPlaybackSpeedMenu: false,
                                        // //                                       ),
                                        //  child: FittedBox(
                                        //         fit: BoxFit.fitWidth,
                                        //         child: Container(
                                        //         height: MediaQuery.of(context)
                                        //                        .size.height*0.35,
                                        //         width: MediaQuery.of(context)
                                        //                        .size.width,
                                        //           // child: Theme(
                                        //           //   data: ThemeData.light().copyWith(
                                        //           //     platform: TargetPlatform.android,
                                        //           //   ),
                                        //             child:(_chewieController != null &&
                                        //       _chewieController!
                                        //               .videoPlayerController.value.isInitialized)
                                        //       ? Chewie(controller: _chewieController!)
                                        //       : (_chewieController != null &&
                                        //       _chewieController!.videoPlayerController.value.hasError)
                                        //       ? Text('Error playing video')
                                        //       : Column(
                                        //     mainAxisAlignment: MainAxisAlignment.center,
                                        //     children:  [
                                        //       Container(
                                        //           height: 20,
                                        //           width: 20,
                                        //           child: CircularProgressIndicator()),
                                        //       SizedBox(height: 20),
                                        //       Text('Loading'),
                                        //     ],
                                        //   ),),
                                        //
                                        // ),),),
                                        //         //),
                                        //
                                        //         //),
                                        //         ),
                                        //
                                        //
                                        //                                 ),
                                        //                           onTap: () {
                                        //                                  //_chewieController.enterFullScreen();
                                        //                                  _chewieController?.toggleFullScreen();
                                        //                                  // _currentController.enterFullScreen();
                                        //                                 },
                                        //                               ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  18, 52, 18, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              RotatedBox(
                                                quarterTurns:
                                                    FFAppState().locale == 'en'
                                                        ? 0
                                                        : 2,
                                                child: FlutterFlowIconButton(
                                                  borderColor:
                                                      Colors.transparent,
                                                  borderRadius: 30,
                                                  buttonSize: 34,
                                                  fillColor: Colors.white,
                                                  icon: Icon(
                                                    Manzel.back_icon,
                                                    color: Colors.black,
                                                    size: 12,
                                                  ),
                                                  onPressed: () async {
                                                    logFirebaseEvent(
                                                        'PROPERTY_DETAILS_arrow_back_rounded_ICN_');
                                                    // back
                                                    logFirebaseEvent(
                                                        'IconButton_back');
                                                  //  dispose();
                                                    context.pop();
                                                  },
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 16, 0),
                                                    child:
                                                        FlutterFlowIconButton(
                                                      borderColor:
                                                          Colors.transparent,
                                                      borderRadius: 30,
                                                      buttonSize: 34,
                                                      fillColor: Colors.white,
                                                      icon: Icon(
                                                        Manzel.share,
                                                        color: Colors.black,
                                                        size: 14,
                                                      ),
                                                      onPressed: () async {
                                                        logFirebaseEvent(
                                                            'PROPERTY_DETAILS_PAGE_share_ON_TAP');
                                                        // shareProperty
                                                        logFirebaseEvent(
                                                            'share_shareProperty');

                                                        await Share.share(await generateDynamicLink({
                                                          'propertyId':
                                                              widget.propertyId,
                                                        },
                                                            description:
                                                                PropertyCall
                                                                    .propertyName(
                                                              columnPropertyResponse,
                                                            ).toString(),
                                                            thumbnailUrl: PropertyCall
                                                                .thumbnailImage(
                                                                    columnPropertyResponse)));
                                                      },
                                                    ),
                                                  ),
                                                  Stack(
                                                    children: [
                                                      // FlutterFlowIconButton(
                                                      //   borderColor:
                                                      //       Colors.transparent,
                                                      //   borderRadius: 30,
                                                      //   borderWidth: 1,
                                                      //   buttonSize: 34,
                                                      //   fillColor: Colors.white,
                                                      //   icon: Icon(
                                                      //     Manzel.favorite,
                                                      //     color: FlutterFlowTheme
                                                      //             .of(context)
                                                      //         .alternate,
                                                      //     size: 18,
                                                      //   ),
                                                      //   onPressed: () {
                                                      //     print(
                                                      //         'BookMarkedIconButton pressed ...');
                                                      //   },
                                                      // ),
                                                      // FlutterFlowIconButton(
                                                      //   borderColor:
                                                      //       Colors.transparent,
                                                      //   borderRadius: 30,
                                                      //   buttonSize: 34,
                                                      //   fillColor: Colors.white,
                                                      //   icon: Icon(
                                                      //     Manzel.favorite,
                                                      //     color: Colors.black,
                                                      //     size: 18,
                                                      //   ),
                                                      //   onPressed: () async {
                                                      //     logFirebaseEvent(
                                                      //         'PROPERTY_DETAILS_favorite_border_ICN_ON_');
                                                      //     // save
                                                      //     logFirebaseEvent(
                                                      //         'IconButton_save');
                                                      //
                                                      //     final userSavedCreateData =
                                                      //         createUserSavedRecordData(
                                                      //       uId:
                                                      //           currentUserReference,
                                                      //       pId: widget
                                                      //           .propertyId,
                                                      //     );
                                                      //     var userSavedRecordReference =
                                                      //         UserSavedRecord
                                                      //             .collection
                                                      //             .doc();
                                                      //     await userSavedRecordReference
                                                      //         .set(
                                                      //             userSavedCreateData);
                                                      //     saveProperty = UserSavedRecord
                                                      //         .getDocumentFromData(
                                                      //             userSavedCreateData,
                                                      //             userSavedRecordReference);
                                                      //
                                                      //     setState(() {});
                                                      //   },
                                                      // ),
                                                      Container(
                                                        height: 35,
                                                        width: 35,
                                                        decoration:
                                                            BoxDecoration(

                                                                color: Colors
                                                                    .white,
                                                                shape: BoxShape
                                                                    .circle),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(2,
                                                                      5, 2, 5),
                                                          child: Icon(
                                                            Manzel.favorite,
                                                            color: Colors.black,
                                                            size: 18,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0,
                                          MediaQuery.of(context).size.height *
                                              0.33,
                                          0,
                                          0),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0),
                                            topLeft: Radius.circular(17),
                                            topRight: Radius.circular(17),
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 16),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(16,
                                                                    20, 16, 0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          5),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            3,
                                                                            0),
                                                                    child: Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'ak0ss5un' /* Updated:  */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText1
                                                                          .override(
                                                                            fontFamily:
                                                                                'AvenirArabic',
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w300,
                                                                            useGoogleFonts:
                                                                                false,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    PropertyCall
                                                                        .propertyUpdatedAt(
                                                                      columnPropertyResponse,
                                                                    ).toString(),
                                                                    maxLines: 2,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'AvenirArabic',
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          useGoogleFonts:
                                                                              false,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          12,
                                                                          0),
                                                                  child: Text(
                                                                    functions.orderIdFormatter(
                                                                        PropertyCall
                                                                            .propertyRef(
                                                                      columnPropertyResponse,
                                                                    ).toString()),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Sofia Pro By Khuzaimah',
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          useGoogleFonts:
                                                                              false,
                                                                        ),
                                                                  ),
                                                                ),
                                                                // if (functions
                                                                //     .propertyStatusConditionalVisibilty(
                                                                //         PropertyCall
                                                                //             .propertyStatus(
                                                                //   columnPropertyResponse
                                                                //       ,
                                                                // ).toString()))
                                                                //   Container(
                                                                //     height: 26,
                                                                //     decoration:
                                                                //         BoxDecoration(
                                                                //       color: FlutterFlowTheme.of(context).secondaryGreen
                                                                //           ,
                                                                //       borderRadius:
                                                                //           BorderRadius
                                                                //               .circular(
                                                                //                   7),
                                                                //     ),
                                                                //     child: Row(
                                                                //       mainAxisSize:
                                                                //           MainAxisSize
                                                                //               .max,
                                                                //       mainAxisAlignment:
                                                                //           MainAxisAlignment
                                                                //               .center,
                                                                //       children: [
                                                                //         Padding(
                                                                //           padding: EdgeInsetsDirectional
                                                                //               .fromSTEB(
                                                                //                   10,
                                                                //                   1,
                                                                //                   10,
                                                                //                   1),
                                                                //           child: Text(
                                                                //             FFLocalizations.of(
                                                                //                     context)
                                                                //                 .getText(
                                                                //               'ccsmgbaf' /* Available */,
                                                                //             ),
                                                                //             style: FlutterFlowTheme.of(
                                                                //                     context)
                                                                //                 .bodyText1
                                                                //                 .override(
                                                                //                   fontFamily:
                                                                //                       'AvenirArabic',
                                                                //                   color:
                                                                //                       FlutterFlowTheme.of(context).white,
                                                                //                   fontSize:
                                                                //                       13,
                                                                //                   fontWeight:
                                                                //                       FontWeight.w500,
                                                                //                   useGoogleFonts:
                                                                //                       false,
                                                                //                 ),
                                                                //           ),
                                                                //          ),
                                                                //       ],
                                                                //     ),
                                                                //  ),
                                                                // if (!functions
                                                                //     .propertyStatusConditionalVisibilty(
                                                                //         PropertyCall
                                                                //             .propertyStatus(
                                                                //   columnPropertyResponse
                                                                //       ,
                                                                // ).toString()))
                                                                //   Container(
                                                                //     height: 26,
                                                                //     decoration:
                                                                //         BoxDecoration(
                                                                //       color: Color(
                                                                //           0xFFD7D7D7),
                                                                //       borderRadius:
                                                                //           BorderRadius
                                                                //               .circular(
                                                                //                   7),
                                                                //     ),
                                                                //     child: Row(
                                                                //       mainAxisSize:
                                                                //           MainAxisSize
                                                                //               .max,
                                                                //       mainAxisAlignment:
                                                                //           MainAxisAlignment
                                                                //               .center,
                                                                //       children: [
                                                                //         Padding(
                                                                //           padding: EdgeInsetsDirectional
                                                                //               .fromSTEB(
                                                                //                   10,
                                                                //                   1,
                                                                //                   10,
                                                                //                   1),
                                                                //           child: Text(
                                                                //             FFLocalizations.of(
                                                                //                     context)
                                                                //                 .getText(
                                                                //               'ie4ye37b' /* Booked */,
                                                                //             ),
                                                                //             style: FlutterFlowTheme.of(
                                                                //                     context)
                                                                //                 .bodyText1
                                                                //                 .override(
                                                                //                   fontFamily:
                                                                //                       'AvenirArabic',
                                                                //                   color:
                                                                //                       FlutterFlowTheme.of(context).white,
                                                                //                   fontSize:
                                                                //                       13,
                                                                //                   fontWeight:
                                                                //                       FontWeight.w500,
                                                                //                   useGoogleFonts:
                                                                //                       false,
                                                                //                 ),
                                                                //           ),
                                                                //         ),
                                                                //       ],
                                                                //     ),
                                                                //   ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 12, 16, 0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        10,
                                                                        8,
                                                                        0),
                                                            child: InkWell(
                                                              onTap: () async {
                                                                //_chewieController?.pause();
                                                                logFirebaseEvent(
                                                                    'PROPERTY_DETAILS_Container_5imdfn3l_ON_T');
                                                                logFirebaseEvent(
                                                                    'Container_Navigate-To');
                                                                context
                                                                    .pushNamed(
                                                                  'ThreeSixtyView',
                                                                  queryParams: {
                                                                    'url': serializeParam(
                                                                        getJsonField(
                                                                          columnPropertyResponse,
                                                                          r'''$.attributes.threesixty_degree_view''',
                                                                        ).toString(),
                                                                        ParamType.String),
                                                                  }.withoutNulls,
                                                                );
                                                              },
                                                              child: Container(
                                                                width: 80,
                                                                height: 30,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  border: Border
                                                                      .all(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                  ),
                                                                ),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              8),
                                                                      child:
                                                                          Icon(
                                                                        Manzel
                                                                            .view_360,
                                                                        size:
                                                                            20,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          // InkWell(
                                                          //   onTap: () async {
                                                          //     //_chewieController?.pause();
                                                          //     logFirebaseEvent(
                                                          //         'PROPERTY_DETAILS_Container_i2se6sfv_ON_T');
                                                          //     logFirebaseEvent(
                                                          //         'Container_Navigate-To');
                                                          //     context.pushNamed(
                                                          //       'FloorPlan',
                                                          //       queryParams: {
                                                          //         'propertyId': serializeParam(
                                                          //             widget
                                                          //                 .propertyId,
                                                          //             ParamType
                                                          //                 .int),
                                                          //       }.withoutNulls,
                                                          //     );
                                                          //   },
                                                          //   child: Container(
                                                          //     height: 30,
                                                          //     decoration:
                                                          //         BoxDecoration(
                                                          //       color: FlutterFlowTheme.of(
                                                          //               context)
                                                          //           .white,
                                                          //       borderRadius:
                                                          //           BorderRadius
                                                          //               .circular(
                                                          //                   8),
                                                          //       border:
                                                          //           Border.all(
                                                          //         color: FlutterFlowTheme.of(
                                                          //                 context)
                                                          //             .primaryText,
                                                          //       ),
                                                          //     ),
                                                          //     child: Row(
                                                          //       mainAxisSize:
                                                          //           MainAxisSize
                                                          //               .max,
                                                          //       mainAxisAlignment:
                                                          //           MainAxisAlignment
                                                          //               .center,
                                                          //       children: [
                                                          //         Padding(
                                                          //           padding: EdgeInsetsDirectional
                                                          //               .fromSTEB(
                                                          //                   5,
                                                          //                   0,
                                                          //                   5,
                                                          //                   0),
                                                          //           child:
                                                          //               Container(
                                                          //             width: 60,
                                                          //             child: Icon(
                                                          //                 Manzel
                                                          //                     .floor_plan,
                                                          //                 color: Colors
                                                          //                     .black,
                                                          //                 size:
                                                          //                     20),
                                                          //           ),
                                                          //         ),
                                                          //       ],
                                                          //     ),
                                                          //   ),
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16, 35, 16, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 46,
                                                        height: 46,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0x80F3F1F1),
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: Color(
                                                                0x7EF3F1F1),
                                                            width: 2,
                                                          ),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          child: Image.network(
                                                            PropertyCall
                                                                .companyLogo(
                                                                    columnPropertyResponse),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(13, 0,
                                                                    0, 0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0, 0),
                                                              child: Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'kqc4ney0' /* Property manage by  */,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily:
                                                                          'AvenirArabic',
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      useGoogleFonts:
                                                                          false,
                                                                    ),
                                                              ),
                                                            ),
                                                            Text(
                                                              PropertyCall
                                                                  .mangedBy(
                                                                columnPropertyResponse,
                                                              ).toString(),
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
                                                                            .bold,
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
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16, 21, 16, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          PropertyCall
                                                              .propertyName(
                                                            columnPropertyResponse,
                                                          ).toString(),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'AvenirArabic',
                                                                fontSize: 25,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                useGoogleFonts:
                                                                    false,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16, 1, 16, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        6,
                                                                        6),
                                                            child: Icon(
                                                              Manzel
                                                                  .location_pin,
                                                              color:
                                                                  Colors.black,
                                                              size: 14,
                                                            ),
                                                          ),
                                                          Text(
                                                            PropertyCall
                                                                .propertyCity(
                                                              columnPropertyResponse,
                                                            ).toString(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'AvenirArabic',
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        3,
                                                                        0,
                                                                        3,
                                                                        0),
                                                            child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                '73rcbvl6' /* ,  */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'AvenirArabic',
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    useGoogleFonts:
                                                                        false,
                                                                  ),
                                                            ),
                                                          ),
                                                          Text(
                                                            PropertyCall
                                                                .propertyDistrict(
                                                              columnPropertyResponse,
                                                            ).toString(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'AvenirArabic',
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    1, 0, 0, 0),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            logFirebaseEvent(
                                                                'PROPERTY_DETAILS_Text_ytdaqx1p_ON_TAP');
                                                            logFirebaseEvent(
                                                                'Text_Launch-Map');
                                                            await launchMap(
                                                              mapType: $ml
                                                                  .MapType
                                                                  .google,
                                                              location: functions
                                                                  .propertyLocation(
                                                                      PropertyCall
                                                                          .propertyLat(
                                                                        columnPropertyResponse,
                                                                      ),
                                                                      PropertyCall
                                                                          .propertylng(
                                                                        columnPropertyResponse,
                                                                      )),
                                                              title: PropertyCall
                                                                  .propertyName(
                                                                columnPropertyResponse,
                                                              ).toString(),
                                                            );
                                                          },
                                                          child: Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              'regy8zap' /* View on map */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'AvenirArabic',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16, 8, 16, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      8, 0, 0),
                                                          child: Text(
                                                            PropertyCall
                                                                .propertyDescription(
                                                              columnPropertyResponse,
                                                            ).toString(),
                                                            maxLines: 20,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'AvenirArabic',
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16, 35, 16, 20),
                                                  child: Container(
                                                    decoration: BoxDecoration(),
                                                    child: GridView(
                                                      padding: EdgeInsets.zero,
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3,
                                                        crossAxisSpacing: 20,
                                                        mainAxisSpacing: 20,
                                                        childAspectRatio: 1,
                                                      ),
                                                      primary: false,
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            border: Border.all(
                                                              color: Color(
                                                                  0xFFEED260),
                                                              width: 1,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Manzel.bed,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 14,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          8,
                                                                          0,
                                                                          0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            3,
                                                                            0),
                                                                        child:
                                                                            Text(
                                                                          PropertyCall
                                                                              .propertyBedrooms(
                                                                            columnPropertyResponse,
                                                                          ).toString(),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'AvenirArabic',
                                                                                fontWeight: FontWeight.w300,
                                                                                useGoogleFonts: false,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        functions.bedroomsText(
                                                                            PropertyCall.propertyBedrooms(
                                                                              columnPropertyResponse,
                                                                            ),
                                                                            FFAppState().locale),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'AvenirArabic',
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
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            border: Border.all(
                                                              color: Color(
                                                                  0xFFEED260),
                                                              width: 1,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Manzel.bath,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 24,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          8,
                                                                          0,
                                                                          0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            3,
                                                                            0),
                                                                        child:
                                                                            Text(
                                                                          PropertyCall
                                                                              .propertyBathrooms(
                                                                            columnPropertyResponse,
                                                                          ).toString(),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'AvenirArabic',
                                                                                fontWeight: FontWeight.w300,
                                                                                useGoogleFonts: false,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        functions.bathroomText(
                                                                            PropertyCall.propertyBathrooms(
                                                                              columnPropertyResponse,
                                                                            ),
                                                                            FFAppState().locale),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'AvenirArabic',
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
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            border: Border.all(
                                                              color: Color(
                                                                  0xFFEED260),
                                                              width: 1,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        2,
                                                                        0,
                                                                        0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Manzel.size,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 24,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          8,
                                                                          0,
                                                                          0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            3,
                                                                            0),
                                                                        child:
                                                                            Text(
                                                                          PropertyCall
                                                                              .propertySize(
                                                                            columnPropertyResponse,
                                                                          ).toString(),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'AvenirArabic',
                                                                                fontWeight: FontWeight.w300,
                                                                                useGoogleFonts: false,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'swyvkhf5' /*  sqm */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'AvenirArabic',
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
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            border: Border.all(
                                                              color: Color(
                                                                  0xFFEED260),
                                                              width: 1,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        2,
                                                                        0,
                                                                        0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Manzel
                                                                      .living_room,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 24,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          8,
                                                                          0,
                                                                          0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            3,
                                                                            0),
                                                                        child:
                                                                            Text(
                                                                          PropertyCall
                                                                              .propertyLivingrooms(
                                                                            columnPropertyResponse,
                                                                          ).toString(),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'AvenirArabic',
                                                                                fontWeight: FontWeight.w300,
                                                                                useGoogleFonts: false,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        functions.livingroomText(
                                                                            PropertyCall.propertyLivingrooms(
                                                                              columnPropertyResponse,
                                                                            ),
                                                                            FFAppState().locale),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'AvenirArabic',
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
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            border: Border.all(
                                                              color: Color(
                                                                  0xFFEED260),
                                                              width: 1,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        2,
                                                                        0,
                                                                        0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Manzel
                                                                      .home_icon,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 24,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          8,
                                                                          0,
                                                                          0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          functions.intText(
                                                                              PropertyCall.propertyBuiltIn(
                                                                                columnPropertyResponse,
                                                                              ).toString(),
                                                                              FFAppState().locale),
                                                                          'null',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'AvenirArabic',
                                                                              fontWeight: FontWeight.w300,
                                                                              useGoogleFonts: false,
                                                                            ),
                                                                      ),
                                                                      Text(
                                                                        functions.agoTextDetailScreen(
                                                                            PropertyCall.propertyBuiltIn(
                                                                              columnPropertyResponse,
                                                                            ).toString(),
                                                                            FFAppState().locale),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1,
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
                                                Divider(
                                                  thickness: 1,
                                                  indent: 10,
                                                  endIndent: 10,
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16, 20, 0, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'nq19lw60' /* Features and Amenities */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'AvenirArabic',
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16, 17, 16, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          '6brswcwm' /* Ref no. */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'AvenirArabic',
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                      ),
                                                      Text(
                                                        PropertyCall
                                                            .propertyRef(
                                                          columnPropertyResponse,
                                                        ).toString(),
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
                                                                          .bold,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (functions
                                                    .propertyTypeCheckHouse(
                                                        PropertyCall
                                                            .propertyType(
                                                          columnPropertyResponse,
                                                        ).toString(),
                                                        FFAppState().locale))
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                16, 15, 16, 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'ku7u4p9w' /* Floors */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'AvenirArabic',
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                useGoogleFonts:
                                                                    false,
                                                              ),
                                                        ),
                                                        Text(
                                                          PropertyCall
                                                              .propertyFloors(
                                                            columnPropertyResponse,
                                                          ).toString(),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'AvenirArabic',
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                useGoogleFonts:
                                                                    false,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                if (functions
                                                    .propertyTypeCheckApartment(
                                                        PropertyCall
                                                            .propertyType(
                                                          columnPropertyResponse,
                                                        ).toString(),
                                                        FFAppState().locale))
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                16, 15, 16, 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'bidhdd2g' /* Floor Number */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'AvenirArabic',
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                useGoogleFonts:
                                                                    false,
                                                              ),
                                                        ),
                                                        Text(
                                                          PropertyCall
                                                              .propertyFloorNumber(
                                                            columnPropertyResponse,
                                                          ).toString(),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'AvenirArabic',
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                useGoogleFonts:
                                                                    false,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16, 15, 16, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'vrdckjrg' /* Furnishing type */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'AvenirArabic',
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                      ),
                                                      Text(
                                                        PropertyCall
                                                            .propertyFurnishingType(
                                                          columnPropertyResponse,
                                                        ).toString(),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'AvenirArabic',
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16, 15, 16, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'fk1mf2ip' /* Street width */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'AvenirArabic',
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Text(
                                                            PropertyCall
                                                                .propertyStreetWidth(
                                                              columnPropertyResponse,
                                                            ).toString(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'AvenirArabic',
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                          ),
                                                          Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              'ntqkfyop' /*  m */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'AvenirArabic',
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16, 15, 16, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'e52iigjz' /* Total Price */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'AvenirArabic',
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        3,
                                                                        0),
                                                            child: Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                functions.formatAmountWithoutDecimal(
                                                                    valueOrDefault<
                                                                        String>(
                                                                  PropertyCall
                                                                      .propertyPrice(
                                                                    columnPropertyResponse,
                                                                  ).toString(),
                                                                  '0',
                                                                )),
                                                                '0',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'AvenirArabic',
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    useGoogleFonts:
                                                                        false,
                                                                  ),
                                                            ),
                                                          ),
                                                          Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              've2ud2ws' /*  SAR */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'AvenirArabic',
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16, 15, 16, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'xiuyvuiq' /* Property type */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'AvenirArabic',
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                      ),
                                                      Text(
                                                        PropertyCall
                                                            .propertyType(
                                                          columnPropertyResponse,
                                                        ).toString(),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'AvenirArabic',
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (!functions
                                                    .requestButtonVisibilty(
                                                        getJsonField(
                                                  columnPropertyResponse,
                                                  r'''$.attributes.pincode''',
                                                )))
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                16, 15, 16, 32),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                                  'pinCode'),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'AvenirArabic',
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                useGoogleFonts:
                                                                    false,
                                                              ),
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          3,
                                                                          0),
                                                              child: Text(
                                                                getJsonField(
                                                                  columnPropertyResponse,
                                                                  r'''$.attributes.pincode''',
                                                                ).toString(),
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
                                                                              .bold,
                                                                      useGoogleFonts:
                                                                          false,
                                                                    ),
                                                              ),
                                                            ),
                                                            // Text(
                                                            //   FFLocalizations.of(
                                                            //           context)
                                                            //       .getText(
                                                            //     've2ud2ws' /*  SAR */,
                                                            //   ),
                                                            //   style:
                                                            //       FlutterFlowTheme.of(
                                                            //               context)
                                                            //           .bodyText1
                                                            //           .override(
                                                            //             fontFamily:
                                                            //                 'AvenirArabic',
                                                            //             fontSize: 16,
                                                            //             fontWeight:
                                                            //                 FontWeight
                                                            //                     .bold,
                                                            //             useGoogleFonts:
                                                            //                 false,
                                                            //           ),
                                                            // ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                if (functions
                                                    .requestButtonVisibilty(
                                                        getJsonField(
                                                  columnPropertyResponse,
                                                  r'''$.attributes.pincode''',
                                                )))
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                16, 32, 16, 32),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        FFButtonWidget(
                                                          onPressed: () async {
                                                            final phoneNumber =
                                                                getJsonField(
                                                              columnPropertyResponse,
                                                              r'''$.attributes.managed_by.data.attributes.Company_phone''',
                                                            );
                                                            print(
                                                                ">>>>>>>>>>>>>>>>>>>>>>phone number = ${phoneNumber}");
                                                            final message = '''
                                                        ${FFLocalizations.of(context).getText(
                                                              'opening' /* Logout */,
                                                            )}
                                                         ${FFLocalizations.of(context).getText(
                                                              'propertyName' /* Logout */,
                                                            )} : ${PropertyCall.propertyName(
                                                              columnPropertyResponse,
                                                            ).toString()}
                                                        ${FFLocalizations.of(context).getText(
                                                              'propertyRef' /* Logout */,
                                                            )} : ${PropertyCall.propertyRef(
                                                              columnPropertyResponse,
                                                            ).toString()}
                                                       ${FFLocalizations.of(context).getText(
                                                              'propertyAdd' /* Logout */,
                                                            )} : ${PropertyCall.propertyEntranceDirection(
                                                              columnPropertyResponse,
                                                            ).toString()}
                                                        ''';
                                                            openWhatsapp(
                                                                context,
                                                                message,
                                                                phoneNumber);
                                                          },
                                                          text: FFLocalizations
                                                                  .of(context)
                                                              .getText(
                                                            'requestVisit' /* Logout */,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            width: 335,
                                                            height: 48,
                                                            color: Colors.white,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .subtitle2
                                                                    .override(
                                                                      fontFamily:
                                                                          'Sofia Pro By Khuzaimah',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      useGoogleFonts:
                                                                          false,
                                                                    ),
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryColor,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                Divider(
                                                  thickness: 1,
                                                  indent: 10,
                                                  endIndent: 10,
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16, 20, 16, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'fobsike6' /* Supported Banks */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'AvenirArabic',
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 19, 0, 30),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 164,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                          ),
                                                          child: Builder(
                                                            builder: (context) {
                                                              final banks =
                                                                  PropertyCall
                                                                      .banks(
                                                                columnPropertyResponse,
                                                              ).toList();
                                                              return ListView
                                                                  .builder(
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                primary: false,
                                                                shrinkWrap:
                                                                    true,
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                itemCount: banks
                                                                    .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        banksIndex) {
                                                                  final banksItem =
                                                                      banks[
                                                                          banksIndex];
                                                                  return Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        logFirebaseEvent(
                                                                            'PROPERTY_DETAILS_Container_94tgk0v4_ON_T');
                                                                        logFirebaseEvent(
                                                                            'Container_Bottom-Sheet');
                                                                        await showModalBottomSheet(
                                                                          isScrollControlled:
                                                                              true,
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return Padding(
                                                                              padding: MediaQuery.of(context).viewInsets,
                                                                              child: Container(
                                                                                height: MediaQuery.of(context).size.height * 0.72,
                                                                                child: BankDetailsBottomSheetWidget(
                                                                                  bankId: getJsonField(
                                                                                    banksItem,
                                                                                    r'''$.id''',
                                                                                  ),
                                                                                  bankJSON: getJsonField(
                                                                                    banksItem,
                                                                                    r'''$.attributes''',
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        ).then((value) =>
                                                                            setState(() {}));
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.328,
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.14,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              color: Color(0x230F1113),
                                                                            )
                                                                          ],
                                                                          borderRadius:
                                                                              BorderRadius.circular(12),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Color(0xFFF3F3F3),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                                child: Image.network(
                                                                                  getJsonField(
                                                                                    banksItem,
                                                                                    r'''$..bank_logo..url''',
                                                                                  ),
                                                                                  width: MediaQuery.of(context).size.width * 0.29,
                                                                                  height: MediaQuery.of(context).size.height * 0.1,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(9, 0, 9, 0),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(9, 0, 0, 0),
                                                                                      child: Text(
                                                                                        getJsonField(
                                                                                          banksItem,
                                                                                          r'''$..bank_name''',
                                                                                        ).toString(),
                                                                                        maxLines: 2,
                                                                                        style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                              fontFamily: 'AvenirArabic',
                                                                                              fontSize: 14,
                                                                                              fontWeight: FontWeight.bold,
                                                                                              useGoogleFonts: false,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(9, 0, 0, 17),
                                                                                      child: Text(
                                                                                        FFLocalizations.of(context).getText(
                                                                                          '1v1r516t' /* More Details */,
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                              fontFamily: 'AvenirArabic',
                                                                                              color: FlutterFlowTheme.of(context).primaryColor,
                                                                                              fontSize: 11,
                                                                                              fontWeight: FontWeight.bold,
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
                                                Divider(
                                                  thickness: 1,
                                                  indent: 10,
                                                  endIndent: 10,
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16, 20, 16, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          '8fdy3f5a' /* Location */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'AvenirArabic',
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16, 10, 16, 7),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        PropertyCall
                                                            .propertyEntranceDirection(
                                                          columnPropertyResponse,
                                                        ).toString(),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'AvenirArabic',
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16, 7, 16, 16),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.27,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFEEEEEE),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Expanded(
                                                          child: InkWell(
                                                            onTap: () async {
                                                              logFirebaseEvent(
                                                                  'PROPERTY_DETAILS_StaticMap_xhp2s348_ON_T');
                                                              // OpenMap
                                                              logFirebaseEvent(
                                                                  'StaticMap_OpenMap');
                                                              await launchMap(
                                                                mapType: $ml
                                                                    .MapType
                                                                    .google,
                                                                location: functions
                                                                    .propertyLocation(
                                                                        PropertyCall
                                                                            .propertyLat(
                                                                          columnPropertyResponse,
                                                                        ),
                                                                        PropertyCall
                                                                            .propertylng(
                                                                          columnPropertyResponse,
                                                                        )),
                                                                title: PropertyCall
                                                                    .propertyName(
                                                                  columnPropertyResponse,
                                                                ).toString(),
                                                              );
                                                            },
                                                            child:
                                                                FlutterFlowStaticMap(
                                                              location: functions
                                                                  .propertyLocation(
                                                                      PropertyCall
                                                                          .propertyLat(
                                                                        columnPropertyResponse,
                                                                      ),
                                                                      PropertyCall
                                                                          .propertylng(
                                                                        columnPropertyResponse,
                                                                      )),
                                                              apiKey:
                                                                  'pk.eyJ1IjoibWFuemVsIiwiYSI6ImNsNTB0NjI3YjA3OXQzYm9sdWNvM2Rrc2kifQ.zAYcxr9ozMoZfe4pEfxv7A',
                                                              style: MapBoxStyle
                                                                  .Streets,
                                                              width: double
                                                                  .infinity,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.27,
                                                              fit: BoxFit.cover,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              markerColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate,
                                                              cached: true,
                                                              zoom: 10,
                                                              tilt: 0,
                                                              rotation: 0,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Divider(
                                                  thickness: 1,
                                                  indent: 10,
                                                  endIndent: 10,
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16, 20, 16, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          '67qymqb4' /* Photos */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'AvenirArabic',
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 12, 0, 55),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 164,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                          ),
                                                          child: Builder(
                                                            builder: (context) {
                                                              final propertyImages =
                                                                  PropertyCall
                                                                      .propertyImages(
                                                                columnPropertyResponse,
                                                              ).toList();
                                                              return InkWell(
                                                                onTap:
                                                                    () async {
                                                                  logFirebaseEvent(
                                                                      'PROPERTY_DETAILS_horizontalList_ON_TAP');
                                                                  logFirebaseEvent(
                                                                      'horizontalList_Navigate-To');
                                                                  context
                                                                      .pushNamed(
                                                                    'imageGalleryView',
                                                                    queryParams:
                                                                        {
                                                                      'propertyId': serializeParam(
                                                                          widget
                                                                              .propertyId,
                                                                          ParamType
                                                                              .int),
                                                                          'imageList': serializeParam(propertyImages, ParamType.JSON),
                                                                          'ScreenName':serializeParam("PropertyImages", ParamType.String)
                                                                    }.withoutNulls,
                                                                  );
                                                                },
                                                                child: ListView
                                                                    .builder(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  primary:
                                                                      false,
                                                                  shrinkWrap:
                                                                      true,
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  itemCount:
                                                                      propertyImages
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          propertyImagesIndex) {
                                                                    final propertyImagesItem =
                                                                        propertyImages[
                                                                            propertyImagesIndex];
                                                                    return Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              16,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            147,
                                                                        height:
                                                                            117,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              color: Color(0x230F1113),
                                                                            )
                                                                          ],
                                                                          borderRadius:
                                                                              BorderRadius.circular(12),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Color(0xFFF3F3F3),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                          child:
                                                                              Image.network(
                                                                            getJsonField(
                                                                              propertyImagesItem,
                                                                              r'''$.attributes.formats.medium.url''',
                                                                            ),
                                                                            width:
                                                                                147,
                                                                            height:
                                                                                117,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  thickness: 1,
                                                  indent: 10,
                                                  endIndent: 10,
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16, 20, 16, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        FFLocalizations.of(
                                                            context)
                                                            .getText(
                                                          'floorPlan' /* Photos */,
                                                        ),
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyText1
                                                            .override(
                                                          fontFamily:
                                                          'AvenirArabic',
                                                          fontSize: 20,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                          useGoogleFonts:
                                                          false,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 12, 0, 55),
                                                  child: Row(
                                                    mainAxisSize:
                                                    MainAxisSize.min,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          width:
                                                          double.infinity,
                                                          height: 164,
                                                          decoration:
                                                          BoxDecoration(
                                                            color: Colors.white,
                                                          ),
                                                          child: Builder(
                                                            builder: (context) {
                                                              final propertyFloorPlan =
                                                              getJsonField(
                                                                  columnPropertyResponse,
                                                                  r'''$.attributes.property_floor_plan.data''').toList();
                                                              return InkWell(
                                                                onTap:
                                                                    () async {
                                                                  logFirebaseEvent(
                                                                      'PROPERTY_DETAILS_horizontalList_ON_TAP');
                                                                  logFirebaseEvent(
                                                                      'horizontalList_Navigate-To');
                                                                  context
                                                                      .pushNamed(
                                                                    'imageGalleryView',
                                                                    queryParams:
                                                                    {
                                                                      'propertyId': serializeParam(
                                                                          widget
                                                                              .propertyId,
                                                                          ParamType
                                                                              .int),
                                                                      'imageList': serializeParam(propertyFloorPlan, ParamType.JSON),
                                                                      'ScreenName':serializeParam("FloorPlan", ParamType.String)
                                                                    }.withoutNulls,
                                                                  );
                                                                },
                                                                child: ListView
                                                                    .builder(
                                                                  padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                                  primary:
                                                                  false,
                                                                  shrinkWrap:
                                                                  true,
                                                                  scrollDirection:
                                                                  Axis.horizontal,
                                                                  itemCount:
                                                                  propertyFloorPlan
                                                                      .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                      propertyFloorPlanIndex) {
                                                                    final propertyFloorPlanItem =
                                                                    propertyFloorPlan[
                                                                    propertyFloorPlanIndex];
                                                                    return Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          16,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                      child:
                                                                      Container(
                                                                        width:
                                                                        147,
                                                                        height:
                                                                        117,
                                                                        decoration:
                                                                        BoxDecoration(
                                                                          color:
                                                                          Colors.white,
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              color: Color(0x230F1113),
                                                                            )
                                                                          ],
                                                                          borderRadius:
                                                                          BorderRadius.circular(12),
                                                                          border:
                                                                          Border.all(
                                                                            color:
                                                                            Color(0xFFF3F3F3),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                        ClipRRect(
                                                                          borderRadius:
                                                                          BorderRadius.circular(8),
                                                                          child:
                                                                          Image.network(
                                                                            getJsonField(
                                                                              propertyFloorPlanItem,
                                                                              r'''$..attributes.formats.medium.url''',
                                                                            ),
                                                                            width:
                                                                            147,
                                                                            height:
                                                                            117,
                                                                            fit:
                                                                            BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              );
                                                            },
                                                          ),
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
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          Material(
                            color: Colors.transparent,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.12,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Color(0x0E000000),
                                    offset: Offset(0, -2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(0),
                              ),
                              alignment: AlignmentDirectional(0, -0.35),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 16, 16, 0),
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
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'i17ddd6l' /* Installment starting from */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'AvenirArabic',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryColor,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              AutoSizeText(
                                                functions
                                                    .formatAmount(PropertyCall
                                                        .propertyInitialInstallment(
                                                      columnPropertyResponse,
                                                    ).toString())
                                                    .maybeHandleOverflow(
                                                        maxChars: 10),
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'AvenirArabic',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryColor,
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          useGoogleFonts: false,
                                                        ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(4, 11, 4, 0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'mgi2d0o9' /* SAR/Monthly */,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'AvenirArabic',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryColor,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (functions.conditionalVisibility(
                                        PropertyCall.propertyStatus(
                                          columnPropertyResponse,
                                        ).toString(),
                                        'Available'))
                                      FFButtonWidget(
                                        onPressed: () async {
                                          //_chewieController?.pause();
                                          logFirebaseEvent(
                                              'PROPERTY_DETAILS_PAGE_reserved_ON_TAP');
                                          if (loggedIn) {
                                            if (functions.profileCompletetionCheck(
                                                currentUserEmail,
                                                valueOrDefault(
                                                    currentUserDocument?.name,
                                                    ''),
                                                valueOrDefault(
                                                    currentUserDocument?.bank,
                                                    ''),
                                                valueOrDefault(
                                                    currentUserDocument
                                                        ?.employmentStatus,
                                                    ''),
                                                valueOrDefault(
                                                    currentUserDocument
                                                        ?.monthlyIncome,
                                                    ''),
                                                valueOrDefault<bool>(
                                                        currentUserDocument
                                                            ?.sakaniLoanCoverage,
                                                        false)
                                                    .toString())) {
                                              logFirebaseEvent(
                                                  'reserved_Bottom-Sheet');
                                              addOrderApiResponse =
                                                  await AddOrderCall.call(
                                                      propertyId: widget!
                                                          .propertyId
                                                          .toString(),
                                                      userId:
                                                          currentUserReference
                                                              ?.id,
                                                      authorazationToken:
                                                          FFAppState()
                                                              .authToken,
                                                    version: FFAppState().apiVersion
                                                  );

                                              if ((addOrderApiResponse
                                                          ?.statusCode ??
                                                      200) ==
                                                  200) {
                                                await configurePaymentSdk();
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor: Colors.white,
                                                  context: context,
                                                  builder: (context) {
                                                    return Padding(
                                                      padding:
                                                          MediaQuery.of(context)
                                                              .viewInsets,
                                                      child: Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.9,
                                                        child:
                                                            ReservationBottomSheetWidget(
                                                          reservationCost:
                                                              PropertyCall
                                                                  .reservationsCost(
                                                            columnPropertyResponse,
                                                          ),
                                                          propertyId:
                                                              widget.propertyId,
                                                          orderId:
                                                              addOrderApiResponse
                                                                      ?.jsonBody[
                                                                  'result'],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then(
                                                    (value) => setState(() {}));
                                                //.then((value) => _chewieController?.play());
                                              } else if (addOrderApiResponse!
                                                      .statusCode ==
                                                  399) {
                                                //   Navigator.pop(context);
                                                logFirebaseEvent(
                                                    'Button_Show-Snack-Bar');
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      addOrderApiResponse!
                                                          .jsonBody['error'],
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .white,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryRed,
                                                  ),
                                                );
                                              } else if (addOrderApiResponse!
                                                      .statusCode ==
                                                  400) {
                                                //Navigator.pop(context);
                                                logFirebaseEvent(
                                                    'Button_Show-Snack-Bar');
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      FFAppState().locale ==
                                                              'en'
                                                          ? "Something went wrong. Please try again."
                                                          : "هناك خطأ ما. حاول مرة اخرى.",
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .white,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryRed,
                                                  ),
                                                );
                                              } else {
                                                // Navigator.pop(context);
                                                logFirebaseEvent(
                                                    'Button_Show-Snack-Bar');
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      functions.snackBarMessage(
                                                          'reservationConfirmed',
                                                          FFAppState().locale),
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .white,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryRed,
                                                  ),
                                                );
                                              }
                                            } else {
                                              logFirebaseEvent(
                                                  'reserved_Navigate-To');

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditPersonallInfoWidget(
                                                    screenName:
                                                        "PropertyDetails",
                                                  ),
                                                ),
                                              ).then(
                                                (value) async {
                                                  logFirebaseEvent(
                                                      'reserved_Bottom-Sheet');
                                                  addOrderApiResponse =
                                                      await AddOrderCall.call(
                                                          propertyId: widget
                                                              .propertyId
                                                              .toString(),
                                                          userId:
                                                              currentUserReference
                                                                  ?.id,
                                                          authorazationToken:
                                                              FFAppState()
                                                                  .authToken,
                                                          version: FFAppState().apiVersion
                                                      );

                                                  if ((addOrderApiResponse
                                                              ?.statusCode ??
                                                          200) ==
                                                      200) {
                                                    await configurePaymentSdk();
                                                    await showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      backgroundColor:
                                                          Colors.white,
                                                      context: context,
                                                      builder: (context) {
                                                        return Padding(
                                                          padding:
                                                              MediaQuery.of(
                                                                      context)
                                                                  .viewInsets,
                                                          child: Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.9,
                                                            child:
                                                                ReservationBottomSheetWidget(
                                                              reservationCost:
                                                                  PropertyCall
                                                                      .reservationsCost(
                                                                columnPropertyResponse,
                                                              ),
                                                              propertyId: widget
                                                                  .propertyId,
                                                              orderId:
                                                                  addOrderApiResponse
                                                                          ?.jsonBody[
                                                                      'result'],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ).then((value) =>
                                                        setState(() {}));
                                                    //.then((value) => _chewieController?.play());
                                                  } else if (addOrderApiResponse!
                                                          .statusCode ==
                                                      399) {
                                                    //Navigator.pop(context);
                                                    logFirebaseEvent(
                                                        'Button_Show-Snack-Bar');
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          addOrderApiResponse!
                                                                  .jsonBody[
                                                              'error'],
                                                          style: TextStyle(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .white,
                                                          ),
                                                        ),
                                                        duration: Duration(
                                                            milliseconds: 4000),
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryRed,
                                                      ),
                                                    );
                                                  } else if (addOrderApiResponse!
                                                          .statusCode ==
                                                      400) {
                                                    //  Navigator.pop(context);
                                                    logFirebaseEvent(
                                                        'Button_Show-Snack-Bar');
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          FFAppState().locale ==
                                                                  'en'
                                                              ? "Something went wrong. Please try again."
                                                              : "هناك خطأ ما. حاول مرة اخرى.",
                                                          style: TextStyle(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .white,
                                                          ),
                                                        ),
                                                        duration: Duration(
                                                            milliseconds: 4000),
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryRed,
                                                      ),
                                                    );
                                                  } else {
                                                    Navigator.pop(context);
                                                    logFirebaseEvent(
                                                        'Button_Show-Snack-Bar');
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          functions.snackBarMessage(
                                                              'reservationConfirmed',
                                                              FFAppState()
                                                                  .locale),
                                                          style: TextStyle(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .white,
                                                          ),
                                                        ),
                                                        duration: Duration(
                                                            milliseconds: 4000),
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryRed,
                                                      ),
                                                    );
                                                  }
                                                },
                                              );
                                            }
                                          } else {
                                            logFirebaseEvent(
                                                'reserved_Navigate-To');
                                            context.pushNamed('Login');
                                          }
                                        },
                                        text:
                                            FFLocalizations.of(context).getText(
                                          'dpmrt150' /* Reserve */,
                                        ),
                                        options: FFButtonOptions(
                                          width: FFAppState().locale == "en"
                                              ? 140
                                              : 120,
                                          height: FFAppState().locale == "en"
                                              ? 56
                                              : 40,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                          textStyle:
                                              FlutterFlowTheme.of(context)
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
                                    if (!functions.conditionalVisibility(
                                        PropertyCall.propertyStatus(
                                          columnPropertyResponse,
                                        ).toString(),
                                        'Available'))
                                      FFButtonWidget(
                                        onPressed: () {
                                          print('Button pressed ...');
                                        },
                                        text:
                                            FFLocalizations.of(context).getText(
                                          'wzirx8i7' /* Booked */,
                                        ),
                                        options: FFButtonOptions(
                                          width: FFAppState().locale == "en"
                                              ? 140
                                              : 120,
                                          height: FFAppState().locale == "en"
                                              ? 56
                                              : 40,
                                          color: Color(0xFF8C8C8C),
                                          textStyle:
                                              FlutterFlowTheme.of(context)
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
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
          },
          valueListenable: isLoading,
        ),
      ),
    );
  }

  Future<String> generateDynamicLink(Map<String, dynamic> params,
      {required String description, required String? thumbnailUrl}) async {
    String url = 'https://www.manzel.app/';

    if (params.isNotEmpty) {
      url = '$url?';
    }

    List<String> keys = params.keys.toList();
    for (int i = 0; i < keys.length; i++) {
      url += '${keys[i]}=${params[keys[i]]}';
      if (i < keys.length - 1) {
        url += '&';
      }
    }

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      socialMetaTagParameters: SocialMetaTagParameters(
          title: "Join Manzel to see what I've been upto",
          imageUrl: Uri.parse(thumbnailUrl!),
          description: description),
      // uriPrefix: 'https://manzelprod.page.link',
      uriPrefix: 'https://manzeldev.page.link',
      link: Uri.parse(url),
      androidParameters: const AndroidParameters(
        packageName: 'com.flutterflow.manzel',
        minimumVersion: 1,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.flutterflow.manzel',
        minimumVersion: '1',
      ),
    );
    ShortDynamicLink uri = await FirebaseDynamicLinks.instance
        .buildShortLink(parameters, shortLinkType: ShortDynamicLinkType.short);
    return uri.shortUrl.toString();
  }

  void openWhatsapp(
      BuildContext context, String? message, String? phoneNumber) async {
    var whatsapp = phoneNumber;
    var whatsappUrlAndroid =
        Uri.parse('$kWhatsAppAndroid$whatsapp&text=${message}');
    var whatsappUrlIos = Uri.parse('$kWhatsAppIOS$whatsapp&text=${Uri.parse("${message}")}');
    if (Platform.isIOS) {
      if (await canLaunchUrl(whatsappUrlIos)) {
        await launchUrl(whatsappUrlIos, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Cannot open whatsapp',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.white)),
          backgroundColor: FlutterFlowTheme.of(context).primaryRed,
        ));
      }
    } else {
      bool canLaunch = await canLaunchUrl(whatsappUrlAndroid);
      if (canLaunch) {
        await launchUrl(whatsappUrlAndroid,
            mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Cannot open whatsapp',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.white),
          ),
          backgroundColor: FlutterFlowTheme.of(context).primaryRed,
        ));
      }
    }
  }
}
