import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static TextTheme lightTextTheme = TextTheme(
    bodyText1: GoogleFonts.ubuntuCondensed(
      fontSize: 14.0,
      // fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline1: GoogleFonts.ubuntuCondensed(
      fontSize: 24.0,
      // fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline2: GoogleFonts.ubuntuCondensed(
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline3: GoogleFonts.ubuntuCondensed(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    headline6: GoogleFonts.ubuntuCondensed(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    button: GoogleFonts.ubuntuCondensed(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
    ),
  );
  static TextTheme darkTextTheme = TextTheme(
    bodyText1: GoogleFonts.ubuntuCondensed(
      fontSize: 14.0,
      // fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headline1: GoogleFonts.ubuntuCondensed(
      fontSize: 24.0,
      // fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline2: GoogleFonts.ubuntuCondensed(
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headline3: GoogleFonts.ubuntuCondensed(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline6: GoogleFonts.ubuntuCondensed(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    button: GoogleFonts.ubuntuCondensed(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
    ),
  );

  static ThemeData light() {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.green,
        brightness: Brightness.light,
      ).copyWith(
        onPrimary: Colors.black,
        secondary: Colors.grey[900],
      ),
      textTheme: lightTextTheme,
    );
  }

  static ThemeData dark() {
    return ThemeData(
      primaryColor: Colors.grey[900],
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
      ).copyWith(
        secondary: Colors.green,
      ),
      textTheme: darkTextTheme,
    );
  }
}
