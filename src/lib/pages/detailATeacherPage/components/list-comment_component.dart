import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:src/data/model/tutor/tutor.dart';
import 'package:src/data/model/tutor/tutor_feedback.dart';
import 'package:src/l10n/app_localizations.dart';

class ListCommentComponent extends StatefulWidget {
  const ListCommentComponent({Key? key, required this.tutor}) : super(key: key);
  final Tutor tutor;

  @override
  State<ListCommentComponent> createState() => _ListCommentComponentState();
}

class _ListCommentComponentState extends State<ListCommentComponent> {
  late List<FeedbackTutor> feedbacks;
  late int _currentPage = 0;
  late int _totalPage = 1;
  late final int _pageSize = 5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    feedbacks = widget.tutor.feedbacks!
        .getRange(_currentPage * _pageSize, (_currentPage + 1) * _pageSize)
        .toList();
    _totalPage = widget.tutor.feedbacks!.length ~/ _pageSize;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
              child:  Text(AppLocalizations.of(context)!.reviews,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black))),
          SizedBox(height: 20),
          _buildInfoCommentItems(),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: NumberPaginator(
                // by default, the paginator shows numbers as center content
                numberPages: _totalPage,
                onPageChange: (int index) {
                  setState(() {
                    _currentPage = index;
                    feedbacks = widget.tutor.feedbacks!
                        .getRange(_currentPage * _pageSize,
                            (_currentPage + 1) * _pageSize)
                        .toList();
                  });
                },
              ))
        ],
      ),
    );
  }

  Widget _buildInfoCommentItems() {
    return Column(
      children: feedbacks?.map((feedback) {
            return _buildInfoCommentItem(feedback);
          }).toList() ??
          [],
    );
  }

  Widget _buildInfoCommentItem(FeedbackTutor feedback) {
    DateTime currentDate = DateTime.now();

    // Parse the updatedAt string to a DateTime object
    DateTime updateDate = DateTime.parse(feedback.updatedAt ?? '');

    int daysAgo = currentDate.difference(updateDate).inDays;
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                width: double.maxFinite,
                fit: BoxFit.fitHeight,
                imageUrl: feedback.firstInfo!.avatar ??
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
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    feedback.firstInfo!.name ?? 'Anonymous',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '$daysAgo days ago',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  for (int i = 0; i < 5; i++)
                    Icon(
                      i < (feedback.rating ?? 0)
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.yellow,
                      size: 16,
                    ),
                ],
              ),
              SizedBox(height: 6),
              Container(
                child: Text(feedback.content ?? ''),
              )
            ],
          ),
        ],
      ),
    );
  }
}
