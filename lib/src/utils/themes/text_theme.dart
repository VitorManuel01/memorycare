import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TTextTheme {
  TTextTheme._();
  static TextTheme lightTextTheme = TextTheme(
      headlineLarge: GoogleFonts.dynaPuff(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineMedium: GoogleFonts.dynaPuff(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineSmall: GoogleFonts.dynaPuff(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodySmall: GoogleFonts.dynaPuff(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ));

  static TextTheme darkTextTheme = TextTheme(
      headlineLarge: GoogleFonts.dynaPuff(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineMedium: GoogleFonts.dynaPuff(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineSmall: GoogleFonts.dynaPuff(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodySmall: GoogleFonts.dynaPuff(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ));
}
