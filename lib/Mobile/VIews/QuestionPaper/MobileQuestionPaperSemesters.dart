import 'package:flutter/material.dart';
import 'package:padhlo/Mobile/MobileUtils/MobileContainer.dart';
import 'package:padhlo/Mobile/MobileUtils/ShimmerContainer.dart';
import 'package:padhlo/Mobile/VIews/QuestionPaper/MobileQuestionPaperSubject.dart';
import 'package:padhlo/Networking/Class/Questionpaper/QuestionpaperSemesters.dart';
import 'package:padhlo/Networking/networking.dart';
import 'package:padhlo/ThemeProvider.dart';
import 'package:padhlo/Util/Util.dart';
import 'package:provider/provider.dart';

class MobileQuestionPaperSemesters extends StatefulWidget {
  final String semester;
  const MobileQuestionPaperSemesters({Key? key, required this.semester})
      : super(key: key);

  @override
  _MobileQuestionPaperSemestersState createState() =>
      _MobileQuestionPaperSemestersState();
}

class _MobileQuestionPaperSemestersState
    extends State<MobileQuestionPaperSemesters> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(StaticText.kSemester),
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
      body: Scrollbar(
        interactive: true,
        child: Container(
          padding: EdgeInsets.all(15),
          child: FutureBuilder(
              future: Networking.getAllQuestionpaperSemester(widget.semester),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  List<QuestionpaperSpecificSemester>? specificSemester =
                      snapshot.data as List<QuestionpaperSpecificSemester>?;
                  return GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15),
                    itemCount: specificSemester![0].courses.semesters.length,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MobileQuestionPaperSubjects(
                                course: specificSemester[0].courses.course,
                                semester: specificSemester[0]
                                    .courses
                                    .semesters[index]
                                    .sem
                                    .toString(),
                              ),
                            ),
                          );
                        },
                        child: MobileContainer(
                            course: specificSemester[0]
                                .courses
                                .semesters[index]
                                .sem
                                .toString()),
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
