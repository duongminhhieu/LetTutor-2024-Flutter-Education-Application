import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/pages/schedulePage/components/info-page_component.dart';
import 'package:src/pages/schedulePage/components/latest-book_component.dart';
import 'package:src/pages/schedulePage/components/list-card-schedule_component.dart';

import '../../commons/appBar.dart';
import '../../commons/drawer.dart';
import '../../providers/auth_provider.dart';
import '../../providers/booking_provider.dart';


class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {

  late bool _isLoading = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        endDrawer: CustomDrawer(),
        appBar: CustomAppBar(),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Container(
          padding: EdgeInsets.only(left: 20.0, right: 20),
          child: ListView(
            children:  [
              SizedBox(height: 16),
              InfoPageScheduleComponent(),
              SizedBox(height: 32),
              LatestBookScheduleComponent(),
              SizedBox(height: 32),
              !_isLoading ? ListCardScheduleComponent(refresh: refresh,) : Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      )
    );
  }

  Future<void> refresh() async {
    setState(() {
      _isLoading = true;
    });
    BookingProvider bookingProvider = context.read<BookingProvider>();
    AuthProvider authProvider = context.read<AuthProvider>();

    await Future.wait([
      bookingProvider.callApiGetListBooked(authProvider)
    ]).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
      return Future<void>.delayed(const Duration(seconds: 0));
    });
  }
}
