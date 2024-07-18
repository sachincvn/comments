import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF0054BE);
  static const Color secondaryColor = Color(0xFF303F60);
  static const Color lightColor = Color(0xFFF5F5FD);
  static const Color grayColor = Color(0xFFCED3DC);

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      background: lightColor,
    ),
    scaffoldBackgroundColor: lightColor,
    inputDecorationTheme: _inputDecorationTheme(),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          color: secondaryColor),
      bodyLarge: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal,
          color: secondaryColor),
      bodyMedium: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal,
          color: secondaryColor),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      background: Colors.black,
    ),
    scaffoldBackgroundColor: Colors.black,
    inputDecorationTheme: _inputDecorationTheme(),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          color: lightColor),
      bodyLarge: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal,
          color: lightColor),
      bodyMedium: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal,
          color: lightColor),
    ),
  );

  static InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme(
      contentPadding: const EdgeInsets.all(18),
      enabledBorder: _inputBorder(AppTheme.grayColor),
      disabledBorder: _inputBorder(AppTheme.grayColor),
      focusedBorder: _inputBorder(AppTheme.primaryColor),
      errorBorder: _inputBorder(Colors.red),
      focusedErrorBorder: _inputBorder(Colors.red),
    );
  }

  static _inputBorder([Color color = AppTheme.grayColor]) => OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 2),
        borderRadius: BorderRadius.circular(12),
      );
}
