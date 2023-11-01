import 'package:flutter/material.dart';


class CourseCard extends StatefulWidget {
  const CourseCard({Key? key}) : super(key: key);

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade100, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Container(
                child: Image.asset("lib/images/loginImage.png",
                fit: BoxFit.cover,),
              ),
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                alignment: Alignment.centerLeft,
                child: Text("Life in the Internet Age", style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text("Let's discuss how technology is changing the way we live", style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.normal
                ),),
              ),
              SizedBox(height: 12,),
              Container(
                alignment: Alignment.centerLeft,
                child: Text("Intermediate - 9 lesson", style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.normal
                ),),
              ),
            ],
          ),
        ));
  }
}
