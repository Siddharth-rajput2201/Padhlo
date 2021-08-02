import 'package:flutter/material.dart';
import 'package:padhlo/Mobile/MobileUtils/MobilePdfContainer.dart';
import 'package:padhlo/ThemeProvider.dart';
import 'package:padhlo/Util/Util.dart';
import 'package:padhlo/Youtubeplayer/youtubeplayerweb.dart';
import 'package:provider/provider.dart';

import '../../urlLauncher.dart';

class MobileTopicVideo extends StatefulWidget {
  final String youtubeUrl;
  final String topicName;
  final String pdfName;
  final String pdfUrl;
  const MobileTopicVideo(
      {Key? key,
      required this.youtubeUrl,
      required this.topicName,
      required this.pdfName,
      required this.pdfUrl})
      : super(key: key);

  @override
  _MobileTopicVideoState createState() => _MobileTopicVideoState();
}

class _MobileTopicVideoState extends State<MobileTopicVideo> {
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
          title: Text(widget.topicName),
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YoutubePlayerWeb(
                url: widget.youtubeUrl,
              ),
              topicPdf(widget.pdfUrl, widget.pdfName, height, width),
            ],
          ),
        ));
  }

  Widget topicPdf(String pdfUrl, String pdfName,double height, double width) {
    if(pdfUrl.isNotEmpty)
    {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          child: Column(
            crossAxisAlignment:  CrossAxisAlignment.start,
            children: [
                Text("Topic Pdf : ",style: TextStyle(fontSize: height*20),),
                  SizedBox(
                  height: height * 130,
                  width: width * 180,
                    child: 
                    GestureDetector(
                      onTap: ()=>{
                        launchDrive(widget.pdfUrl)
                      },
                      child: MobilePdfContainer(course: widget.pdfName)
                      ),
                  ),
            ],
          ),
        ),
      );
    }
    else
    {
      return SizedBox();
    }
  }

}
