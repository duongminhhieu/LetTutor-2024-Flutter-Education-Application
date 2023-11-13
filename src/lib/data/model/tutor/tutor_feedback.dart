import 'package:src/data/model/tutor/tutor.dart';
import 'package:src/data/model/tutor/tutor_info.dart';

class Feedback {
  final String? id;
  final String? bookingId;
  final String? firstId;
  final String? secondId;
  final int? rating;
  final String? content;
  final String? createdAt;
  final String? updatedAt;
  final TutorInfo? firstInfo;

  Feedback({
     this.id,
     this.bookingId,
     this.firstId,
     this.secondId,
     this.rating,
     this.content,
     this.createdAt,
     this.updatedAt,
     this.firstInfo,
  });

  factory Feedback.fromJson(Map<String, dynamic> json) {
    return Feedback(
      id: json['id'],
      bookingId: json['bookingId'],
      firstId: json['firstId'],
      secondId: json['secondId'],
      rating: json['rating'],
      content: json['content'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      firstInfo: TutorInfo.fromJson(json['firstInfo']),
    );
  }
}
