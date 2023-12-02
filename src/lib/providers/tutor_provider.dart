import 'package:flutter/material.dart';

import '../data/model/tutor/tutor.dart';
import '../data/repository/tutor_repository.dart';

class TutorProvider extends ChangeNotifier {
  final TutorRepository _repository = TutorRepository();
  List<Tutor> _tutors = [];

  TutorProvider()  {
    getTutors();
  }

  List<Tutor> get tutors => _tutors;

  Future<void> getTutors() async {
    try {
      _tutors = await _repository.getTutors();
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> searchTutor({String? filterStr, String? tutorName, String? tutorNation}) async {
    try {
      _tutors = await _repository.searchTutor(filterStr: filterStr, tutorName: tutorName,tutorNation: tutorNation);
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
