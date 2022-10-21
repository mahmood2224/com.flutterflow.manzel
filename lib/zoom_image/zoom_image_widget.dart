import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manzel/app_state.dart';
import 'package:manzel/common_widgets/manzel_icons.dart';
import 'package:manzel/flutter_flow/flutter_flow_theme.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

import '../backend/firebase_analytics/analytics.dart';


class ZoomImage extends StatefulWidget {
  const ZoomImage({Key? key,this.data,this.index}):super(key: key);

  final Map? data;
  final int? index;


  @override
  _ZoomImageState createState() => _ZoomImageState();
}

class _ZoomImageState extends State<ZoomImage> {
  PageController? pageController;
  late List<String> imageLinks = [];
  int? index;
  int? pageNumber;
  @override
  void initState() {
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'ZoomImage'});
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom
    ]);
    widget.data!.forEach((key, value) {
      imageLinks.add(value!);
    });
    index = widget.index;
    pageNumber  = index;
    pageController = PageController(
        initialPage: index??1, keepPage: true, viewportFraction: 1);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          color: Colors.black,
          child: Stack(
            children: [
              PageView.builder(
                onPageChanged: (v){
                  setState(() {
                    pageNumber = v;
                  });
                },
                itemCount: imageLinks?.length??0,
                itemBuilder: (_, int index) {
                  return
                    PinchZoom(child:  CachedNetworkImage(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.contain,
                      imageUrl: imageLinks![index]!,
                    ),
                      //for pinch zoom
                      resetDuration:
                      const Duration(milliseconds: 100),
                      maxScale: 2.5,
                      onZoomStart: () {

                      },
                      onZoomEnd: () {

                      },
                    );
                },
                controller: pageController,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap :(){
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top:8 ,left:20 ),
                          child: RotatedBox(
                            quarterTurns: FFAppState().locale=='en'?0:2,
                            child: Container(
                              height: 34,
                              width: 34,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white),
                              ),
                              child: Icon(
                                Manzel.back_icon,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:17 ,right:20 ),
                        child: Text('${(pageNumber??-1)+1} / ${imageLinks?.length??0}',style: FlutterFlowTheme.of(context)
                            .bodyText1
                            .override(
                          fontFamily: 'AvenirArabic',
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          useGoogleFonts: false,
                        ),),
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
