import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoPageScheduleComponent extends StatelessWidget {
  const InfoPageScheduleComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildImage(),
          SizedBox(height: 16),
          _buildTitleText(),
          SizedBox(
            height: 16,
          ),
          _buildSubTitle(),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Icon(
        Icons.calendar_month_rounded,
        color: Colors.blue,
        size: 160,
      ),
    );
  }

  Widget _buildTitleText() {
    return Container(
      alignment: Alignment.centerLeft,
      child: const Text(
        'Schedule',
        style: TextStyle(
          color: Colors.black,
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSubTitle() {
    return Container(
      child: const Text(
        'Here is a list of the sessions you have booked\n'
        'You can track when the meeting starts, join the meeting with one click or can cancel the meeting before 2 hours',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
          height: 1.5
        ),
      ),
    );
  }
}
