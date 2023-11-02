import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:src/commons/appBar.dart';
import 'package:src/commons/drawer.dart';
import 'package:src/pages/listTeacherPage/components/banner_component.dart';
import 'package:src/pages/listTeacherPage/components/filter_component.dart';
import 'package:src/pages/listTeacherPage/components/listTeacher_component.dart';

class ListTeacherPage extends StatefulWidget {
  const ListTeacherPage({Key? key}) : super(key: key);

  @override
  State<ListTeacherPage> createState() => _ListTeacherPageState();
}

class _ListTeacherPageState extends State<ListTeacherPage> {
  late Color myColor;
  late Size mediaSize;

  @override
  Widget build(BuildContext context) {
    myColor = Theme
        .of(context)
        .primaryColor;
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: CustomDrawer(),
      appBar: CustomAppBar(),
      body: ListView(children: [
        BannerComponent(myColor: myColor),
        const FilterComponent(),
        Container(
          padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
          child: const Divider(
            height: 20,
            color: Color.fromRGBO(238, 238, 238, 60),
            thickness: 1,
          ),
        ),
        const ListTeacherComponent()
      ]),
    );
  }
}
