import 'package:flutter/material.dart';
import 'package:padhlo/Util/SpashScreen.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({ Key? key }) : super(key: key);

  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/error.png"),         
              ElevatedButton(onPressed: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SplashScreen())), child: Text("RETRY"))
            ],
          ),
        ),
      ),
    );
  }
}