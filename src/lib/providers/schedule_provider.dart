import 'package:flutter/material.dart';
import 'package:src/data/model/schedule/schedule.dart';
import 'package:src/data/repository/schedule_repository.dart';

class ScheduleProvider extends ChangeNotifier {
  final ScheduleRepository _repository = ScheduleRepository();
  List<Schedule> _schedules = [];

  List<Schedule> get schedules => _schedules;

  Future<void> getScheduleById(String tutorId) async {
    try {
      _schedules = await _repository.getScheduleById(tutorId);
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
