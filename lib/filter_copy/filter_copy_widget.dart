import '../flutter_flow/flutter_flow_choice_chips.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterCopyWidget extends StatefulWidget {
  const FilterCopyWidget({Key key}) : super(key: key);

  @override
  _FilterCopyWidgetState createState() => _FilterCopyWidgetState();
}

class _FilterCopyWidgetState extends State<FilterCopyWidget> {
  String citiesListValue;
  String propertyTypeListValue;
  double installmentSliderValue;
  String isFurnishingValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'FilterCopy'});
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
              '9wjco7f5' /* Reset */,
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
            '4r6li7uf' /* Filter */,
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
                logFirebaseEvent('FILTER_COPY_close_rounded_ICN_ON_TAP');
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    FFLocalizations.of(context).getText(
                      'bfc0jvhc' /* City */,
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
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                      child: FlutterFlowDropDown(
                        options: [
                          FFLocalizations.of(context).getText(
                            '1snf3qye' /* Riyadh */,
                          )
                        ],
                        onChanged: (val) =>
                            setState(() => citiesListValue = val),
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
                          '5kec6c0m' /* Select City */,
                        ),
                        fillColor: Colors.white,
                        elevation: 2,
                        borderColor: Color(0xFFA5A5A5),
                        borderWidth: 1,
                        borderRadius: 8,
                        margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                        hidesUnderline: true,
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
                        '1xtsbq2y' /* Type */,
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
                                  'qhz0rrjr' /* All */,
                                )
                              ],
                        options: [
                          ChipData(FFLocalizations.of(context).getText(
                            'rnc35lnt' /* All */,
                          )),
                          ChipData(FFLocalizations.of(context).getText(
                            'ducpx83i' /* House */,
                          )),
                          ChipData(FFLocalizations.of(context).getText(
                            'fqnjkv6g' /* Apartment */,
                          )),
                          ChipData(FFLocalizations.of(context).getText(
                            '0pjvwkk1' /* Flat */,
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
                        '6xt16jt5' /* Installment Range */,
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
                        '8ozjkl8w' /* Furnishing */,
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
                                  'kgidgtfz' /* All */,
                                )
                              ],
                        options: [
                          ChipData(FFLocalizations.of(context).getText(
                            'o1h78xn1' /* All */,
                          )),
                          ChipData(FFLocalizations.of(context).getText(
                            '5sipykmn' /* Furnishing */,
                          )),
                          ChipData(FFLocalizations.of(context).getText(
                            'emup7poc' /* Un-Furnishing */,
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
                    '3tmmjthp' /* Show  Properties */,
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
                    borderRadius: BorderRadius.circular(12),
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
