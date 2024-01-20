import 'package:dio/dio.dart';
import '../services/apiService.dart';

abstract class BaseRepository {
  late CancelToken cancelToken;
  late ApiService service;

  BaseRepository() {
    service = ApiService();
    cancelToken = CancelToken();
  }
}