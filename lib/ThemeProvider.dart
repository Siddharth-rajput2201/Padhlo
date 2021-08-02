import 'package:flutter/material.dart';
import 'package:padhlo/Util/Util.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemePrefrences with ChangeNotifier {
 
  late ThemeData _selectedTheme;

  ThemeData light = ThemeData.light();
  ThemeData dark = ThemeData.dark().copyWith(
    primaryColor: ThemeColor.kdarkThemeBackGroundColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ThemeColor.kdarkThemeBackGroundColor,
    backgroundColor: ThemeColor.kdarkThemeContainerColor,
    indicatorColor: ThemeColor.kdarkThemeShimmerDarkColor,
    splashColor:ThemeColor.kdarkThemeShimmerLightColor, 
  );

  ThemePrefrences(isDarkMode)
  {
    this._selectedTheme = isDarkMode ? dark : light;
  }

  ThemeData get getTheme => _selectedTheme;


  Future<void> swapTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_selectedTheme == dark) {
      _selectedTheme = light;
      prefs.setBool("isDarkTheme", false);
    } else {
      _selectedTheme = dark;
      prefs.setBool("isDarkTheme", true);
    }
    notifyListeners();
  }


}
