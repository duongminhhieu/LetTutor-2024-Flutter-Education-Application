import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';
import 'package:src/pages/schedulePage/components/scheduleCard.dart';

import '../../../data/model/schedule/booking_info.dart';
import '../../../providers/booking_provider.dart';

class ListCardScheduleComponent extends StatefulWidget {
  const ListCardScheduleComponent({Key? key, required this.refresh}) : super(key: key);

  final Function refresh;


  @override
  State<ListCardScheduleComponent> createState() =>
      _ListCardScheduleComponentState();
}

class _ListCardScheduleComponentState extends State<ListCardScheduleComponent> {
  bool _loading = false;

  late List<BookingInfo> lessonList;
  late int _currentPage = 0;
  late int _totalPage = 1;
  late final int _pageSize = 5;

  @override
  void initState() {
    final bookingProvider = context.read<BookingProvider>();

    lessonList = bookingProvider.lessonList!
        .getRange(_currentPage * _pageSize, bookingProvider.lessonList.length > _pageSize ? (_currentPage + 1) * _pageSize : bookingProvider.lessonList.length)
        .toList();
    _totalPage = bookingProvider.lessonList.length ~/ _pageSize == 0 ? 1 : bookingProvider.lessonList.length ~/ _pageSize;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.watch<BookingProvider>();

    return !_loading
        ? Column(
            children: [
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: lessonList.length,
                  itemBuilder: (context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: ScheduleCard(
                        bookingInfo: lessonList[index],
                        refresh: widget.refresh,
                      ),
                    );
                  },
                ),
              ),
              NumberPaginator(
                // by default, the paginator shows numbers as center content
                numberPages: _totalPage,
                onPageChange: (int index) {
                  setState(() {
                    _currentPage = index;
                    lessonList = bookingProvider.lessonList!
                        .getRange(_currentPage * _pageSize,
                            (_currentPage + 1) * _pageSize)
                        .toList();
                  });
                },
              ),
              SizedBox(height: 32)
            ],
          )
        : SizedBox(
            child: const Center(child: CircularProgressIndicator()),
          );
  }
}
