import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:src/pages/listTeacherPage/components/banner_component.dart';
import 'package:src/pages/listTeacherPage/components/filter_component.dart';
import 'package:src/pages/listTeacherPage/components/listTeacher_component.dart';

class ListTeacherPage extends StatefulWidget {
  const ListTeacherPage({Key? key}) : super(key: key);

  @override
  State<ListTeacherPage> createState() => _ListTeacherPageState();
}

class _ListTeacherPageState extends State<ListTeacherPage> {
  late Color myColor;
  late Size mediaSize;

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          children: [
            ListTile(
              title: Container(
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 45,
                      height: 45,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.asset('lib/images/loginImage.png'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      "Hieu Duong",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              onTap: () {
                // Update the state of the app
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title:  Container(
                child: const Row(
                  children: [
                    Icon(Icons.calendar_month_rounded, size: 36, color: Colors.blue,),
                    SizedBox(width: 12),
                    Text(
                      "Recurring Lesson Schedule",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              onTap: () {
                // Update the state of the app
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title:  Container(
                child: const Row(
                  children: [
                    Icon(Icons.co_present, size: 36, color: Colors.blue,),
                    SizedBox(width: 12),
                    Text(
                      "Tutor",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              onTap: () {
                // Update the state of the app
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title:  Container(
                child: const Row(
                  children: [
                    Icon(Icons.calendar_today_rounded, size: 36, color: Colors.blue,),
                    SizedBox(width: 12),
                    Text(
                      "Schedule",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              onTap: () {

                // Then close the drawer
                Navigator.pushNamed(context, '/schedulePage');
              },
            ),
            ListTile(
              title:  Container(
                child: const Row(
                  children: [
                    Icon(Icons.history, size: 40, color: Colors.blue,),
                    SizedBox(width: 12),
                    Text(
                      "History",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              onTap: () {
                // Update the state of the app
                // Then close the drawer
                Navigator.pushNamed(context, '/historyPage');
              },
            ),
            ListTile(
              title:  Container(
                child: const Row(
                  children: [
                    Icon(Icons.add_card_rounded, size: 36, color: Colors.blue,),
                    SizedBox(width: 12),
                    Text(
                      "Courses",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              onTap: () {
                // Update the state of the app
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title:  Container(
                child: const Row(
                  children: [
                    Icon(Icons.co_present_rounded, size: 36, color: Colors.blue,),
                    SizedBox(width: 12),
                    Text(
                      "My course",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              onTap: () {
                // Update the state of the app
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title:  Container(
                child: const Row(
                  children: [
                    Icon(Icons.people_alt, size: 36, color: Colors.blue,),
                    SizedBox(width: 12),
                    Text(
                      "Become a tutor",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              onTap: () {
                // Update the state of the app
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title:  Container(
                child: const Row(
                  children: [
                    Icon(Icons.logout, size: 36, color: Colors.blue,),
                    SizedBox(width: 12),
                    Text(
                      "Log out",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              onTap: () {
                // Update the state of the app
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: SvgPicture.asset('lib/images/lettutor_logo.svg',
            semanticsLabel: "My SVG", height: 36),
        actions: [
          MaterialButton(
            onPressed: () {},
            minWidth: 20,
            color: Colors.grey.shade300,
            textColor: Colors.white,
            padding: const EdgeInsets.all(6),
            shape: const CircleBorder(),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(10), // Adjust the radius as needed
              child: SvgPicture.asset('lib/images/vietnam.svg',
                  semanticsLabel: "My SVG", height: 18),
            ),
          ),
          Container(
            child: IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.grey,
              ),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      body: ListView(children: [
        BannerComponent(myColor: myColor),
        const FilterComponent(),
        Container(
          padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
          child: const Divider(
            height: 20,
            color: Color.fromRGBO(238, 238, 238, 60),
            thickness: 1,
          ),
        ),
        const ListTeacherComponent()
      ]),
    );
  }
}
