import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:src/data/model/courses/course.dart';
import 'package:src/pages/detailCoursePage/detail-course_page.dart';
import 'package:src/utilities/const.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseCard extends StatefulWidget {
  const CourseCard({Key? key, required this.course, required this.tabIndex}) : super(key: key);
  final Course course;
  final int tabIndex;

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if(widget.tabIndex == 0){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailCoursePage(),
              settings:
              RouteSettings(arguments: {
                'course': widget.course,
              },),
            ),
          );
        } else{

          final Uri _url = Uri.parse(widget.course.fileUrl!);
          if (!await launchUrl(_url)) {
            // Show message error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Loading url failed"),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 2),
              ),
            );

          }
        }
      },
      child: Card(
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
                    imageUrl: widget.course?.imageUrl ??
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
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${widget.course.name}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${widget.course.description}",
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
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${ConstValue.levelList[int.parse(widget.course.level!) == 0 ? 0 : int.parse(widget.course.level!) - 1]}  •  ${widget.course.topics?.length ?? 0} Lessons",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),

                ),
              ],
            ),
          )),
    );
  }
}
