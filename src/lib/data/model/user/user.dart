import 'dart:convert';

class WalletInfo {
  final String id;
  final String userId;
  final String amount;
  final bool isBlocked;
  final String createdAt;
  final String updatedAt;
  final int bonus;

  WalletInfo({
    required this.id,
    required this.userId,
    required this.amount,
    required this.isBlocked,
    required this.createdAt,
    required this.updatedAt,
    required this.bonus,
  });

  factory WalletInfo.fromJson(Map<String, dynamic> json) {
    return WalletInfo(
      id: json['id'],
      userId: json['userId'],
      amount: json['amount'],
      isBlocked: json['isBlocked'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      bonus: json['bonus'],
    );
  }
}

class LearnTopic {
  final int id;
  final String key;
  final String name;

  LearnTopic({
    required this.id,
    required this.key,
    required this.name,
  });

  factory LearnTopic.fromJson(Map<String, dynamic> json) {
    return LearnTopic(
      id: json['id'],
      key: json['key'],
      name: json['name'],
    );
  }
}

class User {
  final String id;
  final String email;
  final String name;
  final String avatar;
  final String country;
  final String phone;
  final List<String> roles;
  final String? language;
  final String birthday;
  final bool isActivated;
  final WalletInfo walletInfo;
  final List<String> courses;
  final String requireNote;
  final String level;
  final List<LearnTopic> learnTopics;
  final List<String> testPreparations;
  final bool isPhoneActivated;
  final int timezone;
  final String studySchedule;
  final bool canSendMessage;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.avatar,
    required this.country,
    required this.phone,
    required this.roles,
    this.language,
    required this.birthday,
    required this.isActivated,
    required this.walletInfo,
    required this.courses,
    required this.requireNote,
    required this.level,
    required this.learnTopics,
    required this.testPreparations,
    required this.isPhoneActivated,
    required this.timezone,
    required this.studySchedule,
    required this.canSendMessage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      avatar: json['avatar'],
      country: json['country'],
      phone: json['phone'],
      roles: List<String>.from(json['roles']),
      language: json['language'],
      birthday: json['birthday'],
      isActivated: json['isActivated'],
      walletInfo: WalletInfo.fromJson(json['walletInfo']),
      courses: List<String>.from(json['courses']),
      requireNote: json['requireNote'],
      level: json['level'],
      learnTopics: List<LearnTopic>.from(json['learnTopics'].map((x) => LearnTopic.fromJson(x))),
      testPreparations: List<String>.from(json['testPreparations']),
      isPhoneActivated: json['isPhoneActivated'],
      timezone: json['timezone'],
      studySchedule: json['studySchedule'],
      canSendMessage: json['canSendMessage'],
    );
  }
}

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
  final User user;
  final Tokens tokens;

  UserData({
    required this.user,
    required this.tokens,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: User.fromJson(json['user']),
      tokens: Tokens.fromJson(json['tokens']),
    );
  }
}
