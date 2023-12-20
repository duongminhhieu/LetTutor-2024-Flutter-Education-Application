import 'package:flutter/material.dart';
import 'package:src/data/repository/booking_repository.dart';

import '../data/model/schedule/booking_info.dart';
import 'auth_provider.dart';

class BookingProvider extends ChangeNotifier {
  final BookingRepository _repository = BookingRepository();
  List<BookingInfo> lessonList = [];
  String totalLessonTime = "";
  BookingInfo? upcomingLesson;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> callApiGetListBooked(AuthProvider authProvider) async {
    lessonList = [];
    await _repository.getIncomingLessons(
        accessToken: authProvider.token?.access?.token ?? "",
        page: 1,
        perPage: 100000,
        now: DateTime.now().millisecondsSinceEpoch.toString(),
        onSuccess: (response, total) async {
          _filterListScheduleFromApi(response);
          _errorMessage = null;
          notifyListeners();
        },
        onFail: (error) {
          _errorMessage = error.toString(); // Set the error message
          notifyListeners();
        });
  }

  void _filterListScheduleFromApi(List<BookingInfo> listBooking) {
    for (var value in listBooking) {
      if (value.isDeleted != true) {
        lessonList.insert(0, value);
      }
    }

    //Calculate total learning time
    DateTime totalTime = DateTime.now();
    DateTime nowTime = totalTime;
    for (var element in lessonList) {
      var startTime = DateTime.fromMillisecondsSinceEpoch(
          element.scheduleDetailInfo!.startPeriodTimestamp!);
      var endTime = DateTime.fromMillisecondsSinceEpoch(
          element.scheduleDetailInfo!.endPeriodTimestamp!);
      var learningDuration = endTime.difference(startTime);
      totalTime = totalTime.add(learningDuration);
    }
    Duration learningDuration = totalTime.difference(nowTime);

    if (lessonList.isNotEmpty) {
      upcomingLesson = lessonList.first;
      totalLessonTime = _printDuration(learningDuration);
    }
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
