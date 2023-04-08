import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart' as badges;

import 'package:provider/provider.dart';
import 'package:the_eventors/providers/UserProvider.dart';
import 'package:the_eventors/ui/home_screen.dart';
import 'package:the_eventors/ui/search_events_screen.dart';
import 'package:the_eventors/ui/settings_screen.dart';
import 'package:the_eventors/ui/widgets/body_profile_widget.dart';
import 'package:the_eventors/ui/widgets/top_profile_widget.dart';

import '../models/dto/UserProfileDto.dart';
import '../providers/MyActivityProvider.dart';
import 'all_near_events_map_screen.dart';
import 'bottom_bar.dart';
import 'edit_profile_screen.dart';
import 'multi_step_form_screen.dart';
import 'notifications_list_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String username;
  const ProfileScreen({Key? key, required this.username}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? token = "";
  bool isUser = false;
  bool isFollowing = false;
  UserProfileDto profile = UserProfileDto(
      username: "",
      profileImage: "",
      fullName: "",
      bio: "",
      countEvents: 0,
      countFollowers: 0,
      countFollowing: 0);
  String username = "";
  bool isLoading = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<UserProvider>(context, listen: false)
        .getUserByUsername(widget.username);
    Provider.of<UserProvider>(context, listen: false).getUsername();

    if (widget.username == "" ||
        widget.username == context.read<UserProvider>().username) {
      setState(() {
        isUser = true;
      });
    } else {
      Provider.of<UserProvider>(context, listen: false)
          .checkIsFollowing(widget.username);
    }

    Future.delayed(Duration(milliseconds: 1200), () {
      profile = context.read<UserProvider>().profile;

      isFollowing = context.read<UserProvider>().isFollowing;

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<MyActivityProvider>(context).notificationsStatus();

    return isLoading
        ? Scaffold(
            backgroundColor: Color(0xFF203647),
            body: Center(
              child: CircularProgressIndicator(
                color: Color(0xFF007CC7),
              ),
            ))
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              return ScreenUtilInit(
                designSize: const Size(350, 690),
                minTextAdapt: true,
                splitScreenMode: true,
                builder: (context, child) {
                  return SafeArea(
                      child: Scaffold(
                          bottomNavigationBar: BottomAppBar(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen()));
                                        },
                                        icon: Icon(Icons.home_outlined),
                                        color: Color(0xFFEEFBFB),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SearchEventScreen()));
                                          },
                                          icon: Icon(Icons.search),
                                          color: Color(0xFFEEFBFB)),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AllNearEventsMapScreen(),
                                              ));
                                        },
                                        icon: Icon(Icons.map_outlined),
                                        color: Color(0xFFEEFBFB),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    NotificationListScreen(
                                                  key: UniqueKey(),
                                                ),
                                              ));
                                        },
                                        icon: Column(children: [
                                          SizedBox(
                                            height: 3,
                                          ),
                                          if (!context
                                              .read<MyActivityProvider>()
                                              .notifications)
                                            const badges.Badge(
                                              badgeContent: Text(''),
                                              child: Icon(
                                                Icons.notifications_outlined,
                                                color: Color(0xFFEEFBFB),
                                              ),
                                            ),
                                          if (context
                                              .read<MyActivityProvider>()
                                              .notifications)
                                            Icon(
                                              Icons.notifications_outlined,
                                              color: Color(0xFFEEFBFB),
                                            )
                                        ]),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            _scrollController.animateTo(
                                                _scrollController
                                                    .position.minScrollExtent,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                curve: Curves.fastOutSlowIn);
                                          },
                                          icon: Icon(Icons.person),
                                          color: Color(0xFFEEFBFB)),
                                    ],
                                  ))),
                          backgroundColor: Color(0xFF203647),
                          appBar: isUser
                              ? AppBar(
                                  automaticallyImplyLeading: false,
                                  iconTheme: const IconThemeData(
                                      color: Color(0xFFEEFBFB)),
                                  leading: IconButton(
                                    icon: const Icon(Icons.arrow_back),
                                    color: const Color(0xFFEEFBFB),
                                    iconSize: 30.0,
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                  ),
                                  actions: [
                                    Container(
                                      //width: 35.0,
                                      child: IconButton(
                                        icon: const Icon(Icons.edit),
                                        color: const Color(0xFFEEFBFB),
                                        iconSize: 30.0,
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditProfileScreen(
                                                        fullName:
                                                            profile.fullName,
                                                        bio: profile.bio,
                                                      )))
                                              .then((value) => setState(() {
                                                    isLoading = true;
                                                    initState();
                                                  }));
                                        },
                                      ),
                                    ),
                                    Container(
                                      //width: 35.0,
                                      child: IconButton(
                                        icon: const Icon(Icons.add),
                                        color: const Color(0xFFEEFBFB),
                                        iconSize: 30.0,
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MultiStepFormPage()))
                                              .then((value) => setState(() {
                                                    isLoading = true;
                                                    initState();
                                                  }));
                                        },
                                      ),
                                    ),
                                    Container(
                                      //width: 35.0,
                                      child: IconButton(
                                        icon: const Icon(Icons.menu),
                                        color: const Color(0xFFEEFBFB),
                                        iconSize: 30.0,
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      SettingsScreen()))
                                              .then((value) => setState(() {
                                                    isLoading = true;
                                                    initState();
                                                  }));
                                        },
                                      ),
                                    ),
                                  ],
                                  title: isUser
                                      ? Text(
                                          "@" + profile.username,
                                          style: TextStyle(
                                              color: Color(0xFFEEFBFB),
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : const Text(""),
                                  backgroundColor: const Color(0xFF203647),
                                )
                              : AppBar(
                                  backgroundColor: const Color(0xFF203647),
                                  actions: [
                                    Container(
                                      //width: 35.0,
                                      child: IconButton(
                                        icon: const Icon(Icons.add),
                                        color: const Color(0xFFEEFBFB),
                                        iconSize: 30.0,
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MultiStepFormPage()))
                                              .then((value) => setState(() {
                                                    isLoading = true;
                                                    initState();
                                                  }));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                          body: profile.username == null
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.error,
                                        size: 100.sp,
                                        color: Color(0xFFEEFBFB),
                                      ),
                                      Text(
                                        "Profile with username " +
                                            widget.username +
                                            " doesn't exists",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFFEEFBFB),
                                          fontSize: 20.sp,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : SafeArea(
                                  child: SingleChildScrollView(
                                      controller: _scrollController,
                                      child: Column(children: [
                                        TopProfileWidget(
                                            isFollowing: isFollowing,
                                            isUser: isUser,
                                            profile: profile),
                                        BodyProfileWidget(
                                            username: widget.username)
                                      ])))));
                },
              );
            });
  }
}
