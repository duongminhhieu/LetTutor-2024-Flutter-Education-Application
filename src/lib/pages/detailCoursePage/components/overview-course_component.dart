import 'package:flutter/material.dart';

class OverviewCourseComponent extends StatelessWidget {
  const OverviewCourseComponent({Key? key}) : super(key: key);

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
        _buildSubDescription(
            "Our world is rapidly changing thanks to new technology, and the vocabulary needed to discuss modern life is evolving almost daily. In this course you will learn the most up-to-date terminology from expertly crafted lessons as well from your native-speaking tutor."),
        SizedBox(height: 20),
        _buildSubTitle(
            Icons.question_mark, "What will you be able to do", Colors.red),
        SizedBox(height: 8),
        _buildSubDescription(
            "You will learn vocabulary related to timely topics like remote work, artificial intelligence, online privacy, and more. In addition to discussion questions, you will practice intermediate level speaking tasks such as using data to describe trends."),
        SizedBox(height: 20),
        _buildTitle("Experience Level"),
        SizedBox(height: 20),
        _buildSubTitle(Icons.group_add, "Intermediate", Colors.blueAccent),
        SizedBox(height: 20),
        _buildTitle("Course Length"),
        SizedBox(height: 20),
        _buildSubTitle(Icons.topic, "9 topics", Colors.blueAccent),
        SizedBox(height: 20),
        _buildTitle("List Topics"),
        SizedBox(height: 20),
        _buildListTopics()
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

  Widget _buildListTopics() {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildItemList(1, "The Internet"),
        _buildItemList(2, "Artificial Intelligence"),
        _buildItemList(3, "Social Media"),
        _buildItemList(4, "Internet Privacy"),
        _buildItemList(5, "Live Stream"),
        _buildItemList(4, "Coding"),
      ],
    );
  }

  Widget _buildItemList(int index, String title) {
    return InkWell(
      onTap: () {
        // Xử lý sự kiện khi mục được nhấp vào
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
              title,
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
