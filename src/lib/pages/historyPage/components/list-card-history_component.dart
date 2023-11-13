import 'package:flutter/material.dart';
import 'package:src/pages/historyPage/components/history-card.dart';

class ListCardHistoryComponent extends StatefulWidget {
  const ListCardHistoryComponent({Key? key}) : super(key: key);

  @override
  State<ListCardHistoryComponent> createState() => _ListCardHistoryComponentState();
}

class _ListCardHistoryComponentState extends State<ListCardHistoryComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children:[
            HistoryCard(),
            const SizedBox(height: 24),
            HistoryCard(),
            const SizedBox(height: 24),
            HistoryCard(),
            const SizedBox(height: 24),
            HistoryCard(),
          ]
      ),
    );
  }
}
