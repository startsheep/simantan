import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SchemaColor {
  static const Color primary = Color.fromRGBO(77, 110, 255, 1);
  static const Color success = Color.fromARGB(255, 111, 255, 111);
  static const Color primaryDark = Color.fromARGB(255, 25, 25, 25);
  static const Color dFontColor = Color.fromARGB(255, 25, 25, 25);
  static const Color primaryLight = Color(0xFF64B5F6);
  static const Color accent = Color(0xFF00ACC1);
  static const Color accentDark = Color(0xFF00838F);
  static const Color accentLight = Color(0xFF4DD0E1);
  static const Color background = Color(0xFFECEFF1);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFB00020);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryDark = Color(0xFF000000);
  static const Color onPrimaryLight = Color(0xFF000000);
  static const Color onAccent = Color(0xFF000000);
  static const Color onAccentDark = Color(0xFFFFFFFF);
  static const Color onAccentLight = Color(0xFF000000);
  static const Color onBackground = Color(0xFF000000);
  static const Color onSurface = Color(0xFF000000);
  static const Color onError = Color(0xFFFFFFFF);

  static ThemeData get getTheme {
    return ThemeData(
      primaryColor: primary,
      primaryColorDark: primaryDark,
      primaryColorLight: primaryLight,
      backgroundColor: background,
      scaffoldBackgroundColor: surface,
      errorColor: error,
      fontFamily: GoogleFonts.poppins().fontFamily,
      // textTheme: TextTheme(d)
    );
  }
}
