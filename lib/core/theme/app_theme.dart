import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static final TextTheme _textTheme = TextTheme(
    displaySmall: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
    labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
    labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
    headlineLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
      fontFamily: GoogleFonts.shareTech().fontFamily,
      textTheme: _textTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,

      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
      textTheme: _textTheme,
    );
  }
}
