import 'package:src/data/model/tutor/tutor_extracted_info.dart';

class FavoriteTutor {
  String? id;
  String? firstId;
  String? secondId;
  String? createdAt;
  String? updatedAt;
  TutorExtractedInfo secondInfo;

  FavoriteTutor({
    required this.id,
    required this.firstId,
    required this.secondId,
    required this.createdAt,
    required this.updatedAt,
    required this.secondInfo,
  });

  factory FavoriteTutor.fromJson(Map<String, dynamic> json) {
    return FavoriteTutor(
      id: json['id'],
      firstId: json['firstId'],
      secondId: json['secondId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      secondInfo: TutorExtractedInfo.fromJson(json['secondInfo']),
    );
  }
}