import 'package:flutter/material.dart';
import 'package:src/data/model/schedule/booking_info.dart';
import 'package:src/data/model/schedule/schedule.dart';
import 'package:src/data/repository/schedule_repository.dart';
import 'package:src/data/responses/result_response.dart';
import 'package:src/providers/auth_provider.dart';

import '../data/responses/list-booking_response.dart';

class ScheduleProvider extends ChangeNotifier {
  final ScheduleRepository _repository = ScheduleRepository();

  List<BookingInfo> historyList = [];

  //Pagination
  int totalPageHistory = 100;
  int perPage = 5;
  int currentPage = 1;

  Future<void> getScheduleById(
      String tutorId,
      int startTime,
      int endTime,
      AuthProvider authProvider,
      Function(List<Schedule>) onSuccess,
      Function(String) onFail) async {
    try {
      Result result = await _repository.getScheduleById(
          accessToken: authProvider.token?.access?.token ?? "",
          tutorId: tutorId,
          startTime: startTime,
          endTime: endTime);

      if (result.data != null) {
        onSuccess(result.data as List<Schedule>);
      }
      if (result.error != null) {
        onFail(result.error.toString());
      }

      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
      onFail(error.toString());
    }
  }

  Future<void> bookSchedule(
      List<String> scheduleDetailIds,
      String notes,
      AuthProvider authProvider,
      Function(String) onSuccess,
      Function(String) onFail) async {
    try {
      Result result = await _repository.bookLesson(
          accessToken: authProvider.token?.access?.token ?? "",
          scheduleDetailIds: scheduleDetailIds,
          notes: notes);

      if (result.data != null) {
        onSuccess(result.data as String);
      }
      if (result.error != null) {
        onFail(result.error.toString());
      }
    } catch (error) {
      debugPrint(error.toString());
      onFail(error.toString());
    }
  }

  Future<void> callApiGetHistorySchedules(int page, AuthProvider authProvider, Function(String) onFail) async {
    try {
      Result result = await _repository.getHistorySchedule(
          accessToken: authProvider.token?.access?.token ?? "",
          page: page,
          perPage: perPage,
          inFuture: 0);

      if (result.data != null) {
        BookingPagination response = result.data as BookingPagination;

        // set list history data
        historyList = response?.rows ?? [];

        // set total page
        totalPageHistory = (response?.count ?? 0) ~/ perPage;

      }
      if (result.error != null) {
        onFail(result.error.toString());
      }
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
      onFail(error.toString());
    }
  }
}
