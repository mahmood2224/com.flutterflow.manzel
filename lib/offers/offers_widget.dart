import '../auth/auth_util.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class OffersWidget extends StatefulWidget {
  const OffersWidget({Key key}) : super(key: key);

  @override
  _OffersWidgetState createState() => _OffersWidgetState();
}

class _OffersWidgetState extends State<OffersWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance?.addPostFrameCallback((_) async {
      logFirebaseEvent('OFFERS_PAGE_Offers_ON_PAGE_LOAD');
      if ((valueOrDefault(currentUserDocument?.status, '')) == 'Active') {
        return;
      }

      logFirebaseEvent('Offers_Alert-Dialog');
      await showDialog(
        context: context,
        builder: (alertDialogContext) {
          return AlertDialog(
            title: Text('Please get your account activated'),
            content: Text(
                'You are not an active user please connect admin for further details on ok logout user '),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(alertDialogContext),
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
      logFirebaseEvent('Offers_Auth');
      GoRouter.of(context).prepareAuthEvent();
      await signOut();
      context.goNamedAuth('OnboardingView', mounted);
    });

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Offers'});
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 15, 16, 0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'mthnzz7x' /* Offers */,
                            ),
                            style: FlutterFlowTheme.of(context).title2.override(
                                  fontFamily: 'Sofia Pro By Khuzaimah',
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                  useGoogleFonts: false,
                                ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).white,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'r282eka0' /* You have  */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily:
                                                  'Sofia Pro By Khuzaimah',
                                              fontSize: 16,
                                              useGoogleFonts: false,
                                            ),
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          '9i2we2yx' /* 4 offers active */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily:
                                                  'Sofia Pro By Khuzaimah',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              useGoogleFonts: false,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'eiivr9zt' /*       */,
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 20,
                              color: Color(0x06000000),
                              offset: Offset(0, 9),
                              spreadRadius: 0,
                            )
                          ],
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xFFF4F4F4),
                          ),
                        ),
                        child: Icon(
                          Icons.filter_list,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15,
                              color: Color(0x06000000),
                              offset: Offset(0, 8),
                              spreadRadius: 0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Color(0xFFF1F1F1),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 15, 16, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 6, 0),
                                    child: Container(
                                      width: 82,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFD05C5C),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 3, 0, 3),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'vw6fpdxx' /* New offer */,
                                          ),
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily:
                                                    'Sofia Pro By Khuzaimah',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 6, 0),
                                    child: Container(
                                      width: 108,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF41566C),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 3, 0, 3),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'jmco7dzk' /* Await approval */,
                                          ),
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily:
                                                    'Sofia Pro By Khuzaimah',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 149,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF0A637),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 2, 0, 2),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'k2gp95dp' /* Sent, waiting for reply */,
                                        ),
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily:
                                                  'Sofia Pro By Khuzaimah',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              useGoogleFonts: false,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 5, 16, 14),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'gtkb9quu' /* AlRajhi Bank */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily:
                                                    'Sofia Pro By Khuzaimah',
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                't2kwojss' /* Offers for booking # */,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1,
                                            ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '9qrfxvvc' /* 277621515 */,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'ksabd4y2' /* 5 min ago */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily:
                                                    'Sofia Pro By Khuzaimah',
                                                color: Color(0xFF2971FB),
                                                fontWeight: FontWeight.bold,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                      ],
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(43),
                                      child: Image.network(
                                        'https://picsum.photos/seed/165/600',
                                        width: 43,
                                        height: 43,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: Color(0xFFF1F1F1),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 15, 26, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'ez8wbssn' /* Initial installment */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily:
                                                    'Sofia Pro By Khuzaimah',
                                                color: Color(0xFF6B6B6B),
                                                fontWeight: FontWeight.w300,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              functions.formatAmount('2700'),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'Sofia Pro By Khuzaimah',
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        useGoogleFonts: false,
                                                      ),
                                            ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'ldwv6qbd' /* .00 */,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'Sofia Pro By Khuzaimah',
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        useGoogleFonts: false,
                                                      ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(4, 0, 0, 4),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'z7x7wv59' /* SAR */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'Sofia Pro By Khuzaimah',
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts: false,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            '4ha591ne' /* Installment period */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily:
                                                    'Sofia Pro By Khuzaimah',
                                                color: Color(0xFF6B6B6B),
                                                fontWeight: FontWeight.w300,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'bm6xbs4z' /* 24 */,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'Sofia Pro By Khuzaimah',
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        useGoogleFonts: false,
                                                      ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(4, 0, 0, 4),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'b1jmmlnc' /* Month */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'Sofia Pro By Khuzaimah',
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts: false,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 18),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            '2kxnix92' /* Total price */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily:
                                                    'Sofia Pro By Khuzaimah',
                                                color: Color(0xFF6B6B6B),
                                                fontWeight: FontWeight.w300,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              functions.formatAmount('790000'),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'Sofia Pro By Khuzaimah',
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        useGoogleFonts: false,
                                                      ),
                                            ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'c0ty6rbh' /* .00 */,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'Sofia Pro By Khuzaimah',
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        useGoogleFonts: false,
                                                      ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(4, 0, 0, 4),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'h47bvnhi' /* SAR */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'Sofia Pro By Khuzaimah',
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts: false,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'wxex1r7b' /* Agent Name */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily:
                                                    'Sofia Pro By Khuzaimah',
                                                color: Color(0xFF6B6B6B),
                                                fontWeight: FontWeight.w300,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'g9lopb8b' /* Abdullah Ahmed */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily:
                                                    'Sofia Pro By Khuzaimah',
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 18),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        logFirebaseEvent(
                                            'OFFERS_PAGE_ACCEPT_BTN_ON_TAP');
                                        logFirebaseEvent('Button_Alert-Dialog');
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: Text('Accept offer'),
                                              content: Text(
                                                  'On acceptation this offer remaining offer will be rejected'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext),
                                                  child: Text('Ok'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      text: FFLocalizations.of(context).getText(
                                        'i1uf8h4b' /* Accept */,
                                      ),
                                      options: FFButtonOptions(
                                        width: 130,
                                        height: 38,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBtnText,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .subtitle2
                                            .override(
                                              fontFamily:
                                                  'Sofia Pro By Khuzaimah',
                                              color: Color(0xFF2971FB),
                                              useGoogleFonts: false,
                                            ),
                                        borderSide: BorderSide(
                                          color: Color(0xFF2971FB),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 0, 0, 0),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        print('Button pressed ...');
                                      },
                                      text: FFLocalizations.of(context).getText(
                                        '0ipnoq80' /* Starting Chatting */,
                                      ),
                                      options: FFButtonOptions(
                                        width: 173,
                                        height: 38,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryColor,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .subtitle2
                                            .override(
                                              fontFamily:
                                                  'Sofia Pro By Khuzaimah',
                                              color: Colors.white,
                                              useGoogleFonts: false,
                                            ),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 15,
                        color: Color(0x06000000),
                        offset: Offset(0, 8),
                        spreadRadius: 0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color(0xFFF1F1F1),
                    ),
                  ),
                  child: InkWell(
                    onTap: () async {
                      logFirebaseEvent('OFFERS_PAGE_Row_w1xydhtz_ON_TAP');
                      logFirebaseEvent('Row_Navigate-To');
                      context.pushNamed(
                        'PastOffers',
                        extra: <String, dynamic>{
                          kTransitionInfoKey: TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                          ),
                        },
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              '5gvwuuh2' /* Completed or canceled offers */,
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Sofia Pro By Khuzaimah',
                                      color: Color(0xFF474747),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: false,
                                    ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 17, 0),
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
