import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF258CF4);
  static const Color backgroundLight = Color(0xFFF5F7F8);
  static const Color backgroundDark = Color(0xFF101922);
  static const Color textLight = Color(0xFF111418);
  static const Color textDark = Colors.white;

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: backgroundLight,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      // background: backgroundLight, // fromSeed might override, so we set scaffoldBackgroundColor
      surface: backgroundLight,
      onBackground: textLight,
      onSurface: textLight,
      brightness: Brightness.light,
    ),
    textTheme: GoogleFonts.plusJakartaSansTextTheme(
      ThemeData.light().textTheme.apply(
            bodyColor: textLight,
            displayColor: textLight,
          ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundLight,
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(color: textLight),
      titleTextStyle: TextStyle(
        color: textLight,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999), // .rounded-full
        ),
        textStyle: GoogleFonts.plusJakartaSans(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: Colors.white,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: backgroundDark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      surface: backgroundDark,
      onBackground: textDark,
      onSurface: textDark,
      brightness: Brightness.dark,
    ),
    textTheme: GoogleFonts.plusJakartaSansTextTheme(
      ThemeData.dark().textTheme.apply(
            bodyColor: textDark,
            displayColor: textDark,
          ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundDark,
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(color: textDark),
      titleTextStyle: TextStyle(
        color: textDark,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
        textStyle: GoogleFonts.plusJakartaSans(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: const Color(0xFF1F2937), // Darker shade for inputs
    ),
  );
}
