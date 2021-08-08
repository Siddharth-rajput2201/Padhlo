import 'package:flutter/material.dart';
import 'package:padhlo/Mobile/MobileUtils/MobileContainer.dart';
import 'package:padhlo/Mobile/MobileUtils/ShimmerContainer.dart';
import 'package:padhlo/Mobile/VIews/Notes/MobileSubject.dart';
import 'package:padhlo/Networking/Class/Notes/Semesters.dart';
import 'package:padhlo/Networking/networking.dart';
import 'package:padhlo/ThemeProvider.dart';
import 'package:padhlo/Util/Util.dart';
import 'package:provider/provider.dart';

class MobileSemester extends StatefulWidget {
  final String course;

  const MobileSemester({Key? key, required this.course}) : super(key: key);

  @override
  _MobileSemesterState createState() => _MobileSemesterState();
}

class _MobileSemesterState extends State<MobileSemester> {
  List<SpecificSemester> specificSemester = [];
  List<Semesters> _searchResult = [];
  TextEditingController searchController = TextEditingController();
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
      body: Column(
        children: [
          searchBar(context),
          Expanded(
            child: Scrollbar(
              interactive: true,
              child: Container(
                padding: EdgeInsets.all(15),
                child: FutureBuilder(
                    future: Networking.getAllSemester(widget.course),
                    //Networking.getAllData(),
                    builder: (_, snapshot) {
                      //Text(padhlo![0].courses[0].course);
                      if (snapshot.hasData) {
                        //List<Padhlo>? padhlo = snapshot.data as List<Padhlo>?;
                        specificSemester =
                            (snapshot.data as List<SpecificSemester>?)!;
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
                                            builder: (context) => MobileSubject(
                                              course: widget.course,
                                              semester: _searchResult[index]
                                                  .sem
                                                  .toString(),
                                            ),
                                          ),
                                        ).then((_) {
                                          FocusScope.of(context).unfocus();
                                          searchController.clear();
                                          _searchResult.clear();
                                        });
                                      },
                                      child: MobileContainer(
                                          course: _searchResult[index]
                                              .sem
                                              .toString()),
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
                                itemCount: specificSemester[0]
                                    .courses
                                    .semesters
                                    .length,
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
                                            builder: (context) => MobileSubject(
                                              course: specificSemester[0]
                                                  .courses
                                                  .course,
                                              semester: specificSemester[0]
                                                  .courses
                                                  .semesters[index]
                                                  .sem
                                                  .toString(),
                                            ),
                                          ),
                                        ).then((_) {
                                          FocusScope.of(context).unfocus();
                                          searchController.clear();
                                          _searchResult.clear();
                                        });
                                      },
                                      child: MobileContainer(
                                          course: specificSemester[0]
                                              .courses
                                              .semesters[index]
                                              .sem
                                              .toString()),
                                      //course:padhlo[0].courses[index].course
                                    ),
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
          keyboardType: TextInputType.number,
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
            if (specificSemester.isNotEmpty) {
              _searchResult.clear();
              if (value.isEmpty) {
                setState(() {});
                return;
              }
              setState(() {
                specificSemester[0].courses.semesters.forEach((searchValue) {
                  if (searchValue.sem
                      .toString()
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
