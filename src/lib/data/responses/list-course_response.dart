import 'package:json_annotation/json_annotation.dart';
import 'package:src/data/model/courses/course.dart';


@JsonSerializable()
class ResponseGetListCourse {
  String? message;
  CoursePagination? data;

  ResponseGetListCourse({
    this.message,
    this.data,
  });

  factory ResponseGetListCourse.fromJson(Map<String, dynamic> json) =>
      _$ResponseGetListCourseFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseGetListCourseToJson(this);
}


@JsonSerializable()
class CoursePagination {
  int? count;
  List<Course>? rows;

  CoursePagination({
    this.count,
    this.rows,
  });

  factory CoursePagination.fromJson(Map<String, dynamic> json) =>
      _$CoursePaginationFromJson(json);
  Map<String, dynamic> toJson() => _$CoursePaginationToJson(this);
}


ResponseGetListCourse _$ResponseGetListCourseFromJson(
    Map<String, dynamic> json) =>
    ResponseGetListCourse(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : CoursePagination.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseGetListCourseToJson(
    ResponseGetListCourse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

CoursePagination _$CoursePaginationFromJson(Map<String, dynamic> json) =>
    CoursePagination(
      count: json['count'] as int?,
      rows: (json['rows'] as List<dynamic>?)
          ?.map((e) => Course.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CoursePaginationToJson(CoursePagination instance) =>
    <String, dynamic>{
      'count': instance.count,
      'rows': instance.rows,
    };
