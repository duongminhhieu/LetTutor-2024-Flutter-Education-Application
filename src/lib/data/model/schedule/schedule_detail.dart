import 'booking_info.dart';

class ScheduleDetail {
  String? id;
  String? scheduleId;
  String? startPeriod;
  String? endPeriod;
  int? startPeriodTimestamp;
  int? endPeriodTimestamp;
  String? createdAt;
  String? updatedAt;
  List<BookingInfo>? bookingInfo;
  bool? isBooked;

  ScheduleDetail({
     this.id,
     this.scheduleId,
     this.startPeriod,
     this.endPeriod,
     this.startPeriodTimestamp,
     this.endPeriodTimestamp,
     this.createdAt,
     this.updatedAt,
     this.bookingInfo,
     this.isBooked,
  });

  factory ScheduleDetail.fromJson(Map<String, dynamic> json) {
    List<dynamic> bookingInfoList = json['bookingInfo'];
    List<BookingInfo> bookingInfo = bookingInfoList.map((info) => BookingInfo.fromJson(info)).toList();

    return ScheduleDetail(
      id: json['id'],
      scheduleId: json['scheduleId'],
      startPeriod: json['startPeriod'],
      endPeriod: json['endPeriod'],
      startPeriodTimestamp: json['startPeriodTimestamp'],
      endPeriodTimestamp: json['endPeriodTimestamp'],
      createdAt:json['createdAt'],
      updatedAt:json['updatedAt'],
      bookingInfo: bookingInfo,
      isBooked: json['isBooked'],
    );
  }
}
