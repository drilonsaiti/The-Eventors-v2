import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/models/dto/ListingEventNearRepsonseDto.dart';
import 'package:the_eventors/repository/EventRepository.dart';
import 'package:the_eventors/ui/detail_event_screen.dart';
import 'package:the_eventors/ui/multi_step_form_screen.dart';
import 'package:the_eventors/ui/profile_screen.dart';

import '../providers/EventProvider.dart';
import '../providers/MyActivityProvider.dart';
import '../providers/UserProvider.dart';
import 'map_screen.dart';

class ListAllEventScreen extends StatefulWidget {
  final int id;
  const ListAllEventScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ListAllEventScreen> createState() => _ListAllEventScreenState();
}

class _ListAllEventScreenState extends State<ListAllEventScreen> {
  List<int> bookmarks = [];

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<MyActivityProvider>(context, listen: false).getCheckBookmarks();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return ScreenUtilInit(
              designSize: const Size(360, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return SafeArea(
                  child: Scaffold(
                      backgroundColor: const Color(0xFF203647),
                      appBar: AppBar(
                        iconTheme:
                            const IconThemeData(color: Color(0xFFEEFBFB)),
                        title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "All events",
                                style: TextStyle(
                                    color: Color(0xFFEEFBFB),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
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
                                              initState();
                                            }));
                                    ;
                                  },
                                ),
                              )
                            ]),
                        backgroundColor: const Color(0xFF203647),
                      ),
                      body: FutureBuilder(
                        future: EventRepository().getAllEvents(widget.id),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            print(snapshot.data);
                            return ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Column(children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.h, vertical: 5.w),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailsEventScreen(
                                                          id: snapshot
                                                              .data[index].id)))
                                              .then((value) => setState(() {
                                                    initState();
                                                  }));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFEEFBFB),
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.w),
                                                child: Column(
                                                  children: <Widget>[
                                                    ListTile(
                                                      leading: Container(
                                                          width: 55.w,
                                                          height: 50.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black45,
                                                                offset: Offset(
                                                                    0, 5),
                                                                blurRadius:
                                                                    8.0.sp,
                                                              ),
                                                            ],
                                                          ),
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .push(MaterialPageRoute(
                                                                      builder: (context) => ProfileScreen(
                                                                          username: snapshot
                                                                              .data[
                                                                                  index]
                                                                              .createdBy)))
                                                                  .then((value) =>
                                                                      setState(
                                                                          () {
                                                                        true;
                                                                        initState();
                                                                      }));
                                                            },
                                                            child: CircleAvatar(
                                                                child: ClipOval(
                                                                    child: snapshot
                                                                            .data[
                                                                                index]
                                                                            .profileImage
                                                                            .isEmpty
                                                                        ? Image
                                                                            .asset(
                                                                            'assets/profile_image.png',
                                                                            height:
                                                                                50.h,
                                                                            width:
                                                                                60.h,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          )
                                                                        : Image
                                                                            .memory(
                                                                            base64Decode(snapshot.data[index].profileImage),
                                                                            height:
                                                                                50.h,
                                                                            width:
                                                                                60.h,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ))),
                                                          )),
                                                      title: InkWell(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(MaterialPageRoute(
                                                                    builder: (context) => ProfileScreen(
                                                                        username: snapshot
                                                                            .data[
                                                                                index]
                                                                            .createdBy)))
                                                                .then((value) =>
                                                                    setState(
                                                                        () {
                                                                      true;
                                                                      initState();
                                                                    }));
                                                          },
                                                          child: Text(
                                                            snapshot.data[index]
                                                                .createdBy,
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )),
                                                      subtitle: Text(snapshot
                                                              .data[index]
                                                              .agoCreated +
                                                          " ago"),
                                                    ),
                                                    InkWell(
                                                        onDoubleTap: () {},
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .push(MaterialPageRoute(
                                                                  builder: (context) => DetailsEventScreen(
                                                                      id: snapshot
                                                                          .data[
                                                                              index]
                                                                          .id)))
                                                              .then((value) =>
                                                                  setState(() {
                                                                    true;
                                                                    initState();
                                                                  }));
                                                        },
                                                        child: Container(
                                                          height: 300,
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      2.5.w),
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  Image.memory(
                                                                base64Decode(snapshot
                                                                    .data[index]
                                                                    .coverImage),
                                                                height: 300,
                                                              ).image,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        )),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.w),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Row(
                                                            children: <Widget>[
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  IconButton(
                                                                    icon: Icon(Icons
                                                                        .share),
                                                                    iconSize:
                                                                        35.sp,
                                                                    onPressed:
                                                                        () {},
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          IconButton(
                                                            icon: !bookmarks
                                                                    .contains(
                                                                        snapshot
                                                                            .data[index]
                                                                            .id)
                                                                ? const Icon(
                                                                    Icons
                                                                        .bookmark_add_outlined,
                                                                    color: Color(
                                                                        0xFF12232E),
                                                                  )
                                                                : const Icon(
                                                                    Icons
                                                                        .bookmark_add,
                                                                    color: Color(
                                                                        0xFF12232E),
                                                                  ),
                                                            iconSize: 35.0.sp,
                                                            onPressed: () {
                                                              if (!bookmarks
                                                                  .contains(snapshot
                                                                      .data[
                                                                          index]
                                                                      .id)) {
                                                                Provider.of<UserProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .addBookmark(
                                                                        snapshot
                                                                            .data[index]
                                                                            .id);
                                                                setState(() {
                                                                  bookmarks.add(
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                          .id);
                                                                });
                                                              } else {
                                                                Future.delayed(
                                                                    Duration(
                                                                        milliseconds:
                                                                            150),
                                                                    () {
                                                                  Provider.of<UserProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .removeBookmark(snapshot
                                                                          .data[
                                                                              index]
                                                                          .id);

                                                                  setState(() {
                                                                    bookmarks.remove(
                                                                        snapshot
                                                                            .data[index]
                                                                            .id);
                                                                  });
                                                                });
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 20.w),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Column(
                                                            children: <Widget>[
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  const Icon(Icons
                                                                      .title),
                                                                  SizedBox(
                                                                    width: 3.w,
                                                                  ),
                                                                  Flexible(
                                                                      child:
                                                                          Text(
                                                                    snapshot
                                                                        .data[
                                                                            index]
                                                                        .title,
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    softWrap:
                                                                        false,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            20.sp),
                                                                  ))
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            children: <Widget>[
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  const Icon(Icons
                                                                      .location_on),
                                                                  SizedBox(
                                                                    width: 5.w,
                                                                  ),
                                                                  Flexible(
                                                                      child: InkWell(
                                                                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => MapScreen(address: snapshot.data[index].location))),
                                                                          child: Text(
                                                                            snapshot.data[index].location,
                                                                            maxLines:
                                                                                1,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            softWrap:
                                                                                false,
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                                                                          )))
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            children: <Widget>[
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  const Icon(Icons
                                                                      .schedule),
                                                                  SizedBox(
                                                                    width: 5.w,
                                                                  ),
                                                                  Flexible(
                                                                      child:
                                                                          Text(
                                                                    snapshot
                                                                        .data[
                                                                            index]
                                                                        .startDateTime,
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    softWrap:
                                                                        false,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            16.sp),
                                                                  ))
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ))
                                ]);
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text(' error: ${snapshot.error.toString()}');
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF007CC7),
                              ),
                            );
                          }
                        },
                      )),
                );
              });
        });
  }
}
