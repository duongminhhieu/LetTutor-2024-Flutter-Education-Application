import 'package:flutter/material.dart';

class ListCommentComponent extends StatelessWidget {
  const ListCommentComponent({Key? key}) : super(key: key);

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

          _buildInfoCommentItem(),
          SizedBox(height: 36),
          _buildInfoCommentItem(),
          SizedBox(height: 36),
          _buildInfoCommentItem(),
          SizedBox(height: 36),
          _buildInfoCommentItem(),

        ],
      ),
    );
  }

  Widget _buildInfoCommentItem() {
    return Container(
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
              child: Image.asset('lib/assets/images/loginImage.png'),
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text(
                    'Hieu Duong',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '125 days',
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
                      i < 3.5 ? Icons.star : Icons.star_border,
                      color: Colors.yellow,
                      size: 16,
                    ),
                ],
              ),
              SizedBox(height: 6),
              Container(
                child: Text('Good courses, very good'),
              )
            ],
          )
        ],
      ),
    );
  }
}
