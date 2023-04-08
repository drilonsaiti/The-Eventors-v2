import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_eventors/ui/profile_screen.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/providers/UserProvider.dart';

import '../services/UserRepository.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  bool isLoading = true;
  List<String> myFollowing = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UserProvider>(context, listen: false).getDiscoverUsers();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  getMyFollowing() async {
    myFollowing = await UserRepository().myFollowing();
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
                                "Discover users",
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
                                        itemCount: data.users.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                              trailing: myFollowing.contains(data
                                                      .users[index].username)
                                                  ? Container(
                                                      height: 35.h,
                                                      width: 150.w,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            const LinearGradient(
                                                          begin: Alignment
                                                              .topRight,
                                                          end: Alignment
                                                              .bottomLeft,
                                                          colors: [
                                                            Color(0xFF203647),
                                                            Color(0xCC203647)
                                                          ],
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(10),
                                                        ),
                                                        border: Border.all(
                                                            color: const Color(
                                                                0xFFEEFBFB)),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Color(
                                                                0x3312232E),
                                                            spreadRadius: 3,
                                                            blurRadius: 4,
                                                            offset:
                                                                Offset(0, 3),
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
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    250,
                                                                    250,
                                                                    250),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      height: 30.h,
                                                      width: 100.w,
                                                      decoration: BoxDecoration(
                                                          gradient:
                                                              const LinearGradient(
                                                            begin: Alignment
                                                                .topRight,
                                                            end: Alignment
                                                                .bottomLeft,
                                                            colors: [
                                                              Color(0xff4DA8DA),
                                                              Color(0xff007CC7),
                                                            ],
                                                          ),
                                                          borderRadius:
                                                              const BorderRadius.all(
                                                                  Radius.circular(
                                                                      18)),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: const Color(
                                                                      0xFF1C1C1C)
                                                                  .withOpacity(
                                                                      0.2),
                                                              spreadRadius: 3,
                                                              blurRadius: 4,
                                                              offset:
                                                                  const Offset(
                                                                      0, 3),
                                                            )
                                                          ]),
                                                      child: MaterialButton(
                                                        onPressed: () {
                                                          Provider.of<UserProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .follow(data
                                                                  .users[index]
                                                                  .username);
                                                          setState(() {
                                                            myFollowing.add(data
                                                                .users[index]
                                                                .username);
                                                          });
                                                        },
                                                        child: Center(
                                                          child: Text(
                                                            "Follow",
                                                            style: TextStyle(
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color(
                                                                    0xFFEEFBFB)),
                                                          ),
                                                        ),
                                                      )),
                                              leading: InkWell(
                                                  onTap: () =>
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      ProfileScreen(
                                                                        username: data
                                                                            .users[index]
                                                                            .username,
                                                                      ))),
                                                  child: CircleAvatar(
                                                    child: ClipOval(
                                                      child: !data.users[index]
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
                                                                    .users[
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
                                                  onTap: () =>
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      ProfileScreen(
                                                                        username: data
                                                                            .users[index]
                                                                            .username,
                                                                      ))),
                                                  child: Text(data.users[index].username,
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
