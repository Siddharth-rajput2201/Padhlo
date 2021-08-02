import 'package:flutter/material.dart';
import 'package:padhlo/Mobile/MobileUtils/MobileContainer.dart';
import 'package:padhlo/Mobile/MobileUtils/ShimmerContainer.dart';
import 'package:padhlo/Mobile/VIews/MobileSubject.dart';
import 'package:padhlo/Networking/Class/Semesters.dart';
import 'package:padhlo/Networking/networking.dart';
import 'package:padhlo/ThemeProvider.dart';
import 'package:provider/provider.dart';

class MobileSemester extends StatefulWidget {
  final String semester;

  const MobileSemester({ Key? key , required this.semester}) : super(key: key);

  @override
  _MobileSemesterState createState() => _MobileSemesterState();
}

class _MobileSemesterState extends State<MobileSemester> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Semester"),
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
      body: Container(
        padding: EdgeInsets.all(15),
        child : FutureBuilder(
          future: Networking.getAllSemester(widget.semester),
          //Networking.getAllData(),
          builder: (_,snapshot)
          {
            //Text(padhlo![0].courses[0].course);
            if(snapshot.hasData)
            {
              //List<Padhlo>? padhlo = snapshot.data as List<Padhlo>?;
              List<SpecificSemester>? specificSemester = snapshot.data as List<SpecificSemester>?;
              return GridView.builder(
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15
                ),
                itemCount: specificSemester![0].courses.semesters.length ,
                //padhlo![0].courses.length,
                itemBuilder: (_,index)
                {
                 return GestureDetector(
                   onTap: (){
                     Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>MobileSubject(
                          course :  specificSemester[0].courses.course,
                          semester : specificSemester[0].courses.semesters[index].sem.toString(),
                        ),),);
                   },
                   child: MobileContainer(course: specificSemester[0].courses.semesters[index].sem.toString()),
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
    );
  }
}