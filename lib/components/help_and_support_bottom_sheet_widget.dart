import '../auth/auth_util.dart';
import '../auth/firebase_user_provider.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpAndSupportBottomSheetWidget extends StatefulWidget {
  const HelpAndSupportBottomSheetWidget({Key? key}) : super(key: key);

  @override
  _HelpAndSupportBottomSheetWidgetState createState() =>
      _HelpAndSupportBottomSheetWidgetState();
}

class _HelpAndSupportBottomSheetWidgetState
    extends State<HelpAndSupportBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
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
                          'HELP_AND_SUPPORT_BOTTOM_SHEET_Icon_6if05');
                      logFirebaseEvent('Icon_Bottom-Sheet');
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 24,
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
                          FFLocalizations.of(context).getText(
                            'btyml6ed' /* Help & Support */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'AvenirArabic',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
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
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).white,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'emjcotxb' /* Please write us at */,
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'AvenirArabic',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: false,
                                    ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              'hwo08yn2' /* Support@manzel.app */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'AvenirArabic',
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: false,
                                ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              'pzfwn97d' /* for any query and concern */,
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'AvenirArabic',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: false,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).primaryText,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.email_outlined,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (loggedIn)
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 50, 20, 0),
                child: InkWell(
                  onTap: () async {
                    logFirebaseEvent(
                        'HELP_AND_SUPPORT_BOTTOM_SHEET_Container_');
                    Function() _navigate = () {};
                    if (FFAppState().locale == 'en') {
                      logFirebaseEvent('Container_Alert-Dialog');
                      var confirmDialogResponse = await showDialog<bool>(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(
                                        alertDialogContext, false),
                                    child: Text(''),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext, true),
                                    child: Text(''),
                                  ),
                                ],
                              );
                            },
                          ) ??
                          false;
                      if (confirmDialogResponse) {
                        logFirebaseEvent('Container_Backend-Call');

                        final userUpdateData = createUserRecordData(
                          isDeleted: 1,
                        );
                        await currentUserReference!.update(userUpdateData);
                        logFirebaseEvent('Container_Auth');
                        GoRouter.of(context).prepareAuthEvent();
                        await signOut();
                        _navigate = () =>
                            context.goNamedAuth('OnboardingView', mounted);
                      } else {
                        logFirebaseEvent('Container_Wait-Delay');
                        await Future.delayed(const Duration(milliseconds: 100));
                        logFirebaseEvent('Container_Bottom-Sheet');
                        Navigator.pop(context);
                      }
                    } else {
                      logFirebaseEvent('Container_Alert-Dialog');
                      var confirmDialogResponse = await showDialog<bool>(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(
                                        alertDialogContext, false),
                                    child: Text(''),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext, true),
                                    child: Text(''),
                                  ),
                                ],
                              );
                            },
                          ) ??
                          false;
                      if (confirmDialogResponse) {
                        logFirebaseEvent('Container_Backend-Call');

                        final userUpdateData = createUserRecordData(
                          isDeleted: 1,
                        );
                        await currentUserReference!.update(userUpdateData);
                        logFirebaseEvent('Container_Auth');
                        GoRouter.of(context).prepareAuthEvent();
                        await signOut();
                        _navigate = () =>
                            context.goNamedAuth('OnboardingView', mounted);
                      } else {
                        logFirebaseEvent('Container_Wait-Delay');
                        await Future.delayed(const Duration(milliseconds: 100));
                        logFirebaseEvent('Container_Bottom-Sheet');
                        Navigator.pop(context);
                      }
                    }

                    _navigate();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.delete_sweep_outlined,
                            color: FlutterFlowTheme.of(context).primaryColor,
                            size: 24,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'eaazmbdx' /* Delete Account */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'AvenirArabic',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    useGoogleFonts: false,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
