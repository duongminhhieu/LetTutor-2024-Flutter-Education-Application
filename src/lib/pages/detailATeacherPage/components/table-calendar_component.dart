import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter/material.dart';

import '../../../data/model/schedule/schedule.dart';
import '../../../data/model/schedule/schedule_detail.dart';

class TableCalendar extends StatefulWidget {
  const TableCalendar({Key? key}) : super(key: key);

  @override
  State<TableCalendar> createState() => _TableCalendar();
}

class _TableCalendar extends State<TableCalendar> {
  final now = DateTime.now();
  late BookingService mockBookingService;

  @override
  void initState() {
    super.initState();
    // DateTime.now().startOfDay
    // DateTime.now().endOfDay
    mockBookingService = BookingService(
        serviceName: 'Mock Service',
        serviceDuration: 30,
        bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
        bookingStart: DateTime(now.year, now.month, now.day, 8, 0));
  }

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    List<Schedule> schedules = [
      Schedule(
        id: "f6aa6d7b-f64b-4a7c-80e4-6f692d88ba77",
        tutorId: "4d54d3d7-d2a9-42e5-97a2-5ed38af5789a",
        startTime: "07:00",
        endTime: "07:25",
        startTimestamp: 1675407600000,
        endTimestamp: 1675409100000,
        createdAt: ("2023-01-09T18:47:13.628Z"),
        isBooked: false,
        scheduleDetails: [
          ScheduleDetail(
            startPeriodTimestamp: 1675407600000,
            endPeriodTimestamp: 1675409100000,
            id: "6eb71db0-a80f-426a-ba8e-0889c0cb03e4",
            scheduleId: "f6aa6d7b-f64b-4a7c-80e4-6f692d88ba77",
            startPeriod: "07:00",
            endPeriod: "07:25",
            createdAt: ("2023-01-09T18:47:13.633Z"),
            updatedAt: ("2023-01-09T18:47:13.633Z"),
            bookingInfo: [],
            isBooked: false,
          ),
        ],
      ),
      // Add more schedules as needed
    ];
    return Stream.value(schedules);
  }

  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));
    print('${newBooking.toJson()} has been uploaded');
  }

  List<DateTimeRange> converted = [];

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    ///take care this is only mock, so if you add today as disabledDays it will still be visible on the first load
    ///disabledDays will properly work with real data
    DateTime first = now;
    DateTime tomorrow = now.add(const Duration(days: 1));
    DateTime second = now.add(const Duration(minutes: 55));
    DateTime third = now.subtract(const Duration(minutes: 240));
    DateTime fourth = now.subtract(const Duration(minutes: 500));
    converted.add(
        DateTimeRange(start: first, end: now.add(const Duration(minutes: 30))));
    converted.add(DateTimeRange(
        start: second, end: second.add(const Duration(minutes: 23))));
    converted.add(DateTimeRange(
        start: third, end: third.add(const Duration(minutes: 15))));
    converted.add(DateTimeRange(
        start: fourth, end: fourth.add(const Duration(minutes: 50))));

    //book whole day example
    converted.add(DateTimeRange(
        start: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 5, 0),
        end: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 23, 0)));
    return converted;
  }

  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
          start: DateTime(now.year, now.month, now.day, 12, 0),
          end: DateTime(now.year, now.month, now.day, 13, 0))
    ];
  }

  void showBookingDialog(DateTime startTime, DateTime endTime) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Booking Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Start Time: $startTime'),
              Text('End Time: $endTime'),
              // Add more details as needed
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 600,
        child: BookingCalendar(
          bookingService: mockBookingService,
          availableSlotColor: Colors.lightBlue,
          bookingButtonColor: Colors.blue,
          convertStreamResultToDateTimeRanges: convertStreamResultMock,
          getBookingStream: getBookingStreamMock,
          uploadBooking: uploadBookingMock,
          pauseSlots: generatePauseSlots(),
          pauseSlotText: 'LUNCH',
          hideBreakTime: false,
          loadingWidget: const Text('Fetching data...'),
          uploadingWidget: const CircularProgressIndicator(),
          startingDayOfWeek: StartingDayOfWeek.monday,
          wholeDayIsBookedWidget:
              const Text('Sorry, for this day everything is booked'),
          //disabledDates: [DateTime(2023, 1, 20)],
          //disabledDays: [6, 7],
        ),
      ),
    ]);
  }
}
