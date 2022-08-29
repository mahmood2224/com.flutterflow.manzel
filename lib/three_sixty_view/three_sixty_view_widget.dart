import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class ThreeSixtyViewWidget extends StatefulWidget {
  const ThreeSixtyViewWidget({Key key}) : super(key: key);

  @override
  _ThreeSixtyViewWidgetState createState() => _ThreeSixtyViewWidgetState();
}

class _ThreeSixtyViewWidgetState extends State<ThreeSixtyViewWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'ThreeSixtyView'});
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
            logFirebaseEvent('THREE_SIXTY_VIEW_Icon_p867d9du_ON_TAP');
            logFirebaseEvent('Icon_Close-Dialog,-Drawer,-Etc');
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
            size: 24,
          ),
        ),
        title: Text(
          FFLocalizations.of(context).getText(
            'e6q07s67' /* 360° View */,
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              FlutterFlowWebView(
                url: 'https://webobook.com/public/62e01156e972564a8f40d032',
                bypass: false,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1,
                verticalScroll: false,
                horizontalScroll: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
