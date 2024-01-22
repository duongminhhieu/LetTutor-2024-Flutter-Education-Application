import 'package:flutter/material.dart';

class RequiredLabel extends StatelessWidget {
  const RequiredLabel({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
          TextSpan(
              text: '* ',),
        ]));
  }
}