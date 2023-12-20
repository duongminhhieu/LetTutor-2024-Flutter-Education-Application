
import 'package:src/data/responses/list-booking_response.dart';
import 'package:src/data/responses/next-booking-info_response.dart';

import '../api/apiSchedule.dart';
import '../model/schedule/booking_info.dart';
import '../services/apiService.dart';
import 'base_repository.dart';

class BookingRepository extends BaseRepository {

  BookingRepository() : super();

  Future<void> getLearningHistory({
    required String accessToken,
    required String now,
    required int page,
    required int perPage,
    required Function(List<BookingInfo>, int) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
        url:
        APISchedule.getBookedClass(page, perPage, now, "meeting", "desc"),
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        var result = ListBookingResponse.fromJson(response.response).data;
        onSuccess(result?.rows ?? [], result?.count ?? 0);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  Future<void> getIncomingLessons({
    required String accessToken,
    required String now,
    required int page,
    required int perPage,
    required Function(List<BookingInfo>, int) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
        url:
        APISchedule.getIncomingBookedClass(page, perPage, now, "meeting", "desc"),
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        var result = ListBookingResponse.fromJson(response.response).data;
        onSuccess(result?.rows ?? [], result?.count ?? 0);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  Future<void> getUpcomingLessonAtHomePage({
    required String accessToken,
    required int now,
    required Function(List<BookingInfo>) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
        url: APISchedule.getUpcomingBookedClass(now),
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(
            NextBookingInfoResponse.fromJson(response.response).data ?? []);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  Future<void> bookLesson({
    required String accessToken,
    required String notes,
    required List<String> scheduleDetailIds,
    required Function(String) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.post(
        url: APISchedule.BOOK_CLASS,
        data: {"note": notes, "scheduleDetailIds": scheduleDetailIds},
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(response.response['message']);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  Future<void> cancelALesson({
    required String accessToken,
    required String scheduleDetailIds,
    required int cancelReasonId,
    required String? notes,
    required Function(String) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.delete(url: APISchedule.BOOK_CLASS, data: {
      "scheduleDetailIds": [scheduleDetailIds],
      "cancelInfo": {"cancelReasonId": cancelReasonId, "note": notes}
    }, headers: {
      "Authorization": "Bearer $accessToken"
    }) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(response.response['message']);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }
}
