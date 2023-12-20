import 'package:json_annotation/json_annotation.dart';
import 'package:src/data/model/tutor/tutor.dart';

import '../model/tutor/favorite_tutor.dart';

@JsonSerializable()
class ListTutorResponse {
  TutorPagination? tutors;
  List<FavoriteTutor>? favoriteTutor;

  ListTutorResponse({this.tutors, this.favoriteTutor});

  factory ListTutorResponse.fromJson(Map<String, dynamic> json) =>
      _$ListTutorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ListTutorResponseToJson(this);
}

ListTutorResponse _$ListTutorResponseFromJson(Map<String, dynamic> json) =>
    ListTutorResponse(
      tutors: json['tutors'] == null
          ? null
          : TutorPagination.fromJson(json['tutors'] as Map<String, dynamic>),
      favoriteTutor: json['favoriteTutor'] == null ? null : (json['favoriteTutor'] as List<dynamic>?)
          ?.map((e) => FavoriteTutor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListTutorResponseToJson(ListTutorResponse instance) =>
    <String, dynamic>{
      'tutors': instance.tutors,
      'favoriteTutor': instance.favoriteTutor,
    };

@JsonSerializable()
class TutorPagination {
  int? count;
  List<Tutor>? rows;

  TutorPagination({
    this.count,
    this.rows,
  });

  factory TutorPagination.fromJson(Map<String, dynamic> json) =>
      _$TutorPaginationFromJson(json);
  Map<String, dynamic> toJson() => _$TutorPaginationToJson(this);
}

TutorPagination _$TutorPaginationFromJson(Map<String, dynamic> json) =>
    TutorPagination(
      count: json['count'] as int?,
      rows: (json['rows'] as List<dynamic>?)
          ?.map((e) => Tutor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TutorPaginationToJson(TutorPagination instance) =>
    <String, dynamic>{
      'count': instance.count,
      'rows': instance.rows,
    };
