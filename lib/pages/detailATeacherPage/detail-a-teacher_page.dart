import 'package:flutter/material.dart';
import 'package:src/data/model/tutor/tutor.dart';
import 'package:src/l10n/app_localizations.dart';
import 'package:src/pages/detailATeacherPage/components/info_component.dart';
import 'package:src/pages/detailATeacherPage/components/list-comment_component.dart';

import 'components/table-calendar_component.dart';


class DetailATeacherPage extends StatefulWidget {
  const DetailATeacherPage({Key? key}) : super(key: key);

  @override
  State<DetailATeacherPage> createState() => _DetailATeacherPageState();
}

class _DetailATeacherPageState extends State<DetailATeacherPage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    Tutor tutor = arguments['tutor'] as Tutor;
    int index = arguments['index'] as int;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.tutorDetails, textAlign: TextAlign.center,),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child:  Column(
            children: [
              InfoComponent(tutor: tutor, index: index),
              ListCommentComponent(tutor: tutor),
              TableCalendar(tutor: tutor),
            ],
          ),
        ),
      ),
    );
  }
}
