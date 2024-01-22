import '../../utilities/const.dart';

class APIUser {
  static String BASE_URL = ConstValue.BASE_URL;

  static String USER_INFO = '${BASE_URL}user/info';
  static String USER_UPLOAD_AVATAR = '${BASE_URL}user/uploadAvatar';

  static String MANAGE_FAVORITE_TUTOR = '${BASE_URL}user/manageFavoriteTutor';
}