import 'dart:convert';

import 'package:flutter/services.dart';

import '../model/tutor/favorite_tutor.dart';
import '../model/tutor/tutor.dart';

class TutorRepository {

  Future<List<Tutor>> getTutors() async {
    String data = await rootBundle.loadString('lib/assets/tutor-mock-data.json');
    List<dynamic> jsonData = json.decode(data);

    List<Tutor> tutors = jsonData.map((json) => Tutor.fromJson(json)).toList();

    return tutors;
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
