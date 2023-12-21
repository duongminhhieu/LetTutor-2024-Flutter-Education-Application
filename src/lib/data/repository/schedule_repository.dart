
import 'package:flutter/cupertino.dart';
import 'package:src/data/api/apiSchedule.dart';
import 'package:src/data/model/schedule/schedule.dart';

import '../responses/list-schedule_response.dart';
import '../responses/result_response.dart';
import '../services/apiService.dart';
import 'base_repository.dart';

class ScheduleRepository extends BaseRepository {

  ScheduleRepository() : super();

  Future<List<Schedule>> bookSchedule(List<Schedule> schedules,
      List<String> scheduleDetailIds, String notes) async {
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

  Future<Result<List<Schedule>>> getScheduleById({
    required String accessToken,
    required String tutorId,
    required int startTime,
    required int endTime,
  }) async {
    try {
      final response = await service.get(
        url: APISchedule.getSchedulesByTutorId(tutorId, startTime, endTime),
        headers: {"Authorization": "Bearer $accessToken"},
      ) as BoundResource;

      switch (response.statusCode) {
        case 200:
        case 201:
          return Result(
              data: ResponseGetListSchedule.fromJson(response.response)
                      .scheduleOfTutor ??
                  []);
        default:
          return Result(error: response.errorMsg.toString());
      }
    } catch (e) {
      return Result(error: e.toString());
    }
  }
}
