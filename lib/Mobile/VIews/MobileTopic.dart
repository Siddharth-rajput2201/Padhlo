import 'package:flutter/material.dart';
import 'package:padhlo/Mobile/MobileUtils/MobileListContainer.dart';
import 'package:padhlo/Mobile/MobileUtils/MobilePdfContainer.dart';
import 'package:padhlo/Mobile/MobileUtils/ShimmerListContainer.dart';
import 'package:padhlo/Networking/Class/Topics.dart';
import 'package:padhlo/Networking/networking.dart';
import 'package:padhlo/ThemeProvider.dart';
import 'package:padhlo/Util/Util.dart';
import 'package:provider/provider.dart';

class MobileTopic extends StatefulWidget {
  final String course;
  final String semester;
  final String subject;
  final String unit;
  final String pdfName; 
  final String pdfUrl;
  const MobileTopic(
      {Key? key,
      required this.course,
      required this.semester,
      required this.subject,
      required this.unit,
      required this.pdfName,
      required this.pdfUrl,
      })
      : super(key: key);

  @override
  _MobileTopicState createState() => _MobileTopicState();
}

class _MobileTopicState extends State<MobileTopic> {
  @override
  Widget build(BuildContext context) {
      final double height =
        MediaQuery.of(context).size.height / DeviceConstraints.kHeight;
    final double width =
        MediaQuery.of(context).size.width / DeviceConstraints.kWidth;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("TOPIC"),
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
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("UNIT PDF : "),
              SizedBox(
                height: height * 130,
                width: width * 180,
                  child: 
                  MobilePdfContainer(course: "HELLO"),
                ),
              Text("TOPICS : "),
              Expanded(
                child: FutureBuilder(
                    future: Networking.getAllTopic(widget.course,
                        widget.semester, widget.subject, widget.unit),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        List<SpecificTopic>? specificUnit =
                            snapshot.data as List<SpecificTopic>?;
                        return 
                        ListView.builder(
                          physics: BouncingScrollPhysics(),
                         
                          itemCount: specificUnit![0]
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
                                //  Navigator.push(context,
                                //     MaterialPageRoute(builder: (context)=>MobileSubject(
                                //       course :  specificSemester[0].courses.course,
                                //       semester : specificSemester[0].courses.semesters[index].sem.toString(),
                                //     ),),);
                              },
                              child: MobileListContainer(course: 
                                        specificUnit[0]
                                      .courses
                                      .semesters
                                      .subjects
                                      .units
                                      .topics[index]
                                      .topic,
                              )
                             );
                          },
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
}
