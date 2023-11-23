import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/pages/schedulePage/components/scheduleCard.dart';

import '../../../providers/schedule_provider.dart';

class ListCardScheduleComponent extends StatefulWidget {
  const ListCardScheduleComponent({Key? key}) : super(key: key);

  @override
  State<ListCardScheduleComponent> createState() =>
      _ListCardScheduleComponentState();
}

class _ListCardScheduleComponentState extends State<ListCardScheduleComponent> {
  @override
  Widget build(BuildContext context) {

    var scheduleProvider = context.watch<ScheduleProvider>();

    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: countBooked(),
        itemBuilder: (context, int index) {
          return ScheduleCard(schedule: scheduleProvider.schedules[index]);
        },
      ),
    );
  }

  int countBooked(){
    var scheduleProvider = context.watch<ScheduleProvider>();
    var count = 0;
    scheduleProvider.schedules.forEach((element) {
      if(element.isBooked == true){
        count++;
      }
    });
    return count;
  }
}
