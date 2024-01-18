import 'package:json_annotation/json_annotation.dart';

import 'course_category.dart';
import 'course_topic.dart';


@JsonSerializable()
class Course {
  String? id;
  String? name;
  String? description;
  String? imageUrl;
  String? level;
  String? reason;
  String? purpose;
  String? otherDetails;
  int? defaultPrice;
  int? coursePrice;
  bool? visible;
  String? createdAt;
  String? updatedAt;
  List<CourseTopic>? topics;
  List<CourseCategory>? categories;

  Course({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.level,
    this.reason,
    this.purpose,
    this.otherDetails,
    this.defaultPrice,
    this.coursePrice,
    this.visible,
    this.createdAt,
    this.updatedAt,
    this.topics,
    this.categories,
  });

  factory Course.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);
  Map<String, dynamic> toJson() => _$CourseModelToJson(this);
}


Course _$CourseModelFromJson(Map<String, dynamic> json) => Course(
  id: json['id'] as String?,
  name: json['name'] as String?,
  description: json['description'] as String?,
  imageUrl: json['imageUrl'] as String?,
  level: json['level'] as String?,
  reason: json['reason'] as String?,
  purpose: json['purpose'] as String?,
  otherDetails: json['otherDetails'] as String?,
  defaultPrice: json['defaultPrice'] as int?,
  coursePrice: json['coursePrice'] as int?,
  visible: json['visible'] as bool?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  topics: (json['topics'] as List<dynamic>?)
      ?.map((e) => CourseTopic.fromJson(e as Map<String, dynamic>))
      .toList(),
  categories: (json['categories'] as List<dynamic>?)
      ?.map((e) => CourseCategory.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CourseModelToJson(Course instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'level': instance.level,
      'reason': instance.reason,
      'purpose': instance.purpose,
      'otherDetails': instance.otherDetails,
      'defaultPrice': instance.defaultPrice,
      'coursePrice': instance.coursePrice,
      'visible': instance.visible,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'topics': instance.topics,
      'categories': instance.categories,
    };
