
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:src/data/model/schedule/schedule.dart';

class TutorRepository {

  Future<List<Schedule>> getScheduleById() async {
    String data = await rootBundle.loadString('lib/assets/schedule_tutor-mock-data.json');
    List<dynamic> jsonData = json.decode(data);

    List<Schedule> schedules = jsonData.map((json) => Schedule.fromJson(json)).toList();

    return schedules;
  }

}
