import 'package:flutter/material.dart';
import 'package:src/data/model/tutor/tutor_info.dart';
import 'package:src/data/responses/list-tutor_response.dart';
import '../data/model/tutor/tutor.dart';
import '../data/repository/tutor_repository.dart';
import 'auth_provider.dart';

class TutorProvider extends ChangeNotifier {
  final TutorRepository _repository = TutorRepository();
  List<Tutor> tutors = [];
  List<String> favTutorSecondId = [];
  TutorInfo? tutorInfo;
  int totalPage = 100;
  int perPage = 10;
  int currentPage = 1;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> callAPIGetTutorList(int page, AuthProvider authProvider) async {
    tutors = [];
    favTutorSecondId = [];
    try {
      await _repository.getListTutor(
          accessToken: authProvider.token?.access?.token ?? "",
          page: page,
          perPage: perPage,
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

    // set total page
    totalPage = (response.tutors?.count ?? 0) ~/ perPage;
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
      Function(String, bool) onSuccess,
      Function(String) onFail) async {
    await _repository.manageFavoriteTutor(
        accessToken: authProvider.token?.access?.token ?? "",
        tutorId: tutorClicked.userId!,
        onSuccess: onSuccess,
        onFail: onFail);
    notifyListeners();
  }

  Future<void> callAPISearchTutor(int page, String searchKey,
      List<String> specialities, AuthProvider authProvider) async {
    await _repository.searchTutors(
      accessToken: authProvider.token?.access?.token ?? "",
      searchKeys: searchKey,
      speciality: specialities,
      nationality: {},
      page: page,
      onSuccess: (response, total) async {
        tutors = [];
        tutors.addAll(response);
        currentPage = page;
        totalPage = (total / perPage).ceil();
        _errorMessage = null;
        notifyListeners();
      },
      onFail: (error) {
        _errorMessage = error.toString(); // Set the error message
        notifyListeners();
      },
    );
  }

  Future<void> callAPIGetTutorById(
      AuthProvider authProvider, String? userId) async {
    await _repository.getTutorById(
        accessToken: authProvider.token?.access?.token ?? "",
        tutorId: userId ?? "",
        onSuccess: (response) async {
          notifyListeners();
        },
        onFail: (error) {});
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
