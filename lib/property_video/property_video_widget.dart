import 'package:flick_video_player/flick_video_player.dart';
import 'package:manzel/common_widgets/manzel_icons.dart';
import 'package:video_player/video_player.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class PropertyVideoWidget extends StatefulWidget {
  const PropertyVideoWidget({
    Key? key,
    this.videoURL,
    this.propertyName,
  }) : super(key: key);

  final String? videoURL;
  final String? propertyName;

  @override
  _PropertyVideoWidgetState createState() => _PropertyVideoWidgetState();
}

class _PropertyVideoWidgetState extends State<PropertyVideoWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
         widget.videoURL!),
    );
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'propertyVideo'});
  }
@override
  void dispose() {
  flickManager.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: RotatedBox(
          quarterTurns: FFAppState().locale=='en'?0:2,
          child: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Manzel.back_icon,
              color: Colors.black,
              size: 15,
            ),
            onPressed: () async {
              logFirebaseEvent('PROPERTY_VIDEO_arrow_back_rounded_ICN_ON');
              logFirebaseEvent('IconButton_Close-Dialog,-Drawer,-Etc');
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          widget.propertyName!,
          style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'AvenirArabic',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                useGoogleFonts: false,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child:FlickVideoPlayer(
                  flickManager: flickManager,
                  flickVideoWithControls: FlickVideoWithControls(
                    closedCaptionTextStyle: TextStyle(fontSize: 8),
                    controls: FlickPortraitControls(),
                  ),
                  flickVideoWithControlsFullscreen: FlickVideoWithControls(
                    controls: FlickLandscapeControls(),
                  ),
                ),
                // FlutterFlowVideoPlayer(
                //   path: widget.videoURL!,
                //   videoType: VideoType.network,
                //   width: double.infinity,
                //   height: MediaQuery.of(context).size.height * 0.85,
                //   autoPlay: true,
                //   looping: true,
                //   showControls: true,
                //   allowFullScreen: true,
                //   allowPlaybackSpeedMenu: false,
                //   isFromPropertyDetail: true,
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
