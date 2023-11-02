import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:src/pages/schedulePage/components/info-page_component.dart';
import 'package:src/pages/schedulePage/components/latest-book_component.dart';
import 'package:src/pages/schedulePage/components/list-card-schedule_component.dart';

import '../../commons/appBar.dart';
import '../../commons/drawer.dart';


class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        endDrawer: CustomDrawer(),
        appBar: CustomAppBar(),
      body: Container(
        padding: EdgeInsets.all(36.0),
        child: ListView(
          children: const [
            InfoPageScheduleComponent(),
            SizedBox(height: 32),
            LatestBookScheduleComponent(),
            SizedBox(height: 32),
            ListCardScheduleComponent(),

          ],
        ),
      )
    );
  }
}
