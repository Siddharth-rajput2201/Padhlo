import 'package:flutter/material.dart';
import 'package:padhlo/Util/Util.dart';

class MobilePdfContainer extends StatelessWidget {
  final String course;
  const MobilePdfContainer({ Key? key ,required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final double height =
        MediaQuery.of(context).size.height / DeviceConstraints.kHeight;
    // final double width =
    //     MediaQuery.of(context).size.width / DeviceConstraints.kWidth;
    return Padding(
      padding: const EdgeInsets.only(top : 10.0, bottom: 10.0),
      child: Ink(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.all(
             Radius.circular(40),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.add_to_drive_outlined,size: height*30,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text("$course")),
            ),
          ],
        ),
      ),
    );
  }
}