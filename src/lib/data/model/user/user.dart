import 'dart:convert';

import 'package:src/data/model/user/test_preparation.dart';
import 'package:src/data/model/user/wallet_info.dart';

import 'learn_topic.dart';

class User {
   String? id;
   String? email;
   String? name;
   String? avatar;
   String? country;
   String? phone;
   List<String>? roles;
   String? language;
   String? birthday;
   bool? isActivated;
   WalletInfo? walletInfo;
   List<String>? courses;
   String? requireNote;
   String? level;
   List<LearnTopic>? learnTopics;
   List<TestPreparation>? testPreparations;
   bool? isPhoneActivated;
   int? timezone;
   String? studySchedule;
   bool? canSendMessage;

  User({
    this.id,
    this.email,
    this.name,
    this.avatar,
    this.country,
    this.phone,
    this.roles,
    this.language,
    this.birthday,
    this.isActivated,
    this.walletInfo,
    this.courses,
    this.requireNote,
    this.level,
    this.learnTopics,
    this.testPreparations,
    this.isPhoneActivated,
    this.timezone,
    this.studySchedule,
    this.canSendMessage,
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
      learnTopics: List<LearnTopic>.from(
          json['learnTopics'].map((x) => LearnTopic.fromJson(x))),
      testPreparations: List<TestPreparation>.from(
          json['testPreparations'].map((x) => TestPreparation.fromJson(x))),
      isPhoneActivated: json['isPhoneActivated'],
      timezone: json['timezone'],
      studySchedule: json['studySchedule'],
      canSendMessage: json['canSendMessage'],
    );
  }
}
