import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:padhlo/Mobile/MobileUtils/MobileContainer.dart';
import 'package:padhlo/Mobile/VIews/MobileCourses.dart';
import 'package:padhlo/ThemeProvider.dart';
import 'package:padhlo/Util/Util.dart';
import 'package:provider/provider.dart';

class Mobile extends StatefulWidget {
  const Mobile({Key? key}) : super(key: key);

  @override
  _MobileState createState() => _MobileState();
}
class _MobileState extends State<Mobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: AnimatedTextKit(
          totalRepeatCount: 1,
          animatedTexts: [
            TypewriterAnimatedText(StaticText.kAppName,speed: const Duration(milliseconds: 200)),
            TypewriterAnimatedText(StaticText.kToTheStudent,speed: const Duration(milliseconds: 200)),
            TypewriterAnimatedText(StaticText.kByTheStudent,speed: const Duration(milliseconds: 200)),
            TypewriterAnimatedText(StaticText.kForTheStudent,speed: const Duration(milliseconds: 200)),
            TypewriterAnimatedText(StaticText.kAppName,speed: const Duration(milliseconds: 200)),
        ],
      
        ),
        actions: [
          GestureDetector
          (
            onTap: (){
              ThemePrefrences themePrefrences = Provider.of<ThemePrefrences>(context,listen: false);
              themePrefrences.swapTheme();
            },
            child: Padding(
              padding: EdgeInsets.only(right : 10),
              child: Icon(Theme.of(context).brightness == Brightness.light ? Icons.brightness_4 : Icons.brightness_high),
            ))
        ],
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [ 
                    GestureDetector(
                      onTap: ()=>{
                          // Networking.getAllData()
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>MobileCourses()))
                      },
                      child: MobileContainer(course:"Notes")
                      ),
                    MobileContainer(course:"Question Papers")
        //  YoutubePlayerWeb(url: "https://www.youtube.com/watch?v=KfTtjdqLMrk",)
        ],
          ),
      ),
    );
  }
}
