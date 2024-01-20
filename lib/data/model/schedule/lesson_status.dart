import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class LessonStatus {
  final int? id;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LessonStatus({
    this.id,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory LessonStatus.fromJson(Map<String, dynamic> json) =>
      _$LessonStatusFromJson(json);
  Map<String, dynamic> toJson() => _$LessonStatusToJson(this);
}

LessonStatus _$LessonStatusFromJson(Map<String, dynamic> json) => LessonStatus(
  id: json['id'] as int?,
  status: json['status'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$LessonStatusToJson(LessonStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
