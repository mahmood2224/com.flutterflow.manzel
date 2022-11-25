import 'package:manzel/common_alert_dialog/common_alert_dialog.dart';
import 'package:manzel/common_widgets/manzel_icons.dart';
import 'package:manzel/components/something_went_wrong_widget.dart';
import 'package:manzel/flutter_flow/custom_functions.dart';

import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsConditionsBottomSheetWidget extends StatefulWidget {
  const TermsConditionsBottomSheetWidget({
    Key? key,
    this.pageType,
  }) : super(key: key);

  final int? pageType;

  @override
  _TermsConditionsBottomSheetWidgetState createState() =>
      _TermsConditionsBottomSheetWidgetState();
}



class _TermsConditionsBottomSheetWidgetState
    extends State<TermsConditionsBottomSheetWidget> {

  ApiCallResponse?  columnTermsConitionsAndPrivacyPoliciesResponse;
  bool termsAndConditionsLoading = true;
  bool? isInternetAvailable;


  @override
  void initState(){
    super.initState();
    termsAndConditions();

  }

  Future<void> termsAndConditions() async {
    termsAndConditionsLoading = true;
    setState(() {});
    isInternetAvailable = await isInternetConnected();
    if (isInternetAvailable ?? false) {
      columnTermsConitionsAndPrivacyPoliciesResponse = await TermsConitionsAndPrivacyPoliciesCall.call(
        pageType: widget.pageType,
        locale: FFAppState().locale,
      );
      termsAndConditionsLoading = false;
      setState(() {});
    } else {
      termsAndConditionsLoading = false;
      setState((){});
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
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBtnText,
      ),
      child: Builder(
        builder: (context) {
          // Customize what your widget looks like when it's loading.
          if (termsAndConditionsLoading) {
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
          else if(columnTermsConitionsAndPrivacyPoliciesResponse?.statusCode!=null&&columnTermsConitionsAndPrivacyPoliciesResponse?.statusCode==200){
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).white,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                          child: InkWell(
                            onTap: () async {
                              logFirebaseEvent(
                                  'TERMS_CONDITIONS_BOTTOM_SHEET_Icon_hhw3c');
                              logFirebaseEvent('Icon_Bottom-Sheet');
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Manzel.clear,
                              color: Colors.black,
                              size: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  valueOrDefault<String>(
                                    getJsonField(
                                      columnTermsConitionsAndPrivacyPoliciesResponse?.jsonBody,
                                      r'''$.data.attributes.title''',
                                    ).toString(),
                                    'null',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                    fontFamily: 'AvenirArabic',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Html(
                            data: valueOrDefault<String>(
                              getJsonField(
                                columnTermsConitionsAndPrivacyPoliciesResponse?.jsonBody,
                                r'''$.data.attributes.description''',
                              ).toString(),
                              'null',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          else if(columnTermsConitionsAndPrivacyPoliciesResponse?.statusCode!=null&&columnTermsConitionsAndPrivacyPoliciesResponse?.statusCode!=200){
            return SomethingWentWrongWidget(onTryAgain: (){
              termsAndConditions();
            });
          }
          else if(columnTermsConitionsAndPrivacyPoliciesResponse?.statusCode==403){
            termsAndConditions();
          }
          return SizedBox();

        },
      ),
    );
  }
}
