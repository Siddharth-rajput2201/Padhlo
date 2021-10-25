import 'package:flutter/material.dart';

class ErrorUtil extends StatelessWidget {
  final String errorText;
  const ErrorUtil({Key? key,required this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text("$errorText"),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      );
  }
}