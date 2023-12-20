import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/commons/appBar.dart';
import 'package:src/commons/drawer.dart';
import 'package:src/commons/loading.dart';
import 'package:src/pages/listTeacherPage/components/banner_component.dart';
import 'package:src/pages/listTeacherPage/components/filter_component.dart';
import 'package:src/pages/listTeacherPage/components/listTeacher_component.dart';
import 'package:src/providers/booking_provider.dart';
import 'package:src/providers/schedule_provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/tutor_provider.dart';

class ListTeacherPage extends StatefulWidget {
  const ListTeacherPage({Key? key}) : super(key: key);

  @override
  State<ListTeacherPage> createState() => _ListTeacherPageState();
}

class _ListTeacherPageState extends State<ListTeacherPage> {
  late Color myColor;
  late Size mediaSize;
  //Fetch API
  bool _hasFetched = false;
  bool _isLoading = true;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    var authProvider = Provider.of<AuthProvider>(context);
    var tutorProvider = Provider.of<TutorProvider>(context);
    var bookingProvider = Provider.of<BookingProvider>(context);

    // Fetch API
    if (!_hasFetched) {
      await Future.wait([
        tutorProvider.callAPIGetTutorList(1, authProvider),
        bookingProvider.callApiGetListBooked(authProvider)
      ]).whenComplete(() {
        // Use addPostFrameCallback to ensure that the widget tree is built
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          if (tutorProvider.errorMessage != null || bookingProvider.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(tutorProvider.errorMessage ?? bookingProvider.errorMessage ?? ""),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 2),
              ),
            );
          }
        });

        if (mounted) {
          setState(() {
            _hasFetched = true;
            _isLoading = false;
          });
        }
      });
    }
  }


  Future<void> refreshHomePage() async {
    TutorProvider tutorProvider = context.read<TutorProvider>();
    BookingProvider bookingProvider = context.read<BookingProvider>();
    AuthProvider authProvider = context.read<AuthProvider>();

    setState(() {
      tutorProvider.tutors = [];
      bookingProvider.lessonList = [];
      tutorProvider.favTutorSecondId = [];
      _isLoading = true;
    });
    await Future.wait([
      tutorProvider.callAPIGetTutorList(1, authProvider),
      bookingProvider.callApiGetListBooked(authProvider)
    ]).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
      return Future<void>.delayed(const Duration(seconds: 0));
    });
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    return _isLoading
        ? const LoadingFilled()
        : Scaffold(
            backgroundColor: Colors.white,
            endDrawer: CustomDrawer(),
            appBar: CustomAppBar(),
            body: RefreshIndicator(
              onRefresh: refreshHomePage,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BannerComponent(myColor: myColor,),
                    FilterComponent(),
                    Container(
                      padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
                      child: const Divider(
                        height: 20,
                        color: Color.fromRGBO(238, 238, 238, 60),
                        thickness: 1,
                      ),
                    ),
                    ListTeacherComponent(),
                  ],
                ),
              ),
            ),
          );
  }
}
