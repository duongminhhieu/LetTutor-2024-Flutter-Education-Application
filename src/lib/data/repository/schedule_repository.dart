
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:src/data/model/schedule/schedule.dart';

class ScheduleRepository {

  Future<List<Schedule>> getScheduleById(String tutorId) async {
    String data = await rootBundle.loadString('lib/assets/schedule_tutor-mock-data.json');
    List<dynamic> jsonData = json.decode(data);

    List<Schedule> schedules = jsonData.map((json) => Schedule.fromJson(json)).toList();
    return schedules;
  }

  Future<List<Schedule>> bookSchedule(List<Schedule> schedules, List<String> scheduleDetailIds, String notes) async {

    try {
      for (var element in scheduleDetailIds) {
        for (var schedule in schedules) {
          if (element == schedule.id) {
            schedule.isBooked = true;
            schedule.scheduleDetails!.forEach((e) {
              e.isBooked = true;
            });
          }
        }
      }

    } catch (error) {
      debugPrint(error.toString());
    }
    return schedules;

  }
}
