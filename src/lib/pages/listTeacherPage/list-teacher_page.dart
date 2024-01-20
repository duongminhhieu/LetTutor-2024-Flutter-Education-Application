import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';
import 'package:src/commons/appBar.dart';
import 'package:src/commons/drawer.dart';
import 'package:src/commons/loading.dart';
import 'package:src/pages/listTeacherPage/components/banner_component.dart';
import 'package:src/pages/listTeacherPage/components/filter_component.dart';
import 'package:src/pages/listTeacherPage/components/listTeacher_component.dart';
import 'package:src/providers/booking_provider.dart';

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
  bool _isLoadingPagination = false;


  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    var authProvider = Provider.of<AuthProvider>(context);
    var tutorProvider = Provider.of<TutorProvider>(context);
    var bookingProvider = Provider.of<BookingProvider>(context);

    // Fetch API
    if (!_hasFetched) {
      setState(() {
        _isLoadingPagination = true; // Set loading indicator to true
      });
      await Future.wait([
        tutorProvider.callAPIGetTutorList(1, authProvider),
        bookingProvider.callApiGetListBooked(authProvider)
      ]).whenComplete(() {
        // Use addPostFrameCallback to ensure that the widget tree is built
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          if (tutorProvider.errorMessage != null ||
              bookingProvider.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(tutorProvider.errorMessage ??
                    bookingProvider.errorMessage ??
                    ""),
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
            _isLoadingPagination = false;
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
  
  // call api search
  Future<void> callApiSearch(String searchTutor, List<String> specialities, Map<String, bool> nationality) async {
    TutorProvider tutorProvider = Provider.of<TutorProvider>(context, listen: false);
    AuthProvider authProvider = context.read<AuthProvider>();
    setState(() {
      _isLoadingPagination = true;
    });
    await tutorProvider.callAPISearchTutor(1, searchTutor, specialities, nationality, authProvider, (tutorLst, count) => {

      tutorProvider.tutors = tutorLst,
      tutorProvider.totalPage = (count ?? 0) ~/ tutorProvider.perPage + 1,
      setState(() {
        _isLoadingPagination = false;
      }),

    }, (error) =>
    {
      setState(() {
        _isLoadingPagination = false;

        // show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );

      })
    }).whenComplete(() => setState(() {
        _isLoadingPagination = false;
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    TutorProvider tutorProvider = context.watch<TutorProvider>();
    AuthProvider authProvider = context.watch<AuthProvider>();

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
                    BannerComponent(
                      myColor: myColor,
                    ),
                    FilterComponent( onSearch: callApiSearch,),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 12, left: 16, right: 16),
                      child: const Divider(
                        height: 20,
                        color: Color.fromRGBO(238, 238, 238, 60),
                        thickness: 1,
                      ),
                    ),
                    !_isLoadingPagination
                        ? ListTeacherComponent()
                        : SizedBox(
                            child: const Center(
                                child: CircularProgressIndicator()),
                          ),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(16),
                        child: NumberPaginator(
                          // by default, the paginator shows numbers as center content
                          numberPages: tutorProvider.totalPage,
                          onPageChange: (int index) {
                            setState(() {
                              _isLoadingPagination = true;
                            });
                            tutorProvider
                                .callAPIGetTutorList(index + 1, authProvider)
                                .whenComplete(() {
                              setState(() {
                                _isLoadingPagination = false;
                              });
                            });
                          },
                        ))
                  ],
                ),
              ),
            ),
          );
  }
}
