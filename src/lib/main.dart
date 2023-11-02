import 'package:flutter/material.dart';
import 'package:src/pages/coursesPage/courses_page.dart';
import 'package:src/pages/detailATeacherPage/detail-a-teacher_page.dart';
import 'package:src/pages/detailCoursePage/detail-course_page.dart';
import 'package:src/pages/detailLessonPage/detail-lesson_page.dart';
import 'package:src/pages/historyPage/history_page.dart';
import 'package:src/pages/listTeacherPage/list-teacher_page.dart';
import 'package:src/pages/loginPage/login_page.dart';
import 'package:src/pages/schedulePage/schedule_page.dart';
import 'package:src/pages/videoCallPage/videoCallPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      routes: {
        '/loginPage': (context) => LoginPage(),
        '/listTeacherPage': (context) => ListTeacherPage(),
        '/detailATeacher': (context) => DetailATeacherPage(),
        '/schedulePage': (context) => SchedulePage(),
        '/historyPage': (context) => HistoryPage(),
        '/coursesPage': (context) => CoursesPage(),
        '/detailCoursePage': (context) => DetailCoursePage(),
        '/detailLessonPage': (context) => DetailLessonPage(),
        '/videoCallPage': (context) => VideoCallPage(),


      },
      theme: ThemeData(primarySwatch: Colors.blue, primaryColor: const Color.fromRGBO(0, 113, 240, 1.0)),
    );
  }

}