import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:src/l10n/app_localizations.dart';

import '../../../data/model/schedule/booking_info.dart';

class HistoryCard extends StatefulWidget {
  const HistoryCard({Key? key, required this.bookingInfo}) : super(key: key);
  final BookingInfo bookingInfo;

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
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
              const SizedBox(height: 24),
              _buildCardRequest(),
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
            child: Text(
              formatTimeAgo(widget
                  .bookingInfo!.scheduleDetailInfo!.startPeriodTimestamp!),
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

  String formatTimeAgo(int startPeriodTimestamp) {
    DateTime startTime = DateTime.fromMillisecondsSinceEpoch(startPeriodTimestamp);
    DateTime now = DateTime.now();
    Duration difference = now.difference(startTime);

    if (difference.inDays > 365) {
      int years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays >= 7) {
      int weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
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
                      "${widget.bookingInfo.scheduleDetailInfo?.scheduleInfo?.tutorInfo?.country}",
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
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text(
                      '${AppLocalizations.of(context)!.lessonTime}: ' +
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardRequest() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(4),
            child: Column(
              children: [
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
                          AppLocalizations.of(context)!.requestForLesson,
                          style: TextStyle(fontSize: 14),
                        )),
                      ],
                    ),
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                            top: 14, left: 14, right: 14, bottom: 24),
                        child: Text(
                            widget.bookingInfo.studentRequest ??
                                AppLocalizations.of(context)!
                                    .studentRequestEmpty,
                            style: TextStyle(
                                color: Colors.grey, fontSize: 14, height: 1.5)),
                      )
                    ],
                  ),
                ),
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
                          AppLocalizations.of(context)!.requestForTutorial,
                          style: TextStyle(fontSize: 14),
                        )),
                      ],
                    ),
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                            top: 14, left: 14, right: 14, bottom: 24),
                        child: Text(
                           AppLocalizations.of(context)!
                                    .studentRequestEmpty,
                            style: TextStyle(
                                color: Colors.grey, fontSize: 14, height: 1.5)),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 12, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                _dialogBuilder(context);
                              },
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  alignment: Alignment.centerLeft),
                              child: Text(
                                AppLocalizations.of(context)!.addRating,
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 16),
                              ))),
                      Expanded(
                          child: TextButton(
                              onPressed: null,
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  alignment: Alignment.centerRight),
                              child:  Text(
                                AppLocalizations.of(context)!.report,
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 16),
                              )))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 60,
                  height: 60,
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
                  child: Text(
                    AppLocalizations.of(context)!.lessonTime,
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
                                .startPeriodTimestamp!)) +
                        '\n' +
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
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 16),
                Divider(height: 1, thickness: 1, color: Colors.grey.shade100),
                SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.whatIsYourRating +
                      "${widget.bookingInfo.scheduleDetailInfo?.scheduleInfo?.tutorInfo?.name}" +
                      "?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  alignment: Alignment.center,
                  child: RatingBar.builder(
                    initialRating: 5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star_rate_rounded,
                      size: 28,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  maxLines: 3, // Số dòng tối đa
                  minLines: 3, // Số dòng tối thiểu
                  initialValue: AppLocalizations.of(context)!.contentReview,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24), // Khoảng cách 24 pixel
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(AppLocalizations.of(context)!.later),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                        backgroundColor: Colors.blue, // Đặt màu nền thành blue
                        primary: Colors.white, // Đặt màu chữ thành trắng
                      ),
                      onPressed: () {
                        // Xử lý khi nút "Submit" được nhấn
                        Navigator.of(context).pop();
                      },
                      child:  Text(AppLocalizations.of(context)!.submit),
                    ),
                  ],
                ),
              ],
            ),
          ),
          insetPadding: EdgeInsets.zero,
          actions: <Widget>[],
        );
      },
    );
  }
}
