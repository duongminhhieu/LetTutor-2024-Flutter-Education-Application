
import 'package:src/data/model/courses/course.dart';
import 'package:src/data/responses/list-course_response.dart';

import '../api/apiCourses.dart';
import '../responses/result_response.dart';
import '../services/apiService.dart';
import 'base_repository.dart';

class CourseRepository extends BaseRepository {

  CourseRepository() : super();


  Future<Result> getCourseListWithPagination({
    required String accessToken,
    required int size,
    required int page,
    required String? orderBy,
    required String? order,
    required int? level,
    required String? search,
    required String? categoryStr,
  }) async {

    try {
      final response = await service.get(
          url: APICourse.getCourse(page, size, orderBy, order, level, categoryStr, search),
          headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

      switch (response.statusCode) {
        case 200:
        case 201:
        var result = ResponseGetListCourse.fromJson(response.response);
        return Result(data: result);
        default:
          return Result(error: response.errorMsg.toString());
      }
    } catch (e) {
      return Result(error: e.toString());
    }

  }

  Future<Result> getEbookListWithPagination({
    required String accessToken,
    required int size,
    required int page,
    required String orderBy,
    required String order,
    required int level,
    required String search,
    required String categoryStr,
  }) async {

    try {
      final response = await service.get(
          url: APICourse.getEbook(page, size, orderBy, order, level, categoryStr, search),
          headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

      switch (response.statusCode) {
        case 200:
        case 201:
          var result = ResponseGetListCourse.fromJson(response.response);
          return Result(data: result);
        default:
          return Result(error: response.errorMsg.toString());
      }
    } catch (e) {
      return Result(error: e.toString());
    }

  }

  Future<Result> getInteractiveEbookListWithPagination({
    required String accessToken,
    required int size,
    required int page,
    required String orderBy,
    required String order,
    required int level,
    required String search,
    required String categoryStr,
  }) async {

    try {
      final response = await service.get(
          url: APICourse.getInteractiveEbook(page, size, orderBy, order, level, categoryStr, search),
          headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

      switch (response.statusCode) {
        case 200:
        case 201:
          var result = ResponseGetListCourse.fromJson(response.response);
          return Result(data: result);
        default:
          return Result(error: response.errorMsg.toString());
      }
    } catch (e) {
      return Result(error: e.toString());
    }

  }

}
