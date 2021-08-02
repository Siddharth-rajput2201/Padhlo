import 'package:flutter/material.dart';
import 'package:padhlo/Mobile/MobileUtils/MobileContainer.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatefulWidget {
  const ShimmerContainer({Key? key}) : super(key: key);

  @override
  _ShimmerContainerState createState() => _ShimmerContainerState();
}

class _ShimmerContainerState extends State<ShimmerContainer> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Theme.of(context).backgroundColor,
        highlightColor: Theme.of(context).splashColor,
        child: MobileContainer(course: "Padhlo"));
  }
}
