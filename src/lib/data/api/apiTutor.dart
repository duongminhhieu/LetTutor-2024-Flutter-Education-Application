import '../../utilities/const.dart';

class APITutor{
  static const String BASE_URL = ConstValue.BASE_URL;

  static String getListTutorPagination(int perPage, int page){
    return '${BASE_URL}tutor/more?perPage=$perPage&page=$page';
  }

  static const String FEEDBACK_TUTOR = '${BASE_URL}user/feedbackTutor';
  //Get tutor information by Id
  static String getTutorById(String tutorId){
    return '${BASE_URL}tutor/$tutorId';
  }

  //Search tutor
  static String searchTutor(String keyword, int perPage, int page){
    return '${BASE_URL}tutor/search?keyword=$keyword&perPage=$perPage&page=$page';
  }

  // Add a tutor to favourite list
  static const String ADD_FAVOURITE_TUTOR = '${BASE_URL}user/manageFavoriteTutor';
}