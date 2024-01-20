import 'package:json_annotation/json_annotation.dart';
import 'package:src/data/model/schedule/schedule_detail.dart';
import 'package:src/data/model/tutor/tutor.dart';


@JsonSerializable()
class Schedule {
  String? id;
  String? date;
  String? tutorId;
  String? startTime;
  String? endTime;
  int? startTimestamp;
  int? endTimestamp;
  String? createdAt;
  bool? isBooked;
  bool? isDeleted;
  List<ScheduleDetail>? scheduleDetails;
  Tutor? tutorInfo;

  Schedule({
    this.id,
    this.date,
    this.tutorId,
    this.startTime,
    this.endTime,
    this.startTimestamp,
    this.endTimestamp,
    this.createdAt,
    this.isBooked,
    this.isDeleted,
    this.scheduleDetails,
    this.tutorInfo,
  });

  String getDisplayTime() {
    return "$startTime:$endTime";
  }

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}
Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule(
  id: json['id'] as String?,
  date: json['date'] as String?,
  tutorId: json['tutorId'] as String?,
  startTime: json['startTime'] as String?,
  endTime: json['endTime'] as String?,
  startTimestamp: json['startTimestamp'] as int?,
  endTimestamp: json['endTimestamp'] as int?,
  createdAt: json['createdAt'] as String?,
  isBooked: json['isBooked'] as bool?,
  isDeleted: json['isDeleted'] as bool?,
  scheduleDetails:json['scheduleDetails'] == null ? null : (json['scheduleDetails'] as List<dynamic>?)
      ?.map((e) => ScheduleDetail.fromJson(e as Map<String, dynamic>))
      .toList(),
  tutorInfo: json['tutorInfo'] == null
      ? null
      : Tutor.fromJson(json['tutorInfo'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
  'id': instance.id,
  'date': instance.date,
  'tutorId': instance.tutorId,
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'startTimestamp': instance.startTimestamp,
  'endTimestamp': instance.endTimestamp,
  'createdAt': instance.createdAt,
  'isBooked': instance.isBooked,
  'isDeleted': instance.isDeleted,
  'scheduleDetails': instance.scheduleDetails,
  'tutorInfo': instance.tutorInfo,
};
