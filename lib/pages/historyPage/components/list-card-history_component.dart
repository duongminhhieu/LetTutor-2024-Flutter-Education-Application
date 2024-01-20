import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/pages/historyPage/components/history-card.dart';
import 'package:src/providers/schedule_provider.dart';

class ListCardHistoryComponent extends StatefulWidget {
  const ListCardHistoryComponent({Key? key}) : super(key: key);

  @override
  State<ListCardHistoryComponent> createState() => _ListCardHistoryComponentState();
}

class _ListCardHistoryComponentState extends State<ListCardHistoryComponent> {
  @override
  Widget build(BuildContext context) {

    final ScheduleProvider scheduleProvider = context.watch<ScheduleProvider>();

    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: scheduleProvider.historyList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: HistoryCard(
                bookingInfo: scheduleProvider.historyList[index],
              ),
            );
          })
      );
  }
}
