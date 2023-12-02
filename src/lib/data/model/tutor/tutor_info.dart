class TutorInfo {
  final String? level;
  final String? email;
  final String? google;
  final String? facebook;
  final String? apple;
  final String? avatar;
  final String? name;
  final String? country;
  final String? phone;
  final String? language;
  final String? birthday;
  final bool? requestPassword;
  final bool? isActivated;
  final bool? isPhoneActivated;
  final String? requireNote;
  final int? timezone;
  final String? phoneAuth;
  final bool? isPhoneAuthActivated;
  final String? studySchedule;
  final bool? canSendMessage;
  final bool? isPublicRecord;
  final String? caredByStaffId;
  final String? zaloUserId;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final String? studentGroupId;

  TutorInfo({
     this.level,
     this.email,
     this.google,
     this.facebook,
     this.apple,
     this.avatar,
     this.name,
     this.country,
     this.phone,
     this.language,
     this.birthday,
     this.requestPassword,
     this.isActivated,
     this.isPhoneActivated,
     this.requireNote,
     this.timezone,
     this.phoneAuth,
     this.isPhoneAuthActivated,
     this.studySchedule,
     this.canSendMessage,
     this.isPublicRecord,
     this.caredByStaffId,
     this.zaloUserId,
     this.createdAt,
     this.updatedAt,
     this.deletedAt,
     this.studentGroupId,
  });

  factory TutorInfo.fromJson(Map<String, dynamic> json) {
    return TutorInfo(
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
    );
  }
}
