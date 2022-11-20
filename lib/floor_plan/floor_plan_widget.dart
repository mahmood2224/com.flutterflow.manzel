import 'package:manzel/common_widgets/manzel_icons.dart';

import '../backend/api_requests/api_calls.dart';
import '../common_alert_dialog/common_alert_dialog.dart';
import '../components/something_went_wrong_widget.dart';
import '../flutter_flow/custom_functions.dart';
import '../flutter_flow/flutter_flow_expanded_image_view.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class FloorPlanWidget extends StatefulWidget {
  const FloorPlanWidget({
    Key? key,
    this.propertyId,
  }) : super(key: key);

  final int? propertyId;

  @override
  _FloorPlanWidgetState createState() => _FloorPlanWidgetState();
}

class _FloorPlanWidgetState extends State<FloorPlanWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ApiCallResponse? columnPropertyResponse;
  bool? isInternetAvailable;
  bool isLoading = true;


  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'FloorPlan'});
    propertyCall();
  }
  Future<void> propertyCall() async {
    isInternetAvailable = await isInternetConnected();
    if(isInternetAvailable??false){
      columnPropertyResponse = await PropertyCall.call(
        propertyId: widget.propertyId,
        locale: FFAppState().locale,
      );
      isLoading=false;
      setState(() {});
    }else{
      isLoading=false;
      setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () async {
            logFirebaseEvent('FLOOR_PLAN_PAGE_Icon_r92djljt_ON_TAP');
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
        title: Text(
          FFLocalizations.of(context).getText(
            '316x1ckw' /* Floor Plan  */,
          ),
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'AvenirArabic',
                color: Colors.black,
                fontSize: 22,
                useGoogleFonts: false,
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Builder(
            builder: (context) {
              // Customize what your widget looks like when it's loading.
              if (isLoading) {
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
              else if(columnPropertyResponse!=null&&columnPropertyResponse?.statusCode==200){
                return SomethingWentWrongWidget(
                  onTryAgain: (){
                  },
                );
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 30),
                        child: InkWell(
                          onTap: () async {
                            logFirebaseEvent(
                                'FLOOR_PLAN_PAGE_Image_762wwk00_ON_TAP');
                            logFirebaseEvent('Image_Expand-Image');
                            await Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: FlutterFlowExpandedImageView(
                                  image: Image.network(
                                    getJsonField(
                                      columnPropertyResponse?.jsonBody,
                                      r'''$.data.attributes.property_floor_plan.data.attributes.formats.medium.url''',
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                  allowRotation: false,
                                  tag: getJsonField(
                                    columnPropertyResponse?.jsonBody,
                                    r'''$.data.attributes.property_floor_plan.data.attributes.url''',
                                  ),
                                  useHeroAnimation: true,
                                ),
                              ),
                            );
                          },
                          child: Hero(
                            tag: getJsonField(
                              columnPropertyResponse?.jsonBody,
                              r'''$.data.attributes.property_floor_plan.data.attributes.url''',
                            ),
                            transitionOnUserGestures: true,
                            child: Image.network(
                              getJsonField(
                                columnPropertyResponse?.jsonBody,
                                r'''$.data.attributes.property_floor_plan.data.attributes.url''',
                              ),
                              width: double.infinity,
                              height: 500,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              else if ((columnPropertyResponse?.statusCode !=
                  200) &&
                  (columnPropertyResponse?.statusCode !=
                      null)){
                return SomethingWentWrongWidget(
                  onTryAgain: (){
                  },
                );
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
