import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_eventors/ui/profile_screen.dart';

import '../services/CheckInternetAndLogin.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/providers/UserProvider.dart';

class MyFollowersScreen extends StatefulWidget {
  const MyFollowersScreen({Key? key}) : super(key: key);

  @override
  State<MyFollowersScreen> createState() => _MyFollowersScreenState();
}

class _MyFollowersScreenState extends State<MyFollowersScreen> {
  bool isLoading = true;
  List<String> myFollowing = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UserProvider>(context, listen: false).getMyFollowers();

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return ScreenUtilInit(
              designSize: const Size(400, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return SafeArea(
                    child: Scaffold(
                        backgroundColor: const Color(0xFF203647),
                        appBar: AppBar(
                          iconTheme:
                              const IconThemeData(color: Color(0xFFEEFBFB)),
                          title: Row(children: [
                            Container(
                              child: const Text(
                                "Followers",
                                style: TextStyle(color: Color(0xFFEEFBFB)),
                              ),
                            ),
                          ]),
                          backgroundColor: const Color(0xFF203647),
                        ),
                        body: SafeArea(
                          child: isLoading
                              ? Container()
                              : Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Consumer<UserProvider>(
                                      builder: (context, data, child) {
                                    return ListView.builder(
                                        padding: const EdgeInsets.only(top: 10),
                                        scrollDirection: Axis.vertical,
                                        itemCount: data.myFollowers.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                              trailing: PopupMenuButton<int>(
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 1,
                                                    child: Row(children: [
                                                      Icon(
                                                        Icons
                                                            .person_remove_alt_1,
                                                        color: Colors.redAccent,
                                                      ),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      Text(
                                                        "Unfollow @drilon",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .redAccent),
                                                      )
                                                    ]),
                                                  ),
                                                ],
                                                onSelected: (value) {
                                                  //unfollow
                                                  Provider.of<UserProvider>(
                                                          context,
                                                          listen: false)
                                                      .unfollow(data
                                                          .myFollowing[index]
                                                          .username);
                                                },
                                                child: Container(
                                                  height: 35.h,
                                                  width: 150.w,
                                                  decoration: BoxDecoration(
                                                    gradient:
                                                        const LinearGradient(
                                                      begin: Alignment.topRight,
                                                      end: Alignment.bottomLeft,
                                                      colors: [
                                                        Color(0xFF203647),
                                                        Color(0xCC203647)
                                                      ],
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xFFEEFBFB)),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x3312232E),
                                                        spreadRadius: 3,
                                                        blurRadius: 4,
                                                        offset: Offset(0, 3),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Following",
                                                      style: TextStyle(
                                                        fontSize: 20.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 250, 250, 250),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              leading: InkWell(
                                                  onTap: () => Navigator.of(
                                                          context)
                                                      .push(MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProfileScreen(
                                                                username: data
                                                                    .myFollowers[
                                                                        index]
                                                                    .username,
                                                              ))),
                                                  child: CircleAvatar(
                                                    child: ClipOval(
                                                      child: !data
                                                              .myFollowers[
                                                                  index]
                                                              .profileImage
                                                              .startsWith('/')
                                                          ? Image.asset(
                                                              'assets/profile_image.png',
                                                              height: 50.h,
                                                              width: 60.w,
                                                              fit: BoxFit.cover,
                                                            )
                                                          : Image.memory(
                                                              base64Decode(
                                                                data
                                                                    .myFollowers[
                                                                        index]
                                                                    .profileImage,
                                                              ),
                                                              height: 50.h,
                                                              width: 60.w,
                                                              fit: BoxFit.cover,
                                                            ),
                                                    ),
                                                  )),
                                              title: InkWell(
                                                  onTap: () => Navigator.of(
                                                          context)
                                                      .push(MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProfileScreen(
                                                                username: data
                                                                    .myFollowers[
                                                                        index]
                                                                    .username,
                                                              ))),
                                                  child: Text(
                                                      data.myFollowers[index]
                                                          .username,
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFFEEFBFB),
                                                      ))));
                                        });
                                  }),
                                ),
                        )));
              });
        });
  }
}
