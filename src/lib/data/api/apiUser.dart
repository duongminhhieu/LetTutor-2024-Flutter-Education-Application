import '../../utilities/const.dart';

class APIUser {
  static const String BASE_URL = ConstValue.BASE_URL;

  static const USER_INFO = '${BASE_URL}user/info';
  static const USER_UPLOAD_AVATAR = '${BASE_URL}user/uploadAvatar';

  static const MANAGE_FAVORITE_TUTOR = '${BASE_URL}user/manageFavoriteTutor';
}