import 'package:src/data/model/schedule/schedule_detail.dart';

class Schedule {
  String? id;
  String? tutorId;
  String? startTime;
  String? endTime;
  int? startTimestamp;
  int? endTimestamp;
  String? createdAt;
  bool? isBooked;
  List<ScheduleDetail>? scheduleDetails;

  Schedule({
     this.id,
     this.tutorId,
     this.startTime,
     this.endTime,
     this.startTimestamp,
     this.endTimestamp,
     this.createdAt,
     this.isBooked,
     this.scheduleDetails,
  });

  String getDisplayTime() {
    return "$startTime:$endTime";
  }

  factory Schedule.fromJson(Map<String, dynamic> json) {
    List<dynamic> details = json['scheduleDetails'];
    List<ScheduleDetail> scheduleDetails = details.map((detail) => ScheduleDetail.fromJson(detail)).toList();

    return Schedule(
      id: json['id'],
      tutorId: json['tutorId'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      startTimestamp: json['startTimestamp'],
      endTimestamp: json['endTimestamp'],
      createdAt: json['createdAt'],
      isBooked: json['isBooked'],
      scheduleDetails: scheduleDetails,
    );
  }
}
