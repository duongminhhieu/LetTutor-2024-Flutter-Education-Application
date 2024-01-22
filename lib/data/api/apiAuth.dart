import '../../utilities/const.dart';

class APIAuthentication{

  static String BASE_URL = ConstValue.BASE_URL;

  static String REGISTER_ACCOUNT = '${BASE_URL}auth/register';
  static String LOGIN_ACCOUNT = '${BASE_URL}auth/login';
  static String LOGIN_PHONE = '${BASE_URL}auth/phone-login';


  static String verifyAccount(String token){
    return '${BASE_URL}auth/verifyAccount?token=$token';
  }

  static String LOGIN_GOOGLE = '${BASE_URL}auth/google';
  static String LOGIN_FACEBOOK = '${BASE_URL}auth/facebook';

  static String REFRESH_TOKEN = '${BASE_URL}auth/refresh-token';
  static String REGISTER_PHONE = '${BASE_URL}auth/phone-register';

  static String RESEND_OTP = '${BASE_URL}verify/phone-auth-verify/create';
  static String ACTIVE_ACCOUNT = '${BASE_URL}verify/phone-auth-verify/activate';
  static String FORGOT_PASSWORD = '${BASE_URL}user/forgotPassword';
  static String CHANGE_PASSWORD = '${BASE_URL}auth/change-password';


}