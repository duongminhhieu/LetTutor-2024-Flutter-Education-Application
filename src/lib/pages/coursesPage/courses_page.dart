import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';
import 'package:src/commons/appBar.dart';
import 'package:src/commons/drawer.dart';
import 'package:src/l10n/app_localizations.dart';
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
    loadDataPage(_tabController.index, 1, null, null, null, null, null);
    super.initState();
  }

  // refresh
  Future<void> loadDataPage(int tabIndex, int page, String? orderBy, String? order, String? search, int? level, String? categoryStr) async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var courseProvider = Provider.of<CoursesProvider>(context, listen: false);

    switch (tabIndex) {
      case 0:
        await courseProvider.callApiGetCourses(
            page,
            orderBy,
            order,
            search,
            level,
            categoryStr,
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
        await courseProvider.callApiGetEbook(
            page,
            orderBy,
            order,
            search,
            level,
            categoryStr,
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
        await courseProvider.callApiGetInteractiveBook(
            page,
            orderBy,
            order,
            search,
            level,
            categoryStr,
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

  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CoursesProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: CustomDrawer(),
      appBar: CustomAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _isLoadingPagination = true;
          });
          _tabController.index = 0;
          loadDataPage(_tabController.index, 1, null, null, null, null, null);
          setState(() {
            _isLoadingPagination = false;
          });
        },
        child: Container(
          padding: EdgeInsets.only(left: 20.0, right: 20),
          child: ListView(
            children: [
              SizedBox(height: 16),
              CoursesMainInfoComponent(onSearch: loadDataPage, tabIndex: _tabController.index),
              SizedBox(height: 16),
              TabBar(
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.black38,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                controller: _tabController,
                onTap: (index) {
                  setState(() {
                    _isLoadingPagination = true;
                  });
                  loadDataPage(_tabController.index, 1, null, null, null, null, null);
                  setState(() {
                    _isLoadingPagination = false;
                  });
                },
                tabs: [
                  Tab(text: AppLocalizations.of(context)!.course),
                  Tab(text: AppLocalizations.of(context)!.ebook),
                  Tab(text: AppLocalizations.of(context)!.interactiveBook),
                ],
              ),
              SizedBox(height: 16),
              _isLoadingPagination
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  :
              ListCoursesComponent(tabIndex: _tabController.index),
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

                      loadDataPage(_tabController.index, index + 1, null, null, null, null, null);

                      setState(() {
                        _isLoadingPagination = false;
                      });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
