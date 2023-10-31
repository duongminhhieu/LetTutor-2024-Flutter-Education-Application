import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class InfoPageHistoryComponent extends StatelessWidget {
  const InfoPageHistoryComponent({Key? key}) : super(key: key);

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
      child:SvgPicture.asset('lib/images/history.svg',
          semanticsLabel: "History", height: 120)
    );
  }

  Widget _buildTitleText() {
    return Container(
      alignment: Alignment.centerLeft,
      child: const Text(
        'History',
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
        'The following is a list of lessons you have attended.\n'
          'You can review the details of the lessons you have attended',
        style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            height: 1.5
        ),
      ),
    );
  }
}
