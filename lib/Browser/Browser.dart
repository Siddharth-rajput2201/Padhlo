import 'package:flutter/material.dart';
import 'package:padhlo/Mobile/MobileUtils/MobileContainer.dart';

class Browser extends StatefulWidget {
  const Browser({ Key? key }) : super(key: key);

  @override
  _BrowserState createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text("Browser"),    
    ),
    body: Center(
        child: SingleChildScrollView(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 500,
                width: 500,
                child: MobileContainer(course: "BCA") 
                //YoutubePlayerWeb(url: "https://www.youtube.com/watch?v=KfTtjdqLMrk",)
                )
            ],
          ),
        ),
      ),
    );
  }
}