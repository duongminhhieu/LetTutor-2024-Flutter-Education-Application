import '../../utilities/const.dart';

class APIAuthentication{

  static const String BASE_URL = ConstValue.BASE_URL;

  static const String REGISTER_ACCOUNT = '${BASE_URL}auth/register';
  static const String LOGIN_ACCOUNT = '${BASE_URL}auth/login';
  static const String LOGIN_PHONE = '${BASE_URL}auth/phone-login';


  static String verifyAccount(String token){
    return '${BASE_URL}auth/verifyAccount?token=$token';
  }

  static const String LOGIN_GOOGLE = '${BASE_URL}auth/google';
  static const String LOGIN_FACEBOOK = '${BASE_URL}auth/facebook';

  static const String REFRESH_TOKEN = '${BASE_URL}auth/refresh-token';
  static const String REGISTER_PHONE = '${BASE_URL}auth/phone-register';

  static const String RESEND_OTP = '${BASE_URL}verify/phone-auth-verify/create';
  static const String ACTIVE_ACCOUNT = '${BASE_URL}verify/phone-auth-verify/activate';
static const String FORGOT_PASSWORD = '${BASE_URL}auth/forgotPassword';


}