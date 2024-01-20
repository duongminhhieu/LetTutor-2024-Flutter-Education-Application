import 'package:flutter/cupertino.dart';
import 'package:src/data/repository/auth_repository.dart';

import '../data/model/user/user.dart';
import '../data/model/user/user_data.dart';


class AuthProvider extends ChangeNotifier {
  late AuthRepository authRepository;

  User? currentUser;
  Tokens? token;

  bool refreshHome = false;

  AuthProvider() {
    authRepository = AuthRepository();
  }

  void saveLoginInfo(User currentUser, Tokens? token) {
    this.token = token;
    this.currentUser = currentUser;
    notifyListeners();
  }

  void clearUserInfo() {
    token = null;
    currentUser = null;
    notifyListeners();
  }
}