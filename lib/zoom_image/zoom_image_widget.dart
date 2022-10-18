import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manzel/app_state.dart';
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
    return Scaffold(
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
                  InteractiveViewer(child:  CachedNetworkImage(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.contain,
                    imageUrl: imageLinks![index]!,
                  ),
                    //for pinch zoom
                    // resetDuration:
                    // const Duration(milliseconds: 100),
                    // maxScale: 2.5,
                    // onZoomStart: () {
                    //
                    // },
                    // onZoomEnd: () {
                    //
                    // },
                  );
              },
              controller: pageController,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 1),
                  child:  Text('${(pageNumber??-1)+1} ${FFAppState().locale=='en'?' of ':' من '} ${imageLinks?.length??0}',style: textTheme.bodyLarge!.copyWith(color: Colors.white,fontWeight: FontWeight.w400),),

                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
