import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const smallPadding = 8.00;
const mediumPadding = 16.00;
const largePadding = 32.00;

// Modern color palette - Vibrant Indigo Theme
const Color primaryColor = Color(0xFF4F46E5); // Vibrant Indigo
const Color primaryHoverColor = Color(0xFF4338CA); // Darker Indigo for hover

// Accent color for authentication screens
const Color accentGreen = Color(0xFF34D399); // Vibrant Green

// Quiz theme colors
const Color quizPrimary = Color(0xFFFFD600); // Vibrant Yellow
const Color quizBackgroundDark = Color(0xFF1A237E); // Deep Blue
const Color quizSurfaceDark = Color(0xFF283593); // Medium Blue
const Color quizCorrect = Color(0xFF00C853); // Bright Green
const Color quizIncorrect = Color(0xFFD50000); // Bright Red

// Friends screen theme
const Color friendsBlue = Color(0xFF3B82F6); // Vibrant Blue

// Light theme colors
const Color backgroundLight = Color(0xFFF3F4F6); // Light Gray
const Color surfaceLight = Color(0xFFFFFFFF); // White
const Color primaryTextLight = Color(0xFF1F2937); // Dark Gray
const Color secondaryTextLight = Color(0xFF6B7280); // Medium Gray
const Color borderLight = Color(0xFFE5E7EB); // Border Light

// Dark theme colors
const Color backgroundDark = Color(0xFF111827); // Very Dark Blue/Gray
const Color surfaceDark = Color(0xFF1F2937); // Dark Gray
const Color primaryTextDark = Color(0xFFF9FAFB); // Off-white
const Color secondaryTextDark = Color(0xFF9CA3AF); // Light Gray
const Color borderDark = Color(0xFF374151); // Border Dark

// Legacy color support (for backward compatibility)
var darkBg = primaryColor;
var lightBg = const Color(0xFFE0E7FF); // Light Indigo

var darkText = primaryTextLight;
var lightText = secondaryTextLight;
var whiteText = Colors.white;

Color bgColor = backgroundLight;
Color darkBgColor = backgroundDark;

const cardWidth = 160.00;

class MyTheme {
  // Modern Material 3 Light Theme
  static var lighTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
      primary: primaryColor,
      secondary: const Color(0xFF818CF8),
      tertiary: const Color(0xFFC7D2FE),
      surface: surfaceLight,
      error: const Color(0xFFBA1A1A),
    ),
    scaffoldBackgroundColor: backgroundLight,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: primaryTextLight),
      backgroundColor: backgroundLight,
      elevation: 0,
      titleTextStyle: const TextStyle(
          color: primaryTextLight, fontSize: 40, fontFamily: 'Poppins'),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: backgroundLight,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    fontFamily: 'Poppins',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          color: primaryTextLight, fontSize: 30, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
          color: primaryTextLight, fontSize: 18, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(
          color: primaryTextLight, fontSize: 18, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(color: secondaryTextLight, fontSize: 14),
      bodySmall: TextStyle(color: secondaryTextLight, fontSize: 13),
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
      seedColor: primaryColor,
      brightness: Brightness.dark,
      primary: primaryColor,
      secondary: const Color(0xFF818CF8),
      tertiary: const Color(0xFF6366F1),
      surface: surfaceDark,
      error: const Color(0xFFFFB4AB),
    ),
    scaffoldBackgroundColor: backgroundDark,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: primaryTextDark),
      backgroundColor: backgroundDark,
      elevation: 0,
      titleTextStyle: const TextStyle(
          color: primaryTextDark, fontSize: 40, fontFamily: 'Poppins'),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: backgroundDark,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    fontFamily: 'Poppins',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          color: primaryTextDark, fontSize: 30, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
          color: primaryTextDark, fontSize: 18, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(
          color: primaryTextDark, fontSize: 18, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(color: secondaryTextDark, fontSize: 14),
      bodySmall: TextStyle(color: secondaryTextDark, fontSize: 13),
    ),
    cardTheme: const CardThemeData(
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      color: surfaceDark,
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
