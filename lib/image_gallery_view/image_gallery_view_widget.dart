import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:manzel/auth/auth_util.dart';
import 'package:manzel/auth/firebase_user_provider.dart';
import 'package:manzel/common_widgets/manzel_icons.dart';
import 'package:manzel/enviorment/env_variables.dart';
import 'package:manzel/zoom_image/zoom_image_widget.dart';
import '../common_alert_dialog/common_alert_dialog.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/custom_functions.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ImageGalleryViewWidget extends StatefulWidget {
  const ImageGalleryViewWidget({
    Key? key,
    this.propertyId,
    this.screenName,
    this.imageList,
    this.jsonData

  }) : super(key: key);

  final int? propertyId;
  final String? screenName;
  final dynamic imageList;
  final dynamic jsonData;

  @override
  _ImageGalleryViewWidgetState createState() => _ImageGalleryViewWidgetState();
}

class _ImageGalleryViewWidgetState extends State<ImageGalleryViewWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic> imageList = [];
  Map<String, bool> fav = {};
  bool? isInternetAvailable;
  var columnPropertyResponse;
  ValueNotifier<bool> bookMarkTapped = ValueNotifier<bool>(false);


  @override
  void initState() {
    super.initState();
    fav = FavouriteList.instance.favourite;
    if (widget.jsonData != null) {
      columnPropertyResponse = widget.jsonData;
    }
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
                              isInternetAvailable= await isInternetConnected();
                              logFirebaseEvent(
                                  'IMAGE_GALLERY_VIEW_Container_sx0hx6fk_ON');
                              // shareProperty
                              logFirebaseEvent('Container_shareProperty');
                              if(isInternetAvailable??false){
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
                              }else{
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
                          ValueListenableBuilder(
                              valueListenable:bookMarkTapped,
                              builder: (context,value,child) {
                                return InkWell(
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'add_to_wishlist');
                                    logFirebaseEvent(
                                        'HOME_SCREEN_Container_jprwonvd_ON_TAP');
                                    bookMarkTapped.value=!bookMarkTapped.value;
                                    if (loggedIn) {
                                      bool isInternetAvailable = await isInternetConnected();
                                      if(isInternetAvailable){
                                        fav[widget.propertyId.toString()]=!(fav[widget.propertyId.toString()]??false);
                                        logFirebaseEvent(
                                            'Container_Backend-Call');
                                        final bookmarkApiResponse =
                                        await BookmarkPropertyCall
                                            .call(
                                          userId:
                                          currentUserUid,
                                          authorazationToken:
                                          FFAppState()
                                              .authToken,
                                          propertyId: widget
                                              .propertyId
                                              .toString(),
                                          version:
                                          FFAppState()
                                              .apiVersion,
                                        );
                                        if ((bookmarkApiResponse
                                            .statusCode) ==
                                            200) {
                                          if((fav[widget.propertyId.toString()] ?? false)){
                                            fav[widget
                                                .propertyId
                                                .toString()] = true;
                                          }else{
                                            fav.remove(widget.propertyId.toString());
                                          }

                                        } else {
                                          logFirebaseEvent(
                                              'Icon_Show-Snack-Bar');
                                          ScaffoldMessenger.of(
                                              context)
                                              .showSnackBar(
                                            SnackBar(
                                              content:
                                              Text(
                                                functions.snackBarMessage(
                                                    'error',
                                                    FFAppState()
                                                        .locale),
                                                style:
                                                TextStyle(
                                                  color: FlutterFlowTheme.of(context)
                                                      .white,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize:
                                                  16,
                                                  height:
                                                  2,
                                                ),
                                              ),
                                              duration: Duration(
                                                  milliseconds:
                                                  4000),
                                              backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryRed,
                                            ),
                                          );
                                        }
                                      }
                                      else{
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) => CommonAlertDialog(
                                            onCancel: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        );
                                      }
                                    }
                                    else {
                                      logFirebaseEvent(
                                          'Container_Navigate-To');
                                      context.pushNamed(
                                          'Login');
                                    }
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
                                );
                              }
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
      uriPrefix:  '${EnvVariables.instance.dynamicLinkUrl}',
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
}
