import '../../utilities/const.dart';

class APIUser {
  static const String BASE_URL = ConstValue.BASE_URL;

  static const CHANGE_PASSWORD = '${BASE_URL}auth/change-password';
  static const USER_INFO = '${BASE_URL}user/info';
}