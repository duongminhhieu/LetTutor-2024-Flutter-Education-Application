import 'package:dio/dio.dart';

class BoundResource {
  final dynamic response;
  final int statusCode;
  final String? errorMsg;

  BoundResource({this.response, required this.statusCode, this.errorMsg});
}

class ApiService {
  Dio api = Dio();
  String? accessToken;

  Future<dynamic> put(
      {required String url,
        Map<String, dynamic>? headers,
        Map<String, dynamic>? data,
        CancelToken? cancelToken}) async {
    try {
      final response = await api.put(url,
          options: Options(
              headers: headers,
              contentType: Headers.jsonContentType,
              method: 'PUT'),
          data: data,
          cancelToken: cancelToken);
      switch (response.statusCode) {
        case 200:
          return BoundResource(response: response.data, statusCode: 200);
        case 201:
          return BoundResource(response: response.data, statusCode: 201);
      }
    } on DioException catch (err) {
      return BoundResource(
          errorMsg: err.response?.data['message'] ?? err.message,
          statusCode: err.response?.statusCode ?? 500);
    }
  }

  Future<dynamic> delete(
      {required String url,
        Map<String, dynamic>? headers,
        Map<String, dynamic>? data,
        CancelToken? cancelToken}) async {
    try {
      final response = await api.delete(url,
          options: Options(
              headers: headers,
              contentType: Headers.jsonContentType,
              method: 'POST'),
          data: data,
          cancelToken: cancelToken);
      switch (response.statusCode) {
        case 200:
          return BoundResource(response: response.data, statusCode: 200);
        case 201:
          return BoundResource(response: response.data, statusCode: 201);
      }
    } on DioException catch (err) {
      return BoundResource(
          errorMsg: err.response?.data['message'] ?? err.message,
          statusCode: err.response?.statusCode ?? 500);
    }
  }

  Future<dynamic> post(
      {required String url,
        Map<String, dynamic>? headers,
        Map<String, dynamic>? data,
        CancelToken? cancelToken}) async {
    try {
      final response = await api.post(url,
          options: Options(
              headers: headers,
              contentType: Headers.jsonContentType,
              method: 'POST'),
          data: data,
          cancelToken: cancelToken);
      switch (response.statusCode) {
        case 200:
          return BoundResource(response: response.data, statusCode: 200);
        case 201:
          return BoundResource(response: response.data, statusCode: 201);
      }
    } on DioException catch (err) {
      return BoundResource(
          errorMsg: err.response?.data['message'] ?? err.message,
          statusCode: err.response?.statusCode ?? 500);
    }
  }

  Future<dynamic> get(
      {required String url,
        Map<String, dynamic>? headers,
        CancelToken? cancelToken}) async {
    try {
      final response = await api.get(url,
          options:
          Options(headers: headers, contentType: Headers.jsonContentType),
          cancelToken: cancelToken);
      switch (response.statusCode) {
        case 200:
          return BoundResource(response: response.data, statusCode: 200);
        case 201:
          return BoundResource(response: response.data, statusCode: 201);
      }
    } on DioException catch (err) {
      return BoundResource(
          errorMsg: err.response?.data['message'] ?? err.message,
          statusCode: err.response?.statusCode ?? 500);
    }
  }
  // }

  Future<dynamic> postFormUrlEncoded(
      {required String url,
        Map<String, dynamic>? headers,
        required Map<String, dynamic>? data,
        CancelToken? cancelToken}) async {
    try {
      final response = await api.post(url,
          options: Options(
              headers: headers, contentType: Headers.formUrlEncodedContentType),
          data: data,
          cancelToken: cancelToken);
      switch (response.statusCode) {
        case 200:
          return BoundResource(response: response.data, statusCode: 200);
        case 201:
          return BoundResource(response: response.data, statusCode: 201);
      }
    } on DioError catch (err) {
      return BoundResource(
          errorMsg: err.response?.data['message'] ?? err.message,
          statusCode: err.response?.statusCode ?? 500);
    }
  }

  Future<dynamic> postFormData(
      {required String url,
        Map<String, dynamic>? headers,
        required FormData? data,
        CancelToken? cancelToken}) async {
    try {
      final response = await api.post(url,
          options: Options(
              headers: headers,
              contentType: Headers.multipartFormDataContentType),
          data: data,
          cancelToken: cancelToken);
      switch (response.statusCode) {
        case 200:
          return BoundResource(response: response.data, statusCode: 200);
        case 201:
          return BoundResource(response: response.data, statusCode: 201);
      }
    } on DioException catch (err) {
      return BoundResource(
          errorMsg: err.response?.data['message'] ?? err.message,
          statusCode: err.response?.statusCode ?? 500);
    }
  }
}