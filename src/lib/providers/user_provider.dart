import 'package:flutter/material.dart';
import 'package:src/data/model/user/user_data.dart';
import 'package:src/data/repository/user_repository.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _repository = UserRepository();

  UserData _userData = UserData();
  UserData get userData => _userData;

  UserProvider()  {
    getUserData();
  }

  Future<void> getUserData() async {
    try {
      _userData = await _repository.getUserData();
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  String _email = '';
  String get email => _email;

  String _password ='';
  String get password => _password;

  bool _isRegistered = false;
  bool get isRegistered => _isRegistered;

  bool _isLoggedIn   = false;
  bool get isLoggedIn  => _isLoggedIn ;


  void login(String email, String password) {
    _email = email;
    _password = password;
    _isRegistered = false;
    _isLoggedIn  = true;

    notifyListeners();
  }

  void logout() {
    _isRegistered = false;
    _isLoggedIn  = false;

    notifyListeners();
  }

  void setCredentials(String email, String password) {
    _email = email;
    _password = password;
    _isRegistered = true;

    notifyListeners();
  }
}
