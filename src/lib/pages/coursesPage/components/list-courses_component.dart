import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/providers/courses_provider.dart';

import 'course-card.dart';

class ListCoursesComponent extends StatefulWidget {
  const ListCoursesComponent({Key? key}) : super(key: key);

  @override
  State<ListCoursesComponent> createState() => _ListCoursesComponentState();
}

class _ListCoursesComponentState extends State<ListCoursesComponent> {
  @override
  Widget build(BuildContext context) {
    CoursesProvider coursesProvider = Provider.of<CoursesProvider>(context, listen: true);

    return Container(
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: coursesProvider.courseList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CourseCard(
                  course: coursesProvider.courseList[index],
                ),
              );
            })
    );
  }
}
