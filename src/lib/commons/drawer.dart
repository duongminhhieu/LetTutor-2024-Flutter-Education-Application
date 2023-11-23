import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/loginPage/login_page.dart';
import '../providers/user_provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        children: [
          ListTile(
            title: Container(
              child: Consumer<UserProvider>(

                builder: (BuildContext context, UserProvider userProvider, Widget? child) {
                  return Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: 45,
                        height: 45,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image.network(userProvider.userData?.user!.avatar ?? "https://yt3.googleusercontent.com/mm2-5anuZ6ghmK2zL6QM7wciD6kuupOfOagiAh5vZE1hx9tRhKEXTAExZUUY4PVq2RSw9jBpBQ=s900-c-k-c0x00ffffff-no-rj",
                            fit: BoxFit.cover,),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        userProvider.userData?.user!.name ?? "Anonymous",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  );
                },
              ),
            ),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profilePage');
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
                  Icon(
                    Icons.school, size: 36, color: Colors.blue,),
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
              Navigator.pushNamed(context, "/coursesPage");
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
              userProvider.logout();
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));            },
          ),
        ],
      ),
    );
  }
}
