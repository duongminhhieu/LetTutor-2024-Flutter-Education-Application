import 'package:json_annotation/json_annotation.dart';
import 'package:src/data/model/schedule/class_review.dart';
import 'package:src/data/model/schedule/schedule_detail.dart';

import '../tutor/tutor_feedback.dart';

@JsonSerializable()
class BookingInfo {
  int? createdAtTimeStamp;
  int? updatedAtTimeStamp;
  String? id;
  String? userId;
  String? scheduleDetailId;
  String? tutorMeetingLink;
  String? studentMeetingLink;
  String? studentRequest;
  String? tutorReview;
  int? scoreByTutor;
  String? createdAt;
  String? updatedAt;
  String? recordUrl;
  bool? isDeleted;
  ScheduleDetail? scheduleDetailInfo;
  ClassReview? classReview;
  //new
  int? cancelReasonId;
  String? lessonPlanId;
  String? cancelNote;
  String? calendarId;
  bool? showRecordUrl;
  // List<String>? studentMaterials;
  List<FeedbackTutor>? feedbacks;

  BookingInfo({
    this.createdAtTimeStamp,
    this.updatedAtTimeStamp,
    this.id,
    this.userId,
    this.scheduleDetailId,
    this.tutorMeetingLink,
    this.studentMeetingLink,
    this.studentRequest,
    this.tutorReview,
    this.scoreByTutor,
    this.createdAt,
    this.updatedAt,
    this.recordUrl,
    this.isDeleted,
    this.scheduleDetailInfo,
    this.classReview,
    this.cancelReasonId,
    this.lessonPlanId,
    this.cancelNote,
    this.calendarId,
    this.showRecordUrl,
    // this.studentMaterials,
    this.feedbacks,
  });

  factory BookingInfo.fromJson(Map<String, dynamic> json) =>
      _$BookingInfoFromJson(json);
  Map<String, dynamic> toJson() => _$BookingInfoToJson(this);
}

BookingInfo _$BookingInfoFromJson(Map<String, dynamic> json) => BookingInfo(
  createdAtTimeStamp: json['createdAtTimeStamp'] as int?,
  updatedAtTimeStamp: json['updatedAtTimeStamp'] as int?,
  id: json['id'] as String?,
  userId: json['userId'] as String?,
  scheduleDetailId: json['scheduleDetailId'] as String?,
  tutorMeetingLink: json['tutorMeetingLink'] as String?,
  studentMeetingLink: json['studentMeetingLink'] as String?,
  studentRequest: json['studentRequest'] as String?,
  tutorReview: json['tutorReview'] as String?,
  scoreByTutor: json['scoreByTutor'] as int?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  recordUrl: json['recordUrl'] as String?,
  isDeleted: json['isDeleted'] as bool?,
  scheduleDetailInfo: json['scheduleDetailInfo'] == null
      ? null
      : ScheduleDetail.fromJson(
      json['scheduleDetailInfo'] as Map<String, dynamic>),
  classReview: json['classReview'] == null
      ? null
      : ClassReview.fromJson(json['classReview'] as Map<String, dynamic>),
  cancelReasonId: json['cancelReasonId'] as int?,
  lessonPlanId: json['lessonPlanId'] as String?,
  cancelNote: json['cancelNote'] as String?,
  calendarId: json['calendarId'] as String?,
  showRecordUrl: json['showRecordUrl'] as bool?,
  feedbacks: (json['feedbacks'] as List<dynamic>?)
      ?.map((e) => FeedbackTutor.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BookingInfoToJson(BookingInfo instance) =>
    <String, dynamic>{
      'createdAtTimeStamp': instance.createdAtTimeStamp,
      'updatedAtTimeStamp': instance.updatedAtTimeStamp,
      'id': instance.id,
      'userId': instance.userId,
      'scheduleDetailId': instance.scheduleDetailId,
      'tutorMeetingLink': instance.tutorMeetingLink,
      'studentMeetingLink': instance.studentMeetingLink,
      'studentRequest': instance.studentRequest,
      'tutorReview': instance.tutorReview,
      'scoreByTutor': instance.scoreByTutor,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'recordUrl': instance.recordUrl,
      'isDeleted': instance.isDeleted,
      'scheduleDetailInfo': instance.scheduleDetailInfo,
      'classReview': instance.classReview,
      'cancelReasonId': instance.cancelReasonId,
      'lessonPlanId': instance.lessonPlanId,
      'cancelNote': instance.cancelNote,
      'calendarId': instance.calendarId,
      'showRecordUrl': instance.showRecordUrl,
      'feedbacks': instance.feedbacks,
    };

