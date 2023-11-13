import 'package:src/data/model/tutor/tutor_feedback.dart';

class Tutor {
  final String id;
  final String level;
  final String email;
  final String? google;
  final String? facebook;
  final String? apple;
  final String avatar;
  final String name;
  final String country;
  final String phone;
  final String language;
  final String birthday;
  final bool requestPassword;
  final bool isActivated;
  final bool? isPhoneActivated;
  final String? requireNote;
  final int timezone;
  final String? phoneAuth;
  final bool isPhoneAuthActivated;
  final String studySchedule;
  final bool canSendMessage;
  final bool isPublicRecord;
  final String? caredByStaffId;
  final String? zaloUserId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String? studentGroupId;
  final List<Feedback> feedbacks;
  final String video;
  final String bio;
  final String education;
  final String experience;
  final String profession;
  final String? accent;
  final String targetStudent;
  final String interests;
  final String languages;
  final String specialties;
  final String? resume;
  final double rating;
  final bool? isNative;
  final String? youtubeVideoId;
  final int price;
  final bool isOnline;

  Tutor({
    required this.id,
    required this.level,
    required this.email,
    this.google,
    this.facebook,
    this.apple,
    required this.avatar,
    required this.name,
    required this.country,
    required this.phone,
    required this.language,
    required this.birthday,
    required this.requestPassword,
    required this.isActivated,
    this.isPhoneActivated,
    this.requireNote,
    required this.timezone,
    this.phoneAuth,
    required this.isPhoneAuthActivated,
    required this.studySchedule,
    required this.canSendMessage,
    required this.isPublicRecord,
    this.caredByStaffId,
    this.zaloUserId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.studentGroupId,
    required this.feedbacks,
    required this.video,
    required this.bio,
    required this.education,
    required this.experience,
    required this.profession,
    this.accent,
    required this.targetStudent,
    required this.interests,
    required this.languages,
    required this.specialties,
    this.resume,
    required this.rating,
    this.isNative,
    this.youtubeVideoId,
    required this.price,
    required this.isOnline,
  });

  factory Tutor.fromJson(Map<String, dynamic> json) {
    return Tutor(
      id: json['id'],
      level: json['level'],
      email: json['email'],
      google: json['google'],
      facebook: json['facebook'],
      apple: json['apple'],
      avatar: json['avatar'],
      name: json['name'],
      country: json['country'],
      phone: json['phone'],
      language: json['language'],
      birthday: json['birthday'],
      requestPassword: json['requestPassword'],
      isActivated: json['isActivated'],
      isPhoneActivated: json['isPhoneActivated'],
      requireNote: json['requireNote'],
      timezone: json['timezone'],
      phoneAuth: json['phoneAuth'],
      isPhoneAuthActivated: json['isPhoneAuthActivated'],
      studySchedule: json['studySchedule'],
      canSendMessage: json['canSendMessage'],
      isPublicRecord: json['isPublicRecord'],
      caredByStaffId: json['caredByStaffId'],
      zaloUserId: json['zaloUserId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      studentGroupId: json['studentGroupId'],
      feedbacks: List<Feedback>.from(
        json['feedbacks'].map((feedbackJson) => Feedback.fromJson(feedbackJson)),
      ),
      video: json['video'],
      bio: json['bio'],
      education: json['education'],
      experience: json['experience'],
      profession: json['profession'],
      accent: json['accent'],
      targetStudent: json['targetStudent'],
      interests: json['interests'],
      languages: json['languages'],
      specialties: json['specialties'],
      resume: json['resume'],
      rating: json['rating'],
      isNative: json['isNative'],
      youtubeVideoId: json['youtubeVideoId'],
      price: json['price'],
      isOnline: json['isOnline'],
    );
  }
}
