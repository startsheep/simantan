import 'package:flutter/material.dart';

class TypoGraphy {
  static const String fontName = 'Roboto';
  static const String fontNameBold = 'RobotoBold';
  static const String fontNameItalic = 'RobotoItalic';
  static const String fontNameBoldItalic = 'RobotoBoldItalic';

  static const TextStyle h1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w300,
    fontSize: 96,
    letterSpacing: -1.5,
  );
  static const TextStyle h2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w300,
    fontSize: 60,
    letterSpacing: -0.5,
  );
  static const TextStyle h3 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 48,
    letterSpacing: 0,
  );
  static const TextStyle h4 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 34,
    letterSpacing: 0.25,
  );
  static const TextStyle h5 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 24,
    letterSpacing: 0,
  );
  static const TextStyle h6 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 20,
    letterSpacing: 0.15,
  );
  static const TextStyle subtitle1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 0.15,
  );
  static const TextStyle subtitle2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    letterSpacing: 0.1,
  );
  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 0.5,
  );
  static const TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.25,
  );
  static const TextStyle button = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    letterSpacing: 1.25,
  );
  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.4,
  );
}
