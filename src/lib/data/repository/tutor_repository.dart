import 'dart:convert';

import 'package:flutter/services.dart';

import '../model/tutor/tutor.dart';

class TutorRepository {

  Future<List<Tutor>> getTutors() async {
    String data = await rootBundle.loadString('lib/assets/tutor-mock-data.json');
    List<dynamic> jsonData = json.decode(data);

    List<Tutor> tutors = jsonData.map((json) => Tutor.fromJson(json)).toList();

    return tutors;
  }

}
