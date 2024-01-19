import 'package:flutter/material.dart';
import 'package:src/pages/detailLessonPage/detail-lesson_page.dart';

import '../../../data/model/courses/course.dart';
import '../../../utilities/const.dart';

class OverviewCourseComponent extends StatelessWidget {
  const OverviewCourseComponent({Key? key, required this.course})
      : super(key: key);
  final Course course;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildTitle("Overview"),
        SizedBox(height: 20),
        _buildSubTitle(Icons.question_mark, "Why take this course", Colors.red),
        SizedBox(height: 8),
        _buildSubDescription(course.reason ?? CourseOverView.takenReason),
        SizedBox(height: 20),
        _buildSubTitle(
            Icons.question_mark, "What will you be able to do", Colors.red),
        SizedBox(height: 8),
        _buildSubDescription(course.purpose ?? CourseOverView.achievement),
        SizedBox(height: 20),
        _buildTitle("Experience Level"),
        SizedBox(height: 20),
        _buildSubTitle(Icons.group_add, ConstValue.levelList[int.parse(course.level!)  - 1] , Colors.blueAccent),
        SizedBox(height: 20),
        _buildTitle("Course Length"),
        SizedBox(height: 20),
        _buildSubTitle(Icons.topic, "${course.topics?.length ?? 0} topics", Colors.blueAccent),
        SizedBox(height: 20),
        _buildTitle("List Topics"),
        SizedBox(height: 20),
        _buildListTopics( context)
      ],
    );
  }

  Widget _buildTitle(String title) {
    return Container(
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
      ),
    );
  }

  Widget _buildSubTitle(IconData icon, String title, Color color) {
    return Container(
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: color,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }

  Widget _buildSubDescription(String text) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.normal,
            fontSize: 14,
            height: 1.3),
      ),
    );
  }

  Widget _buildListTopics(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: course.topics?.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemList(index + 1, context);
      },

    );
  }

  Widget _buildItemList(int index, BuildContext context) {
    return InkWell(
      onTap: () {
        // Xử lý sự kiện khi mục được nhấp vào
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailLessonPage(),
            settings:
            RouteSettings(arguments: {
              'course': course,
              'index': index - 1
            },),
          ),
        );

      },
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          color: Colors.grey.shade100,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 1),
            )
          ],
        ),
        padding: EdgeInsets.only(left: 12, right: 12, top: 24, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              index.toString(),
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              course.topics?[index - 1].name ?? "No title",
              style: TextStyle(
                  color: Colors.grey.shade900,
                  fontSize: 20,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
