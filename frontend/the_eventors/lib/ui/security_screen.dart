import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../models/dto/SettingsList.dart';
import '../providers/UserProvider.dart';
import 'change_screen.dart';
import 'my_activity_list_screen.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({Key? key}) : super(key: key);

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  List<SettingsList> list = [
    SettingsList(
        name: "Change username", widget: ChangeScreen(change: "username")),
    SettingsList(
        name: "Change password", widget: ChangeScreen(change: "password")),
    SettingsList(name: "Change email", widget: ChangeScreen(change: "email")),
    SettingsList(name: "Delete account", widget: null),
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
                    if (list[index].name == "Delete account") {
                      showDialog(
                          context: context,
                          builder: (context) {
                            String contentText = "Content of Dialog";
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return AlertDialog(
                                title: Text("Delete your account"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Are you sure you want to delete your account?",
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                    child: const Text(
                                      'Cancel',
                                      style:
                                          TextStyle(color: Color(0xff007CC7)),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                      style: TextButton.styleFrom(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                      child: const Text(
                                        'Confirm',
                                        style:
                                            TextStyle(color: Color(0xff007CC7)),
                                      ),
                                      onPressed: () {
                                        Provider.of<UserProvider>(context)
                                            .deleteAccount();
                                      }),
                                ],
                              );
                            });
                          });
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => list[index].widget!));
                    }
                  },
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
