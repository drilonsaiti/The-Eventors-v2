import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:intl/intl.dart';
import 'package:the_eventors/ui/list_my_followers_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/ImageHelper.dart';
import '../../models/dto/UserProfileDto.dart';
import '../../providers/UserProvider.dart';
import '../list_my_following_screen.dart';

class TopProfileWidget extends StatefulWidget {
  final bool isFollowing;
  final bool isUser;
  UserProfileDto profile = UserProfileDto(
      username: "",
      profileImage: "",
      fullName: "",
      bio: "",
      countEvents: 0,
      countFollowers: 0,
      countFollowing: 0);
  TopProfileWidget(
      {Key? key,
      required this.isFollowing,
      required this.isUser,
      required this.profile})
      : super(key: key);

  @override
  State<TopProfileWidget> createState() => _TopProfileWidgetState();
}

class _TopProfileWidgetState extends State<TopProfileWidget> {
  bool isFollowing = false;
  final imageHelper = ImageHelper();
  bool descTextShowFlag = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.profile.bio);
    setState(() {
      isFollowing = widget.isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("IS USER " + widget.isUser.toString());
    Size size = (TextPainter(
            text: TextSpan(
                text: widget.profile.bio,
                style: TextStyle(color: Color(0xFFEEFBFB))),
            maxLines: 1,
            textScaleFactor: MediaQuery.of(context).textScaleFactor,
            textDirection: ui.TextDirection.ltr)
          ..layout())
        .size;
    print(size);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(14.sp),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Stack(children: [
                    CircleAvatar(
                      maxRadius: 40.w,
                      child: ClipOval(
                          child: widget.profile.profileImage == ""
                              ? Image.asset(
                                  'assets/profile_image.png',
                                  height: double.infinity,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : Image.memory(
                                  base64Decode(widget.profile.profileImage),
                                  height: double.infinity,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )),
                    ),
                    if (widget.isUser)
                      Positioned(
                        height: 35.h,
                        width: 23.5.w,
                        top: 45.h,
                        left: 55.w,
                        child: Container(
                            child: PopupMenuButton(
                                itemBuilder: (context) => [
                                      PopupMenuItem(
                                          onTap: () async {
                                            final files =
                                                await imageHelper.pickImage();
                                            File? imageFile;
                                            setState(() {
                                              imageFile =
                                                  File(files.first.path);
                                              widget.profile.profileImage =
                                                  base64Encode(imageFile!
                                                      .readAsBytesSync());
                                              Provider.of<UserProvider>(context,
                                                      listen: false)
                                                  .addProfileImage(base64Encode(
                                                      imageFile!
                                                          .readAsBytesSync()));
                                            });
                                          },
                                          value: "gallery",
                                          child: Row(
                                            children: [
                                              Icon(Icons.photo_library),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Text("Chose from library")
                                            ],
                                          )),
                                      PopupMenuItem(
                                          value: "take",
                                          onTap: () async {
                                            File? imageFile;
                                            var pickedImage = await ImagePicker
                                                .platform
                                                .getImage(
                                                    source: ImageSource.camera);
                                            if (pickedImage != null) {
                                              setState(() {
                                                imageFile =
                                                    File(pickedImage.path);
                                                widget.profile.profileImage =
                                                    base64Encode(imageFile!
                                                        .readAsBytesSync());
                                                Provider.of<UserProvider>(
                                                        context,
                                                        listen: false)
                                                    .addProfileImage(
                                                        base64Encode(imageFile!
                                                            .readAsBytesSync()));
                                              });
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              Icon(Icons.camera),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Text("Take a photo")
                                            ],
                                          )),
                                      PopupMenuItem(
                                          value: "remove",
                                          onTap: () {
                                            setState(() {
                                              widget.profile.profileImage = "";
                                            });
                                            Provider.of<UserProvider>(context,
                                                    listen: false)
                                                .removeProfileImage();
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.delete,
                                                color: Colors.redAccent,
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Text(
                                                "Remove current photo",
                                                style: TextStyle(
                                                    color: Colors.redAccent),
                                              )
                                            ],
                                          ))
                                    ],
                                child: Container(
                                  height: 48,
                                  width: 38,
                                  decoration: new BoxDecoration(
                                    color: Color(0xff007CC7),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 25.sp,
                                    color: Color(0xFF12232E),
                                  ),
                                ))),
                      )
                  ]),
                  Column(
                    children: [
                      Text(
                          NumberFormat.compact()
                              .format(widget.profile.countEvents)
                              .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp,
                              color: Color(0xFFEEFBFB))),
                      Text("Events",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                              color: Color(0xFFEEFBFB))),
                    ],
                  ),
                  Column(
                    children: [
                      InkWell(
                          onTap: () => Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) =>
                                      const MyFollowersScreen()))
                              .then((value) => setState(() {
                                    initState();
                                  })),
                          child: Text(
                              NumberFormat.compact()
                                  .format(widget.profile.countFollowers)
                                  .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.sp,
                                  color: Color(0xFFEEFBFB)))),
                      InkWell(
                          onTap: () => Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) =>
                                      const MyFollowersScreen()))
                              .then((value) => setState(() {
                                    initState();
                                  })),
                          child: Text("Followers",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                  color: Color(0xFFEEFBFB)))),
                    ],
                  ),
                  Column(
                    children: [
                      InkWell(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MyFollowingScreen())),
                          child: Text(
                              NumberFormat.compact()
                                  .format(widget.profile.countFollowing)
                                  .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.sp,
                                  color: Color(0xFFEEFBFB)))),
                      InkWell(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MyFollowingScreen())),
                          child: Text("Following",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                  color: Color(0xFFEEFBFB)))),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 25.w),
          child: Text(widget.profile.fullName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.sp,
                  color: Color(0xFFEEFBFB))),
        ),
        if (!widget.isUser)
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 25.w),
            child: Text("@" + widget.profile.username,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                    color: Color(0xCCEEFBFB))),
          ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 25.w, top: 5.h, right: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Linkify(
                  onOpen: (link) => launchUrl(Uri.parse(link.url)),
                  text: widget.profile.bio,
                  maxLines: descTextShowFlag ? 300 : 5,
                  style: TextStyle(color: Color(0xFFEEFBFB))),
              if (widget.profile.bio.isNotEmpty && size.width > 1000)
                InkWell(
                  onTap: () {
                    setState(() {
                      descTextShowFlag = !descTextShowFlag;
                    });
                  },
                  child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          descTextShowFlag
                              ? Text(
                                  "Show Less",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff007CC7)),
                                )
                              : Text("Show More",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff007CC7)))
                        ],
                      )),
                ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        if (!widget.isUser)
          isFollowing
              ? PopupMenuButton<int>(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Row(children: [
                        Icon(
                          Icons.person_remove_alt_1,
                          color: Colors.redAccent,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "Unfollow @drilon",
                          style: TextStyle(color: Colors.redAccent),
                        )
                      ]),
                    ),
                  ],
                  onSelected: (value) {
                    //unfollow
                    Provider.of<UserProvider>(context, listen: false)
                        .unfollow(widget.profile.username);
                    setState(() {
                      isFollowing = false;
                    });
                  },
                  child: Container(
                    height: 35.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Color(0xFF203647), Color(0xCC203647)],
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border: Border.all(color: const Color(0xFFEEFBFB)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x3312232E),
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
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 250, 250, 250),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(
                  height: 35.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xff4DA8DA),
                        Color(0xff007CC7),
                      ],
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    border: Border.all(color: const Color(0xFFEEFBFB)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x3312232E),
                        spreadRadius: 3,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      if (!isFollowing) {
                        Provider.of<UserProvider>(context, listen: false)
                            .follow(widget.profile.username);
                        setState(() {
                          isFollowing = true;
                        });
                      }
                    },
                    child: Center(
                      child: Text(
                        isFollowing ? "Following" : "Follow",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 250, 250, 250),
                        ),
                      ),
                    ),
                  ),
                ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
