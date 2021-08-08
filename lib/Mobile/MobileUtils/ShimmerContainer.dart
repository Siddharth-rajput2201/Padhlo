import 'package:flutter/material.dart';
import 'package:padhlo/Util/Util.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatefulWidget {
  const ShimmerContainer({Key? key}) : super(key: key);

  @override
  _ShimmerContainerState createState() => _ShimmerContainerState();
}

class _ShimmerContainerState extends State<ShimmerContainer> {
  @override
  Widget build(BuildContext context) {
    final double height =
    MediaQuery.of(context).size.height / DeviceConstraints.kHeight;
    final double width =
    MediaQuery.of(context).size.width / DeviceConstraints.kWidth;
    return Shimmer.fromColors(
        baseColor: Theme.of(context).indicatorColor,
        highlightColor: Theme.of(context).splashColor,
        child: Container(
          height: height * 200,
          width: width * 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                  Radius.circular(40),
            ),
            color: Theme.of(context).backgroundColor,
          ),
          child: Center(child: Text("Padlo"))
          ));
  }
}
