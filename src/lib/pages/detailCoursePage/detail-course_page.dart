import 'package:flutter/material.dart';
import 'package:src/data/model/courses/course.dart';
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

    Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    Course course = arguments['course'] as Course;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Detail Course", textAlign: TextAlign.center,),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 20.0, right: 20),
          child: ListView(
            children: [
              CourseCardComponent(course: course),
              SizedBox(height: 32),
              OverviewCourseComponent(course: course,)
            ],
          ),
        ));
  }
}
