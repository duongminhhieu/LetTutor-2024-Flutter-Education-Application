import 'package:flutter/material.dart';
import 'package:src/data/model/tutor/tutor.dart';
import 'package:src/pages/detailATeacherPage/components/info_component.dart';
import 'package:src/pages/detailATeacherPage/components/list-comment_component.dart';

import 'components/table-calendar_component.dart';


class DetailATeacherPage extends StatelessWidget {
  const DetailATeacherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tutor = ModalRoute.of(context)!.settings.arguments as Tutor;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text("Detail Teacher", textAlign: TextAlign.center,),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child:  Column(
            children: [
              InfoComponent(tutor: tutor),
              ListCommentComponent(tutor: tutor),
              TableCalendar(tutor: tutor),
            ],
          ),
        ),
      ),
    );
  }
}
