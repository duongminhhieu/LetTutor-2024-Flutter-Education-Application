import 'package:flutter/material.dart';
import 'package:src/data/responses/list-tutor_response.dart';

import '../data/model/schedule/booking_info.dart';
import '../data/model/tutor/tutor.dart';
import '../data/repository/tutor_repository.dart';
import 'auth_provider.dart';

class TutorProvider extends ChangeNotifier {
  final TutorRepository _repository = TutorRepository();
  List<Tutor> tutors = [];
  List<String> favTutorSecondId = [];
  List<BookingInfo> lessonList = [];

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> callAPIGetTutorList(int page, AuthProvider authProvider) async {
    try {
      await _repository.getListTutor(
          accessToken: authProvider.token?.access?.token ?? "",
          page: page,
          perPage: 10,
          onSuccess: (response) async {
            _handleTutorListDataFromAPI(response);
            _errorMessage = null;
            notifyListeners();
          },
          onFail: (error) {
            _errorMessage = error.toString(); // Set the error message
            notifyListeners();
          });
    } catch (e) {
      _errorMessage = e.toString(); // Set the error message
      notifyListeners();
    }
  }

  void _handleTutorListDataFromAPI(ListTutorResponse response) {
    response.favoriteTutor?.forEach((element) {
      if (element.secondId != null) {
        favTutorSecondId.add(element.secondId!);
      }
    });

    //Separate list
    List<Tutor> notFavoredList = [];
    List<Tutor> favoredList = [];
    response.tutors?.rows?.forEach((element) {
      if (checkIfTutorIsFavored(element)) {
        favoredList.add(element);
      } else {
        notFavoredList.add(element);
      }
    });

    //Sort by score
    favoredList.sort((b, a) => (a.rating ?? 0).compareTo((b.rating ?? 0)));
    notFavoredList.sort((b, a) => (a.rating ?? 0).compareTo((b.rating ?? 0)));

    //Add to final list
    tutors.addAll(favoredList);
    tutors.addAll(notFavoredList);
  }

  bool checkIfTutorIsFavored(Tutor tutor) {
    for (var element in favTutorSecondId) {
      if (element == tutor.userId) return true;
    }
    return false;
  }

  Future<void> callApiManageFavoriteTutor(
      Tutor tutorClicked,
      AuthProvider authProvider,
      int index,
      Function(String, bool) onSuccess,
      Function(String) onFail) async {
    await _repository.manageFavoriteTutor(
        accessToken: authProvider.token?.access?.token ?? "",
        tutorId: tutorClicked.userId!,
        onSuccess: onSuccess,
        onFail: onFail);
  }

  Future<void> searchTutor(
      {String? filterStr, String? tutorName, String? tutorNation}) async {
    try {
      tutors = await _repository.searchTutor(
          filterStr: filterStr, tutorName: tutorName, tutorNation: tutorNation);
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
