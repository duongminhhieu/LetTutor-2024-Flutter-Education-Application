import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:src/data/model/courses/course.dart';
import 'package:src/l10n/app_localizations.dart';

import '../../detailLessonPage/detail-lesson_page.dart';

class CourseCardComponent extends StatelessWidget {
  const CourseCardComponent({Key? key, required this.course}) : super(key: key);

  final Course course;

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
                child: CachedNetworkImage(
                  width: double.maxFinite,
                  fit: BoxFit.fitHeight,
                  imageUrl: course?.imageUrl ??
                      "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1700296337596.jpg",
                  progressIndicatorBuilder:
                      (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => Image.network(
                      "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1700296337596.jpg"),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 32, bottom: 20),
                alignment: Alignment.centerLeft,
                child:  Text(
                  course.name!,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child:  Text(
                  course.description!,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailLessonPage(),
                        settings:
                        RouteSettings(arguments: {
                          'course': course,
                          'index': 0
                        },),
                      ),
                    );
                  },
                  child: Text(AppLocalizations.of(context)!.discover),
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
