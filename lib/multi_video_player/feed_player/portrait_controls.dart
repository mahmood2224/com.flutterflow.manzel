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
