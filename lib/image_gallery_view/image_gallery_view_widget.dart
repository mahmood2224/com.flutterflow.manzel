import 'package:manzel/common_widgets/manzel_icons.dart';

import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_expanded_image_view.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share_plus/share_plus.dart';

class ImageGalleryViewWidget extends StatefulWidget {
  const ImageGalleryViewWidget({
    Key? key,
    this.propertyId,
  }) : super(key: key);

  final int? propertyId;

  @override
  _ImageGalleryViewWidgetState createState() => _ImageGalleryViewWidgetState();
}

class _ImageGalleryViewWidgetState extends State<ImageGalleryViewWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'imageGalleryView'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(18, 6, 18, 6),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 6),
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xFFF3F2F2),
                            width: 1,
                          ),
                        ),
                        child: InkWell(
                          onTap: () async {
                            logFirebaseEvent(
                                'IMAGE_GALLERY_VIEW_Icon_61cpjbpa_ON_TAP');
                            logFirebaseEvent('Icon_Close-Dialog,-Drawer,-Etc');
                            Navigator.pop(context);
                          },
                          child: RotatedBox(
                            quarterTurns: FFAppState().locale=='en'?0:2,
                            child: Icon(
                              Manzel.back_icon,
                              color: Colors.black,
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).white,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 26, 0),
                            child: InkWell(
                              onTap: () async {
                                logFirebaseEvent(
                                    'IMAGE_GALLERY_VIEW_Container_sx0hx6fk_ON');
                                // shareProperty
                                logFirebaseEvent('Container_shareProperty');
                                await Share.share(
                                    'manzel://manzel.com${GoRouter.of(context).location}');
                              },
                              child: Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color(0xFFF3F2F2),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      6, 6, 6, 6),
                                  child: Icon(
                                    Manzel.share,
                                    color: Colors.black,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color(0xFFF3F2F2),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(6, 6, 6, 6),
                              child: Icon(
                                Manzel.favorite,
                                color: Colors.black,
                                size: 16,
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder<ApiCallResponse>(
                  future: PropertyCall.call(
                    propertyId: widget.propertyId,
                    locale: FFAppState().locale,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: SpinKitRipple(
                            color: FlutterFlowTheme.of(context).primaryColor,
                            size: 50,
                          ),
                        ),
                      );
                    }
                    final listViewPropertyResponse = snapshot.data!;
                    return Builder(
                      builder: (context) {
                        final images = getJsonField(
                            listViewPropertyResponse.jsonBody,

    r'''$.data.attributes.property_images.data''').toList();
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: images.length,
                          itemBuilder: (context, imagesIndex) {
                            final imagesItem = images[imagesIndex];
                            return Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 6, 8, 6),
                              child: InkWell(
                                onTap: () async {
                                  logFirebaseEvent(
                                      'IMAGE_GALLERY_VIEW_Image_xq7pxmei_ON_TAP');
                                  logFirebaseEvent('Image_Expand-Image');
                                  await Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: FlutterFlowExpandedImageView(
                                        image: Image.network(
                                          getJsonField(
                                            imagesItem,
                                            r'''$.attributes.formats.medium.url''',
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                        allowRotation: false,
                                        tag: getJsonField(
                                          imagesItem,
                                          r'''$.attributes.formats.medium.url''',
                                        ),
                                        useHeroAnimation: true,
                                      ),
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: getJsonField(
                                    imagesItem,
                                    r'''$.attributes.formats.medium.url''',
                                  ),
                                  transitionOnUserGestures: true,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      getJsonField(
                                        imagesItem,
                                        r'''$.attributes.formats.medium.url''',
                                      ),
                                      width: 100,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.27,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
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
    );
  }
}
