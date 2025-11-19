import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const smallPadding = 8.00;
const mediumPadding = 16.00;
const largePadding = 32.00;

// Modern color palette using HSL-based colors for better harmony
var darkBg = const Color(0xFF68869A);
var lightBg = const Color(0xFFC1E2FF);

var darkText = const Color(0xFF2C353E);
var lightText = const Color(0xFF455361);
var whiteText = Colors.white;

Color bgColor = Colors.white;
Color darkBgColor = const Color(0xFF1A1C1E);

const cardWidth = 160.00;

class MyTheme {
  // Modern Material 3 Light Theme
  static var lighTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF2C353E),
      brightness: Brightness.light,
      primary: const Color(0xFF2C353E),
      secondary: const Color(0xFF68869A),
      tertiary: const Color(0xFFC1E2FF),
      surface: Colors.white,
      error: const Color(0xFFBA1A1A),
    ),
    scaffoldBackgroundColor: bgColor,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: darkText),
      backgroundColor: bgColor,
      elevation: 0,
      titleTextStyle:
          TextStyle(color: darkText, fontSize: 40, fontFamily: 'Plex'),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: bgColor,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    fontFamily: 'IBM',
    textTheme: TextTheme(
      displayLarge:
          TextStyle(color: darkText, fontSize: 32, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: darkText, fontSize: 18),
      bodyMedium: TextStyle(color: lightText, fontSize: 14),
    ),
    cardTheme: const CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );

  // Modern Material 3 Dark Theme
  static var darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF2C353E),
      brightness: Brightness.dark,
      primary: const Color(0xFFC1E2FF),
      secondary: const Color(0xFF68869A),
      tertiary: const Color(0xFF2C353E),
      surface: const Color(0xFF1A1C1E),
      error: const Color(0xFFFFB4AB),
    ),
    scaffoldBackgroundColor: darkBgColor,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Color(0xFFC1E2FF)),
      backgroundColor: darkBgColor,
      elevation: 0,
      titleTextStyle: const TextStyle(
          color: Color(0xFFC1E2FF), fontSize: 40, fontFamily: 'Plex'),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF1A1C1E),
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    fontFamily: 'IBM',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          color: Color(0xFFC1E2FF), fontSize: 32, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: Color(0xFFE1E3E5), fontSize: 18),
      bodyMedium: TextStyle(color: Color(0xFFC4C6C8), fontSize: 14),
    ),
    cardTheme: const CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      color: Color(0xFF2A2C2E),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );

  // Utility function to generate MaterialColor (kept for backward compatibility)
  static MaterialColor generateMaterialColorFromColor(Color color) {
    return MaterialColor(color.value, {
      50: Color.fromRGBO(color.red, color.green, color.blue, 0.1),
      100: Color.fromRGBO(color.red, color.green, color.blue, 0.2),
      200: Color.fromRGBO(color.red, color.green, color.blue, 0.3),
      300: Color.fromRGBO(color.red, color.green, color.blue, 0.4),
      400: Color.fromRGBO(color.red, color.green, color.blue, 0.5),
      500: Color.fromRGBO(color.red, color.green, color.blue, 0.6),
      600: Color.fromRGBO(color.red, color.green, color.blue, 0.7),
      700: Color.fromRGBO(color.red, color.green, color.blue, 0.8),
      800: Color.fromRGBO(color.red, color.green, color.blue, 0.9),
      900: Color.fromRGBO(color.red, color.green, color.blue, 1.0),
    });
  }
}
