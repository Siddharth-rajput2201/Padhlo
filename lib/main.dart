import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:padhlo/Browser/Browser.dart';
import 'package:padhlo/Mobile/VIews/Mobile.dart';
import 'package:padhlo/Tablet/Tablet.dart';
import 'package:padhlo/ThemeProvider.dart';
import 'package:padhlo/Util/Util.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(
    ChangeNotifierProvider(
      child: MyApp(),
      create : (BuildContext context) => ThemePrefrences(prefs.getBool("isDarkTheme")??true)
      ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemePrefrences>(
          builder: (context, themePreference , child){
          return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: StaticText.kAppName,
        theme: themePreference.getTheme,
        home: MyHomePage(),
      );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static int mobileLimit = 640;
  static int tabletLimit = 1100;

  void printConstraints(double width, double height) {
    print("Width : " + width.toString());
    print("\nHeight : " + height.toString());
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constaints) {
        if (constaints.maxWidth <= mobileLimit) {
          //  printConstraints(constaints.maxWidth, constaints.maxHeight);
          return Mobile();
        } else if (constaints.maxWidth > mobileLimit &&
            constaints.maxWidth < tabletLimit) {
          //  printConstraints(constaints.maxWidth, constaints.maxHeight);
          return Tablet();
        } else {
            // print("BROWSER=============>");
            // printConstraints(constaints.maxWidth , constaints.maxHeight);
          return Browser();
        }
      },
    );
  }
}
