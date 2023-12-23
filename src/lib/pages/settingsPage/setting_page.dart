import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:src/commons/appBar.dart';
import 'package:src/providers/auth_provider.dart';

import '../../commons/loadingOverlay.dart';
import '../../providers/user_provider.dart';
import '../loginPage/login_page.dart';
class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  String selectedLanguage = 'Automatic';
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body:  Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            // User card
            Consumer<AuthProvider>(
              builder: (BuildContext context, AuthProvider authProvider, Widget? child) {
                return BigUserCard(
                  backgroundColor: Colors.blue,
                  userName: authProvider.currentUser?.name ?? "Anonymous",
                  userProfilePic: NetworkImage(authProvider.currentUser?.avatar ??
                      "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1700296337596.jpg", scale: 1.0),
                  cardActionWidget: SettingsItem(
                    icons: Icons.edit,
                    iconStyle: IconStyle(
                      withBackground: true,
                      borderRadius: 50,
                      backgroundColor: Colors.blue[600],
                    ),
                    title: "Profile",
                    subtitle: "Tap to change your profile",
                    onTap: () {
                      Navigator.pushNamed(context, "/profilePage");
                    },
                  ),
                );
              },
            ),
            SettingsGroup(
              settingsGroupTitle: "App Settings",
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.dark_mode_rounded,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.grey,
                  ),
                  title: 'Dark mode',
                  subtitle: "Automatic",
                  trailing: Switch.adaptive(
                    value: isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        isDarkMode = value;
                      });
                    },
                  ),
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.language,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.grey,
                  ),
                  title: 'Language',
                  subtitle: selectedLanguage ?? 'Automatic',
                  trailing: Container(
                    width: 120, // Set width to match parent
                    height: 42.0, // Set height to match TextInput
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: DropdownButton<String>(
                        underline: Container(),
                        isDense: true,
                        isExpanded: true,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedLanguage = newValue!;
                          });
                        },
                        items: <String>['English', 'Vietnamese']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: TextStyle(fontSize: 16),),
                          );
                        }).toList(),
                      ),
                    ),
                  )

                ),

              ],
            ),
            SettingsGroup(
              settingsGroupTitle: "Account",
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.wallet,
                  iconStyle: IconStyle(),
                  title: 'My Wallet',
                  subtitle: "Manage your wallet",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.co_present,
                  iconStyle: IconStyle(),
                  title: 'Become a tutor',
                  subtitle: "How to become a tutor",
                ),
              ],
            ),
            SettingsGroup(
              settingsGroupTitle: "Overview",
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'About',
                  subtitle: "Learn more about LetTutor App",
                ),
                SettingsItem(
                  onTap: () {
                    var authProvider =
                    Provider.of<AuthProvider>(context, listen: false);
                    handleLogout(context, authProvider);

                  },
                  icons: Icons.logout,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.red,
                  ),
                  title: 'Logout',
                  subtitle: "Log out LetTutor app",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void handleLogout(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Log out"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
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
              child: const Text("Log out"),
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
