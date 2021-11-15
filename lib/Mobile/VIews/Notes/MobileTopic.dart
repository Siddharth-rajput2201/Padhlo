import 'package:flutter/material.dart';
import 'package:padhlo/Mobile/MobileUtils/MobileListContainer.dart';
import 'package:padhlo/Mobile/MobileUtils/MobilePdfContainer.dart';
import 'package:padhlo/Mobile/MobileUtils/ShimmerListContainer.dart';
import 'package:padhlo/Mobile/VIews/Notes/MobileTopicVideo.dart';
import 'package:padhlo/Networking/Class/Notes/Topics.dart';
import 'package:padhlo/Networking/networking.dart';
import 'package:padhlo/ThemeProvider.dart';
import 'package:padhlo/Util/Util.dart';
import 'package:padhlo/urlLauncher.dart';
import 'package:provider/provider.dart';

class MobileTopic extends StatefulWidget {
  final String course;
  final String semester;
  final String subject;
  final String unit;
  final String pdfName;
  final String pdfUrl;
  const MobileTopic({
    Key? key,
    required this.course,
    required this.semester,
    required this.subject,
    required this.unit,
    required this.pdfName,
    required this.pdfUrl,
  }) : super(key: key);

  @override
  _MobileTopicState createState() => _MobileTopicState();
}

class _MobileTopicState extends State<MobileTopic> {
  List<SpecificTopic> specificTopic = [];
  List<Topics> _searchResult = [];
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double height =
        MediaQuery.of(context).size.height / DeviceConstraints.kHeight;
    // final double width =
    //     MediaQuery.of(context).size.width / DeviceConstraints.kWidth;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(StaticText.kTopic),
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
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(StaticText.kUnitPdf,
                  style: TextStyle(fontSize: height * 20)),
              SizedBox(
                // height: height * 100,
                // width: width * 130,
                child: Material(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                  color: Theme.of(context).backgroundColor,
                  child: InkWell(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                    onTap: () => {launchDrive(widget.pdfUrl)},
                    child: MobilePdfContainer(course: widget.pdfName),
                  ),
                ),
              ),
              Text(StaticText.kTopics, style: TextStyle(fontSize: height * 20)),
              searchBar(context),
              Expanded(
                child: FutureBuilder(
                    future: Networking.getAllTopic(widget.course,
                        widget.semester, widget.subject, widget.unit),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        specificTopic =
                            (snapshot.data as List<SpecificTopic>?)!;
                        return Scrollbar(
                          interactive: true,
                          child: _searchResult.length != 0 ||
                                  searchController.text.isNotEmpty
                              ? ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: _searchResult.length,
                                  //padhlo![0].courses.length,
                                  itemBuilder: (_, index) {
                                    return GestureDetector(
                                      
                                        onTap: () {
                                          //  Networking.getAllTopic("BCA", "1", "Physics", "1");
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MobileTopicVideo(
                                                youtubeUrl:
                                                    _searchResult[index]
                                                        .youtubeUrl,
                                                topicName:
                                                    _searchResult[index]
                                                        .topic,
                                                pdfName: _searchResult[index]
                                                    .pdfName,
                                                pdfUrl: _searchResult[index]
                                                    .pdfUrl,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            MobileListContainer(
                                              course: _searchResult[index].topic,
                                            ),
                                            SizedBox(height: 10,)
                                          ],
                                        ));
                                  },
                                )
                              : ListView.builder(
                                
                                  physics: BouncingScrollPhysics(),
                                  itemCount: specificTopic[0]
                                      .courses
                                      .semesters
                                      .subjects
                                      .units
                                      .topics
                                      .length,
                                  //padhlo![0].courses.length,
                                  itemBuilder: (_, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        //  Networking.getAllTopic("BCA", "1", "Physics", "1");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MobileTopicVideo(
                                              youtubeUrl: specificTopic[0]
                                                  .courses
                                                  .semesters
                                                  .subjects
                                                  .units
                                                  .topics[index]
                                                  .youtubeUrl,
                                              topicName: specificTopic[0]
                                                  .courses
                                                  .semesters
                                                  .subjects
                                                  .units
                                                  .topics[index]
                                                  .topic,
                                              pdfName: specificTopic[0]
                                                  .courses
                                                  .semesters
                                                  .subjects
                                                  .units
                                                  .topics[index]
                                                  .pdfName,
                                              pdfUrl: specificTopic[0]
                                                  .courses
                                                  .semesters
                                                  .subjects
                                                  .units
                                                  .topics[index]
                                                  .pdfUrl,
                                            ),
                                          ),
                                        );
                                      },
                                      child: MobileListContainer(
                                        course: specificTopic[0]
                                            .courses
                                            .semesters
                                            .subjects
                                            .units
                                            .topics[index]
                                            .topic,
                                      ),
                                    );
                                  },
                                ),
                        );
                      } else {
                        return ListView(
                          physics: BouncingScrollPhysics(),
                          children: [
                            ShimmerListContainer(),
                            ShimmerListContainer(),
                            ShimmerListContainer(),
                            ShimmerListContainer(),
                          ],
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
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
          if (specificTopic.isNotEmpty) {
            _searchResult.clear();
            if (value.isEmpty) {
              setState(() {});
              return;
            }
            setState(() {
              specificTopic[0]
                  .courses
                  .semesters
                  .subjects
                  .units
                  .topics
                  .forEach((searchValue) {
                if (searchValue.topic
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
    );
  }
}
