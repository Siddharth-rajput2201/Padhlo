import 'package:flutter/material.dart';
import 'package:padhlo/Util/Util.dart';

class MobileListContainer extends StatelessWidget {
  final String course;
  const MobileListContainer({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height =
        MediaQuery.of(context).size.height / DeviceConstraints.kHeight;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height * 50,
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
