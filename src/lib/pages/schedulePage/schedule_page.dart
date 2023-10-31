import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:src/pages/schedulePage/components/info-page_component.dart';
import 'package:src/pages/schedulePage/components/latest-book_component.dart';
import 'package:src/pages/schedulePage/components/list-card-schedule_component.dart';


class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

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
