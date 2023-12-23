import 'package:json_annotation/json_annotation.dart';

import '../model/schedule/booking_info.dart';

@JsonSerializable()
class ListBookingResponse {
  String? message;
  BookingPagination? data;

  ListBookingResponse({
    this.message,
    this.data,
  });

  factory ListBookingResponse.fromJson(Map<String, dynamic> json) =>
      _$ResponseGetListBookingFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseGetListBookingToJson(this);
}

ListBookingResponse _$ResponseGetListBookingFromJson(
    Map<String, dynamic> json) =>
    ListBookingResponse(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : BookingPagination.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseGetListBookingToJson(
    ListBookingResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };


@JsonSerializable()
class BookingPagination {
  int? count;
  List<BookingInfo>? rows;

  BookingPagination({
    this.count,
    this.rows,
  });

  factory BookingPagination.fromJson(Map<String, dynamic> json) =>
      _$BookingPaginationFromJson(json);
  Map<String, dynamic> toJson() => _$BookingPaginationToJson(this);
}


BookingPagination _$BookingPaginationFromJson(Map<String, dynamic> json) =>
    BookingPagination(
      count: json['count'] as int?,
      rows: (json['rows'] as List<dynamic>?)
          ?.map((e) => BookingInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookingPaginationToJson(BookingPagination instance) =>
    <String, dynamic>{
      'count': instance.count,
      'rows': instance.rows,
    };

