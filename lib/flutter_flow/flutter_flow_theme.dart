// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class FlutterFlowTheme {
  static FlutterFlowTheme of(BuildContext context) => LightModeTheme();

  Color primaryColor;
  Color secondaryColor;
  Color tertiaryColor;
  Color alternate;
  Color primaryBackground;
  Color secondaryBackground;
  Color primaryText;
  Color secondaryText;

  Color primaryBtnText;
  Color grayIcon;
  Color gray200;
  Color gray600;
  Color black600;
  Color tertiary400;
  Color textColor;
  Color lineColor;

  TextStyle get title1 => TextStyle(
        fontFamily: 'Sofia Pro By Khuzaimah',
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      );
  TextStyle get title2 => TextStyle(
        fontFamily: 'Sofia Pro By Khuzaimah',
        color: secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 22,
      );
  TextStyle get title3 => TextStyle(
        fontFamily: 'Sofia Pro By Khuzaimah',
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      );
  TextStyle get subtitle1 => TextStyle(
        fontFamily: 'Sofia Pro By Khuzaimah',
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      );
  TextStyle get subtitle2 => TextStyle(
        fontFamily: 'Sofia Pro By Khuzaimah',
        color: secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      );
  TextStyle get bodyText1 => TextStyle(
        fontFamily: 'Sofia Pro By Khuzaimah',
        color: Colors.black,
        fontWeight: FontWeight.w300,
        fontSize: 14,
      );
  TextStyle get bodyText2 => TextStyle(
        fontFamily: 'Sofia Pro By Khuzaimah',
        color: secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
}

class LightModeTheme extends FlutterFlowTheme {
  Color primaryColor = const Color(0xFF2971FB);
  Color secondaryColor = const Color(0xFF39D2C0);
  Color tertiaryColor = const Color(0xFFEE8B60);
  Color alternate = const Color(0xFFFF5963);
  Color primaryBackground = const Color(0xFFFFFFFF);
  Color secondaryBackground = const Color(0xFF000000);
  Color primaryText = const Color(0xFF000000);
  Color secondaryText = const Color(0xFF57636C);

  Color primaryBtnText = Color(0xFFFFFFFF);
  Color grayIcon = Color(0xFF95A1AC);
  Color gray200 = Color(0xFFDBE2E7);
  Color gray600 = Color(0xFF262D34);
  Color black600 = Color(0xFF090F13);
  Color tertiary400 = Color(0xFF39D2C0);
  Color textColor = Color(0xFF1E2429);
  Color lineColor = Color(0xFFE0E3E7);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String fontFamily,
    Color color,
    double fontSize,
    FontWeight fontWeight,
    FontStyle fontStyle,
    bool useGoogleFonts = true,
    TextDecoration decoration,
    double lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
            );
}
