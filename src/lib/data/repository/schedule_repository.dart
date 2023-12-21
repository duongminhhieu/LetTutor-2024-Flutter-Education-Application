
import 'package:flutter/cupertino.dart';
import 'package:src/data/api/apiSchedule.dart';
import 'package:src/data/model/schedule/schedule.dart';

import '../responses/list-schedule_response.dart';
import '../responses/result_response.dart';
import '../services/apiService.dart';
import 'base_repository.dart';

class ScheduleRepository extends BaseRepository {

  ScheduleRepository() : super();

  Future<Result<String>> bookLesson({
    required String accessToken,
    required String notes,
    required List<String> scheduleDetailIds,
  }) async {

    try {
      final response = await service.post(
          url: APISchedule.BOOK_CLASS,
          data: {"note": notes, "scheduleDetailIds": scheduleDetailIds},
          headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

      switch (response.statusCode) {
        case 200:
        case 201:
          return Result(data: response.response['message']);
        default:
          return Result(error: response.errorMsg.toString());
      }
    }catch(error) {
      debugPrint(error.toString());
      return Result(error: error.toString());
    }
  }

  Future<Result<String>> cancelALesson({
    required String accessToken,
    required String scheduleDetailIds,
    required int cancelReasonId,
    required String? notes
  }) async {
    try {
      final response = await service.delete(url: APISchedule.BOOK_CLASS, data: {
        "scheduleDetailIds": [scheduleDetailIds],
        "cancelInfo": {"cancelReasonId": cancelReasonId, "note": notes}
      }, headers: {
        "Authorization": "Bearer $accessToken"
      }) as BoundResource;

      switch (response.statusCode) {
        case 200:
        case 201:
          return Result(data: response.response['message']);
        default:
          return Result(error: response.errorMsg.toString());
      }
    } catch (e) {
      return Result(error: e.toString());
    }
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
