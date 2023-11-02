import 'package:flutter/material.dart';
import 'components/course-card_component.dart';
import 'components/overview-course_component.dart';

class DetailCoursePage extends StatefulWidget {
  const DetailCoursePage({Key? key}) : super(key: key);

  @override
  State<DetailCoursePage> createState() => _DetailCoursePageState();
}

class _DetailCoursePageState extends State<DetailCoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Detail Course", textAlign: TextAlign.center,),
        ),
        body: Container(
          padding: EdgeInsets.all(36.0),
          child: ListView(
            children: [
              CourseCardComponent(),
              SizedBox(height: 32),
              OverviewCourseComponent()
            ],
          ),
        ));
  }
}
