import 'package:flutter/material.dart';
import 'package:src/untils/scheduleCard.dart';


class ListCardScheduleComponent extends StatefulWidget {
  const ListCardScheduleComponent({Key? key}) : super(key: key);

  @override
  State<ListCardScheduleComponent> createState() => _ListCardScheduleComponentState();
}

class _ListCardScheduleComponentState extends State<ListCardScheduleComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
        children:[
          ScheduleCard(),
          const SizedBox(height: 24),
          ScheduleCard(),
          const SizedBox(height: 24),
          ScheduleCard(),
          const SizedBox(height: 24),
          ScheduleCard(),
        ]
      ),
    );
  }
}
