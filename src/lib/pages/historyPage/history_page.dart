
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:src/pages/historyPage/components/info-page_component.dart';
import 'package:src/pages/historyPage/components/list-card-history_component.dart';

import '../../commons/appBar.dart';
import '../../commons/drawer.dart';
class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

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
              InfoPageHistoryComponent(),
              SizedBox(height: 32),
              ListCardHistoryComponent()
            ],
          ),
        )
    );
  }
}
