import 'package:flutter/material.dart';
import 'package:padhlo/Util/Util.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemePrefrences with ChangeNotifier {
 
  late ThemeData _selectedTheme;

  ThemeData light = ThemeData.light().copyWith(
      textTheme: ThemeData.dark().copyWith().textTheme.apply(
      fontFamily: 'PatrickHand',
      bodyColor: Colors.black
    ),
    primaryTextTheme: ThemeData.dark().copyWith().textTheme.apply(
      fontFamily: 'PatrickHand',
      bodyColor: Colors.black
    ),
    appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.black)),
    primaryColor: ThemeColor.klightThemeContainerColor,
    scaffoldBackgroundColor: ThemeColor.klighThemeBackGroundColor,
    backgroundColor: ThemeColor.klightThemeContainerColor,
    indicatorColor: ThemeColor.klightThemeBaseColor,
    splashColor: ThemeColor.klightThemeHighlightColor,
    brightness: Brightness.light
  );
  ThemeData dark = ThemeData.dark().copyWith( 
    appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
    primaryColor: ThemeColor.kdarkThemeBackGroundColor,
    brightness: Brightness.dark,
    indicatorColor: ThemeColor.kdarkThemeContainerColor,
    scaffoldBackgroundColor: ThemeColor.kdarkThemeBackGroundColor,
    backgroundColor: ThemeColor.kdarkThemeContainerColor,
    splashColor:ThemeColor.kdarkThemeShimmerLightColor,
    textTheme: ThemeData.dark().copyWith().textTheme.apply(
      fontFamily: 'PatrickHand'
    ),
    primaryTextTheme: ThemeData.dark().copyWith().textTheme.apply(
      fontFamily: 'PatrickHand',
    ),
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
