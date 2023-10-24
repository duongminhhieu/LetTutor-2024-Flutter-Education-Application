import 'package:flutter/material.dart';
import 'package:src/pages/listTeacherPage/list-teacher_page.dart';
import 'package:src/pages/login_page.dart';

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
      },
      theme: ThemeData(primarySwatch: Colors.blue, primaryColor: const Color.fromRGBO(0, 113, 240, 1.0)),
    );
  }

}