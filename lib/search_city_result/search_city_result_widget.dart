import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../auth/firebase_user_provider.dart';
import '../backend/api_requests/api_calls.dart';
import '../components/no_results_found_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SearchCityResultWidget extends StatefulWidget {
  const SearchCityResultWidget({
    Key? key,
    this.cityName,
    this.propertiesAvailable,
    this.homeScreenLength,
  }) : super(key: key);

  final String? cityName;
  final int? propertiesAvailable;
  final int? homeScreenLength;

  @override
  _SearchCityResultWidgetState createState() => _SearchCityResultWidgetState();
}

class _SearchCityResultWidgetState extends State<SearchCityResultWidget> {
  Completer<ApiCallResponse>? _apiRequestCompleter;
  PageController? pageViewController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentItem = 0;
  bool isPaused = false;
  ValueNotifier<bool> isMuted = ValueNotifier<bool>(true);
  bool? autoplayVal;

  //FlickMultiManager flickMultiManager;
  Set<VideoPlayerController>? videoControllerSet;

  VideoPlayerController? _currentController;
  int currentPropertyindex = 0;

  Map<String, VideoPlayerController> videocontrollerMap = {};

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'SearchCityResult'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        automaticallyImplyLeading: true,
        leading: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Color(0xFFF3F2F2),
                width: 1,
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
              child: InkWell(
                onTap: () async {
                  logFirebaseEvent('SEARCH_CITY_RESULT_Icon_uhxori33_ON_TAP');
                  logFirebaseEvent('Icon_Navigate-Back');
                  context.pop();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    FFLocalizations.of(context).getText(
                      'cv6ymemd' /* Search results  */,
                    ),
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'AvenirArabic',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts: false,
                        ),
                  ),
                  Text(
                    FFLocalizations.of(context).getText(
                      'i7hby2rh' /* " */,
                    ),
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'AvenirArabic',
                          color: Color(0xFF2971FB),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts: false,
                        ),
                  ),
                  Text(
                    widget.cityName!,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'AvenirArabic',
                          color: Color(0xFF2971FB),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts: false,
                        ),
                  ),
                  Text(
                    FFLocalizations.of(context).getText(
                      '6gnj1yz7' /* " */,
                    ),
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'AvenirArabic',
                          color: Color(0xFF2971FB),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts: false,
                        ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    widget.propertiesAvailable!.toString(),
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'AvenirArabic',
                          color: Color(0xFF6B6B6B),
                          useGoogleFonts: false,
                        ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        'nukctvmg' /* properties found */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'AvenirArabic',
                            color: Color(0xFF6B6B6B),
                            useGoogleFonts: false,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
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
                  padding: EdgeInsetsDirectional.fromSTEB(0, 14, 0, 0),
                  child: FutureBuilder<ApiCallResponse>(
                    future:
                        (_apiRequestCompleter ??= Completer<ApiCallResponse>()
                              ..complete(PropertiesCall.call(
                                city: widget.cityName,
                                locale: FFAppState().locale,
                                populate:
                                    '*,banks.Bank_logo,managed_by.Company_logo,property_images,city',
                              )))
                            .future,
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
                      final listViewPropertiesResponse = snapshot.data!;
                      return Builder(
                        builder: (context) {
                          final properties = PropertiesCall.properties(
                            listViewPropertiesResponse.jsonBody,
                          ).toList();
                          if (properties.isEmpty) {
                            return Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                child: NoResultsFoundWidget(
                                  titleText: functions.emptyListWidgetTitle(
                                      'filterResult', FFAppState().locale),
                                  subtitleText: functions.noResultsCityName(
                                      widget.cityName, FFAppState().locale),
                                  screenName: 'Result',
                                  isButtonVisible: false,
                                ),
                              ),
                            );
                          }
                          return RefreshIndicator(
                            onRefresh: () async {
                              logFirebaseEvent(
                                  'SEARCH_CITY_RESULT_ListView_hu1h9tbs_ON_');
                              logFirebaseEvent(
                                  'ListView_Refresh-Database-Request');
                              setState(() => _apiRequestCompleter = null);
                              await waitForApiRequestCompleter();
                            },
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: properties.length,
                              itemBuilder: (context, propertiesIndex) {
                                final propertiesItem =
                                    properties[propertiesIndex];
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 25),
                                  child: InkWell(
                                    onTap: () async {
                                      videoPlayers[propertiesIndex+widget.homeScreenLength!].pause();
                                      logFirebaseEvent(
                                          'SEARCH_CITY_RESULT_propertyCard_ON_TAP');
                                      // propertyDetails
                                      logFirebaseEvent(
                                          'propertyCard_propertyDetails');

                                      context.pushNamed(
                                        'PropertyDetails',
                                        queryParams: {
                                          'propertyId': serializeParam(
                                              getJsonField(
                                                propertiesItem,
                                                r'''$.id''',
                                              ),
                                              ParamType.int),
                                        }.withoutNulls,
                                      );
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.315,
                                          child: Stack(
                                            children: [
                                              if (!functions
                                                  .videoPlayerVisibilty(
                                                      getJsonField(
                                                propertiesItem,
                                                r'''$.attributes.video_manifest_uri''',
                                              )))
                                                Builder(
                                                  builder: (context) {
                                                    final propertyImages =
                                                        getJsonField(
                                                      propertiesItem,
                                                      r'''$..property_images.data''',
                                                    ).toList();
                                                    return Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.3,
                                                      child: Stack(
                                                        children: [
                                                          PageView.builder(
                                                            controller: pageViewController ??=
                                                                PageController(
                                                                    initialPage: min(
                                                                        0,
                                                                        propertyImages.length -
                                                                            1)),
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount:
                                                                propertyImages
                                                                    .length,
                                                            itemBuilder: (context,
                                                                propertyImagesIndex) {
                                                              final propertyImagesItem =
                                                                  propertyImages[
                                                                      propertyImagesIndex];
                                                              return ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl:
                                                                      getJsonField(
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
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0, 0.7),
                                                            child:
                                                                SmoothPageIndicator(
                                                              controller: pageViewController ??=
                                                                  PageController(
                                                                      initialPage: min(
                                                                          0,
                                                                          propertyImages.length -
                                                                              1)),
                                                              count:
                                                                  propertyImages
                                                                      .length,
                                                              axisDirection: Axis
                                                                  .horizontal,
                                                              onDotClicked:
                                                                  (i) {
                                                                pageViewController!
                                                                    .animateToPage(
                                                                  i,
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          500),
                                                                  curve: Curves
                                                                      .ease,
                                                                );
                                                              },
                                                              effect:
                                                                  SlideEffect(
                                                                spacing: 8,
                                                                radius: 3,
                                                                dotWidth: 6,
                                                                dotHeight: 6,
                                                                dotColor: Color(
                                                                    0x80FFFFFF),
                                                                activeDotColor:
                                                                    Colors
                                                                        .white,
                                                                paintStyle:
                                                                    PaintingStyle
                                                                        .fill,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.35,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Visibility(
                                                  visible: functions
                                                      .videoPlayerVisibilty(
                                                          getJsonField(
                                                    propertiesItem,
                                                    r'''$.attributes.video_manifest_uri''',
                                                  )),
                                                  child: ClipRRect(
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
                                                            if(!(videoPlayers[widget.homeScreenLength!+propertiesIndex].value.isInitialized)) {
                                                              videoPlayers[widget.homeScreenLength!+propertiesIndex]
                                                                  .initialize()
                                                                  .then((value) {
                                                                currentPropertyindex = propertiesIndex;
                                                                videoPlayers[widget.homeScreenLength!+propertiesIndex]
                                                                    .play();
                                                                isPaused = false;
                                                                isMuted.value
                                                                    ? videoPlayers[
                                                                widget.homeScreenLength!+propertiesIndex]
                                                                    .setVolume(0)
                                                                    : videoPlayers[
                                                                widget.homeScreenLength!+propertiesIndex]
                                                                    .setVolume(100);
                                                                setState(() {
                                                                  videoPlayers.forEach((otherPlayer) {
                                                                    if (otherPlayer != videoPlayers[widget.homeScreenLength!+propertiesIndex]) {


                                                                      if(otherPlayer.value.isInitialized) {
                                                                        otherPlayer.pause();
                                                                        // var dataSource = otherPlayer.dataSource;
                                                                        // otherPlayer.dispose();
                                                                        // otherPlayer =
                                                                        //     VideoPlayerController.network(dataSource);

                                                                      }
                                                                      else{
                                                                        otherPlayer.initialize().then((value) => otherPlayer.pause());
                                                                      }
                                                                    }
                                                                  });
                                                                  print(
                                                                      'propertyindex - ${propertiesIndex}');
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
                                                              videoPlayers[widget.homeScreenLength!+propertiesIndex]
                                                                  .play();
                                                              isPaused = false;
                                                              isMuted.value
                                                                  ? videoPlayers[
                                                              widget.homeScreenLength!+propertiesIndex]
                                                                  .setVolume(0)
                                                                  : videoPlayers[
                                                              widget.homeScreenLength!+propertiesIndex]
                                                                  .setVolume(100);
                                                              currentPropertyindex = widget.homeScreenLength!+propertiesIndex;
                                                              setState(() {
                                                                videoPlayers.forEach((otherPlayer) {

                                                                  if (otherPlayer != videoPlayers[widget.homeScreenLength!+propertiesIndex]) {
                                                                    if (otherPlayer.value.isInitialized) {
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

                                                          path:
                                                          getJsonField(
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
                                                          aspectRatio: 1.70,
                                                          autoPlay: false,
                                                          looping: true,
                                                          showControls: false,
                                                          allowFullScreen: true,
                                                          allowPlaybackSpeedMenu: false,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    1, -0.95),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 12, 15, 0),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      videoPlayers[propertiesIndex+widget.homeScreenLength!].pause();
                                                      logFirebaseEvent(
                                                          'SEARCH_CITY_RESULT_Container_0oy6ukkp_ON');
                                                      if (!loggedIn) {
                                                        logFirebaseEvent(
                                                            'Container_Navigate-To');

                                                        context
                                                            .pushNamed('Login');
                                                      }
                                                    },
                                                    child: Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0x4D000000),
                                                        image: DecorationImage(
                                                          fit: BoxFit.none,
                                                          image: Image.asset(
                                                            'assets/images/Heart.png',
                                                          ).image,
                                                        ),
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    AlignmentDirectional(-0.9, 1),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 18, 18),
                                                  child: Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color: Color(0x80F3F1F1),
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color:
                                                            Color(0x80F3F1F1),
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
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
                                              Align(
                                                alignment: AlignmentDirectional(0, 0),
                                                child: InkWell(
                                                  onTap: () {
                                                    //print("pause value>>>>>>>>>>>>> $isPaused");
                                                    isPaused =
                                                    isPaused ? false : true;

                                                    isPaused
                                                        ? videoPlayers[widget.homeScreenLength!+propertiesIndex]
                                                        .pause()
                                                        : videoPlayers[widget.homeScreenLength!+propertiesIndex]
                                                        .play();
                                                    setState(() {

                                                    });
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
                                                    child: Container(
                                                      margin: EdgeInsets.all(100),
                                                      height: 50,
                                                      width: 50,
                                                      decoration: BoxDecoration(
                                                        color: isPaused
                                                            ? Colors.black
                                                            .withOpacity(0.5)
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
                                              Align(
                                                alignment: AlignmentDirectional(0, 0),
                                                child:
                                                propertiesIndex == currentPropertyindex-widget.homeScreenLength!
                                                    ? Container():Container(
                                                  margin: EdgeInsets.all(100),
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    color:Colors.black
                                                        .withOpacity(1.0),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(
                                                    Icons.play_arrow_rounded,
                                                    color:  Colors.white
                                                        .withOpacity(1.0),
                                                    size: 40,
                                                  ),
                                                ),
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
                                                      if (videoPlayers[widget.homeScreenLength!+propertiesIndex]!
                                                          .value
                                                          .volume >
                                                          0) {
                                                        videoPlayers[widget.homeScreenLength!+propertiesIndex]
                                                            ?.setVolume(0);
                                                        isMuted.value = true;
                                                      } else {
                                                        videoPlayers[widget.homeScreenLength!+propertiesIndex]
                                                            ?.setVolume(100);
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
                                              // if (functions.conditionalVisibility(
                                              //     getJsonField(
                                              //       propertiesItem,
                                              //       r'''$.attributes.property_status''',
                                              //     ).toString(),
                                              //     'Available'))
                                              //   Align(
                                              //     alignment:
                                              //     AlignmentDirectional(-0.85, -0.8),
                                              //     child: Container(
                                              //       width: 80,
                                              //       height: 26,
                                              //       decoration: BoxDecoration(
                                              //         color: Color(0xFF81D05C),
                                              //         borderRadius:
                                              //         BorderRadius.circular(7),
                                              //       ),
                                              //       child: Row(
                                              //         mainAxisSize: MainAxisSize.max,
                                              //         mainAxisAlignment:
                                              //         MainAxisAlignment.center,
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
                                              //               FlutterFlowTheme.of(context)
                                              //                   .bodyText1
                                              //                   .override(
                                              //                 fontFamily:
                                              //                 'AvenirArabic',
                                              //                 color: FlutterFlowTheme
                                              //                     .of(context)
                                              //                     .white,
                                              //                 fontSize: 13,
                                              //                 fontWeight:
                                              //                 FontWeight.w500,
                                              //                 useGoogleFonts: false,
                                              //               ),
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
                                                  AlignmentDirectional(-0.85, -0.8),
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
                                                  AlignmentDirectional(-0.85, -0.8),
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
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4, 14, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                getJsonField(
                                                  propertiesItem,
                                                  r'''$.attributes.property_name''',
                                                ).toString(),
                                                maxLines: 1,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'AvenirArabic',
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts: false,
                                                        ),
                                              ),
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  '5s0m6vc5' /* Approved Banks */,
                                                ),
                                                textAlign: TextAlign.end,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'AvenirArabic',
                                                          color:
                                                              Color(0xFF474747),
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts: false,
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4, 1, 0, 14),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.location_on_outlined,
                                                    color: Color(0xFF130F26),
                                                    size: 11,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                4, 0, 0, 0),
                                                    child: Text(
                                                      getJsonField(
                                                        propertiesItem,
                                                        r'''$..attributes.city.data.attributes.city_name''',
                                                      ).toString(),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'AvenirArabic',
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            useGoogleFonts:
                                                                false,
                                                          ),
                                                    ),
                                                  ),
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'f2n56efp' /* ,  */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'AvenirArabic',
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          useGoogleFonts: false,
                                                        ),
                                                  ),
                                                  Text(
                                                    getJsonField(
                                                      propertiesItem,
                                                      r'''$..property_district''',
                                                    ).toString(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'AvenirArabic',
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          useGoogleFonts: false,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              Builder(
                                                builder: (context) {
                                                  final banks = getJsonField(
                                                    propertiesItem,
                                                    r'''$.attributes.banks.data''',
                                                  ).toList();
                                                  return Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: List.generate(
                                                        banks.length,
                                                        (banksIndex) {
                                                      final banksItem =
                                                          banks[banksIndex];
                                                      return Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 8, 0),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(11),
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
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4, 0, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'by2cxdfu' /* Installment starting from */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .title3
                                                        .override(
                                                          fontFamily:
                                                              'Sofia Pro By Khuzaimah',
                                                          color:
                                                              Color(0xFF2971FB),
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts: false,
                                                        ),
                                              ),
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'e3d13l9e' /* Total property price */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText2
                                                        .override(
                                                          fontFamily:
                                                              'AvenirArabic',
                                                          color:
                                                              Color(0xFF474747),
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts: false,
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4, 1, 0, 25),
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
                                                      functions.formatAmount(
                                                          valueOrDefault<
                                                              String>(
                                                        getJsonField(
                                                          propertiesItem,
                                                          r'''$.attributes.property_initial_installment''',
                                                        ).toString(),
                                                        '0',
                                                      )),
                                                      '0',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'Sofia Pro By Khuzaimah',
                                                          color:
                                                              Color(0xFF2971FB),
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          useGoogleFonts: false,
                                                        ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                5, 10, 0, 0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'bm7ytrkl' /*  SAR/Monthly */,
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'AvenirArabic',
                                                            color: Color(
                                                                0xFF2971FB),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            useGoogleFonts:
                                                                false,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    functions
                                                        .formatAmountWithoutDecimal(
                                                            valueOrDefault<
                                                                String>(
                                                      getJsonField(
                                                        propertiesItem,
                                                        r'''$..property_price''',
                                                      ).toString(),
                                                      '0',
                                                    )),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText2
                                                        .override(
                                                          fontFamily:
                                                              'AvenirArabic',
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          useGoogleFonts: false,
                                                        ),
                                                  ),
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      's8nfdgfe' /*  SAR */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText2
                                                        .override(
                                                          fontFamily:
                                                              'AvenirArabic',
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
