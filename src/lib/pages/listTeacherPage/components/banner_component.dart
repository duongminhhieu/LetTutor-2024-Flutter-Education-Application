import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/providers/booking_provider.dart';

class BannerComponent extends StatelessWidget {
  final Color myColor;

  const BannerComponent({
    super.key,
    required this.myColor,
  });

  @override
  Widget build(BuildContext context) {
    BookingProvider bookingProvider = context.watch<BookingProvider>();

    return Container(
      color: const Color.fromRGBO(7, 96, 191, 1.0),
      padding: const EdgeInsets.only(top: 32, bottom: 32),
      child: Column(
        children: [
          Container(
            child: const Text(
              'Upcoming lesson',
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
                      child: Container(
                        child: Text(
                          DateTime.fromMillisecondsSinceEpoch(bookingProvider
                                  .upcomingLesson!
                                  .scheduleDetailInfo!
                                  .startPeriodTimestamp!)
                              .toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // Adjusted this SizedBox
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/videoCallPage");
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
                                color: myColor,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Enter lesson room",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: myColor,
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
                          'No upcoming lesson',
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
                  ? 'Total lesson time is 0'
                  : 'Total lesson time is ${bookingProvider.totalLessonTime}',
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
}
