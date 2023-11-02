import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                      child: Image.asset('lib/assets/images/loginImage.png'),
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
            title: Container(
              child: const Row(
                children: [
                  Icon(Icons.calendar_month_rounded, size: 36,
                    color: Colors.blue,),
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
            title: Container(
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
            title: Container(
              child: const Row(
                children: [
                  Icon(Icons.calendar_today_rounded, size: 36,
                    color: Colors.blue,),
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
              Navigator.pop(context);

              Navigator.pushNamed(context, '/schedulePage');
            },
          ),
          ListTile(
            title: Container(
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
              Navigator.pop(context);
              Navigator.pushNamed(context, '/historyPage');
            },
          ),
          ListTile(
            title: Container(
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
              Navigator.pop(context);
              Navigator.pushNamed(context, '/coursesPage');
            },
          ),
          ListTile(
            title: Container(
              child: const Row(
                children: [
                  Icon(
                    Icons.co_present_rounded, size: 36, color: Colors.blue,),
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
            title: Container(
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
            title: Container(
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
              Navigator.pushNamed(context, "/loginPage");
            },
          ),
        ],
      ),
    );
  }
}
