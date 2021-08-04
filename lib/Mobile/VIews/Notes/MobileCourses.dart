import 'package:flutter/material.dart';
import 'package:padhlo/Mobile/MobileUtils/MobileContainer.dart';
import 'package:padhlo/Mobile/MobileUtils/ShimmerContainer.dart';
import 'package:padhlo/Mobile/VIews/Notes/MobileSemester.dart';
import 'package:padhlo/Networking/Class/Notes/Courses.dart';
import 'package:padhlo/Networking/networking.dart';
import 'package:padhlo/Util/Util.dart';
import 'package:provider/provider.dart';
import 'package:padhlo/ThemeProvider.dart';

class MobileCourses extends StatefulWidget {
  const MobileCourses({Key? key}) : super(key: key);

  @override
  _MobileCoursesState createState() => _MobileCoursesState();
}

class _MobileCoursesState extends State<MobileCourses> {
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
      body:
          //searchBar(),
          Scrollbar(
        interactive: true,
        child: Container(
          padding: EdgeInsets.all(15),
          child: FutureBuilder(
              future: Networking.getAllCourses(),
              //Networking.getAllData(),
              builder: (_, snapshot) {
                //Text(padhlo![0].courses[0].course);
                if (snapshot.hasData) {
                  //List<Padhlo>? padhlo = snapshot.data as List<Padhlo>?;
                  List<SpecificCourse>? specificCourse =
                      snapshot.data as List<SpecificCourse>?;
                  return GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15),
                    itemCount: specificCourse![0].courses.length,
                    //padhlo![0].courses.length,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                          onTap: () {
              
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MobileSemester(
                                  course:
                                      specificCourse[0].courses[index].course,
                                ),
                              ),
                            );
                          },
                          child: MobileContainer(
                              course: specificCourse[0].courses[index].course)

                          //course:padhlo[0].courses[index].course
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

  // Widget searchBar() {
  //   return Padding(
  //     padding: const EdgeInsets.only(
  //         left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
  //     child: Container(
  //       child: TextField(
  //         decoration: InputDecoration(
  //             hintText: "Search...", prefixIcon: Icon(Icons.search)),
  //         onChanged: (value) {
  //           setState(() {
  //              searchCourse = value.toLowerCase();
  //           });
  //         },
  //         controller: searchController,
  //       ),
  //     ),
  //   );
  // }
}
