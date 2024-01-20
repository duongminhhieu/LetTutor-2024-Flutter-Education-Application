import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:src/l10n/app_localizations.dart';

class DateSelectionWidget extends StatefulWidget {
  @override
  _DateSelectionWidgetState createState() => _DateSelectionWidgetState();
}

class _DateSelectionWidgetState extends State<DateSelectionWidget> {
  TextEditingController dateController = TextEditingController();
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 36,
          child: TextField(
            controller: dateController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.selectDate,
              labelStyle: TextStyle(
                fontSize: 14,
              ),
              isDense: true, // Added this
              contentPadding: EdgeInsets.symmetric(horizontal: 10), // Điều chỉnh khoảng cách nội dung
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              suffixIcon: IconButton(
                onPressed: () => _selectDate(context),
                icon: Icon(Icons.calendar_today),
              ),
            ),
            readOnly: true, // To prevent manual text input
          ),
        ),
      ],
    );
  }
}
