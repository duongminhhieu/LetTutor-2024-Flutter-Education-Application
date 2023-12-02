
import 'package:src/data/model/user/user.dart';

class Tokens {
  final TokenInfo access;
  final TokenInfo refresh;

  Tokens({
    required this.access,
    required this.refresh,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) {
    return Tokens(
      access: TokenInfo.fromJson(json['access']),
      refresh: TokenInfo.fromJson(json['refresh']),
    );
  }
}

class TokenInfo {
  final String token;
  final String expires;

  TokenInfo({
    required this.token,
    required this.expires,
  });

  factory TokenInfo.fromJson(Map<String, dynamic> json) {
    return TokenInfo(
      token: json['token'],
      expires: json['expires'],
    );
  }
}

class UserData {
   User? user;
   Tokens? tokens;

  UserData({
     this.user,
     this.tokens,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: User.fromJson(json['user']),
      tokens: Tokens.fromJson(json['tokens']),
    );
  }
}
