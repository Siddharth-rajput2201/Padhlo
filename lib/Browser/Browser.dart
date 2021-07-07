import 'package:flutter/material.dart';

class Browser extends StatefulWidget {
  const Browser({ Key? key }) : super(key: key);

  @override
  _BrowserState createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text("Browser"),),
    );
  }
}