import 'package:flutter/material.dart';
import 'package:padhlo/Mobile/MobileUtils/MobilePdfContainer.dart';
import 'package:padhlo/Mobile/MobileUtils/ShimmerContainer.dart';
import 'package:padhlo/Networking/Class/Questionpaper/QuestionpaperYears.dart';
import 'package:padhlo/Networking/networking.dart';
import 'package:padhlo/ThemeProvider.dart';
import 'package:padhlo/Util/Util.dart';
import 'package:padhlo/urlLauncher.dart';
import 'package:provider/provider.dart';

class MobileQuestionPaperYear extends StatefulWidget {
  final String course;
  final String semester;
  final String subject;
  const MobileQuestionPaperYear({ Key? key,required this.course ,required this.semester,required this.subject}) : super(key: key);

  @override
  _MobileQuestionPaperYearState createState() => _MobileQuestionPaperYearState();
}

class _MobileQuestionPaperYearState extends State<MobileQuestionPaperYear> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(StaticText.kYear),
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
      body: Scrollbar(
        interactive: true,
              child: Container(
          padding: EdgeInsets.all(15),
          child : FutureBuilder(
            future: Networking.getAllQuestionpaperYear(widget.course,widget.semester,widget.subject),
            builder: (_,snapshot)
            {
              if(snapshot.hasData)
              {
                List<QuestionpaperSpecificYears>? specificYear = snapshot.data as List<QuestionpaperSpecificYears>?;
                return GridView.builder(
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15
                  ),
                  itemCount: specificYear![0].courses.semesters.subjects.years.length ,
                  //padhlo![0].courses.length,
                  itemBuilder: (_,index)
                  {
                   return GestureDetector(
                     onTap: (){
                       launchDrive(specificYear[0].courses.semesters.subjects.years[index].pdfUrl);
                     },
                     child: MobilePdfContainer(course: specificYear[0].courses.semesters.subjects.years[index].year.toString()),
                     );
                  },
                );
              }
              else
              {
                return  GridView.count(
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
            }
          ),
        ),
      ),
    );
  }
}