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
  const MobileQuestionPaperCourses({Key? key}) : super(key: key);

  @override
  _MobileQuestionPaperCoursesState createState() =>
      _MobileQuestionPaperCoursesState();
}

class _MobileQuestionPaperCoursesState
    extends State<MobileQuestionPaperCourses> {
  List<QuestionpaperSpecificCourse> specificCourse = [];
  List<Courses> _searchResult = [];
  TextEditingController searchController = TextEditingController();
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
      body: Column(
        children: [
          searchBar(context),
          Expanded(
            child: Scrollbar(
              interactive: true,
              child: Container(
                padding: EdgeInsets.all(15),
                child: FutureBuilder(
                    future: Networking.getAllQuestionpaperCourses(),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        specificCourse = (snapshot.data
                            as List<QuestionpaperSpecificCourse>?)!;
                        return _searchResult.length != 0 ||
                                searchController.text.isNotEmpty
                            ? GridView.builder(
                                physics: BouncingScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 15,
                                        crossAxisSpacing: 15),
                                itemCount: _searchResult.length,
                                //padhlo![0].courses.length,
                                itemBuilder: (_, index) {
                                  return Material(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(40),
                                    ),
                                    color: Theme.of(context).backgroundColor,
                                    child: InkWell(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(40),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MobileQuestionPaperSemesters(
                                                course:
                                                    _searchResult[index].course,
                                              ),
                                            ),
                                          ).then((_) {
                                            FocusScope.of(context).unfocus();
                                            searchController.clear();
                                            _searchResult.clear();
                                          });
                                        },
                                        child: MobileContainer(
                                            course: _searchResult[index].course)

                                        //course:padhlo[0].courses[index].course
                                        ),
                                  );
                                },
                              )
                            : GridView.builder(
                                physics: BouncingScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 15,
                                        crossAxisSpacing: 15),
                                itemCount: specificCourse[0].courses.length,
                                itemBuilder: (_, index) {
                                  return Material(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(40),
                                    ),
                                    color: Theme.of(context).backgroundColor,
                                    child: InkWell(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(40),
                                        ),
                                        onTap: () {
                                          //Networking.getAllQuestionpaperSemester(specificCourse[0].courses[index].course);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MobileQuestionPaperSemesters(
                                                course: specificCourse[0]
                                                    .courses[index]
                                                    .course,
                                              ),
                                            ),
                                          );
                                        },
                                        child: MobileContainer(
                                            course: specificCourse[0]
                                                .courses[index]
                                                .course)),
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
          ),
        ],
      ),
    );
  }

  Widget searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
      child: Container(
        child: TextField(
          autofocus: false,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: StaticText.kSearch,
              prefixIcon: Icon(Icons.search),
              suffixIcon: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    searchController.clear();
                    _searchResult.clear();
                  },
                  child: Icon(Icons.cancel_rounded))),
          onChanged: (value) async {
            if (specificCourse.isNotEmpty) {
              _searchResult.clear();
              if (value.isEmpty) {
                setState(() {});
                return;
              }
              setState(() {
                specificCourse[0].courses.forEach((searchValue) {
                  if (searchValue.course
                      .toLowerCase()
                      .contains(value.toLowerCase())) {
                    _searchResult.add(searchValue);
                  }
                });
              });
            }
          },
          controller: searchController,
        ),
      ),
    );
  }
}
