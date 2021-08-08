import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:padhlo/Mobile/MobileUtils/MobileContainer.dart';
import 'package:padhlo/Mobile/VIews/Notes/MobileCourses.dart';
import 'package:padhlo/Mobile/VIews/QuestionPaper/MobileQuestionPaperCourses.dart';
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
            TypewriterAnimatedText(
              StaticText.kAppName,
              speed: const Duration(milliseconds: 200),
              // textStyle: TextStyle(fontFamily: 'PatrickHand')
            ),
            TypewriterAnimatedText(
              StaticText.kToTheStudent,
              speed: const Duration(milliseconds: 200),
              // textStyle: TextStyle(fontFamily: 'PatrickHand')
            ),
            TypewriterAnimatedText(
              StaticText.kByTheStudent,
              speed: const Duration(milliseconds: 200),
              // textStyle: TextStyle(fontFamily: 'PatrickHand')
            ),
            TypewriterAnimatedText(
              StaticText.kForTheStudent,
              speed: const Duration(milliseconds: 200),
              // textStyle: TextStyle(fontFamily: 'PatrickHand')
            ),
            TypewriterAnimatedText(
              StaticText.kAppName,
              speed: const Duration(milliseconds: 200),
              // textStyle: TextStyle(fontFamily: 'PatrickHand')
            ),
          ],
        ),
        actions: [
          GestureDetector(
              onTap: () {
                ThemePrefrences themePrefrences =
                    Provider.of<ThemePrefrences>(context, listen: false);
                themePrefrences.swapTheme();
              },
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Theme.of(context).brightness == Brightness.light
                    ? Icons.brightness_4
                    : Icons.brightness_high),
              ))
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Material(
                borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                child: InkWell(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                    onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MobileCourses()))
                        },
                    child: MobileContainer(course: "Notes")),
              ),
              SizedBox(height: 30),
               Material(
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
                color: Theme.of(context).backgroundColor,
                child: InkWell(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MobileQuestionPaperCourses()))
                      },
                  child: MobileContainer(course: "Question Papers"))
               )
              //  YoutubePlayerWeb(url: "https://www.youtube.com/watch?v=KfTtjdqLMrk",)
            ],
          ),
        ),
      ),
    );
  }
}
