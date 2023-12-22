import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:src/providers/booking_provider.dart';
import '../../../commons/confirmDialog.dart';
import '../../../data/model/schedule/booking_info.dart';
import '../../../providers/auth_provider.dart';
import '../../videoCallPage/join-meeting_page.dart';

class ScheduleCard extends StatefulWidget {
  const ScheduleCard(
      {Key? key, required this.bookingInfo, required this.refresh})
      : super(key: key);
  final BookingInfo bookingInfo;
  final Function refresh;

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade100, width: 1.0),
          borderRadius: BorderRadius.circular(4.0),
        ),
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTitle(),
              const SizedBox(height: 24),
              _buildCardInfo(),
              const SizedBox(height: 24),
              _buildCardTime(),
              const SizedBox(height: 16),
              _buildButton()
            ],
          ),
        ));
  }

  Widget _buildTitle() {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              DateFormat('E, d MMM y').format(
                  DateTime.fromMillisecondsSinceEpoch(widget
                      .bookingInfo!.scheduleDetailInfo!.startPeriodTimestamp!)),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              '1 lesson',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardInfo() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                width: double.maxFinite,
                fit: BoxFit.fitHeight,
                imageUrl: widget.bookingInfo.scheduleDetailInfo?.scheduleInfo
                        ?.tutorInfo?.avatar ??
                    "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1700296337596.jpg",
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress)),
                errorWidget: (context, url, error) => Image.network(
                    "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1700296337596.jpg"),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${widget.bookingInfo.scheduleDetailInfo?.scheduleInfo?.tutorInfo?.name}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                child: Row(
                  children: [
                    Text(
                      '${widget.bookingInfo.scheduleDetailInfo?.scheduleInfo?.tutorInfo?.country}',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Container(
                child: Row(
                  children: [
                    const Icon(
                      Icons.message_outlined,
                      size: 16,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 8),
                    Container(
                        child: Text(
                      "Direct Message",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                      ),
                    )),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardTime() {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text(
                      DateFormat('HH:mm').format(
                              DateTime.fromMillisecondsSinceEpoch(widget
                                  .bookingInfo!
                                  .scheduleDetailInfo!
                                  .startPeriodTimestamp!)) +
                          ' - ' +
                          DateFormat('HH:mm').format(
                              DateTime.fromMillisecondsSinceEpoch(widget
                                  .bookingInfo!
                                  .scheduleDetailInfo!
                                  .endPeriodTimestamp!)),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        onPressedCancel(
                            size,
                            widget.bookingInfo!.scheduleDetailInfo!
                                .startPeriodTimestamp!,
                            widget.bookingInfo.id);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1,
                              style: BorderStyle.solid,
                              color: Colors.red),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.normal, color: Colors.red),
                      )),
                )
              ],
            ),
          ),
          SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.0),
              side: BorderSide(color: Colors.grey.shade100, width: 1.0),
            ),
            child: ExpansionTile(
              title:  Row(
                children: [
                  Expanded(
                      child: Text(
                    "Request for lesson",
                    style: TextStyle(fontSize: 14),
                  )),
                  Expanded(
                    child: TextButton(
                        onPressed: (){
                          onPressedLeaveNote(size);
                        },
                        child: Text(
                          "Edit Request",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                        )),
                  )
                ],
              ),
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      EdgeInsets.only(top: 14, left: 14, right: 14, bottom: 24),
                  child: Text(
                      widget.bookingInfo.studentRequest ??
                          "Currently there are no requests for this class. Please write down any requests for the teacher.",
                      style: TextStyle(
                          color: Colors.grey, fontSize: 14, height: 1.5)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Join the upcoming meeting...'),
              duration: Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.blue,
            ));
            onPressedGoToMeeting();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                  width: 1, style: BorderStyle.solid, color: Colors.blue),
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          child: const Text(
            'Go to meeting',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.white,
                fontSize: 16),
          )),
    );
  }

  void onPressedCancel(Size size, int startTimestamp, String? idBooking) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);

    if (isAllowedToCancel(
        DateTime.fromMicrosecondsSinceEpoch(startTimestamp))) {
      //Variables
      TextEditingController textEditingController = TextEditingController();
      final List<DropdownMenuItem<String>> cancelReasonList = [
        const DropdownMenuItem(
            value: 'Reschedule at another time',
            child: Text('Reschedule at another time')),
        const DropdownMenuItem(
            value: 'Busy at that time', child: Text('Busy at that time')),
        const DropdownMenuItem(
            value: 'Asked by the tutor', child: Text('Asked by the tutor')),
        const DropdownMenuItem(value: 'Other', child: Text('Other')),
      ];
      String? selectedValue = cancelReasonList.first.value;

      //Dialogs
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ConfirmDialog(
              content: null,
              title: "Cancel Lesson",
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        width: double.maxFinite,
                        fit: BoxFit.fitHeight,
                        imageUrl: widget.bookingInfo.scheduleDetailInfo
                                ?.scheduleInfo?.tutorInfo?.avatar ??
                            "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1700296337596.jpg",
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress)),
                        errorWidget: (context, url, error) => Image.network(
                            "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1700296337596.jpg"),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "${widget.bookingInfo.scheduleDetailInfo?.scheduleInfo?.tutorInfo?.name}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Lesson Time",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      DateFormat('E, d MMM y').format(
                          DateTime.fromMillisecondsSinceEpoch(widget
                              .bookingInfo!
                              .scheduleDetailInfo!
                              .startPeriodTimestamp!)),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Divider(height: 1, thickness: 1, color: Colors.grey.shade100),
                  SizedBox(height: 16),
                  Text(
                    "What was the reason you cancel this booking?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      child: DropdownButtonFormField(
                        items: cancelReasonList,
                        value: selectedValue,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      )),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextField(
                      maxLines: 5,
                      controller: textEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText:
                            "What was the reason you cancel this booking?",
                      ),
                    ),
                  ),
                ],
              ),
              size: size,
              onRightButton: () {
                bookingProvider.callApiCancelLesson(
                    authProvider,
                    idBooking!,
                    textEditingController.text,
                    cancelReasonList.indexWhere(
                            (element) => element.value == selectedValue) +
                        1,
                    (message) async => {
                          // success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                              duration: Duration(seconds: 2),
                            ),
                          ),
                          // refresh page
                          widget.refresh(),
                          Navigator.of(context).pop(),
                        },
                    (error) => {
                          // error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(error),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              duration: Duration(seconds: 2),
                            ),
                          ),
                          Navigator.of(context).pop(),
                        });
              },
              onLeftButton: () {
                Navigator.of(context).pop();
              },
              leftButton: "Later",
              rightButton: "Submit",
              hasLeftButton: true,
            );
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Classes can only be canceled within 2 hours before starting.')),
      );
    }
  }

  bool isAllowedToCancel(DateTime lessonStart) {
    var timeToLesson = DateTime.now().difference(lessonStart);
    return timeToLesson.compareTo(const Duration(hours: 2)) > 0;
  }

  void onPressedGoToMeeting() {
    BookingProvider bookingProvider = context.read<BookingProvider>();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              JoinMeetingPage(upcomingClass: bookingProvider.upcomingLesson!),
        ));
  }


  void onPressedLeaveNote( Size size) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmDialog(
            content: null,
            title: 'Special Request',
            widget: Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: TextField(
                maxLines: 5,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Wish Topic (Optional)',
                ),
              ),
            ),
            size: size,
            onRightButton: () {
              Navigator.of(context).pop();
            },
            onLeftButton: () {
              Navigator.of(context).pop();
            },
            leftButton: 'Cancel',
            rightButton: 'Submit',
            hasLeftButton: true,
          );
        });
  }

}
