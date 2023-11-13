import 'package:flutter/material.dart';

class InfoLessonComponent extends StatefulWidget {
  const InfoLessonComponent({Key? key}) : super(key: key);

  @override
  _InfoLessonComponentState createState() => _InfoLessonComponentState();
}

class _InfoLessonComponentState extends State<InfoLessonComponent> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("lib/assets/images/loginImage.png", fit: BoxFit.cover),
        Container(
          padding: const EdgeInsets.only(top: 32, bottom: 20),
          alignment: Alignment.centerLeft,
          child: const Text(
            "Life in the Internet Age",
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            "Let's discuss how technology is changing the way we live",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }


}
