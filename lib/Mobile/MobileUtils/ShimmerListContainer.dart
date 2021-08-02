import 'package:flutter/material.dart';
import 'package:padhlo/Mobile/MobileUtils/MobileListContainer.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListContainer extends StatefulWidget {
  const ShimmerListContainer({Key? key}) : super(key: key);

  @override
  _ShimmerListContainerState createState() => _ShimmerListContainerState();
}

class _ShimmerListContainerState extends State<ShimmerListContainer> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Theme.of(context).backgroundColor,
        highlightColor: Theme.of(context).splashColor,
        child: MobileListContainer(course: "Padhlo"));
  }
}
