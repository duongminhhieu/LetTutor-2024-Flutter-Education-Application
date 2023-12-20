
import '../../utilities/const.dart';

class APISchedule{
  static const String BASE_URL = ConstValue.BASE_URL;

  static const String SCHEDULE = '${BASE_URL}schedule';

  static String getBookedClass(int page, int perPage, String dateTimeLte, String orderBy, String sortBy){
    return '${BASE_URL}booking/list/student?dateTimeLte=$dateTimeLte&page=$page&perPage=$perPage&orderBy=$orderBy&sortBy=$sortBy';
  }
  static const String BOOK_CLASS = '${BASE_URL}booking';

  static String updateStudentRequest(String bookedId){
    return '${BASE_URL}booking/student-request/$bookedId';
  }


}