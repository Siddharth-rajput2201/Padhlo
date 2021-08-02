import 'package:flutter/material.dart';
import 'package:padhlo/Mobile/MobileUtils/MobileContainer.dart';
import 'package:padhlo/Mobile/MobileUtils/ShimmerContainer.dart';
import 'package:padhlo/Mobile/VIews/MobileTopic.dart';
import 'package:padhlo/Networking/Class/Units.dart';
import 'package:padhlo/Networking/networking.dart';
import 'package:padhlo/ThemeProvider.dart';
import 'package:provider/provider.dart';

class MobileUnit extends StatefulWidget {
  final String course;
  final String semester;
  final String subject;
  const MobileUnit({ Key? key ,required this.course, required this.semester , required this.subject}) : super(key: key);

  @override
  _MobileUnitState createState() => _MobileUnitState();
}

class _MobileUnitState extends State<MobileUnit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Unit"),
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
            future: Networking.getAllUnit(widget.course,widget.semester,widget.subject),
            //Networking.getAllData(),
            builder: (_,snapshot)
            {
              //Text(padhlo![0].courses[0].course);
              if(snapshot.hasData)
              {
                //List<Padhlo>? padhlo = snapshot.data as List<Padhlo>?;
                List<SpecificUnit>? specificUnit = snapshot.data as List<SpecificUnit>?;
                return GridView.builder(
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15
                  ),
                  itemCount: specificUnit![0].courses.semesters.subjects.units.length ,
                  //padhlo![0].courses.length,
                  itemBuilder: (_,index)
                  {
                   return GestureDetector(
                     onTap: (){
                      //  Networking.getAllTopic("BCA", "1", "Physics", "1");
                       Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>MobileTopic(
                            course :  specificUnit[0].courses.course,
                            semester : specificUnit[0].courses.semesters.sem.toString(),
                            subject: specificUnit[0].courses.semesters.subjects.subject,
                            unit : specificUnit[0].courses.semesters.subjects.units[index].unit.toString(),
                            pdfName: specificUnit[0].courses.semesters.subjects.units[index].pdfName,
                            pdfUrl: specificUnit[0].courses.semesters.subjects.units[index].pdfUrl,
                          ),),);
                     },
                     child: MobileContainer(course: specificUnit[0].courses.semesters.subjects.units[index].unit.toString()),
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