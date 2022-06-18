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
  double installmentSliderValue;
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
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
                    FlutterFlowDropDown(
                      options: [
                        FFLocalizations.of(context).getText(
                          '1cqnd28g' /* Riyadh */,
                        )
                      ],
                      onChanged: (val) => setState(() => citiesListValue = val),
                      width: 335,
                      height: 55,
                      textStyle:
                          FlutterFlowTheme.of(context).bodyText1.override(
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
                      margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                      hidesUnderline: true,
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
                        'n51panna' /* Type */,
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
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: FlutterFlowChoiceChips(
                        initiallySelected: propertyTypeListValue != null
                            ? [propertyTypeListValue]
                            : [
                                FFLocalizations.of(context).getText(
                                  '2jdd174j' /* All */,
                                )
                              ],
                        options: [
                          ChipData(FFLocalizations.of(context).getText(
                            'rtp5z5fb' /* All */,
                          )),
                          ChipData(FFLocalizations.of(context).getText(
                            '6oes70ac' /* House */,
                          )),
                          ChipData(FFLocalizations.of(context).getText(
                            'zhs5gh3i' /* Apartment */,
                          )),
                          ChipData(FFLocalizations.of(context).getText(
                            '3g790jsh' /* Flat */,
                          ))
                        ],
                        onChanged: (val) =>
                            setState(() => propertyTypeListValue = val.first),
                        selectedChipStyle: ChipStyle(
                          backgroundColor:
                              FlutterFlowTheme.of(context).primaryColor,
                          textStyle:
                              FlutterFlowTheme.of(context).bodyText1.override(
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
                          textStyle:
                              FlutterFlowTheme.of(context).bodyText1.override(
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
                        '4mz2rd2p' /* Installment Range */,
                      ),
                      style: FlutterFlowTheme.of(context).subtitle1.override(
                            fontFamily: 'Sofia Pro By Khuzaimah',
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: false,
                          ),
                    ),
                    Text(
                      valueOrDefault<String>(
                        installmentSliderValue.toString(),
                        '0',
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Sofia Pro By Khuzaimah',
                            color: FlutterFlowTheme.of(context).primaryColor,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SliderTheme(
                      data: SliderThemeData(
                        showValueIndicator: ShowValueIndicator.always,
                      ),
                      child: Container(
                        width: 335,
                        child: Slider(
                          activeColor:
                              FlutterFlowTheme.of(context).primaryColor,
                          inactiveColor: Color(0xFF9E9E9E),
                          min: 0,
                          max: 9000,
                          value: installmentSliderValue ??= 1,
                          label: installmentSliderValue.toString(),
                          onChanged: (newValue) {
                            setState(() => installmentSliderValue = newValue);
                          },
                        ),
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
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: FlutterFlowChoiceChips(
                        initiallySelected: isFurnishingValue != null
                            ? [isFurnishingValue]
                            : [
                                FFLocalizations.of(context).getText(
                                  '7fpsv2qy' /* All */,
                                )
                              ],
                        options: [
                          ChipData(FFLocalizations.of(context).getText(
                            'p4ffui1h' /* All */,
                          )),
                          ChipData(FFLocalizations.of(context).getText(
                            'jrw6qvww' /* Furnishing */,
                          )),
                          ChipData(FFLocalizations.of(context).getText(
                            'skyj7jpv' /* Un-Furnishing */,
                          ))
                        ],
                        onChanged: (val) =>
                            setState(() => isFurnishingValue = val.first),
                        selectedChipStyle: ChipStyle(
                          backgroundColor:
                              FlutterFlowTheme.of(context).primaryColor,
                          textStyle:
                              FlutterFlowTheme.of(context).bodyText1.override(
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
                          textStyle:
                              FlutterFlowTheme.of(context).bodyText1.override(
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
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 220, 0, 30),
                child: FFButtonWidget(
                  onPressed: () {
                    print('apllyFilter pressed ...');
                  },
                  text: FFLocalizations.of(context).getText(
                    'dgzjfbdt' /* Show  Properties */,
                  ),
                  options: FFButtonOptions(
                    width: 343,
                    height: 56,
                    color: Color(0xFF2971FB),
                    textStyle: FlutterFlowTheme.of(context).subtitle1.override(
                          fontFamily: 'Sofia Pro By Khuzaimah',
                          fontWeight: FontWeight.w800,
                          useGoogleFonts: false,
                        ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 12,
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
