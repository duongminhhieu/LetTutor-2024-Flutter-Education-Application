import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:src/providers/schedule_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../data/model/schedule/schedule.dart';
import '../../../data/model/tutor/tutor.dart';
import 'booking_dialog.dart';

class TableCalendar extends StatefulWidget {
  const TableCalendar({Key? key, required this.tutor}) : super(key: key);
  final Tutor tutor;

  @override
  State<TableCalendar> createState() => _TableCalendar();
}

class _TableCalendar extends State<TableCalendar> {
  List<Schedule> listScheduleOfTutor = [];
  bool isDataFetched = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: Consumer<ScheduleProvider>(
        builder: (BuildContext context, ScheduleProvider scheduleProvider,
            Widget? child) {
          if (!isDataFetched) {
            //scheduleProvider.getScheduleById(widget.tutor.id!);

            // Mark that data has been fetched
            isDataFetched = true;
          }
          listScheduleOfTutor = scheduleProvider.schedules; // get data
          return SfCalendar(
            view: CalendarView.week,
            allowedViews: const <CalendarView>[
              CalendarView.day,
              CalendarView.workWeek,
              CalendarView.week,
              CalendarView.month,
              CalendarView.timelineDay,
              CalendarView.timelineWeek,
              CalendarView.timelineWorkWeek,
              CalendarView.timelineMonth,
              CalendarView.schedule
            ],
            firstDayOfWeek: 1,
            showNavigationArrow: true,
            showCurrentTimeIndicator: false,
            timeSlotViewSettings: const TimeSlotViewSettings(
              timeInterval: Duration(minutes: 30), timeFormat: 'h:mm a',
              timeIntervalHeight: 50,
              dateFormat: 'd', dayFormat: 'EEE',
              startHour: 0, // Set the start hour (24-hour format)
              endHour: 24, numberOfDaysInView: 5,
              // Set the end hour (24-hour format)
            ),
            specialRegions: _getTimeRegions(),
            timeRegionBuilder:
                (BuildContext context, TimeRegionDetails details) {
              if (details.region.text == 'Book') {
                return Container(
                  alignment: Alignment.center,
                  child: TextButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            Size(18, 18)), // Thay đổi width và height tùy ý
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 8, vertical: 3)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Book',
                        style: TextStyle(color: Colors.white),
                      )),
                );
              } else {
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Booked',
                    style: TextStyle(color: Colors.green),
                  ),
                );
              }
            },
            onTap: (CalendarTapDetails details) async {
              if (details.targetElement == CalendarElement.calendarCell) {
                // Check if the tap is within a time region
                DateTime tappedTime = details.date!;
                List<TimeRegion> timeRegions = _getTimeRegions();
                for (int i = 0; i < timeRegions.length; i++) {
                  if (tappedTime.isAtSameMomentAs(timeRegions[i].startTime) &&
                      tappedTime.isBefore(timeRegions[i].endTime) &&
                      !listScheduleOfTutor[i].isBooked!) {
                    DateTime timestart = DateTime.fromMillisecondsSinceEpoch(
                        listScheduleOfTutor[i].startTimestamp!);
                    DateTime timeend = DateTime.fromMillisecondsSinceEpoch(
                        listScheduleOfTutor[i].endTimestamp!);

                    String start =
                        "${timestart.hour.toString().length == 1 ? "0" + timestart.hour.toString() : timestart.hour.toString()}:${timestart.minute.toString().length == 1 ? "0" + timestart.minute.toString() : timestart.minute.toString()}";
                    String end =
                        "${timeend.hour.toString().length == 1 ? "0" + timeend.hour.toString() : timeend.hour.toString()}:${timeend.minute.toString().length == 1 ? "0" + timeend.minute.toString() : timeend.minute.toString()}";
                    String date = DateFormat.yMMMMEEEEd().format(
                        DateTime.fromMillisecondsSinceEpoch(
                            listScheduleOfTutor[i].startTimestamp!));
                    List<dynamic> result = await showDialog(
                      context: context,
                      builder: (context) => BookingConfirmDialog(
                          start: start, end: end, date: date),
                    );

                    if (result[0] == true) {
                      setState(() {
                        List<String> list = [];
                        list.add(listScheduleOfTutor[i].id!);
                        scheduleProvider.bookSchedule(list, result[1]);
                        listScheduleOfTutor[i].isBooked = true;
                      });
                    }

                    // Tap is within a time region, perform your action
                  }
                }
              }
            },
          );
        },
      ),
    );
  }

  List<TimeRegion> _getTimeRegions() {
    final List<TimeRegion> regions = <TimeRegion>[];

    for (int i = 0; i < listScheduleOfTutor.length; i++) {
      int? timestamp = listScheduleOfTutor[i].startTimestamp;
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp!);
      DateTime date = DateTime(dateTime.year, dateTime.month, dateTime.day,
          dateTime.hour, dateTime.minute, dateTime.second);
      regions.add(TimeRegion(
        startTime: date,
        endTime: date.add(Duration(minutes: 30)),
        enablePointerInteraction: true,
        color: Colors.grey.withOpacity(0.2),
        text: listScheduleOfTutor[i].isBooked! ? "Booked" : 'Book',
      ));
    }

    return regions;
  }
}
