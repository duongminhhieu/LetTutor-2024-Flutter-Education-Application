import 'package:flutter/material.dart';
import 'package:src/data/model/user/user.dart';
import 'package:src/data/repository/user_repository.dart';
import 'package:src/data/responses/result_response.dart';

import 'auth_provider.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _repository = UserRepository();

  Future<void> callAPIUpdateProfile(AuthProvider authProvider, User input,
      Function(User) onSuccess, Function(String) onFail) async {

    try {
      Result result = await _repository.updateUserInfo(
          accessToken: authProvider.token?.access?.token ?? "", input: input);

      if (result.data != null) {
        onSuccess(result.data as User);
      }

      if (result.error != null) {
        onFail(result.error.toString());
      }

      notifyListeners();

    } catch (error) {
      debugPrint(error.toString());
      onFail(error.toString());
    }
  }

  Future<void> callAPIUpdateAvatar(AuthProvider authProvider, String avatar, Function(User) onSuccess, Function(String) onFail) async {

    try {
      Result result = await _repository.uploadAvatar(
          accessToken: authProvider.token?.access?.token ?? "", imagePath: avatar);

      if (result.data != null) {
        onSuccess(result.data as User);
      }

      if (result.error != null) {
        onFail(result.error.toString());
      }

      notifyListeners();

    } catch (error) {
      debugPrint(error.toString());
      onFail(error.toString());
    }

  }

}
