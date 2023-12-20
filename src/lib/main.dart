import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/commons/loadingOverlay.dart';
import 'package:src/pages/SettingsPage/setting_page.dart';
import 'package:src/pages/coursesPage/courses_page.dart';
import 'package:src/pages/detailATeacherPage/detail-a-teacher_page.dart';
import 'package:src/pages/detailCoursePage/detail-course_page.dart';
import 'package:src/pages/detailLessonPage/detail-lesson_page.dart';
import 'package:src/pages/forgotPasswordPage/forgot-password_page.dart';
import 'package:src/pages/historyPage/history_page.dart';
import 'package:src/pages/listTeacherPage/list-teacher_page.dart';
import 'package:src/pages/loginPage/login_page.dart';
import 'package:src/pages/profilePage/profile_page.dart';
import 'package:src/pages/schedulePage/schedule_page.dart';
import 'package:src/pages/signUpPage/sign-up_page.dart';
import 'package:src/pages/videoCallPage/video-call_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:src/providers/auth_provider.dart';
import 'package:src/providers/booking_provider.dart';
import 'package:src/providers/schedule_provider.dart';
import 'package:src/providers/tutor_provider.dart';
import 'package:src/providers/user_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => TutorProvider()),
        ChangeNotifierProvider(create: (context) => ScheduleProvider()),
        ChangeNotifierProvider(create: (context) => BookingProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: ListTeacherPage(),
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return authProvider.currentUser != null ? LoadingOverlay(child: BottomNavBar()) : LoadingOverlay(child: LoginPage());
            // return SettingPage();
          },
        ),
        routes: {
          '/bottomNavBar': (context) => BottomNavBar(),
          '/loginPage': (context) => LoadingOverlay(child: LoginPage()),
          '/signUpPage': (context) => LoadingOverlay(child: SignUpPage()),
          '/forgotPasswordPage': (context) => LoadingOverlay(child: ForgotPasswordPage()),
          '/listTeacherPage': (context) => LoadingOverlay(child: ListTeacherPage()),
          '/detailATeacher': (context) => DetailATeacherPage(),
          '/schedulePage': (context) => SchedulePage(),
          '/historyPage': (context) => HistoryPage(),
          '/coursesPage': (context) => CoursesPage(),
          '/detailCoursePage': (context) => DetailCoursePage(),
          '/detailLessonPage': (context) => DetailLessonPage(),
          '/videoCallPage': (context) => VideoCallPage(),
          '/profilePage': (context) => ProfilePage(),
          '/settingPage': (context) => SettingPage(),
        },
        theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: const Color.fromRGBO(0, 113, 240, 1.0)),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _buildScreens() {
      return [ListTeacherPage(), SchedulePage(), HistoryPage(), SettingPage()];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
            icon: Icon(Icons.home),
            title: ("Home"),
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Colors.grey,
            routeAndNavigatorSettings: RouteAndNavigatorSettings(
              initialRoute: "/",
              routes: {
                '/listTeacherPage': (context) => ListTeacherPage(),
                '/detailATeacher': (context) => DetailATeacherPage(),
                '/schedulePage': (context) => SchedulePage(),
                '/historyPage': (context) => HistoryPage(),
                '/coursesPage': (context) => CoursesPage(),
                '/detailCoursePage': (context) => DetailCoursePage(),
                '/detailLessonPage': (context) => DetailLessonPage(),
                '/videoCallPage': (context) => VideoCallPage(),
                '/profilePage': (context) => ProfilePage(),
              },
            )),
        PersistentBottomNavBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            title: ("Schedule"),
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Colors.grey,
            routeAndNavigatorSettings: RouteAndNavigatorSettings(
              initialRoute: "/",
              routes: {
                '/listTeacherPage': (context) => ListTeacherPage(),
                '/detailATeacher': (context) => DetailATeacherPage(),
                '/schedulePage': (context) => SchedulePage(),
                '/historyPage': (context) => HistoryPage(),
                '/coursesPage': (context) => CoursesPage(),
                '/detailCoursePage': (context) => DetailCoursePage(),
                '/detailLessonPage': (context) => DetailLessonPage(),
                '/videoCallPage': (context) => VideoCallPage(),
                '/profilePage': (context) => ProfilePage(),
              },
            )),
        PersistentBottomNavBarItem(
            icon: Icon(Icons.history),
            title: ("History"),
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Colors.grey,
            routeAndNavigatorSettings: RouteAndNavigatorSettings(
              initialRoute: "/",
              routes: {
                '/listTeacherPage': (context) => ListTeacherPage(),
                '/detailATeacher': (context) => DetailATeacherPage(),
                '/schedulePage': (context) => SchedulePage(),
                '/historyPage': (context) => HistoryPage(),
                '/coursesPage': (context) => CoursesPage(),
                '/detailCoursePage': (context) => DetailCoursePage(),
                '/detailLessonPage': (context) => DetailLessonPage(),
                '/videoCallPage': (context) => VideoCallPage(),
                '/profilePage': (context) => ProfilePage(),
              },
            )),
        PersistentBottomNavBarItem(
            icon: Icon(Icons.settings),
            title: ("Settings"),
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Colors.grey,
            routeAndNavigatorSettings: RouteAndNavigatorSettings(
              initialRoute: "/",
              routes: {
                '/listTeacherPage': (context) => ListTeacherPage(),
                '/detailATeacher': (context) => DetailATeacherPage(),
                '/schedulePage': (context) => SchedulePage(),
                '/historyPage': (context) => HistoryPage(),
                '/coursesPage': (context) => CoursesPage(),
                '/detailCoursePage': (context) => DetailCoursePage(),
                '/detailLessonPage': (context) => DetailLessonPage(),
                '/videoCallPage': (context) => VideoCallPage(),
                '/profilePage': (context) => ProfilePage(),
              },
            )),
      ];
    }

    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style3, // Choose the nav bar style with this property.
    );
  }
}
