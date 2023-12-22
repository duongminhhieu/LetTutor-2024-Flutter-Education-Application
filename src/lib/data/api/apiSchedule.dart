
import '../../utilities/const.dart';

class APISchedule{
  static const String BASE_URL = ConstValue.BASE_URL;

  static const String SCHEDULE = '${BASE_URL}schedule';

  static String getBookedClass(int page, int perPage, String dateTimeLte, String orderBy, String sortBy){
    return '${BASE_URL}booking/list/student?dateTimeLte=$dateTimeLte&page=$page&perPage=$perPage&orderBy=$orderBy&sortBy=$sortBy';
  }

  static String getIncomingBookedClass(int page, int perPage, String dateTimeLte, String orderBy, String sortBy){
    return '${BASE_URL}booking/list/student?dateTimeGte=$dateTimeLte&page=$page&perPage=$perPage&orderBy=$orderBy&sortBy=$sortBy';
  }

  static String getUpcomingBookedClass(int now){
    return '${BASE_URL}booking/next?dateTime=$now';
  }

  static const String BOOK_CLASS = '${BASE_URL}booking';

  static String updateStudentRequest(String bookedId){
    return '${BASE_URL}booking/student-request/$bookedId';
  }

  static String getSchedulesByTutorId(String tutorId, int startTime, int endTime){
    return '${BASE_URL}schedule?tutorId=$tutorId&startTimestamp=$startTime&endTimestamp=$endTime';
  }

  static String getHistorySchedule(int page , int perPage, int inFuture, String orderBy, String sortBy){
    return '${BASE_URL}booking/list/student?inFuture=$inFuture&page=$page&perPage=$perPage&orderBy=$orderBy&sortBy=$sortBy';
  }

}