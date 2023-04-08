import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/models/dto/ListingEventNearRepsonseDto.dart';
import 'package:the_eventors/ui/detail_event_screen.dart';
import 'package:the_eventors/ui/multi_step_form_screen.dart';
import 'package:the_eventors/ui/profile_screen.dart';
import 'package:badges/badges.dart' as badges;

import '../providers/EventProvider.dart';
import '../providers/MyActivityProvider.dart';
import '../providers/UserProvider.dart';
import '../services/EventRepository.dart';
import 'all_near_events_map_screen.dart';
import 'home_screen.dart';
import 'map_screen.dart';
import 'notifications_list_screen.dart';

class ListEventScreen extends StatefulWidget {
  final int id;
  final String isAll;
  const ListEventScreen({Key? key, required this.id, required this.isAll})
      : super(key: key);

  @override
  State<ListEventScreen> createState() => _ListEventScreenState();
}

class _ListEventScreenState extends State<ListEventScreen> {
  bool isLoading = true;
  int countFollowing = 0;
  int _selectedIndex = 0;
  List<int> bookmarks = [];
  final ScrollController _scrollController = ScrollController();

  double lat = 0;
  double lng = 0;

  void _getUserLocation() async {
    var position = await Geolocator.getCurrentPosition();
    setState(() {
      lat = position.latitude;
      lng = position.longitude;
    });
  }

  List<dynamic> events = [];

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<MyActivityProvider>(context, listen: false).getCheckBookmarks();

    if (widget.isAll == "Near") {
      Provider.of<EventProvider>(context, listen: false).getNear(widget.id);
    } else if (widget.isAll == "Top") {
      Provider.of<EventProvider>(context, listen: false).getTop(widget.id);
    }

    _getUserLocation();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
       Provider.of<MyActivityProvider>(context).notificationsStatus();

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
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.endFloat,
                      floatingActionButton: FloatingActionButton(
                        onPressed: () {
                          _scrollController.animateTo(
                              _scrollController.position.minScrollExtent,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.fastOutSlowIn);
                        },
                        child: Icon(Icons.arrow_upward),
                        backgroundColor: Color(0xff007CC7),
                      ),
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
                                    icon: Icon(Icons.home),
                                    color: Color(0xFFEEFBFB),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context, true);
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
                                    icon: Icon(Icons.map),
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
                                          Icon(Icons.notifications_outlined,
                                            color: Color(0xFFEEFBFB),
                                          )
                                      ]),
                                      color: Color(0xFFEEFBFB)),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfileScreen(
                                                username: "",
                                              ),
                                            ));
                                      },
                                      icon: Icon(Icons.person_outline),
                                      color: Color(0xFFEEFBFB)),
                                ],
                              ))),
                      appBar: AppBar(
                        iconTheme:
                            const IconThemeData(color: Color(0xFFEEFBFB)),
                        title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.isAll + " events",
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
                                              isLoading = true;
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
                        future: widget.isAll == "near"
                            ? EventRepository().getNearEvents(widget.id)
                            : EventRepository().getTopEvents(widget.id),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            print(snapshot.data);
                            return ListView.builder(
                              controller: _scrollController,
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
                                                    isLoading = true;
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
                                                                        isLoading =
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
                                                                      isLoading =
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
                                                                    isLoading =
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
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
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
                                                                          ))),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          if (widget.isAll ==
                                                              "near")
                                                            Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Icon(Icons
                                                                        .route),
                                                                    SizedBox(
                                                                      width:
                                                                          5.w,
                                                                    ),
                                                                    Text(
                                                                      snapshot.data[index]
                                                                              .distance
                                                                              .toString() +
                                                                          "km",
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      softWrap:
                                                                          false,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              16.sp),
                                                                    ),
                                                                  ],
                                                                )
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
                                                          if (widget.isAll ==
                                                              "top")
                                                            Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width:
                                                                          7.w,
                                                                    ),
                                                                    Text(
                                                                      NumberFormat.compact()
                                                                              .format(snapshot.data[index].going)
                                                                              .toString() +
                                                                          " going",
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      softWrap:
                                                                          false,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              16.sp),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          20.w,
                                                                    ),
                                                                    Text(
                                                                      NumberFormat.compact()
                                                                              .format(snapshot.data[index].interested)
                                                                              .toString() +
                                                                          " interested",
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      softWrap:
                                                                          false,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              16.sp),
                                                                    ),
                                                                  ],
                                                                )
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
