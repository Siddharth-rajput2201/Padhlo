import 'package:flutter/material.dart';
import 'package:padhlo/Util/Util.dart';

class MobileListContainer extends StatelessWidget {
  final String course;
  const MobileListContainer({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height =
        MediaQuery.of(context).size.height / DeviceConstraints.kHeight;
    final double width =
        MediaQuery.of(context).size.width / DeviceConstraints.kWidth;
    return Padding(
      padding: const EdgeInsets.only(top : 10.0, bottom: 10.0),
      child: Container(
        height: height * 60,
        width: width * 250,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.all(
             Radius.circular(40),
          ),
        ),
        child: Center(child: Text("$course")),
      ),
    );
  }
}
