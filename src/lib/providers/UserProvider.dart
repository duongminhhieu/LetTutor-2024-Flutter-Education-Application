import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
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
    _email = '';
    _password = '';
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
