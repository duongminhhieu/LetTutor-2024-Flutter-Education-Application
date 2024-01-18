import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:src/data/api/apiTutor.dart';
import 'package:src/data/api/apiUser.dart';
import 'package:src/data/responses/list-tutor_response.dart';

import '../model/tutor/tutor.dart';
import '../responses/result_response.dart';
import '../services/apiService.dart';
import 'base_repository.dart';

class TutorRepository extends BaseRepository{

  TutorRepository() : super();

  Future<List<Tutor>> getTutors() async {
    String data = await rootBundle.loadString('lib/assets/tutor-mock-data.json');
    List<dynamic> jsonData = json.decode(data);

    List<Tutor> tutors = jsonData.map((json) => Tutor.fromJson(json)).toList();

    return tutors;
  }

  Future<void> writeReviewAfterClass({
    required Function() onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.post(
      url: APITutor.FEEDBACK_TUTOR,
    );

    await onSuccess();
  }

  Future<void> getTutorById({
    required String accessToken,
    required String tutorId,
    required Function(Tutor) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
        url: APITutor.getTutorById(tutorId),
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(Tutor.fromJson(response.response));
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }


  Future<void> manageFavoriteTutor({
    required String accessToken,
    required String tutorId,
    required Function(String, bool) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.post(
        url: APIUser.MANAGE_FAVORITE_TUTOR,
        data: {"tutorId": tutorId},
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(
            response.response['message'], response.response['result'] == 1);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }


  Future<void> getListTutor({
    required String accessToken,
    required int perPage,
    required int page,
    required Function(ListTutorResponse) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
        url: APITutor.getListTutorPagination(perPage, page),
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(ListTutorResponse.fromJson(response.response));
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }


  Future<Result> searchTutors({
    required String accessToken,
    required String searchKeys,
    required int page,
    required perPage,
    required List<String> speciality,
    required Map<String, dynamic> nationality,
  }) async {
    try {
      speciality.forEach((element) {
        element = element.toLowerCase();
      });

      final response = await service.post(
          url: APITutor.SEARCH_TUTOR,
          data: {
            "filters": {
              "specialties": speciality,
              "nationality": nationality,
              "date": null,
              "tutoringTimeAvailable": [null, null]
            },
            "search": searchKeys,
            "page": "$page",
            "perPage": "$perPage"
          }, headers: {
        "Authorization": "Bearer $accessToken"
      }) as BoundResource;

      switch (response.statusCode) {
        case 200:
        case 201:
          return Result(data: TutorPagination.fromJson(response.response));
        default:
          return Result(error: response.errorMsg.toString());
      }
    } catch (error) {
      debugPrint(error.toString());
      return Result(error: error.toString());
    }
  }


}
