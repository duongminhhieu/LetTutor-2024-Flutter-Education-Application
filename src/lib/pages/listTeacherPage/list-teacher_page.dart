import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    myColor = Theme.of(context).primaryColor;
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
