import 'package:json_annotation/json_annotation.dart';

import '../model/schedule/schedule.dart';



@JsonSerializable()
class ResponseGetListSchedule {
  String? message;
  List<Schedule>? scheduleOfTutor;

  ResponseGetListSchedule({
    this.message,
    this.scheduleOfTutor,
  });

  factory ResponseGetListSchedule.fromJson(Map<String, dynamic> json) =>
      _$ResponseGetListScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseGetListScheduleToJson(this);
}

ResponseGetListSchedule _$ResponseGetListScheduleFromJson(
    Map<String, dynamic> json) =>
    ResponseGetListSchedule(
      message: json['message'] as String?,
      scheduleOfTutor: (json['scheduleOfTutor'] as List<dynamic>?)
          ?.map((e) => Schedule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseGetListScheduleToJson(
    ResponseGetListSchedule instance) =>
    <String, dynamic>{
      'message': instance.message,
      'scheduleOfTutor': instance.scheduleOfTutor,
    };
