import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Say Hello to your English tutors'**
  String get title;

  /// No description provided for @descriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Become fluent faster through one on one video chat lessons tailored to your goals.'**
  String get descriptionTitle;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @hintPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get hintPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get orContinueWith;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @upComingLesson.
  ///
  /// In en, this message translates to:
  /// **'Upcoming lesson'**
  String get upComingLesson;

  /// No description provided for @meetingIsReady.
  ///
  /// In en, this message translates to:
  /// **'Meeting is ready...'**
  String get meetingIsReady;

  /// No description provided for @noUpComingLesson.
  ///
  /// In en, this message translates to:
  /// **'You have no upcoming lesson'**
  String get noUpComingLesson;

  /// No description provided for @totalLessonTime.
  ///
  /// In en, this message translates to:
  /// **'Total lesson time is '**
  String get totalLessonTime;

  /// No description provided for @findATutor.
  ///
  /// In en, this message translates to:
  /// **'Find a tutor'**
  String get findATutor;

  /// No description provided for @enterTutorName.
  ///
  /// In en, this message translates to:
  /// **'Enter tutor name...'**
  String get enterTutorName;

  /// No description provided for @selectAvailableTime.
  ///
  /// In en, this message translates to:
  /// **'Select available tutoring time:'**
  String get selectAvailableTime;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get selectDate;

  /// No description provided for @selectTutorNationality.
  ///
  /// In en, this message translates to:
  /// **'Select tutor nationality'**
  String get selectTutorNationality;

  /// No description provided for @recommendTutors.
  ///
  /// In en, this message translates to:
  /// **'Recommend tutors'**
  String get recommendTutors;

  /// No description provided for @book.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get book;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @course.
  ///
  /// In en, this message translates to:
  /// **'Course'**
  String get course;

  /// No description provided for @study.
  ///
  /// In en, this message translates to:
  /// **'Study'**
  String get study;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @joinMeeting.
  ///
  /// In en, this message translates to:
  /// **'Join Meeting'**
  String get joinMeeting;

  /// No description provided for @tutorDetails.
  ///
  /// In en, this message translates to:
  /// **'Tutor Details'**
  String get tutorDetails;

  /// No description provided for @showMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get showMore;

  /// No description provided for @showLess.
  ///
  /// In en, this message translates to:
  /// **'Less'**
  String get showLess;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @languages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languages;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @specialities.
  ///
  /// In en, this message translates to:
  /// **'Specialities'**
  String get specialities;

  /// No description provided for @interests.
  ///
  /// In en, this message translates to:
  /// **'Interests'**
  String get interests;

  /// No description provided for @teachingExperience.
  ///
  /// In en, this message translates to:
  /// **'Teaching experience'**
  String get teachingExperience;

  /// No description provided for @enterLessonRoom.
  ///
  /// In en, this message translates to:
  /// **'Enter lesson room'**
  String get enterLessonRoom;

  /// No description provided for @started.
  ///
  /// In en, this message translates to:
  /// **'Started'**
  String get started;

  /// No description provided for @unFavoriteMessage.
  ///
  /// In en, this message translates to:
  /// **'Unfavored tutor successfully!'**
  String get unFavoriteMessage;

  /// No description provided for @favoriteMessage.
  ///
  /// In en, this message translates to:
  /// **'Favored tutor successfully!'**
  String get favoriteMessage;

  /// No description provided for @latestBook.
  ///
  /// In en, this message translates to:
  /// **'Latest Book'**
  String get latestBook;

  /// No description provided for @requestForTutorial.
  ///
  /// In en, this message translates to:
  /// **'Your requests for the tutor'**
  String get requestForTutorial;

  /// No description provided for @requestForLesson.
  ///
  /// In en, this message translates to:
  /// **'Request for lesson'**
  String get requestForLesson;

  /// No description provided for @editRequest.
  ///
  /// In en, this message translates to:
  /// **'Edit request'**
  String get editRequest;

  /// No description provided for @studentRequestEmpty.
  ///
  /// In en, this message translates to:
  /// **'Currently there are no requests for this class. Please write down any requests for the teacher.'**
  String get studentRequestEmpty;

  /// No description provided for @reasonCancelBooking.
  ///
  /// In en, this message translates to:
  /// **'What was the reason you cancel this booking?'**
  String get reasonCancelBooking;

  /// No description provided for @cancelLessonNotAllow.
  ///
  /// In en, this message translates to:
  /// **'You can only cancel the lesson before 2 hours'**
  String get cancelLessonNotAllow;

  /// No description provided for @lessonTime.
  ///
  /// In en, this message translates to:
  /// **'Lesson Time'**
  String get lessonTime;

  /// No description provided for @specialRequest.
  ///
  /// In en, this message translates to:
  /// **'Special Request'**
  String get specialRequest;

  /// No description provided for @chooseYourBirthday.
  ///
  /// In en, this message translates to:
  /// **'Choose your birthday'**
  String get chooseYourBirthday;

  /// No description provided for @capturePhoto.
  ///
  /// In en, this message translates to:
  /// **'Capture Photo'**
  String get capturePhoto;

  /// No description provided for @selectFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get selectFromGallery;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @otherReviewYou.
  ///
  /// In en, this message translates to:
  /// **'Others review you'**
  String get otherReviewYou;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @enterYourName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterYourName;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @enterYourPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterYourPhoneNumber;

  /// No description provided for @updateAvatarSuccess.
  ///
  /// In en, this message translates to:
  /// **'Update avatar successfully!'**
  String get updateAvatarSuccess;

  /// No description provided for @updateProfileSuccess.
  ///
  /// In en, this message translates to:
  /// **'Update profile successfully!'**
  String get updateProfileSuccess;

  /// No description provided for @updateAvatarFail.
  ///
  /// In en, this message translates to:
  /// **'Update avatar failed!'**
  String get updateAvatarFail;

  /// No description provided for @updateProfileFail.
  ///
  /// In en, this message translates to:
  /// **'Update profile failed!'**
  String get updateProfileFail;

  /// No description provided for @tapToChangeProfile.
  ///
  /// In en, this message translates to:
  /// **'Tap to change your profile'**
  String get tapToChangeProfile;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// No description provided for @manageWallet.
  ///
  /// In en, this message translates to:
  /// **'Manage your Wallet'**
  String get manageWallet;

  /// No description provided for @howToBecomeTutor.
  ///
  /// In en, this message translates to:
  /// **'How to become a tutor'**
  String get howToBecomeTutor;

  /// No description provided for @learnAbout.
  ///
  /// In en, this message translates to:
  /// **'Learn more about LetTutor App'**
  String get learnAbout;

  /// No description provided for @logoutDes.
  ///
  /// In en, this message translates to:
  /// **'Log out LetTutor App'**
  String get logoutDes;

  /// No description provided for @discoverCourse.
  ///
  /// In en, this message translates to:
  /// **'Discover Course'**
  String get discoverCourse;

  /// No description provided for @discoverCourseSubTitle.
  ///
  /// In en, this message translates to:
  /// **'LiveTutor has built the most quality, methodical and scientific courses in the fields of life for those who are in need of improving their knowledge of the fields.'**
  String get discoverCourseSubTitle;

  /// No description provided for @interactiveBook.
  ///
  /// In en, this message translates to:
  /// **'Interactive Book'**
  String get interactiveBook;

  /// No description provided for @lessonDetail.
  ///
  /// In en, this message translates to:
  /// **'Lesson Detail'**
  String get lessonDetail;

  /// No description provided for @addRating.
  ///
  /// In en, this message translates to:
  /// **'Add Rating'**
  String get addRating;

  /// No description provided for @whatIsYourRating.
  ///
  /// In en, this message translates to:
  /// **'What is your rating for '**
  String get whatIsYourRating;

  /// No description provided for @contentReview.
  ///
  /// In en, this message translates to:
  /// **'Content Review'**
  String get contentReview;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @historySubTitle.
  ///
  /// In en, this message translates to:
  /// **'The following is a list of lessons you have attended. You can review the details of the lessons you have attended'**
  String get historySubTitle;

  /// No description provided for @bookingTime.
  ///
  /// In en, this message translates to:
  /// **'Booking Time'**
  String get bookingTime;

  /// No description provided for @bookThisTutor.
  ///
  /// In en, this message translates to:
  /// **'Book this tutor'**
  String get bookThisTutor;

  /// No description provided for @bookingDetails.
  ///
  /// In en, this message translates to:
  /// **'Booking Details'**
  String get bookingDetails;

  /// No description provided for @bookingCanOnlyMade.
  ///
  /// In en, this message translates to:
  /// **'Bookings can only be made within the last 7 days.'**
  String get bookingCanOnlyMade;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @priceLesson.
  ///
  /// In en, this message translates to:
  /// **'Price: 1 lesson'**
  String get priceLesson;

  /// No description provided for @haveLessonLess.
  ///
  /// In en, this message translates to:
  /// **'You have 1 lesson left'**
  String get haveLessonLess;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @leaveANote.
  ///
  /// In en, this message translates to:
  /// **'Leave a note for your tutor'**
  String get leaveANote;

  /// No description provided for @helpUs.
  ///
  /// In en, this message translates to:
  /// **'Help us know what\'s happening'**
  String get helpUs;

  /// No description provided for @tutorPretend.
  ///
  /// In en, this message translates to:
  /// **'This tutor is pretending to be someone else'**
  String get tutorPretend;

  /// No description provided for @tutorShady.
  ///
  /// In en, this message translates to:
  /// **'This tutor\'s profile information is incorrect, shady'**
  String get tutorShady;

  /// No description provided for @tutorHarassing.
  ///
  /// In en, this message translates to:
  /// **'This tutor is harassing me'**
  String get tutorHarassing;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @sendReport.
  ///
  /// In en, this message translates to:
  /// **'Send report'**
  String get sendReport;

  /// No description provided for @mySchedule.
  ///
  /// In en, this message translates to:
  /// **'My schedule'**
  String get mySchedule;

  /// No description provided for @lessonDate.
  ///
  /// In en, this message translates to:
  /// **'Lesson date'**
  String get lessonDate;

  /// No description provided for @startTime.
  ///
  /// In en, this message translates to:
  /// **'Start time'**
  String get startTime;

  /// No description provided for @endTime.
  ///
  /// In en, this message translates to:
  /// **'End time'**
  String get endTime;

  /// No description provided for @goToMeeting.
  ///
  /// In en, this message translates to:
  /// **'Go to meeting'**
  String get goToMeeting;

  /// No description provided for @hereIsAList.
  ///
  /// In en, this message translates to:
  /// **'Here is a list of booked lessons. You can track when will the lesson starts, join the meeting or cancel before 2 hours'**
  String get hereIsAList;

  /// No description provided for @wentWrong.
  ///
  /// In en, this message translates to:
  /// **'Oops, something went wrong'**
  String get wentWrong;

  /// No description provided for @analysis.
  ///
  /// In en, this message translates to:
  /// **'Analysis'**
  String get analysis;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @sendNote.
  ///
  /// In en, this message translates to:
  /// **'Send note'**
  String get sendNote;

  /// No description provided for @learningHistory.
  ///
  /// In en, this message translates to:
  /// **'Learning History'**
  String get learningHistory;

  /// No description provided for @last1Month.
  ///
  /// In en, this message translates to:
  /// **'Last 1 month'**
  String get last1Month;

  /// No description provided for @last3Month.
  ///
  /// In en, this message translates to:
  /// **'Last 3 month'**
  String get last3Month;

  /// No description provided for @last6Month.
  ///
  /// In en, this message translates to:
  /// **'Last 6 month'**
  String get last6Month;

  /// No description provided for @selectAFilter.
  ///
  /// In en, this message translates to:
  /// **'Select displaying mode'**
  String get selectAFilter;

  /// No description provided for @hasNoReview.
  ///
  /// In en, this message translates to:
  /// **'This lesson has no review from tutor.'**
  String get hasNoReview;

  /// No description provided for @addAReview.
  ///
  /// In en, this message translates to:
  /// **'Add a review'**
  String get addAReview;

  /// No description provided for @createReview.
  ///
  /// In en, this message translates to:
  /// **'Create review'**
  String get createReview;

  /// No description provided for @tellUsHow.
  ///
  /// In en, this message translates to:
  /// **'Tell us how was the lesson...'**
  String get tellUsHow;

  /// No description provided for @rate.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get rate;

  /// No description provided for @rateAfterLesson.
  ///
  /// In en, this message translates to:
  /// **'after the lesson with him/her on'**
  String get rateAfterLesson;

  /// No description provided for @sendReview.
  ///
  /// In en, this message translates to:
  /// **'Send review'**
  String get sendReview;

  /// No description provided for @cancelLesson.
  ///
  /// In en, this message translates to:
  /// **'Cancel lesson'**
  String get cancelLesson;

  /// No description provided for @doYouWantToCancel.
  ///
  /// In en, this message translates to:
  /// **'Do you want to cancel this lesson?'**
  String get doYouWantToCancel;

  /// No description provided for @leaveReasonWhyCancel.
  ///
  /// In en, this message translates to:
  /// **'Leave the reason why you cancel this lesson...'**
  String get leaveReasonWhyCancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @tutor.
  ///
  /// In en, this message translates to:
  /// **'Tutor'**
  String get tutor;

  /// No description provided for @tutorDescription.
  ///
  /// In en, this message translates to:
  /// **'Find a tutor for a one-on-one lesson'**
  String get tutorDescription;

  /// No description provided for @courseDescription.
  ///
  /// In en, this message translates to:
  /// **'Or exploring yourself with our library of lessons and ebooks'**
  String get courseDescription;

  /// No description provided for @onlineTutors.
  ///
  /// In en, this message translates to:
  /// **'Online Tutors'**
  String get onlineTutors;

  /// No description provided for @selectASpeciality.
  ///
  /// In en, this message translates to:
  /// **'Select a speciality'**
  String get selectASpeciality;

  /// No description provided for @selectNationality.
  ///
  /// In en, this message translates to:
  /// **'Select nationality'**
  String get selectNationality;

  /// No description provided for @selectOrigin.
  ///
  /// In en, this message translates to:
  /// **'Select origin'**
  String get selectOrigin;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @onlineCourses.
  ///
  /// In en, this message translates to:
  /// **'Online Courses'**
  String get onlineCourses;

  /// No description provided for @inputCourseName.
  ///
  /// In en, this message translates to:
  /// **'Input course name...'**
  String get inputCourseName;

  /// No description provided for @allCourses.
  ///
  /// In en, this message translates to:
  /// **'All courses'**
  String get allCourses;

  /// No description provided for @ebook.
  ///
  /// In en, this message translates to:
  /// **'Ebook'**
  String get ebook;

  /// No description provided for @level.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get level;

  /// No description provided for @lessons.
  ///
  /// In en, this message translates to:
  /// **'Lessons '**
  String get lessons;

  /// No description provided for @courseDetail.
  ///
  /// In en, this message translates to:
  /// **'Course Details'**
  String get courseDetail;

  /// No description provided for @discover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get discover;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @whyTakeThisCourse.
  ///
  /// In en, this message translates to:
  /// **'Why take this course'**
  String get whyTakeThisCourse;

  /// No description provided for @whatAbleToDo.
  ///
  /// In en, this message translates to:
  /// **'What will you be able to do'**
  String get whatAbleToDo;

  /// No description provided for @experienceLevel.
  ///
  /// In en, this message translates to:
  /// **'Experience Level'**
  String get experienceLevel;

  /// No description provided for @courseLength.
  ///
  /// In en, this message translates to:
  /// **'Course Length'**
  String get courseLength;

  /// No description provided for @topics.
  ///
  /// In en, this message translates to:
  /// **'Topics'**
  String get topics;

  /// No description provided for @listOfTopic.
  ///
  /// In en, this message translates to:
  /// **'List of Topic'**
  String get listOfTopic;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @myWallet.
  ///
  /// In en, this message translates to:
  /// **'My wallet'**
  String get myWallet;

  /// No description provided for @becomeATutor.
  ///
  /// In en, this message translates to:
  /// **'Become a tutor'**
  String get becomeATutor;

  /// No description provided for @application.
  ///
  /// In en, this message translates to:
  /// **'Application'**
  String get application;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme '**
  String get themeMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @applicationInfo.
  ///
  /// In en, this message translates to:
  /// **'Application information'**
  String get applicationInfo;

  /// No description provided for @privacyPolicies.
  ///
  /// In en, this message translates to:
  /// **'Privacy policies'**
  String get privacyPolicies;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & conditions'**
  String get termsAndConditions;

  /// No description provided for @contactForSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact for support'**
  String get contactForSupport;

  /// No description provided for @receiveInAppNoti.
  ///
  /// In en, this message translates to:
  /// **'Receive in-app notification'**
  String get receiveInAppNoti;

  /// No description provided for @receiveEmail.
  ///
  /// In en, this message translates to:
  /// **'Receive email'**
  String get receiveEmail;

  /// No description provided for @receiveSMSText.
  ///
  /// In en, this message translates to:
  /// **'Receive SMS text'**
  String get receiveSMSText;

  /// No description provided for @vietnamese.
  ///
  /// In en, this message translates to:
  /// **'Vietnamese'**
  String get vietnamese;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light mode'**
  String get lightMode;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @forFurtherInfo.
  ///
  /// In en, this message translates to:
  /// **'For further info, please visit our detailed'**
  String get forFurtherInfo;

  /// No description provided for @officialPage.
  ///
  /// In en, this message translates to:
  /// **'Official page'**
  String get officialPage;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @doYouWantLogout.
  ///
  /// In en, this message translates to:
  /// **'Do you want to log out?'**
  String get doYouWantLogout;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @editAccount.
  ///
  /// In en, this message translates to:
  /// **'Edit Account'**
  String get editAccount;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @nationality.
  ///
  /// In en, this message translates to:
  /// **'Nationality'**
  String get nationality;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @birthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get birthday;

  /// No description provided for @myLevel.
  ///
  /// In en, this message translates to:
  /// **'My level'**
  String get myLevel;

  /// No description provided for @wantToLearn.
  ///
  /// In en, this message translates to:
  /// **'Want to learn'**
  String get wantToLearn;

  /// No description provided for @studySchedule.
  ///
  /// In en, this message translates to:
  /// **'Study schedule'**
  String get studySchedule;

  /// No description provided for @noteTheTime.
  ///
  /// In en, this message translates to:
  /// **'Note the time of week you want to study/teach'**
  String get noteTheTime;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @typeYourMsg.
  ///
  /// In en, this message translates to:
  /// **'Type your message here'**
  String get typeYourMsg;

  /// No description provided for @appointment.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get appointment;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @confirmBooking.
  ///
  /// In en, this message translates to:
  /// **'Confirm booking'**
  String get confirmBooking;

  /// No description provided for @noUpcomingLesson.
  ///
  /// In en, this message translates to:
  /// **'You have no upcoming lesson'**
  String get noUpcomingLesson;

  /// No description provided for @noAvailableSchedule.
  ///
  /// In en, this message translates to:
  /// **'No available schedule'**
  String get noAvailableSchedule;

  /// No description provided for @eWalletNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'E-wallet is not supported in this version, please access to our website for more info'**
  String get eWalletNotAvailable;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
