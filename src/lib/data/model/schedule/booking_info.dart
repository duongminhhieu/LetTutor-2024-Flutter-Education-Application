class BookingInfo {
  int? createdAtTimeStamp;
  int? updatedAtTimeStamp;
  String? id;
  String? userId;
  String? scheduleDetailId;
  String? tutorMeetingLink;
  String? studentMeetingLink;
  String? googleMeetLink;
  String? studentRequest;
  String? tutorReview;
  int? scoreByTutor;
  String? createdAt;
  String? updatedAt;
  String? recordUrl;
  String? cancelReasonId;
  String? lessonPlanId;
  String? cancelNote;
  String? calendarId;
  bool? isDeleted;
  bool? isTrial;
  int? convertedLesson;

  BookingInfo({
     this.createdAtTimeStamp,
     this.updatedAtTimeStamp,
     this.id,
     this.userId,
     this.scheduleDetailId,
     this.tutorMeetingLink,
     this.studentMeetingLink,
    this.googleMeetLink,
    this.studentRequest,
    this.tutorReview,
    this.scoreByTutor,
     this.createdAt,
     this.updatedAt,
    this.recordUrl,
    this.cancelReasonId,
    this.lessonPlanId,
    this.cancelNote,
    this.calendarId,
     this.isDeleted,
     this.isTrial,
     this.convertedLesson,
  });

  factory BookingInfo.fromJson(Map<String, dynamic> json) {
    return BookingInfo(
      createdAtTimeStamp: json['createdAtTimeStamp'],
      updatedAtTimeStamp: json['updatedAtTimeStamp'],
      id: json['id'],
      userId: json['userId'],
      scheduleDetailId: json['scheduleDetailId'],
      tutorMeetingLink: json['tutorMeetingLink'],
      studentMeetingLink: json['studentMeetingLink'],
      googleMeetLink: json['googleMeetLink'],
      studentRequest: json['studentRequest'],
      tutorReview: json['tutorReview'],
      scoreByTutor: json['scoreByTutor'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      recordUrl: json['recordUrl'],
      cancelReasonId: json['cancelReasonId'],
      lessonPlanId: json['lessonPlanId'],
      cancelNote: json['cancelNote'],
      calendarId: json['calendarId'],
      isDeleted: json['isDeleted'],
      isTrial: json['isTrial'],
      convertedLesson: json['convertedLesson'],
    );
  }
}