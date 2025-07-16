import 'package:flutter/material.dart';

class StyledBodyText extends StatelessWidget {
  const StyledBodyText({this.text, super.key});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.brown[900],
      ),
    );
  }
}
