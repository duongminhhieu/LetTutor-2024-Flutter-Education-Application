import 'package:flutter/material.dart';
import 'package:src/data/model/schedule/schedule.dart';
import 'package:src/data/repository/schedule_repository.dart';
import 'package:src/data/responses/result_response.dart';
import 'package:src/providers/auth_provider.dart';

class ScheduleProvider extends ChangeNotifier {
  final ScheduleRepository _repository = ScheduleRepository();
  List<Schedule> _schedules = [];

  List<Schedule> get schedules => _schedules;

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
}
