import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/ui/login_screen.dart';
import 'package:the_eventors/ui/my_activity_list_screen.dart';
import 'package:the_eventors/ui/security_screen.dart';

import '../models/dto/SettingsList.dart';
import '../providers/UserProvider.dart';
import 'my_activity_details_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<SettingsList> list = [
    SettingsList(
        name: "Security",
        icon: Icon(Icons.security, color: Color(0xFFEEFBFB)),
        widget: SecurityScreen()),
    SettingsList(
        name: "Activity",
        icon: Icon(Icons.local_activity, color: Color(0xFFEEFBFB)),
        widget: MyActivityListScreen()),
    SettingsList(
        name: "Notifications",
        icon: Icon(Icons.notifications, color: Color(0xFFEEFBFB)),
        widget: MyActivityListScreen()),
    SettingsList(
        name: "Bookmarks",
        icon: Icon(Icons.bookmark_border, color: Color(0xFFEEFBFB)),
        widget: MyActivityDetailsScreen(
          activity: "Bookmarks",
        )),
    SettingsList(
        name: "Logout",
        icon: Icon(Icons.logout, color: Color(0xFFEEFBFB)),
        widget: null),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF203647),
        appBar: AppBar(
          backgroundColor: const Color(0xFF203647),
          title: Padding(
              padding:
                  EdgeInsets.only(left: MediaQuery.of(context).size.width / 5),
              child: const Text(
                "Settings",
                style: TextStyle(color: Color(0xFFEEFBFB)),
              )),
        ),
        body: SafeArea(
            child: Container(
          padding: const EdgeInsets.all(10),
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 10),
            scrollDirection: Axis.vertical,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return ListTile(
                  onTap: () {
                    if (list[index].name == "Logout") {
                      Provider.of<UserProvider>(context, listen: false)
                          .logout();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => list[index].widget!));
                    }
                  },
                  leading: list[index].icon ?? list[index].icon,
                  trailing: const Icon(
                    Icons.arrow_forward,
                    color: Color(0xFFEEFBFB),
                  ),
                  title: Text(list[index].name,
                      style: const TextStyle(
                        color: Color(0xFFEEFBFB),
                      )));
            },
            separatorBuilder: (context, index) => const Divider(
              thickness: 1,
              height: 1,
              color: Color(0xFF12232E),
            ),
          ),
        )));
  }
}
