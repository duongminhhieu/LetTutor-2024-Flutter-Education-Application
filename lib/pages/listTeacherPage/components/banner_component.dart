import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:src/pages/videoCallPage/join-meeting_page.dart';
import 'package:src/providers/booking_provider.dart';

import '../../../l10n/app_localizations.dart';

class BannerComponent extends StatefulWidget {
  final Color myColor;

  const BannerComponent({
    super.key,
    required this.myColor,
  });

  @override
  State<BannerComponent> createState() => _BannerComponentState();
}

class _BannerComponentState extends State<BannerComponent> {
  @override
  Widget build(BuildContext context) {
    BookingProvider bookingProvider = context.watch<BookingProvider>();

    return Container(
      color: const Color.fromRGBO(7, 96, 191, 1.0),
      padding: const EdgeInsets.only(top: 32, bottom: 32),
      child: Column(
        children: [
          Container(
            child: Text(
              AppLocalizations.of(context)!.upComingLesson,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 16),
          (bookingProvider.upcomingLesson != null)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    Expanded(
                      child: buildTimer(context),
                    ),
                    SizedBox(width: 10), // Adjusted this SizedBox
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            joinUpcomingMeeting(context);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            elevation: MaterialStateProperty.all(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.ondemand_video,
                                color: widget.myColor,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                AppLocalizations.of(context)!.enterLessonRoom,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: widget.myColor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        child: Text(
                          AppLocalizations.of(context)!.noUpcomingLesson,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
          SizedBox(height: 16),
          Container(
            child: Text(
              (bookingProvider.totalLessonTime.isEmpty)
                  ? "${AppLocalizations.of(context)!.totalLessonTime} 0"
                  : '${AppLocalizations.of(context)!.totalLessonTime} ${bookingProvider.totalLessonTime}',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  // Widget build Timer
  Widget buildTimer(BuildContext context) {
    BookingProvider bookingProvider = context.watch<BookingProvider>();

    return Column(
      children: [
        Text(
          DateFormat('E, d MMM y').format(DateTime.fromMillisecondsSinceEpoch(
              bookingProvider.upcomingLesson!.scheduleDetailInfo!
                  .startPeriodTimestamp!)) +
              '\n' +
              DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(
                  bookingProvider.upcomingLesson!.scheduleDetailInfo!
                      .startPeriodTimestamp!)) +
              ' - ' +
              DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(
                  bookingProvider.upcomingLesson!.scheduleDetailInfo!
                      .endPeriodTimestamp!)),
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            Text(
              '(starts in: ',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: Colors.yellow,
              ),
            ),
            CountdownTimer(
              endTime: DateTime.fromMillisecondsSinceEpoch(bookingProvider
                  .upcomingLesson!
                  .scheduleDetailInfo!
                  .startPeriodTimestamp!)
                  .millisecondsSinceEpoch,
              textStyle: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: Colors.yellow,
              ),
              endWidget: Text(
                AppLocalizations.of(context)!.started,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.yellow,
                ),
              ),
            ),
            Text(
              ')',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: Colors.yellow,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void joinUpcomingMeeting(BuildContext context) {
    BookingProvider bookingProvider = context.read<BookingProvider>();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              JoinMeetingPage(upcomingClass: bookingProvider.upcomingLesson!),
        ));
  }
}
