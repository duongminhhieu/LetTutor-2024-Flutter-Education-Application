import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:src/data/api/apiAuth.dart';
import 'package:src/data/api/apiUser.dart';
import 'package:src/data/responses/result_response.dart';

import '../model/user/user.dart';
import '../services/apiService.dart';
import 'base_repository.dart';

class UserRepository extends BaseRepository {
  UserRepository() : super();

  Future<Result<User>> updateUserInfo({
    required String accessToken,
    required User input
  }) async {
    try {
      var learnTopics = [];
      input.learnTopics?.forEach((element) {
        learnTopics.add(element.id);
      });
      var testPreparations = [];
      input.testPreparations?.forEach((element) {
        testPreparations.add(element.id);
      });
      final response = await service.put(url: APIUser.USER_INFO, headers: {
        "Authorization": "Bearer $accessToken"
      }, data: {
        "name": input.name,
        "country": input.country,
        "phone": input.phone,
        "birthday": input.birthday,
        "level": input.level,
        "learnTopics": learnTopics,
        "testPreparations": testPreparations
      }) as BoundResource;

      switch (response.statusCode) {
        case 200:
        case 201:
          final user = User.fromJson(response.response['user']);
          return Result(data: user);
        default:
          return Result(error: response.errorMsg.toString());
      }
    } catch (e) {
      return Result(error: e.toString());
    }
  }

  Future<Result<String>> resetPassword({
    required String email,
    required Function(String) showMessage,
  }) async {
    try {
      var response =
          await service.post(url: APIAuthentication.FORGOT_PASSWORD, headers: {
        "origin": "https://sandbox.app.lettutor.com",
        "referer": "https://sandbox.app.lettutor.com/",
      }, data: {
        "email": email
      }) as BoundResource;

      switch (response.statusCode) {
        case 200:
        case 201:
          return Result(data: response.response['message']);
        default:
          return Result(error: response.errorMsg.toString());
      }
    } catch (e) {
      return Result(error: e.toString());
    }
  }

  Future<Result<User>> uploadAvatar({
    required String accessToken,
    required String imagePath
  }) async {
    try {
      final formDataImage = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(
          imagePath,
        ),
      });
      final response = await service.postFormData(
          url: APIUser.USER_UPLOAD_AVATAR,
          headers: {"Authorization": "Bearer $accessToken"},
          data: formDataImage) as BoundResource;
      switch (response.statusCode) {
        case 200:
        case 201:
          final user = User.fromJson(response.response);
          return Result(data: user);
        default:
          return Result(error: response.errorMsg.toString());
      }
    } catch (e) {
      return Result(error: e.toString());
    }
  }
}
