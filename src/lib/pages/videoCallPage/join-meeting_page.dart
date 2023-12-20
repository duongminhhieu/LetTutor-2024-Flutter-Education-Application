import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../data/model/schedule/booking_info.dart';
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
  bool canJoinMeeting = false;

  @override
  void initState() {
    super.initState();
    // endTime = DateTime.now().add(const Duration(seconds: 10));
    endTime = DateTime.fromMillisecondsSinceEpoch(
        upcomingClass.scheduleDetailInfo!.startPeriodTimestamp!);
  }

  void onEnd() {
    setState(() {
      canJoinMeeting = true;
    });
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
          title: Text('Join Meeting'),
        ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImagesPath.video),
              CountdownTimer(
                onEnd: onEnd,
                endTime: endTime.millisecondsSinceEpoch,
                textStyle: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                endWidget: ElevatedButton(
                  onPressed: () {
                    _joinMeeting();
                  },
                  child: Text('Join Meeting'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _joinMeeting();
                },
                child: Text('Join Meeting'),
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
    // Navigator.pushNamed(context, MyRouter.chatGpt);
  }
}
