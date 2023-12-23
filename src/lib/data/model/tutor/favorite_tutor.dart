import 'package:src/data/model/tutor/tutor_extracted_info.dart';

class FavoriteTutor {
  String? id;
  String? firstId;
  String? secondId;
  String? createdAt;
  String? updatedAt;
  TutorExtractedInfo? secondInfo;

  FavoriteTutor({
    this.id,
     this.firstId,
     this.secondId,
     this.createdAt,
     this.updatedAt,
     this.secondInfo,
  });

  factory FavoriteTutor.fromJson(Map<String, dynamic> json) {
    return FavoriteTutor(
      id: json['id'] as String?,
      firstId: json['firstId'] as String?,
      secondId: json['secondId'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      secondInfo: json['secondInfo'] == null
          ? null
          : TutorExtractedInfo.fromJson(
          json['secondInfo'] as Map<String, dynamic>),
    );
  }
}