

import 'package:flutter/material.dart';

class Extra
{
  static MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
}
class ThemeColor
{
   static const Color kdarkThemeBackGroundColor = Color(0xFF171721);
   static const Color kdarkThemeContainerColor = Color(0xFF2C2C34);
} 

class StaticText
{
  static const String kAppName= "Padhlo";
  static const String kToTheStudent = "To The Student";
  static const String kByTheStudent = "By The Student";
  static const String kForTheStudent = "For The Student";
}

class DeviceConstraints
{
  static const double kWidth = 500;
  static const double kHeight = 679; 
}


