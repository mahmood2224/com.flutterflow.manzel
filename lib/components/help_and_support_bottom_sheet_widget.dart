import 'package:manzel/common_widgets/manzel_icons.dart';
import 'package:flutter/services.dart';
import '../auth/auth_util.dart';
import '../auth/firebase_user_provider.dart';
import '../backend/backend.dart';
import '../common_alert_dialog/common_alert_dialog.dart';
import '../flutter_flow/custom_functions.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

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
                      Manzel.clear,
                      color: Colors.black,
                      size: 18,
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
                          InkWell(
                            onTap: () async {
                              await Clipboard.setData(
                                      ClipboardData(text: "Support@manzel.app"))
                                  .then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(FFAppState().locale ==
                                                'en'
                                            ? 'Copied to your clipboard !'
                                            : 'نسخ إلى الحافظة الخاصة بك')));
                              });
                            },
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'hwo08yn2' /* Support@manzel.app */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'AvenirArabic',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    useGoogleFonts: false,
                                  ),
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
                    InkWell(
                      onTap: () async {
                        await Clipboard.setData(
                            ClipboardData(text: "Support@manzel.app"))
                            .then((_) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(FFAppState().locale ==
                                      'en'
                                      ? 'Copied to your clipboard !'
                                      : 'نسخ إلى الحافظة الخاصة بك')));
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).primaryText,
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          Manzel.mail_icon,
                          color: Colors.black,
                          size: 24,
                        ),
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
                      bool isInternetAvailable = await isInternetConnected();
                      if(isInternetAvailable){
                        logFirebaseEvent('Container_Alert-Dialog');
                        var confirmDialogResponse = await showDialog<bool>(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: Text('Delete Account '),
                              content: Text(
                                  'Your account deletion will be processed soon'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(
                                      alertDialogContext, false),
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext, true),
                                  child: Text('Confirm'),
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

                    } else {
                      logFirebaseEvent('Container_Alert-Dialog');
                      bool isInternetAvailable = await isInternetConnected();
                      if(isInternetAvailable){
                        var confirmDialogResponse = await showDialog<bool>(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: Text('حذف حسابي'),
                              content: Text('سيتم معالجة حذف حسابك قريبًا'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(
                                      alertDialogContext, false),
                                  child: Text('إلغاء'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext, true),
                                  child: Text('تأكيد'),
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
