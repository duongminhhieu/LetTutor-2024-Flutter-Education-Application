import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:src/providers/schedule_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../data/model/schedule/schedule.dart';
import '../../../data/model/tutor/tutor.dart';
import '../../../providers/auth_provider.dart';
import 'booking_dialog.dart';

class TableCalendar extends StatefulWidget {
  const TableCalendar({Key? key, required this.tutor}) : super(key: key);
  final Tutor tutor;

  @override
  State<TableCalendar> createState() => _TableCalendar();
}

class _TableCalendar extends State<TableCalendar> {
  List<Schedule> listScheduleByDate = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    final scheduleProvider =
        Provider.of<ScheduleProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    int startTime = DateTime.now().millisecondsSinceEpoch;
    int endTime = startTime + Duration(days: 4).inMilliseconds;

    await scheduleProvider.getScheduleById(
        widget.tutor.userId!, startTime, endTime, authProvider, (schedules) {
      setState(() {
        listScheduleByDate = schedules;
      });
    }, (message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error when get schedule: $message'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Container(
      height: 600,
      child: Consumer<ScheduleProvider>(
        builder: (BuildContext context, ScheduleProvider scheduleProvider,
            Widget? child) {
          return SfCalendar(
            view: CalendarView.week,
            firstDayOfWeek: DateTime.now().weekday,
            minDate: DateTime.now(),
            showNavigationArrow: true,
            showCurrentTimeIndicator: false,
            timeSlotViewSettings: const TimeSlotViewSettings(
              timeInterval: Duration(minutes: 30),
              timeFormat: 'HH:mm',
              timeIntervalHeight: 50,
              dateFormat: 'd',
              dayFormat: 'EEE',
              startHour: 0, // Set the start hour (24-hour format)
              endHour: 24,
              numberOfDaysInView: 5,
            ),
            onViewChanged: (ViewChangedDetails details) async {
              int startTime = details.visibleDates[0].millisecondsSinceEpoch;
              int endTime = details
                  .visibleDates[details.visibleDates.length - 1]
                  .millisecondsSinceEpoch;

              await scheduleProvider.getScheduleById(
                  widget.tutor.userId!, startTime, endTime, authProvider,
                  (schedules) {
                setState(() {
                  listScheduleByDate = schedules;
                });
              }, (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error when get schedule: $message'),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.red,
                  ),
                );
              });
            },
            specialRegions: _getTimeRegions(authProvider.currentUser?.id!),
            timeRegionBuilder:
                (BuildContext context, TimeRegionDetails details) {
              if (details.region.text == 'Book') {
                return Container(
                  alignment: Alignment.center,
                  child: TextButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(20, 20)),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 8, vertical: 3)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Book',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )),
                );
              } else if (details.region.text == 'Booked') {
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Booked',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                );
              } else {
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Reserved',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                );
              }
            },
            onTap: (CalendarTapDetails details) async {
              if (details.targetElement == CalendarElement.calendarCell) {
                // Check if the tap is within a time region
                DateTime tappedTime = details.date!;
                List<TimeRegion> timeRegions =
                    _getTimeRegions(authProvider.currentUser?.id!);
                for (int i = 0; i < timeRegions.length; i++) {
                  if (tappedTime.isAtSameMomentAs(timeRegions[i].startTime) &&
                      tappedTime.isBefore(timeRegions[i].endTime) &&
                      !listScheduleByDate[i].isBooked!) {
                    DateTime timeStart = DateTime.fromMillisecondsSinceEpoch(
                        listScheduleByDate[i].startTimestamp!);
                    DateTime timeEnd = DateTime.fromMillisecondsSinceEpoch(
                        listScheduleByDate[i].endTimestamp!);

                    String start =
                        "${timeStart.hour.toString().length == 1 ? "0" + timeStart.hour.toString() : timeStart.hour.toString()}:${timeStart.minute.toString().length == 1 ? "0" + timeStart.minute.toString() : timeStart.minute.toString()}";
                    String end =
                        "${timeEnd.hour.toString().length == 1 ? "0" + timeEnd.hour.toString() : timeEnd.hour.toString()}:${timeEnd.minute.toString().length == 1 ? "0" + timeEnd.minute.toString() : timeEnd.minute.toString()}";
                    String date = DateFormat.yMMMMEEEEd().format(
                        DateTime.fromMillisecondsSinceEpoch(
                            listScheduleByDate[i].startTimestamp!));
                    List<dynamic> result = await showDialog(
                      context: context,
                      builder: (context) => BookingConfirmDialog(
                          start: start, end: end, date: date),
                    );

                    if (result[0] == true) {
                      setState(() {
                        List<String> list = [];
                        list.add(listScheduleByDate[i].id!);
                        scheduleProvider.bookSchedule(list, result[1]);
                        listScheduleByDate[i].isBooked = true;
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

  List<TimeRegion> _getTimeRegions(String? idUser) {
    final List<TimeRegion> regions = <TimeRegion>[];

    for (int i = 0; i < listScheduleByDate.length; i++) {
      int? timestamp = listScheduleByDate[i].startTimestamp;
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp!);
      DateTime date = DateTime(dateTime.year, dateTime.month, dateTime.day,
          dateTime.hour, dateTime.minute, dateTime.second);
      regions.add(TimeRegion(
        startTime: date,
        endTime: date.add(Duration(minutes: 30)),
        enablePointerInteraction: true,
        color: Colors.grey.withOpacity(0.2),
        text: !listScheduleByDate[i].isBooked!
            ? "Book"
            : (listScheduleByDate[i]
                        .scheduleDetails?[0]
                        ?.bookingInfo?[0]
                        ?.userId ==
                    idUser)
                ? "Booked"
                : "Reserved",
      ));
    }

    return regions;
  }
}
