import 'package:manzel/common_widgets/manzel_icons.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../backend/api_requests/api_calls.dart';
import '../common_alert_dialog/common_alert_dialog.dart';
import '../components/something_went_wrong_widget.dart';
import '../flutter_flow/custom_functions.dart';
import '../flutter_flow/flutter_flow_choice_chips.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({Key? key, this.homeScreenLength}) : super(key: key);
  final int? homeScreenLength;
  //final dynamic cityList;

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  ApiCallResponse? columnPropertiesResponse;
  bool isPropertiesLoading = true;
  ApiCallResponse? citiesListCityListResponse;
  bool isCitiesLoading = true;
  bool? isInternetAvailable;

  List<String>? isFurnishingValues;
  List<String>? propertyTypeListValues;
  String? citiesListValue;
  double? sliderValue1;
  double? sliderValue2;
  SfRangeValues? installmentRange;
  double? mxRange;
  ApiCallResponse? response;
  var alertCalled = 0;

  //= SfRangeValues(0, 2000000);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Filter'});
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    //installmentRange = SfRangeValues(start, end)
    propertiesCall();
    cityListCall();
  }

  Future<void> propertiesCall() async {
    isInternetAvailable = await isInternetConnected();
    if (isInternetAvailable ?? false) {
      columnPropertiesResponse= await PropertiesCall.call(
        populate:
        'populate=*,banks.Bank_logo,managed_by.Company_logo,property_images,city',
        locale: FFAppState().locale,
      );
      isPropertiesLoading = false;
      setState(() {});
    }
    else{
      isPropertiesLoading = false;
      setState(() {});
      alertCalled++;
      if (alertCalled <= 1)
      showDialog(
        context: context,
        builder: (BuildContext context) => CommonAlertDialog(
          onCancel: () {
            alertCalled=0;
            Navigator.pop(context);
          },
        ),
      );
    }

  }


  void reset() async{
    isInternetAvailable = await isInternetConnected();
    if (isInternetAvailable ?? false) {
      setState(() {
        print("Reset should work");
        isFurnishingValues!.clear();
        propertyTypeListValues!.clear();
        if (FFAppState().locale == 'en') {
          isFurnishingValues!.add("All");
          propertyTypeListValues!.add("All");
        } else {
          isFurnishingValues!.add("الكل");
          propertyTypeListValues!.add("الكل");
        }
        installmentRange = SfRangeValues(0,mxRange);
        citiesListValue= null;
      });
    }else{
      alertCalled++;
      if (alertCalled <= 1)
        showDialog(
          context: context,
          builder: (BuildContext context) => CommonAlertDialog(
            onCancel: () {
              alertCalled=0;
              Navigator.pop(context);
            },
          ),
        );
    }

  }

  Future<void> cityListCall() async {
    isInternetAvailable = await isInternetConnected();
    if (isInternetAvailable ?? false) {
      citiesListCityListResponse = await CityListCall.call(
        locale: FFAppState().locale,
      );
      isCitiesLoading = false;
      setState(() {});
    }
    else{
      isCitiesLoading = false;
      setState(() {});
      alertCalled++;
      if (alertCalled <= 1)
      showDialog(
        context: context,
        builder: (BuildContext context) => CommonAlertDialog(
          onCancel: () {
            alertCalled=0;
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
        leading: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(6, 18, 0, 0),
          child:  (citiesListCityListResponse!=null)?InkWell(
            onTap: () async {
              logFirebaseEvent('FILTER_PAGE_Text_re50sdm2_ON_TAP');
              logFirebaseEvent('Text_Update-Local-State');
              setState(() => FFAppState().filterCity = '');
              logFirebaseEvent('Text_Update-Local-State');
              setState(() => FFAppState().filterPropertyType = []);
              logFirebaseEvent('Text_Update-Local-State');
              setState(() => FFAppState().filterFurnishingType = []);
              logFirebaseEvent('Text_Update-Local-State');
              setState(() => FFAppState().filterCity = '');
              logFirebaseEvent('Text_Update-Local-State');
              setState(() => FFAppState().filterMinPrice = 0);
              logFirebaseEvent('Text_Update-Local-State');
              setState(() => FFAppState().filterMaxPrice = 0);
              mxRange = valueOrDefault<double>(
                functions.formattedDouble(
                    valueOrDefault<int>(
                      getJsonField(
                        columnPropertiesResponse!.jsonBody,
                        r'''$.meta.max_price''',
                      ),
                      1,
                    )),
                1.0,
              );
              isInternetAvailable = await isInternetConnected();
              if(isInternetAvailable??false){
                reset();
              }
              else{
                alertCalled++;
                if (alertCalled <= 1)
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => CommonAlertDialog(
                      onCancel: () {
                        alertCalled=0;
                        Navigator.pop(context);
                      },
                    ),
                  );
              }

            },
            child: Text(
              FFLocalizations.of(context).getText(
                'h84toi7e' /* Reset */,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'AvenirArabic',
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    useGoogleFonts: false,
                  ),
            ),
          ):SizedBox(),
        ),
        title: Text(
          FFLocalizations.of(context).getText(
            'hy8565b9' /* Filter */,
          ),
          style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'AvenirArabic',
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
                Manzel.clear,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 15,
              ),
              onPressed: () async {
                logFirebaseEvent('FILTER_PAGE_close_rounded_ICN_ON_TAP');
                logFirebaseEvent('IconButton_Close-Dialog,-Drawer,-Etc');
                Navigator.pop(context);
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
          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
          child: Builder(
            builder: (context) {
              // Customize what your widget looks like when it's loading.
              if (isPropertiesLoading) {
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
              else if((columnPropertiesResponse != null) &&
                  columnPropertiesResponse?.statusCode ==
                      200){
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'b8bqw4hw' /* City */,
                              ),
                              style:
                              FlutterFlowTheme.of(context).subtitle1.override(
                                fontFamily: 'AvenirArabic',
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: false,
                              ),
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
                              child: Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                                child: Builder(
                                  builder: (context) {
                                    if (isCitiesLoading) {
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
                                    else if ((citiesListCityListResponse != null) &&
                                        citiesListCityListResponse?.statusCode ==
                                            200){
                                      return FlutterFlowDropDown(
                                        initialOption: citiesListValue ??
                                            'Select city',
                                        options: functions
                                            .cityListBuilder(
                                            (getJsonField(
                                              citiesListCityListResponse?.jsonBody,
                                              r'''$.cities''',
                                            ) as List)
                                                .map<String>(
                                                    (s) => s.toString())
                                                .toList(),
                                            FFAppState().locale)
                                            .toList(),
                                        onChanged: (val) =>
                                            setState(() => citiesListValue = val),
                                        width: double.infinity,
                                        height: 55,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                          fontFamily: 'AvenirArabic',
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          useGoogleFonts: false,
                                        ),
                                        hintText:
                                        FFLocalizations.of(context).getText(
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
                                    }
                                    else if ((citiesListCityListResponse
                                        ?.statusCode !=
                                        200) &&
                                        (citiesListCityListResponse?.statusCode !=
                                            null)) {
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
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 26, 0, 0),
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
                                fontFamily: 'AvenirArabic',
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
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 0, 0),
                                    child: FlutterFlowChoiceChips(
                                      initiallySelected:
                                      propertyTypeListValues != null
                                          ? propertyTypeListValues
                                          : functions.choicechipUnselected(
                                          FFAppState()
                                              .filterPropertyType
                                              .toList(),
                                          FFAppState().locale),
                                      options: functions
                                          .propertTypeBuilder(
                                          (getJsonField(
                                            columnPropertiesResponse?.jsonBody,
                                            r'''$.meta.property_type''',
                                          ) as List)
                                              .map<String>(
                                                  (s) => s.toString())
                                              .toList(),
                                          FFAppState().locale)
                                          .map((label) => ChipData(label))
                                          .toList(),
                                      onChanged: (val) => setState(
                                              () => propertyTypeListValues = val),
                                      selectedChipStyle: ChipStyle(
                                        backgroundColor:
                                        FlutterFlowTheme.of(context)
                                            .primaryColor,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                          fontFamily: 'AvenirArabic',
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
                                          fontFamily: 'AvenirArabic',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          useGoogleFonts: false,
                                        ),
                                        iconColor: Color(0xFF323B45),
                                        iconSize: 0,
                                        elevation: 1,
                                      ),
                                      chipSpacing: 8,
                                      multiselect: true,
                                      initialized: propertyTypeListValues != null,
                                      alignment: WrapAlignment.center,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  '4mz2rd2p' /* Installment Range */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .subtitle1
                                    .override(
                                  fontFamily: 'AvenirArabic',
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: false,
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      valueOrDefault<String>(
                                        functions.formattedSliderOutput(
                                            valueOrDefault<double>(
                                              double.parse(
                                                  (installmentRange?.start ?? '0')
                                                      .toString()),
                                              1.0,
                                            )),
                                        '1',
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
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'k57fhygg' /*  -  */,
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
                                    Text(
                                      valueOrDefault<String>(
                                        functions.formattedSliderOutput(
                                            valueOrDefault<double>(
                                              double.parse((installmentRange?.end ??
                                                  valueOrDefault<double>(
                                                    functions.formattedDouble(
                                                        valueOrDefault<int>(
                                                          getJsonField(
                                                            columnPropertiesResponse?.jsonBody,
                                                            r'''$.meta.max_price''',
                                                          ),
                                                          1,
                                                        )),
                                                    1.0,
                                                  ))
                                                  .toString()),
                                              1.0,
                                            )),
                                        '1',
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
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'krfzs4ot' /*  SAR */,
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Container(
                                  child: SliderTheme(
                                    data: SliderThemeData(
                                      rangeThumbShape: RoundRangeSliderThumbShape(
                                          enabledThumbRadius: 15),
                                      trackHeight: 6,
                                    ),
                                    child: SfRangeSlider(
                                      min: 0.0,
                                      max: valueOrDefault<double>(
                                        functions.formattedDouble(
                                            valueOrDefault<int>(
                                              getJsonField(
                                                columnPropertiesResponse?.jsonBody,
                                                r'''$.meta.max_price''',
                                              ),
                                              20000000,
                                            )),
                                        20000000.0,
                                      ),
                                      values: installmentRange ??= SfRangeValues(
                                          0,
                                          valueOrDefault<double>(
                                            functions.formattedDouble(
                                                valueOrDefault<int>(
                                                  getJsonField(
                                                    columnPropertiesResponse?.jsonBody,
                                                    r'''$.meta.max_price''',
                                                  ),
                                                  1,
                                                )),
                                            1.0,
                                          )),
                                      //interval: 2000,
                                      //stepSize: 1,
                                      showTicks: false,
                                      showLabels: false,
                                      //enableTooltip: true,
                                      activeColor: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      //inactiveColor: AppColors.colorDBDBDB,
                                      //minorTicksPerInterval: 1,
                                      onChanged: (SfRangeValues values) {
                                        setState(() {
                                          installmentRange = values;
                                          print(installmentRange);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Expanded(
                            //   child: Padding(
                            //     padding:
                            //         EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                            //     child: Column(
                            //       mainAxisSize: MainAxisSize.max,
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Text(
                            //           FFLocalizations.of(context).getText(
                            //             'q62w4vtf' /* Minimum */,
                            //           ),
                            //           style: FlutterFlowTheme.of(context)
                            //               .bodyText1
                            //               .override(
                            //                 fontFamily: 'AvenirArabic',
                            //                 fontWeight: FontWeight.normal,
                            //                 useGoogleFonts: false,
                            //               ),
                            //         ),
                            //         Slider(
                            //           activeColor: FlutterFlowTheme.of(context)
                            //               .primaryColor,
                            //           inactiveColor: Color(0xFF9E9E9E),
                            //           min: 0,
                            //           max: 200000,
                            //           value: sliderValue1 ??=
                            //               valueOrDefault<double>(
                            //             functions
                            //                 .formattedDouble(valueOrDefault<int>(
                            //               getJsonField(
                            //                 columnPropertiesResponse.jsonBody,
                            //                 r'''$.meta.max_price''',
                            //               ),
                            //               1,
                            //             )),
                            //             1.0,
                            //           ),
                            //           onChanged: (newValue) {
                            //             setState(() => sliderValue1 = newValue);
                            //           },
                            //         ),
                            //         Text(
                            //           FFLocalizations.of(context).getText(
                            //             'wlsjihmj' /* Maximum */,
                            //           ),
                            //           style: FlutterFlowTheme.of(context)
                            //               .bodyText1
                            //               .override(
                            //                 fontFamily: 'AvenirArabic',
                            //                 fontWeight: FontWeight.normal,
                            //                 useGoogleFonts: false,
                            //               ),
                            //         ),
                            //         Slider(
                            //           activeColor: FlutterFlowTheme.of(context)
                            //               .primaryColor,
                            //           inactiveColor: Color(0xFF9E9E9E),
                            //           min: 0,
                            //           max: 200000,
                            //           value: sliderValue2 ??=
                            //               valueOrDefault<double>(
                            //             functions
                            //                 .formattedDouble(valueOrDefault<int>(
                            //               getJsonField(
                            //                 columnPropertiesResponse.jsonBody,
                            //                 r'''$.meta.max_price''',
                            //               ),
                            //               1,
                            //             )),
                            //             1.0,
                            //           ),
                            //           onChanged: (newValue) {
                            //             setState(() => sliderValue2 = newValue);
                            //           },
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 26, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                '2m2ni5iy' /* Furnishing */,
                              ),
                              style:
                              FlutterFlowTheme.of(context).subtitle1.override(
                                fontFamily: 'AvenirArabic',
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
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 0, 0),
                                    child: FlutterFlowChoiceChips(
                                      initiallySelected:
                                      isFurnishingValues != null
                                          ? isFurnishingValues
                                          : functions.choicechipUnselected(
                                          FFAppState()
                                              .filterFurnishingType
                                              .toList(),
                                          FFAppState().locale),
                                      options: [
                                        ChipData(
                                            FFLocalizations.of(context).getText(
                                              'jrw6qvww' /* All */,
                                            )),
                                        ChipData(
                                            FFLocalizations.of(context).getText(
                                              'skyj7jpv' /* Furnished */,
                                            )),
                                        ChipData(
                                            FFLocalizations.of(context).getText(
                                              '8x7rkqnv' /* Un-furnished */,
                                            )),
                                        // ChipData(
                                        //     FFLocalizations.of(context).getText(
                                        //   'mhyiav30' /* Semi-furnished */,
                                        // ))
                                      ],
                                      onChanged: (val) => setState(
                                              () => isFurnishingValues = val),
                                      selectedChipStyle: ChipStyle(
                                        backgroundColor:
                                        FlutterFlowTheme.of(context)
                                            .primaryColor,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                          fontFamily: 'AvenirArabic',
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
                                          fontFamily: 'AvenirArabic',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          useGoogleFonts: false,
                                        ),
                                        iconColor: Color(0xFF323B45),
                                        iconSize: 0,
                                        elevation: 2,
                                      ),
                                      chipSpacing: 8,
                                      multiselect: true,
                                      initialized: isFurnishingValues != null,
                                      alignment: WrapAlignment.center,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 80, 20, 10),
                        child: FFButtonWidget(
                          onPressed: () async {
                            isInternetAvailable = await isInternetConnected();
                            if(true??false){
                              logFirebaseEvent('FILTER_PAGE_apllyFilter_ON_TAP');
                              if (functions.validateInstallmentRange(
                                  double.parse(installmentRange!.start.toString()),
                                  double.parse(installmentRange!.end.toString()))) {
                                logFirebaseEvent('apllyFilter_Navigate-To');

                                context.pushNamed(
                                  'filterResults',
                                  queryParams: {
                                    'homeScreenLength': serializeParam(
                                        widget.homeScreenLength ?? 0,
                                        ParamType.int),
                                    'cityName': serializeParam(
                                        citiesListValue ?? 'All', ParamType.String),
                                    'minInstallment': serializeParam(
                                        valueOrDefault<String>(
                                          functions
                                              .sliderToApi(double.parse(
                                              installmentRange!.start
                                                  .toString()))
                                              .toString(),
                                          '0',
                                        ),
                                        ParamType.String),
                                    'maxInstallment': serializeParam(
                                        functions
                                            .sliderToApi(double.parse(
                                            installmentRange!.end.toString()))
                                            .toString(),
                                        ParamType.String),
                                    'furnishingType': serializeParam(
                                        functions.listToApiParameters(functions
                                            .choicechipUnselected(
                                            isFurnishingValues?.toList(),
                                            FFAppState().locale)
                                            .toList()),
                                        ParamType.String),
                                    'propertyType': serializeParam(
                                        functions.listToApiParameters(functions
                                            .choicechipUnselected(
                                            propertyTypeListValues?.toList(),
                                            FFAppState().locale)
                                            .toList()),
                                        ParamType.String),
                                  }.withoutNulls,
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: TransitionInfo(
                                      hasTransition: true,
                                      transitionType: PageTransitionType.fade,
                                      duration: Duration(milliseconds: 0),
                                    ),
                                  },
                                );
                              }
                              else {
                                logFirebaseEvent('apllyFilter_Show-Snack-Bar');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      functions.snackBarMessage(
                                          'invalidInstallmentRange',
                                          FFAppState().locale),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText2
                                          .override(
                                        fontFamily: 'AvenirArabic',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: false,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                    FlutterFlowTheme.of(context).primaryRed,
                                  ),
                                );
                              }
                            }
                            else{
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => CommonAlertDialog(
                                  onCancel: () {
                                    alertCalled = 0;
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            }

                          },
                          text: FFLocalizations.of(context).getText(
                            'dgzjfbdt' /* Show  Properties */,
                          ),
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 56,
                            color: FlutterFlowTheme.of(context).primaryColor,
                            textStyle:
                            FlutterFlowTheme.of(context).subtitle1.override(
                              fontFamily: 'AvenirArabic',
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
                  ),
                );
              }
              else if ((columnPropertiesResponse
                  ?.statusCode !=
                  200) &&
                  (columnPropertiesResponse?.statusCode !=
                      null)) {
                return SomethingWentWrongWidget(
                  onTryAgain: (){
                  },
                );
              }
              return SizedBox();
             // final columnPropertiesResponse = snapshot.data!;
             // response = columnPropertiesResponse;

            },
          ),
        ),
      ),
    );
  }
}
