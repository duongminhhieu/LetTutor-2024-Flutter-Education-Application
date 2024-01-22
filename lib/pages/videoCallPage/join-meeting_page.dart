import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:intl/intl.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../data/model/schedule/booking_info.dart';
import '../../l10n/app_localizations.dart';
import '../../utilities/const.dart';

class JoinMeetingPage extends StatefulWidget {
  const JoinMeetingPage({super.key, required this.upcomingClass});
  final BookingInfo upcomingClass;

  @override
  State<JoinMeetingPage> createState() => _JoinMeetingPageState();
}

class _JoinMeetingPageState extends State<JoinMeetingPage> {
  //Join meeting
  late BookingInfo upcomingClass = widget.upcomingClass;
  late DateTime endTime;

  @override
  void initState() {
    super.initState();
    // endTime = DateTime.now().add(const Duration(seconds: 10));
    endTime = DateTime.fromMillisecondsSinceEpoch(
        upcomingClass.scheduleDetailInfo!.startPeriodTimestamp!);
  }


  void _joinMeeting() async {
    final String meetingToken =
        upcomingClass.studentMeetingLink?.split('token=')[1] ?? '';
    Map<String, dynamic> jwtDecoded = JwtDecoder.decode(meetingToken);
    final String room = jwtDecoded['room'];

    var options = JitsiMeetingOptions(
      roomNameOrUrl: room,
      serverUrl: "https://meet.lettutor.com",
      token: meetingToken,
      isAudioMuted: true,
      isAudioOnly: true,
      isVideoMuted: true,
    );

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeetWrapper.joinMeeting(
      options: options,
      listener: JitsiMeetingListener(
        onOpened: () => debugPrint("onOpened"),
        onConferenceWillJoin: (url) {
          debugPrint("onConferenceWillJoin: url: $url");
        },
        onConferenceJoined: (url) {
          debugPrint("onConferenceJoined: url: $url");
        },
        onConferenceTerminated: (url, error) {
          debugPrint("onConferenceTerminated: url: $url, error: $error");
        },
        onClosed: () => debugPrint("onClosed"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.joinMeeting),
        ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImagesPath.video),
              Text(AppLocalizations.of(context)!.upComingLesson, style: TextStyle(color: Colors.blue, fontSize: 36, fontWeight: FontWeight.w500,)),
              SizedBox(height: 16),
              Column(
                children: [
                  Text(
                    DateFormat('E, d MMM y').format(
                            DateTime.fromMillisecondsSinceEpoch(widget
                                .upcomingClass!
                                .scheduleDetailInfo!
                                .startPeriodTimestamp!)) +
                        ' ' +
                        DateFormat('HH:mm').format(
                            DateTime.fromMillisecondsSinceEpoch(widget
                                .upcomingClass!
                                .scheduleDetailInfo!
                                .startPeriodTimestamp!)) +
                        ' - ' +
                        DateFormat('HH:mm').format(
                            DateTime.fromMillisecondsSinceEpoch(widget
                                .upcomingClass!
                                .scheduleDetailInfo!
                                .endPeriodTimestamp!)),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: 16),
              CountdownTimer(
                endTime: endTime.millisecondsSinceEpoch,
                textStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                endWidget: Text(AppLocalizations.of(context)!.meetingIsReady , style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _joinMeeting();
                },
                child: Text(AppLocalizations.of(context)!.joinMeeting),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            onPressedChatBubble(context, size);
          },
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.message,
            color: Colors.white,
          ),
        ));
  }

  void onPressedChatBubble(BuildContext context, Size size) {
    Navigator.pushNamed(context, "/chatPage");
  }
}
