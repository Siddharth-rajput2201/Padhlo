import 'package:flutter/material.dart';
import 'package:padhlo/Mobile/MobileUtils/MobileContainer.dart';
import 'package:padhlo/Mobile/MobileUtils/ShimmerContainer.dart';
import 'package:padhlo/Mobile/VIews/MobileUnit.dart';
import 'package:padhlo/Networking/Class/Subjects.dart';
import 'package:padhlo/Networking/networking.dart';
import 'package:padhlo/ThemeProvider.dart';
import 'package:provider/provider.dart';

class MobileSubject extends StatefulWidget {
  final String course;
  final String semester;
  const MobileSubject({ Key? key ,required this.course , required this.semester}) : super(key: key);

  @override
  _MobileSubjectState createState() => _MobileSubjectState();
}

class _MobileSubjectState extends State<MobileSubject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Subject"),
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
            future: Networking.getAllSubject(widget.course,widget.semester),
            //Networking.getAllData(),
            builder: (_,snapshot)
            {
              //Text(padhlo![0].courses[0].course);
              if(snapshot.hasData)
              {
                //List<Padhlo>? padhlo = snapshot.data as List<Padhlo>?;
                List<SpecificSubject>? specificSubject = snapshot.data as List<SpecificSubject>?;
                return GridView.builder(
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15
                  ),
                  itemCount: specificSubject![0].courses.semesters.subjects.length ,
                  //padhlo![0].courses.length,
                  itemBuilder: (_,index)
                  {
                   return GestureDetector(
                     onTap: (){
                      // Networking.getAllUnit("BCA","1","Physics");
                       Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>MobileUnit(
                            course: specificSubject[0].courses.course,
                            semester: specificSubject[0].courses.semesters.sem.toString(),
                            subject: specificSubject[0].courses.semesters.subjects[index].subject),),);
                     },
                     child: MobileContainer(course: specificSubject[0].courses.semesters.subjects[index].subject),
                     //course:padhlo[0].courses[index].course
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