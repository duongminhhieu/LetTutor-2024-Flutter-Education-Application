import 'package:flutter/material.dart';

class LoadingFilled extends StatelessWidget {
  const LoadingFilled({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        constraints: const BoxConstraints.expand(),
        child: const Center(child: CircularProgressIndicator())
    );
  }

}