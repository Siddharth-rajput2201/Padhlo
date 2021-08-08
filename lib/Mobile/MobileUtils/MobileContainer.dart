import 'package:flutter/material.dart';
import 'package:padhlo/Util/Util.dart';

class MobileContainer extends StatelessWidget {
  final String course;
  const MobileContainer({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height =
        MediaQuery.of(context).size.height / DeviceConstraints.kHeight;
    final double width =
        MediaQuery.of(context).size.width / DeviceConstraints.kWidth;
    return Ink(
      height: height * 200,
      width: width * 250,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.all(
           Radius.circular(40),
        ),
      ),
      child: Center(child: Text("$course")),
    );
  }
}
