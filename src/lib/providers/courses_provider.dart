import 'package:flutter/material.dart';
import 'package:src/data/model/courses/course.dart';
import 'package:src/data/repository/course_repository.dart';

import '../data/responses/list-course_response.dart';
import '../data/responses/result_response.dart';
import 'auth_provider.dart';


class CoursesProvider extends ChangeNotifier {
  final CourseRepository _repository = CourseRepository();

  List<Course> courseList = [];

  //Pagination
  int totalPage = 100;
  int perPage = 5;
  int currentPage = 1;

  Future<void> callApiGetCourses(int page, String? orderBy, String? order, String? search, int? level, String? categoryStr, AuthProvider authProvider, Function(String) onFail) async {
    try {
      Result result = await _repository.getCourseListWithPagination(accessToken: authProvider.token?.access?.token ?? "", size: perPage, page: page, orderBy: orderBy, order: order, level: level, search: search, categoryStr: categoryStr);

      if (result.data != null) {

        ResponseGetListCourse responseGetListCourse = result.data as ResponseGetListCourse;
        CoursePagination coursePagination = responseGetListCourse.data as CoursePagination;
        // set list history data
        courseList = coursePagination.rows ?? [];

        // set total page
        totalPage = (coursePagination.count ?? 0) ~/ perPage + 1;

      }
      if (result.error != null) {
        onFail(result.error.toString());
      }
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
      onFail(error.toString());
    }
  }

  Future<void> callApiGetEbook(int page, String orderBy, String order, String search, int level, String categoryStr, AuthProvider authProvider, Function(String) onFail) async {
    try {
      Result result = await _repository.getEbookListWithPagination(accessToken: authProvider.token?.access?.token ?? "", size: perPage, page: page, orderBy: orderBy, order: order, level: level, search: search, categoryStr: categoryStr);

      if (result.data != null) {

        // set list history data
        courseList = result.data?.rows ?? [];

        // set total page
        totalPage = (result.data?.count ?? 0) ~/ perPage + 1;

      }
      if (result.error != null) {
        onFail(result.error.toString());
      }
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
      onFail(error.toString());
    }
  }

  Future<void> callApiGetInteractiveBook(int page, String orderBy, String order, String search, int level, String categoryStr, AuthProvider authProvider, Function(String) onFail) async {
    try {
      Result result = await _repository.getInteractiveEbookListWithPagination(accessToken: authProvider.token?.access?.token ?? "", size: perPage, page: page, orderBy: orderBy, order: order, level: level, search: search, categoryStr: categoryStr);

      if (result.data != null) {

        // set list history data
        courseList = result.data?.rows ?? [];

        // set total page
        totalPage = (result.data?.count ?? 0) ~/ perPage + 1;

      }
      if (result.error != null) {
        onFail(result.error.toString());
      }
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
      onFail(error.toString());
    }
  }

}
