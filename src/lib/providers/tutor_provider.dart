import 'package:flutter/material.dart';

import '../data/model/tutor/tutor.dart';
import '../data/repository/tutor_repository.dart';

class TutorProvider extends ChangeNotifier {
  final TutorRepository _repository = TutorRepository();
  List<Tutor> _tutors = [];

  List<Tutor> get tutors => _tutors;

  Future<void> getTutors() async {
    try {
      _tutors = await _repository.getTutors();
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
