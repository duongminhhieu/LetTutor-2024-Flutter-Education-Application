import 'package:flutter/material.dart';
import 'package:src/pages/detailLessonPage/components/list-topics-lesson_component.dart';

import '../../commons/appBar.dart';
import '../../commons/drawer.dart';
import 'components/main-info-lesson_component.dart';

class DetailLessonPage extends StatefulWidget {
  const DetailLessonPage({Key? key}) : super(key: key);

  @override
  State<DetailLessonPage> createState() => _DetailLessonPageState();
}

class _DetailLessonPageState extends State<DetailLessonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        endDrawer: CustomDrawer(),
        appBar: CustomAppBar(),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: const [
              InfoLessonComponent(),
              ListTopicsLessonComponent()
            ],
          ),
        ));
  }
}
