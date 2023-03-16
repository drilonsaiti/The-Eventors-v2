import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/CheckInternetAndLogin.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/providers/UserProvider.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  bool isLoading = true;
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
                                              trailing: Container(
                                                  height: 30.h,
                                                  width: 100.w,
                                                  decoration: BoxDecoration(
                                                      gradient:
                                                          const LinearGradient(
                                                        begin:
                                                            Alignment.topRight,
                                                        end: Alignment
                                                            .bottomLeft,
                                                        colors: [
                                                          Color(0xff4DA8DA),
                                                          Color(0xff007CC7),
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  18)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: const Color(
                                                                  0xFF1C1C1C)
                                                              .withOpacity(0.2),
                                                          spreadRadius: 3,
                                                          blurRadius: 4,
                                                          offset: const Offset(
                                                              0, 3),
                                                        )
                                                      ]),
                                                  child: MaterialButton(
                                                    onPressed: () {},
                                                    child: Center(
                                                      child: Text(
                                                        "Follow",
                                                        style: TextStyle(
                                                            fontSize: 17.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xFFEEFBFB)),
                                                      ),
                                                    ),
                                                  )),
                                              leading: CircleAvatar(
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
                                                            data.users[index]
                                                                .profileImage,
                                                          ),
                                                          height: 50.h,
                                                          width: 60.w,
                                                          fit: BoxFit.cover,
                                                        ),
                                                ),
                                              ),
                                              title: Text(
                                                  data.users[index].username,
                                                  style: const TextStyle(
                                                    color: Color(0xFFEEFBFB),
                                                  )));
                                        });
                                  }),
                                ),
                        )));
              });
        });
  }
}
