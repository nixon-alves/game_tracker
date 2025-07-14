import 'package:flutter/material.dart';

ThemeData baseTheme({
  required Brightness brightness,
  required Color primaryColor,
  required Color? scaffoldBackgroundColor,
  required Color? cardColor,
}) {
  final base = ThemeData(
    brightness: brightness,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    cardColor: cardColor,
    fontFamily: 'Bree',
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontSize: 16),
      bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 20),
    ),
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: brightness,
    ),
  );
  return base;
}

final ThemeData lightTheme = baseTheme(
  brightness: Brightness.light,
  primaryColor: Colors.cyan,
  scaffoldBackgroundColor: Colors.white,
  cardColor: Colors.grey[100]
  );

final ThemeData darkTheme = baseTheme(
  brightness: Brightness.dark,
  primaryColor: Colors.indigo,
  scaffoldBackgroundColor: Colors.black54,
  cardColor: Colors.grey[900],
  );
