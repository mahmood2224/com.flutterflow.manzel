import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

//const kDefaultAspectRatio = 16 / 9;

enum VideoType {
  asset,
  network,
}

List<VideoPlayerController> videoPlayers = [];

class FlutterFlowVideoPlayer extends StatefulWidget {


  FlutterFlowVideoPlayer({
    required this.path,
    this.videoType = VideoType.network,
    this.width,
    this.height,
    this.aspectRatio,
    this.autoPlay = false,
    this.looping = false,
    this.showControls = true,
    this.allowFullScreen = true,
    this.allowPlaybackSpeedMenu = false,
    this.lazyLoad = false,
    this.isFromPropertyDetail = false,
    this.propertiesIndex,
    this.currentPropertyindex,
    this.isPaused,
    this.homeScreenLength,
    required this.screenName,
    required this.posterImage,
  });

  final String path;
  final VideoType videoType;
  final double? width;
  final double? height;
  final double? aspectRatio;
  final bool autoPlay;
  final bool looping;
  final bool showControls;
  final bool allowFullScreen;
  final bool allowPlaybackSpeedMenu;
  final bool lazyLoad;
  final bool isFromPropertyDetail;
  final int? propertiesIndex;
  int? currentPropertyindex;
  final bool? isPaused;
  final int? homeScreenLength;
  final String screenName;
  final String posterImage;

  @override
  State<StatefulWidget> createState() => _FlutterFlowVideoPlayerState();
}

class _FlutterFlowVideoPlayerState extends State<FlutterFlowVideoPlayer> {
  bool isPaused = false;
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _loggedError = false;

  @override
  void initState() {
    super.initState();
    // isPaused=widget.isPaused;
    initializePlayer();
  }

  @override
  void dispose() {
    videoPlayers.remove(_videoPlayerController);
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  double get width => widget.width == null || widget.width! >= double.infinity
      ? MediaQuery.of(context).size.width
      : widget.width!;

  double get height =>
      widget.height == null || widget.height! >= double.infinity
          ? width / aspectRatio!
          : widget.height!;

  double? get aspectRatio =>
      _chewieController?.videoPlayerController.value.aspectRatio;

  void enterFullScreen() {
    _chewieController?.enterFullScreen();
  }

  Future initializePlayer() async {
    _videoPlayerController = widget.videoType == VideoType.network
        ? VideoPlayerController.network(widget.path)
        : VideoPlayerController.asset(widget.path);
    if (kIsWeb && widget.autoPlay) {
      // Browsers generally don't allow autoplay unless it's muted.
      // Ideally this should be configurable, but for now we just automatically
      // mute on web.
      // See https://pub.dev/packages/video_player_web#autoplay
      _videoPlayerController!.setVolume(0);
    }
    if (!widget.lazyLoad && widget.isFromPropertyDetail) {
      await _videoPlayerController?.initialize();
    }
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      deviceOrientationsOnEnterFullScreen: [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
      aspectRatio: widget.aspectRatio,
      autoPlay: widget.autoPlay,
      looping: widget.looping,
      showControls: widget.showControls,
      allowFullScreen: widget.allowFullScreen,
      allowPlaybackSpeedChanging: widget.allowPlaybackSpeedMenu,
    );
    setState(() {});

    print("Object_Key : ${ObjectKey(FlutterFlowVideoPlayer).toString()}");
    videoPlayers.add(_videoPlayerController!);

    print("_chewieController: ${_chewieController}");
    _videoPlayerController!.addListener(() {
      if (_videoPlayerController!.value.hasError && !_loggedError) {
        print(
            'Error playing video: ${_videoPlayerController!.value.errorDescription}');
        _loggedError = true;
      }
      //Stop all other players when one video is playing.
      // if (_videoPlayerController!.value.isPlaying) {
      //   videoPlayers.forEach((otherPlayer) {
      //     if (otherPlayer != _videoPlayerController &&
      //         otherPlayer.value.isPlaying) {
      //       setState(() {
      //
      //         if(otherPlayer.value.isInitialized) {
      //           otherPlayer.pause();
      //           var dataSource = otherPlayer.dataSource;
      //           otherPlayer.dispose();
      //           otherPlayer = widget.videoType == VideoType.network
      //               ? VideoPlayerController.network(dataSource)
      //               : VideoPlayerController.asset(dataSource);
      //         }
      //
      //       });
      //      }
      //    });
      // }
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.4,
    child: FittedBox(
      fit: BoxFit.cover,
      child: Container(
        height: height,
        width: width,
        child: (_chewieController != null &&
            (widget.lazyLoad ||
                _chewieController!
                    .videoPlayerController.value.isInitialized))
            ? Stack(
          alignment: Alignment.center,
          children: [
            Chewie(controller: _chewieController!),
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: InkWell(
                onTap: () {
                  isPaused = isPaused ? false : true;
                  isPaused
                      ? videoPlayers[returnsIndexBasedOnScreen(
                      widget.screenName,
                      widget.homeScreenLength,
                      widget.propertiesIndex) ??
                      0]
                      .pause()
                      : videoPlayers[returnsIndexBasedOnScreen(
                      widget.screenName,
                      widget.homeScreenLength,
                      widget.propertiesIndex) ??
                      0]
                      .play();
                  // ? videoPlayers[widget.propertiesIndex??0]
                  // .pause()
                  // : videoPlayers[widget.propertiesIndex??0]
                  // .play();
                  setState(() {});
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Center(
                    child: Container(
                      constraints:
                      BoxConstraints(minWidth: 50, maxWidth: 50),
                      decoration: BoxDecoration(
                        color: isPaused
                            ? Colors.black.withOpacity(1.0)
                            : Colors.black.withOpacity(0.0),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isPaused
                            ? Icons.play_arrow_rounded
                            : Icons.pause,
                        color: isPaused
                            ? Colors.white.withOpacity(1.0)
                            : Colors.white.withOpacity(0.0),
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //if ((videoPlayers).length >= 1)
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: ((widget.propertiesIndex) ==
                  ((widget.screenName == 'home')
                      ? (widget.currentPropertyindex)
                      : ((widget.currentPropertyindex) == 0
                      ? widget.currentPropertyindex =
                  widget.homeScreenLength!
                      : widget.currentPropertyindex =
                      widget.currentPropertyindex)! -
                      widget.homeScreenLength!)
                  ? Container()
                  : Container(
                constraints:
                BoxConstraints(minWidth: 50, maxWidth: 50),
                decoration: BoxDecoration(
                  color: (videoPlayers[
                  widget.currentPropertyindex ?? 0]
                      .value
                      .isInitialized)
                      ? Colors.black.withOpacity(1.0)
                      : Colors.black.withOpacity(0.0),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: (videoPlayers[
                  widget.currentPropertyindex ?? 0]
                      .value
                      .isInitialized)
                      ? Colors.white.withOpacity(1.0)
                      : Colors.white.withOpacity(0.0),
                  size: 40,
                ),
              )),
            ),
          ],
        )
            : (_chewieController != null &&
            _chewieController!.videoPlayerController.value.hasError)
            ? Text('Error playing video')
            : Column(
            mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
             // color: Colors.red,
                height: MediaQuery.of(context).size.height/4,
                width: MediaQuery.of(context).size.width,
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new NetworkImage(widget.posterImage),
                      fit: BoxFit.fitWidth,
                    )
                )
            ),

           // SizedBox(height: 25),
            (!widget.lazyLoad && widget.isFromPropertyDetail)
                ? Text('Loading')
                : SizedBox.shrink(),

          ],
        ),
      ),
    ),
  );

  int? returnsIndexBasedOnScreen(String? screenName, int? homeScreenLength, int? propertiesIndex) {
    if (screenName == 'home')
      return propertiesIndex;
    else if (screenName == 'search')
      return homeScreenLength! + propertiesIndex!;
    else if (screenName == 'filter')
      return homeScreenLength! + propertiesIndex!;
    return null;
  }
}

// import 'package:chewie/chewie.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:video_player/video_player.dart';
//
// //const kDefaultAspectRatio = 16 / 9;
//
// enum VideoType {
//   asset,
//   network,
// }
//
// List<VideoPlayerController> videoPlayers = [];
//
// class FlutterFlowVideoPlayer extends StatefulWidget {
//   const FlutterFlowVideoPlayer({
//     required this.path,
//     this.videoType = VideoType.network,
//     this.width,
//     this.height,
//     this.aspectRatio,
//     this.autoPlay = false,
//     this.looping = false,
//     this.showControls = true,
//     this.allowFullScreen = true,
//     this.allowPlaybackSpeedMenu = false,
//     this.lazyLoad = false,
//     this.isFromPropertyDetail = false,
//   });
//
//   final String path;
//   final VideoType videoType;
//   final double? width;
//   final double? height;
//   final double? aspectRatio;
//   final bool autoPlay;
//   final bool looping;
//   final bool showControls;
//   final bool allowFullScreen;
//   final bool allowPlaybackSpeedMenu;
//   final bool lazyLoad;
//   final bool isFromPropertyDetail;
//
//
//   @override
//   State<StatefulWidget> createState() => _FlutterFlowVideoPlayerState();
// }
//
// class _FlutterFlowVideoPlayerState extends State<FlutterFlowVideoPlayer> {
//   VideoPlayerController? _videoPlayerController;
//   ChewieController? _chewieController;
//   bool _loggedError = false;
//
//   @override
//   void initState() {
//     super.initState();
//     initializePlayer();
//   }
//
//   @override
//   void dispose() {
//     videoPlayers.remove(_videoPlayerController);
//     _videoPlayerController?.dispose();
//     _chewieController?.dispose();
//     super.dispose();
//   }
//
//   double get width => widget.width == null || widget.width! >= double.infinity
//       ? MediaQuery.of(context).size.width
//       : widget.width!;
//
//   double get height =>
//       widget.height == null || widget.height! >= double.infinity
//           ? width / aspectRatio!
//           : widget.height!;
//
//   double? get aspectRatio =>
//       _chewieController?.videoPlayerController.value.aspectRatio ;
//
//   void enterFullScreen() {
//     _chewieController?.enterFullScreen();
//   }
//
//   Future initializePlayer() async {
//     _videoPlayerController = widget.videoType == VideoType.network
//         ? VideoPlayerController.network(widget.path)
//         : VideoPlayerController.asset(widget.path);
//     if (kIsWeb && widget.autoPlay) {
//       // Browsers generally don't allow autoplay unless it's muted.
//       // Ideally this should be configurable, but for now we just automatically
//       // mute on web.
//       // See https://pub.dev/packages/video_player_web#autoplay
//       _videoPlayerController!.setVolume(0);
//     }
//     if (!widget.lazyLoad && widget.isFromPropertyDetail) {
//       await _videoPlayerController?.initialize();
//     }
//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController!,
//       deviceOrientationsOnEnterFullScreen: [
//         DeviceOrientation.landscapeLeft,
//         DeviceOrientation.landscapeRight,
//       ],
//       deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
//       aspectRatio: widget.aspectRatio,
//       autoPlay: widget.autoPlay,
//       looping: widget.looping,
//       showControls: widget.showControls,
//       allowFullScreen: widget.allowFullScreen,
//       allowPlaybackSpeedChanging: widget.allowPlaybackSpeedMenu,
//
//     );
//     setState(() {});
//
//     print("Object_Key : ${ObjectKey(FlutterFlowVideoPlayer).toString()}");
//     videoPlayers.add(_videoPlayerController!);
//
//
//     print("_chewieController: ${_chewieController}");
//     _videoPlayerController!.addListener(() {
//       if (_videoPlayerController!.value.hasError && !_loggedError) {
//         print(
//             'Error playing video: ${_videoPlayerController!.value.errorDescription}');
//         _loggedError = true;
//       }
//       //Stop all other players when one video is playing.
//       // if (_videoPlayerController!.value.isPlaying) {
//       //   videoPlayers.forEach((otherPlayer) {
//       //     if (otherPlayer != _videoPlayerController &&
//       //         otherPlayer.value.isPlaying) {
//       //       setState(() {
//       //
//       //         if(otherPlayer.value.isInitialized) {
//       //           otherPlayer.pause();
//       //           var dataSource = otherPlayer.dataSource;
//       //           otherPlayer.dispose();
//       //           otherPlayer = widget.videoType == VideoType.network
//       //               ? VideoPlayerController.network(dataSource)
//       //               : VideoPlayerController.asset(dataSource);
//       //         }
//       //
//       //       });
//       //      }
//       //    });
//       // }
//     });
//
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) => Container(
//     width: MediaQuery.of(context).size.width,
//     height:
//     MediaQuery.of(context).size.height*0.4,
//     child: FittedBox(
//           fit: BoxFit.cover,
//           child: Container(
//             height: height,
//             width: width,
//             child: (_chewieController != null &&
//                     (widget.lazyLoad ||
//                         _chewieController!
//                             .videoPlayerController.value.isInitialized))
//                 ? Chewie(controller: _chewieController!)
//                 : (_chewieController != null &&
//                         _chewieController!.videoPlayerController.value.hasError)
//                     ? Text('Error playing video')
//                     : Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children:  [
//                           Container(
//                             height: (!widget.lazyLoad && widget.isFromPropertyDetail)?25:35,
//                               width: (!widget.lazyLoad && widget.isFromPropertyDetail)?25:35,
//                               child: CircularProgressIndicator()),
//                           SizedBox(height: 25),
//                           (!widget.lazyLoad && widget.isFromPropertyDetail)? Text('Loading'):SizedBox.shrink(),
//                         ],
//                       ),
//           ),
//         ),
//   );
// }
