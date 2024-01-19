import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';
import 'package:src/commons/appBar.dart';
import 'package:src/commons/drawer.dart';
import 'package:src/pages/coursesPage/components/courses-main-info_component.dart';
import 'package:src/pages/coursesPage/components/list-courses_component.dart';

import '../../providers/auth_provider.dart';
import '../../providers/courses_provider.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> with TickerProviderStateMixin {
  // loading
  bool _isLoadingPagination = false;

  // Tab controller
  late TabController _tabController;
  
  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 3, initialIndex: 0, vsync: this);
    refreshHomePage();
    super.initState();
  }

  // refresh
  Future<void> refreshHomePage() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var courseProvider = Provider.of<CoursesProvider>(context, listen: false);

    await Future.wait([
      courseProvider.callApiGetCourses(
          1,
          null,
          null,
          null,
          null,
          null,
          authProvider,
          (error) => {
                // show message error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(error),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 2),
                  ),
                )
              })
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CoursesProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: CustomDrawer(),
      appBar: CustomAppBar(),
      body: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20),
        child: ListView(
          children: [
            SizedBox(height: 16),
            CoursesMainInfoComponent(),
            SizedBox(height: 16),
            TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black38,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              controller: _tabController,
              onTap: (index) {
                // switch case
                switch (index) {
                  case 0:
                    courseProvider.callApiGetCourses(
                        1,
                        null,
                        null,
                        null,
                        null,
                        null,
                        authProvider,
                        (error) => {
                              // show message error
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(error),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  duration: Duration(seconds: 2),
                                ),
                              )
                            });
                    break;
                  case 1:
                    courseProvider.callApiGetEbook(
                        1,
                        null,
                        null,
                        null,
                        null,
                        null,
                        authProvider,
                        (error) => {
                              // show message error
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(error),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  duration: Duration(seconds: 2),
                                ),
                              )
                            });
                    break;
                  case 2:
                    courseProvider.callApiGetInteractiveBook(
                        1,
                        null,
                        null,
                        null,
                        null,
                        null,
                        authProvider,
                        (error) => {
                              // show message error
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(error),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  duration: Duration(seconds: 2),
                                ),
                              )
                            });
                    break;
                }
              },
              tabs: [
                Tab(text: 'Course'),
                Tab(text: 'E-Book'),
                Tab(text: 'Interactive book'),
              ],
            ),
            SizedBox(height: 16),
            _isLoadingPagination
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                :
            ListCoursesComponent(),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: NumberPaginator(
                  numberPages: courseProvider.totalPage,
                  initialPage: courseProvider.currentPage - 1,
                  onPageChange: (int index) {
                    setState(() {
                      _isLoadingPagination = true;
                    });

                    switch (_tabController.index) {
                      case 0:
                        courseProvider
                            .callApiGetCourses(
                                index + 1,
                                null,
                                null,
                                null,
                                null,
                                null,
                                authProvider,
                                (error) => {
                                      // show message error
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(error),
                                          backgroundColor: Colors.red,
                                          behavior: SnackBarBehavior.floating,
                                          duration: Duration(seconds: 2),
                                        ),
                                      )
                                    })
                            .whenComplete(
                              () => setState(() {
                                _isLoadingPagination = false;
                              }),
                            );
                        break;
                      case 1:
                        courseProvider
                            .callApiGetEbook(
                                index + 1,
                                null,
                                null,
                                null,
                                null,
                                null,
                                authProvider,
                                (error) => {
                                      // show message error
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(error),
                                          backgroundColor: Colors.red,
                                          behavior: SnackBarBehavior.floating,
                                          duration: Duration(seconds: 2),
                                        ),
                                      )
                                    })
                            .whenComplete(
                              () => setState(() {
                                _isLoadingPagination = false;
                              }),
                            );
                        break;
                      case 2:
                        courseProvider
                            .callApiGetInteractiveBook(
                                index + 1,
                                null,
                                null,
                                null,
                                null,
                                null,
                                authProvider,
                                (error) => {
                                      // show message error
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(error),
                                          backgroundColor: Colors.red,
                                          behavior: SnackBarBehavior.floating,
                                          duration: Duration(seconds: 2),
                                        ),
                                      )
                                    })
                            .whenComplete(
                              () => setState(() {
                                _isLoadingPagination = false;
                              }),
                            );
                        break;
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
