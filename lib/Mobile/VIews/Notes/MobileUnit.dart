import 'package:flutter/material.dart';
import 'package:padhlo/Mobile/MobileUtils/MobileContainer.dart';
import 'package:padhlo/Mobile/MobileUtils/MobilePdfContainer.dart';
import 'package:padhlo/Mobile/MobileUtils/ShimmerContainer.dart';
import 'package:padhlo/Mobile/VIews/Notes/MobileTopic.dart';
import 'package:padhlo/Networking/Class/Notes/Units.dart';
import 'package:padhlo/Networking/networking.dart';
import 'package:padhlo/ThemeProvider.dart';
import 'package:padhlo/Util/Util.dart';
import 'package:padhlo/urlLauncher.dart';
import 'package:provider/provider.dart';

class MobileUnit extends StatefulWidget {
  final String course;
  final String semester;
  final String subject;
  final String bookName;
  final String bookUrl;
  const MobileUnit(
      {Key? key,
      required this.course,
      required this.semester,
      required this.subject,
      required this.bookName,
      required this.bookUrl})
      : super(key: key);

  @override
  _MobileUnitState createState() => _MobileUnitState();
}

class _MobileUnitState extends State<MobileUnit> {
  List<SpecificUnit> specificUnit = [];
  List<Units> _searchResult = [];
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
     final double height =
        MediaQuery.of(context).size.height / DeviceConstraints.kHeight;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(StaticText.kUnit),
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(StaticText.KBook,
                  style: TextStyle(fontSize: height * 20)),
            SizedBox(
              child: Material(
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
                color: Theme.of(context).backgroundColor,
                child: InkWell(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                  onTap: () => {launchDrive(widget.bookUrl)},
                  child: MobilePdfContainer(course: widget.bookName),
                ),
              ),
            ),
            Text(StaticText.KUnits, style: TextStyle(fontSize: height * 20)),
            searchBar(context),
            Expanded(
              child: Scrollbar(
                interactive: true,
                child: Container(
                  // padding: EdgeInsets.all(15),
                  child: FutureBuilder(
                      future: Networking.getAllUnit(
                          widget.course, widget.semester, widget.subject),
                      //Networking.getAllData(),
                      builder: (_, snapshot) {
                        //Text(padhlo![0].courses[0].course);
                        if (snapshot.hasData) {
                          //List<Padhlo>? padhlo = snapshot.data as List<Padhlo>?;
                          specificUnit = (snapshot.data as List<SpecificUnit>?)!;
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
                                          //  Networking.getAllTopic("BCA", "1", "Physics", "1");
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MobileTopic(
                                                course: widget.course,
                                                semester:
                                                    widget.semester.toString(),
                                                subject: widget.subject,
                                                unit: _searchResult[index]
                                                    .unit
                                                    .toString(),
                                                pdfName:
                                                    _searchResult[index].pdfName,
                                                pdfUrl:
                                                    _searchResult[index].pdfUrl,
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
                                                .unit
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
                                  itemCount: specificUnit[0]
                                      .courses
                                      .semesters
                                      .subjects
                                      .units
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
                                          //  Networking.getAllTopic("BCA", "1", "Physics", "1");
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MobileTopic(
                                                course: specificUnit[0]
                                                    .courses
                                                    .course,
                                                semester: specificUnit[0]
                                                    .courses
                                                    .semesters
                                                    .sem
                                                    .toString(),
                                                subject: specificUnit[0]
                                                    .courses
                                                    .semesters
                                                    .subjects
                                                    .subject,
                                                unit: specificUnit[0]
                                                    .courses
                                                    .semesters
                                                    .subjects
                                                    .units[index]
                                                    .unit
                                                    .toString(),
                                                pdfName: specificUnit[0]
                                                    .courses
                                                    .semesters
                                                    .subjects
                                                    .units[index]
                                                    .pdfName,
                                                pdfUrl: specificUnit[0]
                                                    .courses
                                                    .semesters
                                                    .subjects
                                                    .units[index]
                                                    .pdfUrl,
                                              ),
                                            ),
                                          ).then((_) {
                                            FocusScope.of(context).unfocus();
                                            searchController.clear();
                                            _searchResult.clear();
                                          });
                                        },
                                        child: MobileContainer(
                                            course: specificUnit[0]
                                                .courses
                                                .semesters
                                                .subjects
                                                .units[index]
                                                .unit
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
      ),
    );
  }

  Widget searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 10.0, bottom: 10.0),
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
            if (specificUnit.isNotEmpty) {
              _searchResult.clear();
              if (value.isEmpty) {
                setState(() {});
                return;
              }
              setState(() {
                specificUnit[0]
                    .courses
                    .semesters
                    .subjects
                    .units
                    .forEach((searchValue) {
                  if (searchValue.unit
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
