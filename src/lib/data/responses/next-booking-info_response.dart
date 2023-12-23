import 'package:json_annotation/json_annotation.dart';

import '../model/schedule/booking_info.dart';


@JsonSerializable()
class NextBookingInfoResponse {
  String? message;
  List<BookingInfo>? data;

  NextBookingInfoResponse({
    this.message,
    this.data,
  });

  factory NextBookingInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$ResponseGetNextBookingInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseGetNextBookingInfoToJson(this);
}

NextBookingInfoResponse _$ResponseGetNextBookingInfoFromJson(
    Map<String, dynamic> json) =>
    NextBookingInfoResponse(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BookingInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseGetNextBookingInfoToJson(
    NextBookingInfoResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };



