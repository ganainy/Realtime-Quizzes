import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const smallPadding = 8.00;
const mediumPadding = 16.00;
const largePadding = 32.00;

var darkBg = const Color(0xFF68869A);
var lightBg = const Color(0xFFC1E2FF);

var darkText = const Color(0xFF2C353E);
var lightText = const Color(0xFF455361);
var whiteText = Colors.white;

Color bgColor = Colors.white;

const cardWidth = 160.00;
var bgMaterialColor = MyTheme.generateMaterialColorFromColor(bgColor);

class MyTheme {
  static var darkTheme = ThemeData();

  static var lighTheme = ThemeData(
    scaffoldBackgroundColor: bgColor,
    primarySwatch: generateMaterialColorFromColor(darkText),
    appBarTheme: AppBarTheme(
//change  color of any icon in appbar
      iconTheme: IconThemeData(color: darkText),
      backgroundColor: bgColor,
      elevation: 0,
      titleTextStyle:
          TextStyle(color: darkText, fontSize: 40, fontFamily: 'Plex'),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: bgColor,
      ),
    ),
    fontFamily: 'IBM',
    textTheme: TextTheme(
      displayLarge: TextStyle(color: darkText, fontSize: 32),
      titleMedium: TextStyle(color: darkText, fontSize: 18),
    ),
  );

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
