import 'package:flutter/material.dart';
import 'package:src/l10n/app_localizations.dart';

class LatestBookScheduleComponent extends StatelessWidget {
  const LatestBookScheduleComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              AppLocalizations.of(context)!.latestBook,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
          SizedBox(height: 24),
          _buildTableLatestBook()
        ],
      ),
    );
  }

  Widget _buildTableLatestBook() {
    return Container(
        child: Table(
      border: TableBorder.all(
          color: Colors.grey,
          width: 1.0,
          borderRadius: const BorderRadius.all(Radius.circular(4))),
      children: [
        TableRow(children: [
          TableCell(
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8.0),
                  color: Colors.grey.shade300,
                  child: Text('Name', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)))),
          TableCell(
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8.0),
                  color: Colors.grey.shade300,
                  child: Text('Page', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)))),
          TableCell(
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8.0),
                  color: Colors.grey.shade300,
                  child: Text('Description', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold))))
        ]),
        TableRow(children: [
          TableCell(
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8.0),
                  child: Text('sample.pdf', style: TextStyle(fontSize: 12.0, color: Colors.blue)))),
          TableCell(
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8.0),
                  child: Text('0', style: TextStyle(fontSize: 12.0)))),
          TableCell(
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8.0),
                  child: Text('', style: TextStyle(fontSize: 12.0))))
        ]),
      ],
    ));
  }
}
