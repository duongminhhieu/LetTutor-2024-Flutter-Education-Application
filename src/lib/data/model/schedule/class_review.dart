import 'package:json_annotation/json_annotation.dart';

import 'lesson_status.dart';

@JsonSerializable()
class ClassReview {
  final String? bookingId;
  final int? lessonStatusId;
  final String? book;
  final String? unit;
  final String? lesson;
  final dynamic page;
  final String? lessonProgress;
  final int? behaviorRating;
  final String? behaviorComment;
  final int? listeningRating;
  final String? listeningComment;
  final int? speakingRating;
  final String? speakingComment;
  final int? vocabularyRating;
  final String? vocabularyComment;
  final String? homeworkComment;
  final String? overallComment;
  final LessonStatus? lessonStatus;

  ClassReview({
    this.bookingId,
    this.lessonStatusId,
    this.book,
    this.unit,
    this.lesson,
    this.page,
    this.lessonProgress,
    this.behaviorRating,
    this.behaviorComment,
    this.listeningRating,
    this.listeningComment,
    this.speakingRating,
    this.speakingComment,
    this.vocabularyRating,
    this.vocabularyComment,
    this.homeworkComment,
    this.overallComment,
    this.lessonStatus,
  });

  factory ClassReview.fromJson(Map<String, dynamic> json) =>
      _$ClassReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ClassReviewToJson(this);
}

ClassReview _$ClassReviewFromJson(Map<String, dynamic> json) => ClassReview(
      bookingId: json['bookingId'] as String?,
      lessonStatusId: json['lessonStatusId'] as int?,
      book: json['book'] as String?,
      unit: json['unit'] as String?,
      lesson: json['lesson'] as String?,
      page: json['page'],
      lessonProgress: json['lessonProgress'] as String?,
      behaviorRating: json['behaviorRating'] as int?,
      behaviorComment: json['behaviorComment'] as String?,
      listeningRating: json['listeningRating'] as int?,
      listeningComment: json['listeningComment'] as String?,
      speakingRating: json['speakingRating'] as int?,
      speakingComment: json['speakingComment'] as String?,
      vocabularyRating: json['vocabularyRating'] as int?,
      vocabularyComment: json['vocabularyComment'] as String?,
      homeworkComment: json['homeworkComment'] as String?,
      overallComment: json['overallComment'] as String?,
      lessonStatus: json['lessonStatus'] == null
          ? null
          : LessonStatus.fromJson(json['lessonStatus'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClassReviewToJson(ClassReview instance) =>
    <String, dynamic>{
      'bookingId': instance.bookingId,
      'lessonStatusId': instance.lessonStatusId,
      'book': instance.book,
      'unit': instance.unit,
      'lesson': instance.lesson,
      'page': instance.page,
      'lessonProgress': instance.lessonProgress,
      'behaviorRating': instance.behaviorRating,
      'behaviorComment': instance.behaviorComment,
      'listeningRating': instance.listeningRating,
      'listeningComment': instance.listeningComment,
      'speakingRating': instance.speakingRating,
      'speakingComment': instance.speakingComment,
      'vocabularyRating': instance.vocabularyRating,
      'vocabularyComment': instance.vocabularyComment,
      'homeworkComment': instance.homeworkComment,
      'overallComment': instance.overallComment,
      'lessonStatus': instance.lessonStatus,
    };
