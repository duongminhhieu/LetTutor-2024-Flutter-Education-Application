import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/model/schedule/booking_info.dart';

class ScheduleCard extends StatefulWidget {
  const ScheduleCard({Key? key, required this.bookingInfo}) : super(key: key);
  final BookingInfo bookingInfo;

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
                      DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(
                          widget.bookingInfo!.scheduleDetailInfo!
                              .startPeriodTimestamp!)) +
                          ' - ' +
                          DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(
                              widget.bookingInfo!.scheduleDetailInfo!
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
                      onPressed: () {},
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
              title: const Row(
                children: [
                  Expanded(
                      child: Text(
                    "Request for lesson",
                    style: TextStyle(fontSize: 12),
                  )),
                  Expanded(
                    child: TextButton(
                        onPressed: null,
                        child: Text(
                          "Edit Request",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
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
          onPressed: () {},
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
}
