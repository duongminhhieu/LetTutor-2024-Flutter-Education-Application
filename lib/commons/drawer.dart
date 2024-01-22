import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:src/commons/loadingOverlay.dart';
import 'package:src/l10n/app_localizations.dart';

import '../pages/loginPage/login_page.dart';
import '../providers/auth_provider.dart';
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
              child: Consumer<AuthProvider>(
                builder: (BuildContext context, AuthProvider authProvider,
                    Widget? child) {
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
                          child: CachedNetworkImage(
                            width: double.maxFinite,
                            fit: BoxFit.fitHeight,
                            imageUrl: authProvider.currentUser?.avatar ??
                                "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1700296337596.jpg",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress)),
                            errorWidget: (context, url, error) => Image.network(
                                "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1700296337596.jpg"),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        authProvider.currentUser!.name ?? "Anonymous",
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
              child: Row(
                children: [
                  Icon(
                    Icons.school,
                    size: 36,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 12),
                  Text(
                    AppLocalizations.of(context)!.course,
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
              child: Row(
                children: [
                  Icon(
                    Icons.people_alt,
                    size: 36,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 12),
                  Text(
                    AppLocalizations.of(context)!.becomeATutor,
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
              Navigator.pushNamed(context, "/becomeATeacherPage");
            },
          ),
          ListTile(
            title: Container(
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    size: 36,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 12),
                  Text(
                    AppLocalizations.of(context)!.logout,
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
              var authProvider =
                  Provider.of<AuthProvider>(context, listen: false);
              handleLogout(context, authProvider);
            },
          ),
        ],
      ),
    );
  }

  void handleLogout(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.logout),
          content: Text(AppLocalizations.of(context)!.doYouWantLogout),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () {
                logOut(authProvider);
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoadingOverlay(child: LoginPage()),
                  ),
                );
              },
              child: Text(AppLocalizations.of(context)!.logout),
            ),
          ],
        );
      },
    );
  }

  Future<void> logOut(AuthProvider authProvider) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    authProvider.clearUserInfo();
  }
}
