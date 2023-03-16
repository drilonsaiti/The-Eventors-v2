import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/ui/all_near_events_map_screen.dart';
import 'package:the_eventors/ui/home_screen.dart';
import 'package:the_eventors/ui/profile_screen.dart';
import 'package:the_eventors/ui/search_events_screen.dart';

import '../models/dto/UserProfileDto.dart';
import '../providers/UserProvider.dart';

class BottomBar extends StatefulWidget {
  final String whichScreen;
  final bool isTrue;
  const BottomBar({Key? key, required this.whichScreen, required this.isTrue})
      : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  String home = "home";
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        elevation: 4,
        color: Color(0xFF203647),
        child: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0x4D007CC7),
                  width: 1.5,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    if (widget.isTrue) {
                      print("ITS SAME SCREEN");
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    }
                  },
                  icon: Icon(Icons.home),
                  color: Color(0xFFEEFBFB),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchEventScreen()));
                    },
                    icon: Icon(Icons.search),
                    color: Color(0xFFEEFBFB)),
                IconButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllNearEventsMapScreen(),
                        ));
                  },
                  icon: Icon(Icons.map),
                  color: Color(0xFFEEFBFB),
                ),
                IconButton(
                    onPressed: () async {},
                    icon: Icon(Icons.notifications),
                    color: Color(0xFFEEFBFB)),
                IconButton(
                    onPressed: () async {
                      setState(() {});
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                              username: "",
                            ),
                          ));
                    },
                    icon: Icon(Icons.person_outline),
                    color: Color(0xFFEEFBFB)),
              ],
            )));
  }
}
