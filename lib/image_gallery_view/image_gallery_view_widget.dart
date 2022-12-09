import 'package:manzel/auth/auth_util.dart';
import 'package:manzel/auth/firebase_user_provider.dart';
import 'package:manzel/common_widgets/manzel_icons.dart';
import 'package:manzel/flutter_flow/flutter_flow_icon_button.dart';
import 'package:manzel/zoom_image/zoom_image_widget.dart';
import '../common_alert_dialog/common_alert_dialog.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/custom_functions.dart';
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
    this.screenName,
    this.imageList,
  }) : super(key: key);

  final int? propertyId;
  final String? screenName;
  final dynamic imageList;

  @override
  _ImageGalleryViewWidgetState createState() => _ImageGalleryViewWidgetState();
}

class _ImageGalleryViewWidgetState extends State<ImageGalleryViewWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic> imageList = [];
  Map<String, bool> fav = {};
  bool? bookMarkTapped;
  bool? isInternetAvailable;

  @override
  void initState() {
    super.initState();
    fav = FavouriteList.instance.favourite;
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'imageGalleryView'});
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      checkimageListUrl();
    });
  }

  void checkimageListUrl() async {
    isInternetAvailable = await isInternetConnected();
    if (widget.imageList.length == 1) {
      imageList = [
        getJsonField(widget.imageList, r'''$..attributes.formats.medium.url''')
      ];
    } else {
      imageList = getJsonField(
          widget.imageList, r'''$..attributes.formats.medium.url''');
    }

    if (imageList.isEmpty && (!(isInternetAvailable ?? false))) {
      showDialog(
        context: context,
        builder: (BuildContext context) => CommonAlertDialog(
          onCancel: () {
            Navigator.pop(context);
          },
        ),
      );
    }
    if (mounted) setState(() {});
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
                        width: 40,
                        height: 40,
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
                            FavouriteList.instance.setFavourite(fav);
                            context.pop();
                          },
                          child: RotatedBox(
                            quarterTurns: FFAppState().locale == 'en' ? 0 : 2,
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
                          InkWell(
                            onTap: () async {
                              logFirebaseEvent(
                                  'IMAGE_GALLERY_VIEW_Container_sx0hx6fk_ON');
                              // shareProperty
                              logFirebaseEvent('Container_shareProperty');
                              await Share.share(
                                  'manzel://manzel.com${GoRouter.of(context).location}');
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade200,width:1),
                                color: Colors.white,
                                shape: BoxShape.circle,),
                              child: Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(2, 5, 2, 5),
                                child: Icon(
                                  Manzel.share,
                                  color: Colors.black,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20,),
                          InkWell(
                            onTap: () async {
                              logFirebaseEvent('add_to_wishlist');
                              logFirebaseEvent(
                                  'HOME_SCREEN_Container_jprwonvd_ON_TAP');
                              if (loggedIn) {
                                bool isInternetAvailable =
                                    await isInternetConnected();
                                if (isInternetAvailable) {
                                  if (fav[widget.propertyId.toString()] ??
                                      false) {
                                    logFirebaseEvent('Container_Backend-Call');
                                    final bookmarkApiResponse =
                                        await BookmarkPropertyCall.call(
                                      userId: currentUserUid,
                                      authorazationToken:
                                          FFAppState().authToken,
                                      propertyId: widget.propertyId.toString(),
                                      version: FFAppState().apiVersion,
                                    );
                                    if ((bookmarkApiResponse.statusCode) ==
                                        200) {
                                      fav.remove(widget.propertyId.toString());
                                    } else if ((bookmarkApiResponse
                                            .statusCode) ==
                                        403) {
                                      unAuthorizedUser(context, mounted);
                                    } else {
                                      logFirebaseEvent('Icon_Show-Snack-Bar');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            functions.snackBarMessage(
                                                'error', FFAppState().locale),
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              height: 2,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryRed,
                                        ),
                                      );
                                    }
                                  } else {
                                    logFirebaseEvent('Container_Backend-Call');
                                    final bookmarkApiResponse =
                                        await BookmarkPropertyCall.call(
                                      userId: currentUserUid,
                                      authorazationToken:
                                          FFAppState().authToken,
                                      propertyId: widget.propertyId.toString(),
                                      version: FFAppState().apiVersion,
                                    );
                                    if ((bookmarkApiResponse.statusCode) ==
                                        200) {
                                      fav[widget.propertyId.toString()] = true;
                                    } else if ((bookmarkApiResponse
                                            .statusCode) ==
                                        403) {
                                      unAuthorizedUser(context, mounted);
                                    } else {
                                      logFirebaseEvent('Icon_Show-Snack-Bar');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            functions.snackBarMessage(
                                                'error', FFAppState().locale),
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              height: 2,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryRed,
                                        ),
                                      );
                                    }
                                  }
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CommonAlertDialog(
                                      onCancel: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                }
                              } else {
                                logFirebaseEvent('Container_Navigate-To');
                                context.pushNamed('Login');
                              }
                              bookMarkTapped = false;
                              setState(() {});
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade200,width:1),
                                  color: (fav[widget.propertyId.toString()] ??
                                          false)
                                      ? FlutterFlowTheme.of(context).primaryRed
                                      : Colors.white,
                                  shape: BoxShape.circle,),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(2, 5, 2, 5),
                                child: Icon(
                                  Manzel.favourite,
                                  color: (fav[widget.propertyId.toString()] ??
                                          false)
                                      ? Colors.white
                                      : Colors.black,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (imageList.isEmpty && (isInternetAvailable ?? false)) {
                      return SizedBox();
                    }
                    // imageList = widget.imageList.length==1?
                    // [getJsonField(
                    //     widget.imageList,
                    //     r'''$..attributes.formats.medium.url''')]:getJsonField(
                    //     widget.imageList,
                    //     r'''$..attributes.formats.medium.url''');
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: imageList.length,
                      itemBuilder: (context, imagesIndex) {
                        final imagesItem = widget.imageList[imagesIndex];
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 6, 8, 6),
                          child: InkWell(
                            onTap: () async {
                              //PageTransition(
                              //   type: PageTransitionType.fade,
                              //   child: FlutterFlowExpandedImageView(
                              //     image: Image.network(
                              //       getJsonField(
                              //         imagesItem,
                              //         r'''$.attributes.formats.medium.url''',
                              //       ),
                              //       fit: BoxFit.contain,
                              //     ),
                              //     allowRotation: false,
                              //     tag: getJsonField(
                              //       imagesItem,
                              //       r'''$.attributes.formats.medium.url''',
                              //     ),
                              //     useHeroAnimation: true,
                              //   ),
                              logFirebaseEvent(
                                  'IMAGE_GALLERY_VIEW_Image_xq7pxmei_ON_TAP');
                              logFirebaseEvent('Image_Expand-Image');
                              Map<int, String> dataList = {};
                              int count = 1;
                              imageList.forEach((element) {
                                dataList[count] = element.toString();
                                count += 1;
                              });
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ZoomImage(
                                    data: dataList,
                                    index: imagesIndex,
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
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                  width: 100,
                                  height:
                                      MediaQuery.of(context).size.height * 0.27,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
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
    );
  }
}
