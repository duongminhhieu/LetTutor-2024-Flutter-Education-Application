import 'package:dio/dio.dart';
import 'package:src/data/api/apiAuth.dart';
import 'package:src/data/model/user/user.dart';
import 'package:src/data/model/user/user_data.dart';
import '../services/apiService.dart';
import 'base_repository.dart';

class AuthRepository extends BaseRepository {

  AuthRepository() : super();

  Future<void> loginByAccount({
    required String email,
    required String password,
    required Function(User, Tokens) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.post(url: APIAuthentication.LOGIN_ACCOUNT, data: {
      "email": email,
      "password": password,
    }) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        final user = User.fromJson(response.response['user']);
        final token = Tokens.fromJson(response.response['tokens']);
        await onSuccess(user, token);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  Future<void> loginByPhone({
    required String phone,
    required String password,
    required Function(User, Tokens) onSuccess,
  }) async {
    final response = await service.post(url: APIAuthentication.LOGIN_PHONE, data: {
      "phone": phone,
      "password": password,
    });

    final user = User.fromJson(response['user']);
    final token = Tokens.fromJson(response['tokens']);
    await onSuccess(user, token);
  }

  Future<void> loginByGoogle({
    required String accessToken,
    required Function(User, Tokens) onSuccess,
  }) async {
    final response = await service.post(url: APIAuthentication.LOGIN_GOOGLE, data: {
      "access_token": accessToken,
    });

    final user = User.fromJson(response['user']);
    final token = Tokens.fromJson(response['tokens']);
    await onSuccess(user, token);
  }

  Future<void> loginByFacebook({
    required String accessToken,
    required Function(User, Tokens) onSuccess,
  }) async {
    final response = await service.post(url: APIAuthentication.LOGIN_FACEBOOK, data: {
      "access_token": accessToken,
    });

    final user = User.fromJson(response['user']);
    final token = Tokens.fromJson(response['tokens']);
    await onSuccess(user, token);
  }

  Future<void> signUpByAccount({
    required String email,
    required String password,
    required Function(User, Tokens) onSuccess,
    required Function(String) onFail,
  }) async {
    final response =
    await service.postFormUrlEncoded(url: APIAuthentication.REGISTER_ACCOUNT, headers: {
      "origin": "https://sandbox.app.lettutor.com",
      "referer": "https://sandbox.app.lettutor.com/",
    }, data: {
      "email": email,
      "password": password,
      "source": null
    }) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        final user = User.fromJson(response.response['user']);
        final token = Tokens.fromJson(response.response['tokens']);
        await onSuccess(user, token);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  Future<void> signUpByPhone({
    required String phone,
    required String password,
    required Function(User, Tokens) onSuccess,
    required Function() onFail,
  }) async {
    final response = await service.postFormUrlEncoded(
        url: APIAuthentication.REGISTER_PHONE,
        data: {"phone": phone, "password": password, "source": null});

    if (!response is DioException) {
      final user = User.fromJson(response['user']);
      final token = Tokens.fromJson(response['tokens']);
      await onSuccess(user, token);
    } else {
      onFail();
    }
  }

  Future<void> refreshToken({
    required String refreshToken,
    required Function(User, Tokens) onSuccess,
  }) async {
    final response = await service.post(
        url: APIAuthentication.REFRESH_TOKEN,
        data: {"refreshToken": refreshToken, "timezone": 7}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        final user = User.fromJson(response.response['user']);
        final token = Tokens.fromJson(response.response['tokens']);
        await onSuccess(user, token);
        break;
      default:
        break;
    }
  }

  Future<void> changePassword({
    required String password,
    required String newPassword,
    required Function() onSuccess,
  }) async {
    final response = await service.post(
        url: APIAuthentication.CHANGE_PASSWORD,
        data: {"password": password, "newPassword": newPassword});

    await onSuccess();
  }

  // forgot password
  Future<void> forgotPassword({
    required String email,
    required Function(String) showMessage,
  }) async {
    var response = await service.post(url: APIAuthentication.FORGOT_PASSWORD, headers: {
      "origin": "https://sandbox.app.lettutor.com",
      "referer": "https://sandbox.app.lettutor.com/",
    }, data: {
      "email": email
    }) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        showMessage(response.response['message']);
        break;
      default:
        showMessage(response.errorMsg.toString());
        break;
    }
  }
}