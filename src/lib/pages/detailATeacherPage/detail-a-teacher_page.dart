import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:src/pages/detailATeacherPage/components/info_component.dart';
import 'package:src/pages/detailATeacherPage/components/list-comment_component.dart';

class DetailATeacherPage extends StatelessWidget {
  const DetailATeacherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: SvgPicture.asset('lib/images/lettutor_logo.svg',
            semanticsLabel: "My SVG", height: 36),
        actions: [
          MaterialButton(
            onPressed: () {},
            minWidth: 20,
            color: Colors.grey.shade300,
            textColor: Colors.white,
            padding: const EdgeInsets.all(6),
            shape: const CircleBorder(),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(10), // Adjust the radius as needed
              child: SvgPicture.asset('lib/images/vietnam.svg',
                  semanticsLabel: "My SVG", height: 18),
            ),
          ),
          Container(
            child: IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.grey,
              ),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: const Column(
            children: [
              InfoComponent(filterLabels: [
                'History',
                'Geography',
                'History',
                'Geography',
                'History',
                'Geography',
                'English'
              ]),
              ListCommentComponent()
            ],
          ),
        ),
      ),
    );
  }
}
