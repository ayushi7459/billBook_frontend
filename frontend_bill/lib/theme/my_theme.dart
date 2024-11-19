import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      primaryContainer: const Color.fromARGB(255, 72, 87, 105),
      secondaryContainer: const Color.fromARGB(255, 77, 88, 96),
      surface: const Color.fromARGB(255, 16, 23, 31),
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 34, 34, 34),
    ),
    textTheme: GoogleFonts.latoTextTheme(
      const TextTheme(
        labelLarge: TextStyle(color: Colors.white),
        labelMedium: TextStyle(color: Colors.white),
        labelSmall: TextStyle(color: Colors.white),
        headlineLarge: TextStyle(color: Colors.white),
        headlineMedium: TextStyle(color: Colors.white),
        headlineSmall: TextStyle(color: Colors.white),
      ),
    ),
  );
}
