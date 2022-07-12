import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_choice_chips.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({Key key}) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  String citiesListValue;
  String propertyTypeListValue;
  double sliderValue1;
  double sliderValue2;
  String isFurnishingValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Filter'});
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(6, 18, 0, 0),
          child: InkWell(
            onTap: () async {
              logFirebaseEvent('FILTER_PAGE_Text_re50sdm2_ON_TAP');
              logFirebaseEvent('Text_Update-Local-State');
              setState(() => FFAppState().filterCity = '');
              logFirebaseEvent('Text_Update-Local-State');
              setState(() => FFAppState().filterPropertyType = '');
              logFirebaseEvent('Text_Update-Local-State');
              setState(() => FFAppState().filterFurnishingType = '');
              logFirebaseEvent('Text_Update-Local-State');
              setState(() => FFAppState().filterCity = '');
              logFirebaseEvent('Text_Navigate-Back');
              context.pop();
              logFirebaseEvent('Text_Navigate-To');
              context.pushNamed(
                'Filter',
                extra: <String, dynamic>{
                  kTransitionInfoKey: TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.bottomToTop,
                  ),
                },
              );
            },
            child: Text(
              FFLocalizations.of(context).getText(
                'h84toi7e' /* Reset */,
              ),
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Sofia Pro By Khuzaimah',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    useGoogleFonts: false,
                  ),
            ),
          ),
        ),
        title: Text(
          FFLocalizations.of(context).getText(
            'hy8565b9' /* Filter */,
          ),
          style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Sofia Pro By Khuzaimah',
                fontSize: 18,
                fontWeight: FontWeight.w500,
                useGoogleFonts: false,
              ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              buttonSize: 48,
              icon: Icon(
                Icons.close_rounded,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 30,
              ),
              onPressed: () async {
                logFirebaseEvent('FILTER_PAGE_close_rounded_ICN_ON_TAP');
                logFirebaseEvent('IconButton_Navigate-Back');
                context.pop();
              },
            ),
          ),
        ],
        centerTitle: true,
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
          child: FutureBuilder<ApiCallResponse>(
            future: FilterParamsCall.call(),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: SpinKitRipple(
                      color: Color(0xFF2971FB),
                      size: 50,
                    ),
                  ),
                );
              }
              final columnFilterParamsResponse = snapshot.data;
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'b8bqw4hw' /* City */,
                        ),
                        style: FlutterFlowTheme.of(context).subtitle1.override(
                              fontFamily: 'Sofia Pro By Khuzaimah',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              useGoogleFonts: false,
                            ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: FutureBuilder<ApiCallResponse>(
                            future: CityListCall.call(),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: SpinKitRipple(
                                      color: Color(0xFF2971FB),
                                      size: 50,
                                    ),
                                  ),
                                );
                              }
                              final citiesListCityListResponse = snapshot.data;
                              return FlutterFlowDropDown(
                                initialOption: citiesListValue ??=
                                    FFAppState().filterCity,
                                options: [
                                  FFLocalizations.of(context).getText(
                                    '1cqnd28g' /* Riyadh */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    'ka7r97er' /* Jeddah */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    'fwphp18w' /* Mecca */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    'xagmgkfm' /* Dubai */,
                                  )
                                ],
                                onChanged: (val) =>
                                    setState(() => citiesListValue = val),
                                width: double.infinity,
                                height: 55,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Sofia Pro By Khuzaimah',
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: false,
                                    ),
                                hintText: FFLocalizations.of(context).getText(
                                  'le1j7gvf' /* Select City */,
                                ),
                                fillColor: Colors.white,
                                elevation: 2,
                                borderColor: Color(0xFFA5A5A5),
                                borderWidth: 1,
                                borderRadius: 8,
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    12, 4, 12, 4),
                                hidesUnderline: true,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 26, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          FFLocalizations.of(context).getText(
                            'n51panna' /* Type */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).subtitle1.override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    useGoogleFonts: false,
                                  ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              valueOrDefault<String>(
                                sliderValue1.toString(),
                                '0',
                              ),
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                            Text(
                              ' - ',
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                            Text(
                              valueOrDefault<String>(
                                sliderValue2.toString(),
                                '1',
                              ),
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                            Text(
                              ' SAR',
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FlutterFlowChoiceChips(
                                initiallySelected: propertyTypeListValue != null
                                    ? [propertyTypeListValue]
                                    : [FFAppState().filterPropertyType],
                                options: ((getJsonField(
                                          (columnFilterParamsResponse
                                                  ?.jsonBody ??
                                              ''),
                                          r'''$.meta.property_type''',
                                        ) as List)
                                            .map<String>((s) => s.toString())
                                            .toList() ??
                                        [])
                                    .map((label) => ChipData(label))
                                    .toList(),
                                onChanged: (val) => setState(
                                    () => propertyTypeListValue = val.first),
                                selectedChipStyle: ChipStyle(
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Sofia Pro By Khuzaimah',
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        useGoogleFonts: false,
                                      ),
                                  iconColor: Colors.white,
                                  iconSize: 0,
                                  elevation: 2,
                                ),
                                unselectedChipStyle: ChipStyle(
                                  backgroundColor: Colors.white,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Sofia Pro By Khuzaimah',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        useGoogleFonts: false,
                                      ),
                                  iconColor: Color(0xFF323B45),
                                  iconSize: 0,
                                  elevation: 1,
                                ),
                                chipSpacing: 8,
                                multiselect: false,
                                initialized: propertyTypeListValue != null,
                                alignment: WrapAlignment.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          FFLocalizations.of(context).getText(
                            '4mz2rd2p' /* Installment Range */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).subtitle1.override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    useGoogleFonts: false,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Minimum intsallment',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Sofia Pro By Khuzaimah',
                                      fontWeight: FontWeight.normal,
                                      useGoogleFonts: false,
                                    ),
                              ),
                              Slider(
                                activeColor:
                                    FlutterFlowTheme.of(context).primaryColor,
                                inactiveColor: Color(0xFF9E9E9E),
                                min: 0,
                                max: 0,
                                value: sliderValue1 ??= valueOrDefault<double>(
                                  getJsonField(
                                    (columnFilterParamsResponse?.jsonBody ??
                                        ''),
                                    r'''$.meta.max_price''',
                                  ),
                                  1.0,
                                ),
                                onChanged: (newValue) {
                                  setState(() => sliderValue1 = newValue);
                                },
                              ),
                              Text(
                                'Maximum Installment',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Sofia Pro By Khuzaimah',
                                      fontWeight: FontWeight.normal,
                                      useGoogleFonts: false,
                                    ),
                              ),
                              Slider(
                                activeColor:
                                    FlutterFlowTheme.of(context).primaryColor,
                                inactiveColor: Color(0xFF9E9E9E),
                                min: 0,
                                max: 0,
                                value: sliderValue2 ??= valueOrDefault<double>(
                                  getJsonField(
                                    (columnFilterParamsResponse?.jsonBody ??
                                        ''),
                                    r'''$.meta.max_price''',
                                  ),
                                  1.0,
                                ),
                                onChanged: (newValue) {
                                  setState(() => sliderValue2 = newValue);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 26, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          FFLocalizations.of(context).getText(
                            '2m2ni5iy' /* Furnishing */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).subtitle1.override(
                                    fontFamily: 'Sofia Pro By Khuzaimah',
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    useGoogleFonts: false,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Wrap(
                            spacing: 0,
                            runSpacing: 0,
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            direction: Axis.horizontal,
                            runAlignment: WrapAlignment.start,
                            verticalDirection: VerticalDirection.down,
                            clipBehavior: Clip.none,
                            children: [
                              FlutterFlowChoiceChips(
                                initiallySelected: isFurnishingValue != null
                                    ? [isFurnishingValue]
                                    : [FFAppState().filterFurnishingType],
                                options: ((getJsonField(
                                          (columnFilterParamsResponse
                                                  ?.jsonBody ??
                                              ''),
                                          r'''$.meta.furnishing_type''',
                                        ) as List)
                                            .map<String>((s) => s.toString())
                                            .toList() ??
                                        [])
                                    .map((label) => ChipData(label))
                                    .toList(),
                                onChanged: (val) => setState(
                                    () => isFurnishingValue = val.first),
                                selectedChipStyle: ChipStyle(
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Sofia Pro By Khuzaimah',
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        useGoogleFonts: false,
                                      ),
                                  iconColor: Colors.white,
                                  iconSize: 0,
                                  elevation: 1,
                                ),
                                unselectedChipStyle: ChipStyle(
                                  backgroundColor: Colors.white,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Sofia Pro By Khuzaimah',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        useGoogleFonts: false,
                                      ),
                                  iconColor: Color(0xFF323B45),
                                  iconSize: 0,
                                  elevation: 2,
                                ),
                                chipSpacing: 8,
                                multiselect: false,
                                initialized: isFurnishingValue != null,
                                alignment: WrapAlignment.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 220, 0, 30),
                    child: FFButtonWidget(
                      onPressed: () async {
                        logFirebaseEvent('FILTER_PAGE_apllyFilter_ON_TAP');
                        logFirebaseEvent('apllyFilter_Update-Local-State');
                        setState(() => FFAppState().filterCity = '');
                        logFirebaseEvent('apllyFilter_Update-Local-State');
                        setState(() =>
                            FFAppState().filterCity = valueOrDefault<String>(
                              citiesListValue,
                              'null',
                            ));
                        logFirebaseEvent('apllyFilter_Update-Local-State');
                        setState(() => FFAppState().filterFurnishingType = '');
                        logFirebaseEvent('apllyFilter_Update-Local-State');
                        setState(() => FFAppState().filterFurnishingType =
                                valueOrDefault<String>(
                              isFurnishingValue,
                              'null',
                            ));
                        logFirebaseEvent('apllyFilter_Update-Local-State');
                        setState(() => FFAppState().filterPropertyType = '');
                        logFirebaseEvent('apllyFilter_Update-Local-State');
                        setState(() => FFAppState().filterPropertyType =
                                valueOrDefault<String>(
                              propertyTypeListValue,
                              'null',
                            ));
                        logFirebaseEvent('apllyFilter_Navigate-Back');
                        context.pop();
                      },
                      text: FFLocalizations.of(context).getText(
                        'dgzjfbdt' /* Show  Properties */,
                      ),
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 56,
                        color: Color(0xFF2971FB),
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle1.override(
                                  fontFamily: 'Sofia Pro By Khuzaimah',
                                  fontWeight: FontWeight.w800,
                                  useGoogleFonts: false,
                                ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
