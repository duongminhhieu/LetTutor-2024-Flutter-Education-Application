import 'package:flutter/material.dart';
import 'package:src/data/model/tutor/tutor.dart';
import 'package:src/data/model/tutor/tutor_feedback.dart';


class ListCommentComponent extends StatelessWidget {
  const ListCommentComponent({Key? key, required this.tutor}) : super(key: key);
  final Tutor tutor;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
              child: const Text("Others review",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black))),
          SizedBox(height: 20),
          _buildInfoCommentItems()
        ],
      ),
    );
  }

  Widget _buildInfoCommentItems() {
    return Column(
      children: tutor.feedbacks?.map((feedback) {
        return _buildInfoCommentItem(feedback);
      }).toList() ?? [],
    );
  }

  Widget _buildInfoCommentItem(FeedbackTutor feedback) {
    DateTime currentDate = DateTime.now();

    // Parse the updatedAt string to a DateTime object
    DateTime updateDate = DateTime.parse(feedback.updatedAt ?? '');

    int daysAgo = currentDate.difference(updateDate).inDays;
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.network(feedback.firstInfo!.avatar!),
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    feedback.firstInfo!.name ?? 'Anonymous',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '$daysAgo days ago',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  for (int i = 0; i < 5; i++)
                    Icon(
                      i < (feedback.rating ?? 0) ? Icons.star : Icons.star_border,
                      color: Colors.yellow,
                      size: 16,
                    ),
                ],
              ),
              SizedBox(height: 6),
              Container(
                child: Text(feedback.content ?? ''),
              )
            ],
          ),
        ],
      ),
    );
  }
}
