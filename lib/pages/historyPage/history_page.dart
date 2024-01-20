import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';
import 'package:src/pages/historyPage/components/info-page_component.dart';
import 'package:src/pages/historyPage/components/list-card-history_component.dart';

import '../../commons/appBar.dart';
import '../../commons/drawer.dart';
import '../../providers/auth_provider.dart';
import '../../providers/schedule_provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  //Fetch API
  bool _hasFetched = false;
  bool _isLoadingPagination = false;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    var authProvider = Provider.of<AuthProvider>(context);
    var scheduleProvider = Provider.of<ScheduleProvider>(context);

    // Fetch API
    if (!_hasFetched) {
      setState(() {
        _isLoadingPagination = true; // Set loading indicator to true
      });
      await Future.wait([
        scheduleProvider.callApiGetHistorySchedules(
            1,
            authProvider,
            (error) => {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 2),
                    ),
                  )
                })
      ]).whenComplete(() {
        if (mounted) {
          setState(() {
            _hasFetched = true;
            _isLoadingPagination = false;
          });
        }
      });
    }
  }

  Future<void> refreshHomePage() async {
    ScheduleProvider scheduleProvider = context.read<ScheduleProvider>();
    AuthProvider authProvider = context.read<AuthProvider>();

    setState(() {
      _isLoadingPagination = true;
    });
    scheduleProvider.historyList = [];
    await Future.wait([
      scheduleProvider.callApiGetHistorySchedules(
          1,
          authProvider,
          (error) => {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(error),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 2),
                  ),
                )
              })
    ]).whenComplete(() {
      if (mounted) {
        setState(() {
          _isLoadingPagination = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheduleProvider = Provider.of<ScheduleProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);


    return Scaffold(
        backgroundColor: Colors.white,
        endDrawer: CustomDrawer(),
        appBar: CustomAppBar(),
        body: RefreshIndicator(
          onRefresh: refreshHomePage,
          child: Container(
            padding: EdgeInsets.only(left: 20.0, right: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InfoPageHistoryComponent(),
                  SizedBox(height: 32),
                  !_isLoadingPagination
                      ? ListCardHistoryComponent()
                      : SizedBox(
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16),
                    child: NumberPaginator(
                        numberPages: scheduleProvider.totalPageHistory,
                        onPageChange: (int index) {
                          setState(() {
                            _isLoadingPagination = true;
                          });
                          scheduleProvider.callApiGetHistorySchedules(
                              index + 1,
                              authProvider,
                              (error) => {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(error),
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                        duration: Duration(seconds: 2),
                                      ),
                                    )
                                  }).whenComplete(() => setState(() {
                                  _isLoadingPagination = false;
                                }), );

                        }),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
