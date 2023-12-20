import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:src/data/api/apiTutor.dart';
import 'package:src/data/api/apiUser.dart';
import 'package:src/data/responses/list-tutor_response.dart';

import '../model/tutor/favorite_tutor.dart';
import '../model/tutor/tutor.dart';
import '../services/apiService.dart';
import 'base_repository.dart';

class TutorRepository extends BaseRepository{

  Future<List<Tutor>> getTutors() async {
    String data = await rootBundle.loadString('lib/assets/tutor-mock-data.json');
    List<dynamic> jsonData = json.decode(data);

    List<Tutor> tutors = jsonData.map((json) => Tutor.fromJson(json)).toList();

    return tutors;
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

  Future<List<FavoriteTutor>> getFavoriteTutors() async {
    String data = await rootBundle.loadString('lib/assets/favorite_tutor-mock-data.json');
    List<dynamic> jsonData = json.decode(data);

    List<FavoriteTutor> tutors = jsonData.map((json) => FavoriteTutor.fromJson(json)).toList();

    return tutors;
  }

  Future<List<Tutor>> searchTutor({String? filterStr, String? tutorName, String? tutorNation}) async {
    List<Tutor> tutors = await getTutors();

    // Lọc theo chuỗi filter
    if (filterStr != null && filterStr.isNotEmpty) {
      if(filterStr.toLowerCase() != 'all'){
        tutors = tutors.where((tutor) =>
            tutor.specialties!.contains(filterStr.toLowerCase())).toList();
      }
    }

    // Lọc theo tên giáo viên
    if (tutorName != null && tutorName.isNotEmpty) {
      tutors = tutors.where((tutor) =>
          tutor.name!.toLowerCase().contains(tutorName.toLowerCase())).toList();
    }

    // Lọc theo quốc gia của giáo viên
    if (tutorNation != null && tutorNation.isNotEmpty) {
      tutors = tutors.where((tutor) =>
          tutor.country!.toLowerCase().contains(tutorNation.toLowerCase())).toList();
    }

    return tutors;
  }


}
