import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeRangeSelector extends StatefulWidget {
  @override
  _TimeRangeSelectorState createState() => _TimeRangeSelectorState();
}

class _TimeRangeSelectorState extends State<TimeRangeSelector> {
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime ? _startTime : _endTime,
    );
    if (selectedTime != null) {
      setState(() {
        if (isStartTime) {
          _startTime = selectedTime;
        } else {
          _endTime = selectedTime;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  readOnly: true,
                  onTap: () => _selectTime(context, true),
                  decoration: InputDecoration(
                    hintText: "Start time",
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    suffixIcon: Icon(Icons.arrow_forward),
                  ),
                  controller: TextEditingController(text: _startTime.format(context)),
                ),
              ),
              Container(
                width: 12, // Khoảng cách giữa hai trường
              ),
              Expanded(
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.center,
                  readOnly: true,
                  onTap: () => _selectTime(context, false),
                  decoration: InputDecoration(
                    hintText: 'End Time',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    suffixIcon: Icon(Icons.access_time),
                  ),
                  controller: TextEditingController(text: _endTime.format(context)),
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}