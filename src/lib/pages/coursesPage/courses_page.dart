import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:src/commons/appBar.dart';
import 'package:src/commons/drawer.dart';
import 'package:src/pages/coursesPage/components/courses-main-info_component.dart';
import 'package:src/pages/coursesPage/components/list-courses_component.dart';


class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: CustomDrawer(),
      appBar: CustomAppBar(),
      body: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20),
        child: ListView(
          children:  const [
            SizedBox(height: 16),
            CoursesMainInfoComponent(),
            SizedBox(height: 16),
            ListCoursesComponent()
          ],
        ),
      ),
    );
  }
}
