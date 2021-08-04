import 'package:flutter/material.dart';
import 'package:padhlo/Mobile/MobileUtils/MobileContainer.dart';
import 'package:padhlo/Mobile/MobileUtils/ShimmerContainer.dart';
import 'package:padhlo/Mobile/VIews/QuestionPaper/MobileQuestionPaperSemesters.dart';
import 'package:padhlo/Networking/Class/Questionpaper/QuestionpaperCourses.dart';
import 'package:padhlo/Networking/networking.dart';
import 'package:padhlo/Util/Util.dart';
import 'package:provider/provider.dart';
import 'package:padhlo/ThemeProvider.dart';

class MobileQuestionPaperCourses extends StatefulWidget {
  const MobileQuestionPaperCourses({ Key? key }) : super(key: key);

  @override
  _MobileQuestionPaperCoursesState createState() => _MobileQuestionPaperCoursesState();
}

class _MobileQuestionPaperCoursesState extends State<MobileQuestionPaperCourses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(StaticText.kCourses),
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
      body:
          Scrollbar(
        interactive: true,
        child: Container(
          padding: EdgeInsets.all(15),
          child: FutureBuilder(
              future: Networking.getAllQuestionpaperCourses(),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  List<QuestionpaperSpecificCourse>? specificCourse =
                      snapshot.data as List<QuestionpaperSpecificCourse>?;
                  return GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15),
                    itemCount: specificCourse![0].courses.length,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                          onTap: () {
                            //Networking.getAllQuestionpaperSemester(specificCourse[0].courses[index].course);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MobileQuestionPaperSemesters(
                                  semester:
                                      specificCourse[0].courses[index].course,
                                ),
                              ),
                            );
                          },
                          child: MobileContainer(
                              course: specificCourse[0].courses[index].course)
                          );
                    },
                  );
                } else {
                  return GridView.count(
                    physics: BouncingScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    children: [
                      ShimmerContainer(),
                      ShimmerContainer(),
                      ShimmerContainer(),
                      ShimmerContainer(),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}