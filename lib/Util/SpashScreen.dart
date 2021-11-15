import 'package:flutter/material.dart';
import 'package:padhlo/Mobile/VIews/Mobile.dart';
import 'package:padhlo/Networking/networking.dart';
import 'package:padhlo/Util/ErrorScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _redirect();  
  }

  void _redirect() async 
  {
    if(await Networking.getServerStatus() == true)
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Mobile()));
    }
    else if(await Networking.getServerStatus() == false){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ErrorScreen()));
    }
    else
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ErrorScreen()));
    }
  }
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
              Image.asset("assets/images/splashscreen.png"),         
              Padding(
                padding: const EdgeInsets.only(left : 20.0 , right:  20.0),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      backgroundColor: Theme.of(context).backgroundColor,
                      color: Colors.white,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}