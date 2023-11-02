import 'package:flutter/material.dart';

class CourseCardComponent extends StatelessWidget {
  const CourseCardComponent({Key? key}) : super(key: key);

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
                child: Image.asset(
                  "lib/images/loginImage.png",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 32, bottom: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Life in the Internet Age",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Let's discuss how technology is changing the way we live",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Discover"),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 40),
                  backgroundColor: Colors.blueAccent),
                ),
              ),
            ],
          ),
        ));
  }
}
