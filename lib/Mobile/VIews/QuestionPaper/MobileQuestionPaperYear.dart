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
  List<QuestionpaperSpecificYears> specificYear = [];
  List<Years> _searchResult = [];
  TextEditingController searchController = TextEditingController();
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
      body: Column(
        children: [
          searchBar(context),
          Expanded(
            child: Scrollbar(
              interactive: true,
                    child: Container(
                padding: EdgeInsets.all(15),
                child : FutureBuilder(
                  future: Networking.getAllQuestionpaperYear(widget.course,widget.semester,widget.subject),
                  builder: (_,snapshot)
                  {
                    if(snapshot.hasData)
                    {
                      specificYear = (snapshot.data as List<QuestionpaperSpecificYears>?)!;
                      return _searchResult.length != 0 ||
                        searchController.text.isNotEmpty ? GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15
                        ),
                        itemCount: _searchResult.length,
                        //padhlo![0].courses.length,
                        itemBuilder: (_,index)
                        {
                         return Material(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(40),
                                    ),
                                    color: Theme.of(context).backgroundColor,
                                    child: InkWell(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(40),
                                        ),
                           onTap: (){
                            // Networking.getAllUnit("BCA","1","Physics");
                            launchDrive(_searchResult[index].pdfUrl);
                           },
                           child: MobilePdfContainer(course: _searchResult[index].year.toString()),
                           //course:padhlo[0].courses[index].course
                           ),);
                        },
                      ) : GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15
                        ),
                        itemCount: specificYear[0].courses.semesters.subjects.years.length ,
                        //padhlo![0].courses.length,
                        itemBuilder: (_,index)
                        {
                         return Material(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(40),
                                    ),
                                    color: Theme.of(context).backgroundColor,
                                    child: InkWell(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(40),
                                        ),
                           onTap: (){
                             launchDrive(specificYear[0].courses.semesters.subjects.years[index].pdfUrl);
                           },
                           child: MobilePdfContainer(course: specificYear[0].courses.semesters.subjects.years[index].year.toString()),
                           ),);
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
            border: OutlineInputBorder(
                borderRadius : BorderRadius.circular(20)
              ),
              hintText:StaticText.kSearch, 
              prefixIcon: Icon(Icons.search),
              suffixIcon: GestureDetector(
                onTap: (){
                  FocusScope.of(context).unfocus();
                  searchController.clear();
                  _searchResult.clear();
                },
                child: Icon(Icons.cancel_rounded)
                )
              ),
          onChanged: (value) async {
           if(specificYear.isNotEmpty)
           {
            _searchResult.clear();
            if (value.isEmpty) {
              setState(() {});
              return;
            }
            setState(() {
            specificYear[0].courses.semesters.subjects.years.forEach((searchValue) {
              if (searchValue.year.toString().toLowerCase().contains(value.toLowerCase())) { 
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