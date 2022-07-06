import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class WhereAreYouLookingWidget extends StatefulWidget {
  const WhereAreYouLookingWidget({
    Key key,
    this.city,
  }) : super(key: key);

  final String city;

  @override
  _WhereAreYouLookingWidgetState createState() =>
      _WhereAreYouLookingWidgetState();
}

class _WhereAreYouLookingWidgetState extends State<WhereAreYouLookingWidget> {
  List<PropertyRecord> algoliaSearchResults = [];
  TextEditingController searchController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'WhereAreYouLooking'});
    searchController = TextEditingController(text: widget.city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () async {
            logFirebaseEvent('WHERE_ARE_YOU_LOOKING_backIcon_ON_TAP');
            // goToHome
            logFirebaseEvent('backIcon_goToHome');
            context.goNamed('HomeScreen');
          },
        ),
        title: Text(
          FFLocalizations.of(context).getText(
            '8po9ixlq' /* Where are you looking? */,
          ),
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Sofia Pro By Khuzaimah',
                color: Colors.black,
                fontSize: 22,
                useGoogleFonts: false,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: searchController,
                onChanged: (_) => EasyDebounce.debounce(
                  'searchController',
                  Duration(milliseconds: 2000),
                  () => setState(() {}),
                ),
                onFieldSubmitted: (_) async {
                  logFirebaseEvent('WHERE_ARE_YOU_LOOKING_search_ON_TEXTFIEL');
                  // CitySearch
                  logFirebaseEvent('search_CitySearch');
                  setState(() => algoliaSearchResults = null);
                  await PropertyRecord.search(
                    term: widget.city,
                  )
                      .then((r) => algoliaSearchResults = r)
                      .onError((_, __) => algoliaSearchResults = [])
                      .whenComplete(() => setState(() {}));
                },
                autofocus: true,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: FFLocalizations.of(context).getText(
                    'o5kmjt96' /* Where are you looking? */,
                  ),
                  labelStyle: FlutterFlowTheme.of(context).bodyText2.override(
                        fontFamily: 'Sofia Pro By Khuzaimah',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontWeight: FontWeight.normal,
                        useGoogleFonts: false,
                      ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x80000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(33),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x80000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(33),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: searchController.text.isNotEmpty
                      ? InkWell(
                          onTap: () => setState(
                            () => searchController?.clear(),
                          ),
                          child: Icon(
                            Icons.clear,
                            color: Color(0xFF757575),
                            size: 22,
                          ),
                        )
                      : null,
                ),
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Sofia Pro By Khuzaimah',
                      fontSize: 17,
                      fontWeight: FontWeight.w300,
                      useGoogleFonts: false,
                    ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 0,
                                color: FlutterFlowTheme.of(context).lineColor,
                                offset: Offset(0, 1),
                              )
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSo9GLsm5WZzkjlUGXhbKPV_LYIKhKLqJQX9WW7nXrZEzaQ0gbELk9yZtv5Ak27YxlKpBw&usqp=CAU',
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 0, 0, 0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'nu1b6t0o' /* Riyadh */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .subtitle1
                                              .override(
                                                fontFamily:
                                                    'Sofia Pro By Khuzaimah',
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.navigate_next_rounded,
                                  color: Colors.black,
                                  size: 24,
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
            ],
          ),
        ),
      ),
    );
  }
}
