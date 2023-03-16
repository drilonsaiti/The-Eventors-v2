import 'dart:async';
import 'dart:convert';
import 'package:badges/badges.dart' as badges;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_eventors/providers/MyActivityProvider.dart';
import 'package:the_eventors/ui/detail_event_screen.dart';
import 'package:the_eventors/ui/login_screen.dart';
import 'package:the_eventors/ui/multi_step_form_screen.dart';
import 'package:the_eventors/ui/profile_screen.dart';
import 'package:the_eventors/ui/search_events_screen.dart';
import 'package:the_eventors/ui/users_list_screen.dart';
import 'package:uuid/uuid.dart';
import '../models/dto/ListingEventRepsonseDto.dart';
import '../providers/EventProvider.dart';
import '../providers/UserProvider.dart';
import '../repository/EventRepository.dart';
import '../repository/MyActivityRepository.dart';
import 'all_near_events_map_screen.dart';
import 'bottom_bar.dart';
import 'map_screen.dart';
import 'notifications_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int countFollowing = 0;
  List<int> bookmarks = [];
  bool checkLogin = false;
  String screen = "home";
  final ScrollController _scrollController = ScrollController();
  checkLoginFunc() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    if (token!.isNotEmpty)
      setState(() {
        checkLogin = true;
      });
    else
      setState(() {
        checkLogin = false;
      });
  }

  @override
  void initState() {
    FocusManager.instance.primaryFocus?.unfocus();
    // TODO: implement initState
    checkLoginFunc();
    //subscription =
    //  Connectivity().onConnectivityChanged.listen(showConnectivitySnackBar);

    Provider.of<UserProvider>(context, listen: false).getCountFollowing();
    Provider.of<MyActivityProvider>(context, listen: false).getCheckBookmarks();

    Future.delayed(const Duration(milliseconds: 2000), () async {
      countFollowing = context.read<UserProvider>().countFollowing;
      bookmarks = context.read<MyActivityProvider>().check;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("MY ACTIVITYYYYY");
    bool notifications = false;
    MyActivityRepository()
        .checkNoReadNotifications()
        .then((value) => notifications = value);
    print(notifications);
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);

    void _onRefresh() async {
      // monitor network fetch
      await Future.delayed(const Duration(milliseconds: 1000));
      setState(() {});
      // if failed,use refreshFailed()
      _refreshController.refreshCompleted();
    }

    void _onLoading() async {
      // monitor network fetch
      await Future.delayed(const Duration(milliseconds: 1000));

      // if failed,use loadFailed(),if no data return,use LoadNodata()
      setState(() {});
      _refreshController.loadComplete();
    }

    return checkLogin
        ? ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return SafeArea(
                child: Scaffold(
                    backgroundColor: const Color(0xFF203647),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _scrollController.animateTo(
                                        _scrollController
                                            .position.minScrollExtent,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.fastOutSlowIn);
                                  },
                                  icon: Icon(Icons.home),
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
                                    icon: Icon(Icons.search_outlined),
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
                                      if (!notifications)
                                        SizedBox(
                                          height: 4,
                                        ),
                                      if (!notifications)
                                        const badges.Badge(
                                          badgeContent: Text(''),
                                          child: Icon(
                                              Icons.notifications_outlined),
                                        ),
                                      if (notifications)
                                        Icon(Icons.notifications)
                                    ]),
                                    color: Color(0xFFEEFBFB)),
                                IconButton(
                                    onPressed: () {
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
                            ))),
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      iconTheme: const IconThemeData(color: Color(0xFFEEFBFB)),
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "The eventors",
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
                                              MultiStepFormPage(
                                                key: UniqueKey(),
                                              )))
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
                      future: EventRepository().getFeed(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return SmartRefresher(
                              header: const WaterDropMaterialHeader(),
                              controller: _refreshController,
                              onRefresh: _onRefresh,
                              onLoading: _onLoading,
                              child: snapshot.data.isEmpty
                                  ? ChangeNotifierProvider(
                                      create: (_) => MyActivityProvider(),
                                      child: ListView(
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          children: <Widget>[
                                            if (countFollowing != 0 &&
                                                snapshot.data.isEmpty)
                                              Container(
                                                alignment: Alignment.center,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 0.25.sh,
                                                    ),
                                                    Icon(
                                                      Icons.data_array,
                                                      size: 150.sp,
                                                      color: Color(
                                                        0xFFEEFBFB,
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Center(
                                                        child: Text(
                                                          "No events rigth now from your followers",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xFFEEFBFB)),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            if (countFollowing == 0 &&
                                                snapshot.data.isEmpty)
                                              Container(
                                                alignment: Alignment.center,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 0.2.sh,
                                                    ),
                                                    Icon(
                                                      Icons.home,
                                                      size: 150.sp,
                                                      color: Color(
                                                        0xFFEEFBFB,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Welcome to The eventors",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFFEEFBFB),
                                                          fontSize: 20.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "When you follow people, you'll see the events they post there",
                                                      style: TextStyle(
                                                          fontSize: 15.sp,
                                                          color: Color(
                                                              0x8CEEFBFB)),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Container(
                                                        height: 40.h,
                                                        width: 0.9.sw,
                                                        decoration:
                                                            BoxDecoration(
                                                                gradient:
                                                                    const LinearGradient(
                                                                  begin: Alignment
                                                                      .topRight,
                                                                  end: Alignment
                                                                      .bottomLeft,
                                                                  colors: [
                                                                    Color(
                                                                        0xff4DA8DA),
                                                                    Color(
                                                                        0xff007CC7),
                                                                  ],
                                                                ),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            25)),
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
                                                            Navigator.of(
                                                                    context)
                                                                .push(MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            const UserListScreen()))
                                                                .then((value) =>
                                                                    setState(
                                                                        () {}));
                                                          },
                                                          child: Center(
                                                            child: Text(
                                                              "Find organizers of events",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color(
                                                                      0xFFEEFBFB)),
                                                            ),
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              )
                                          ]))
                                  : ListView.builder(
                                      controller: _scrollController,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      itemCount: snapshot.data == null
                                          ? 0
                                          : snapshot.data.length,
                                      itemBuilder: (context, index) {
                                        return Column(children: <Widget>[
                                          if (countFollowing < 10 &&
                                              countFollowing >= 0 &&
                                              index == 0)
                                            Column(
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 10.h,
                                                          ),
                                                          Container(
                                                              height: 40.h,
                                                              width: 0.9.sw,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      gradient:
                                                                          const LinearGradient(
                                                                        begin: Alignment
                                                                            .topRight,
                                                                        end: Alignment
                                                                            .bottomLeft,
                                                                        colors: [
                                                                          Color(
                                                                              0xff4DA8DA),
                                                                          Color(
                                                                              0xff007CC7),
                                                                        ],
                                                                      ),
                                                                      borderRadius: const BorderRadius
                                                                              .all(
                                                                          Radius.circular(
                                                                              25)),
                                                                      boxShadow: [
                                                                    BoxShadow(
                                                                      color: const Color(
                                                                              0xFF1C1C1C)
                                                                          .withOpacity(
                                                                              0.2),
                                                                      spreadRadius:
                                                                          3,
                                                                      blurRadius:
                                                                          4,
                                                                      offset:
                                                                          const Offset(
                                                                              0,
                                                                              3),
                                                                    )
                                                                  ]),
                                                              child:
                                                                  MaterialButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              const UserListScreen()))
                                                                      .then((value) =>
                                                                          setState(
                                                                              () {}));
                                                                  ;
                                                                },
                                                                child: Center(
                                                                  child: Text(
                                                                    "Find organizers of events",
                                                                    style: TextStyle(
                                                                        fontSize: 16
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Color(
                                                                            0xFFEEFBFB)),
                                                                  ),
                                                                ),
                                                              )),
                                                          SizedBox(
                                                            height: 10.h,
                                                          ),
                                                          if (countFollowing !=
                                                                  0 &&
                                                              snapshot.data
                                                                      .length ==
                                                                  0)
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top:
                                                                          20.h),
                                                              child: Column(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .data_array,
                                                                    size:
                                                                        150.sp,
                                                                    color:
                                                                        Color(
                                                                      0xFFEEFBFB,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "No events rigth now from your followers",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16.sp,
                                                                            fontWeight: FontWeight.bold,
                                                                            color: Color(0xFFEEFBFB)),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          if (countFollowing == 0 &&
                                              snapshot.data.length == 0)
                                            Container(
                                              alignment: Alignment.center,
                                              child: Column(
                                                children: [
                                                  Icon(
                                                    Icons.home,
                                                    size: 150.sp,
                                                    color: Color(
                                                      0xFFEEFBFB,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Welcome to The eventors",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFEEFBFB),
                                                        fontSize: 20.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "When you follow people, you'll see the events they post there",
                                                    style: TextStyle(
                                                        fontSize: 15.sp,
                                                        color:
                                                            Color(0x8CEEFBFB)),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Container(
                                                      height: 40.h,
                                                      width: 0.9.sw,
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
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          25)),
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
                                                          Navigator.of(context)
                                                              .push(MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const UserListScreen()))
                                                              .then((value) =>
                                                                  setState(
                                                                      () {}));
                                                        },
                                                        child: Center(
                                                          child: Text(
                                                            "Find organizers of events",
                                                            style: TextStyle(
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color(
                                                                    0xFFEEFBFB)),
                                                          ),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.h,
                                                  vertical: 5.w),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                          builder: (context) =>
                                                              DetailsEventScreen(
                                                                  id: snapshot
                                                                      .data[
                                                                          index]
                                                                      .id)))
                                                      .then((value) =>
                                                          setState(() {
                                                            initState();
                                                          }));
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFEEFBFB),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.0),
                                                  ),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10.w),
                                                        child: Column(
                                                          children: <Widget>[
                                                            ListTile(
                                                              leading:
                                                                  Container(
                                                                      width:
                                                                          55.w,
                                                                      height:
                                                                          50.h,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                Colors.black45,
                                                                            offset:
                                                                                Offset(0, 5),
                                                                            blurRadius:
                                                                                8.0.sp,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen(username: snapshot.data[index].createdBy))).then((value) =>
                                                                              setState(() {
                                                                                true;
                                                                                initState();
                                                                              }));
                                                                        },
                                                                        child: CircleAvatar(
                                                                            child: ClipOval(
                                                                                child: snapshot.data[index].profileImage.isEmpty
                                                                                    ? Image.asset(
                                                                                        'assets/profile_image.png',
                                                                                        height: 50.h,
                                                                                        width: 60.h,
                                                                                        fit: BoxFit.cover,
                                                                                      )
                                                                                    : Image.memory(
                                                                                        base64Decode(snapshot.data[index].profileImage),
                                                                                        height: 50.h,
                                                                                        width: 60.h,
                                                                                        fit: BoxFit.cover,
                                                                                      ))),
                                                                      )),
                                                              title: InkWell(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                ProfileScreen(username: snapshot.data[index].createdBy)))
                                                                        .then((value) => setState(() {
                                                                              true;
                                                                              initState();
                                                                            }));
                                                                  },
                                                                  child: Text(
                                                                    snapshot
                                                                        .data[
                                                                            index]
                                                                        .createdBy,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  )),
                                                              subtitle: Text(snapshot
                                                                      .data[
                                                                          index]
                                                                      .agoCreated +
                                                                  " ago"),
                                                            ),
                                                            InkWell(
                                                                onDoubleTap:
                                                                    () {},
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              DetailsEventScreen(id: snapshot.data[index].id)))
                                                                      .then((value) => setState(() {
                                                                            true;
                                                                            initState();
                                                                          }));
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 300,
                                                                  margin: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              2.5.w),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      image: Image
                                                                          .memory(
                                                                        base64Decode(snapshot
                                                                            .data[index]
                                                                            .coverImage),
                                                                        height:
                                                                            300,
                                                                      ).image,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                )),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10.w),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: <
                                                                    Widget>[
                                                                  Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Row(
                                                                        children: <
                                                                            Widget>[
                                                                          IconButton(
                                                                            icon:
                                                                                Icon(Icons.share),
                                                                            iconSize:
                                                                                35.sp,
                                                                            onPressed:
                                                                                () {},
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Consumer<
                                                                          MyActivityProvider>(
                                                                      builder: (context,
                                                                              appState,
                                                                              _) =>
                                                                          IconButton(
                                                                            icon: !appState.check.contains(snapshot.data[index].id)
                                                                                ? const Icon(
                                                                                    Icons.bookmark_add_outlined,
                                                                                    color: Color(0xFF12232E),
                                                                                  )
                                                                                : const Icon(
                                                                                    Icons.bookmark_add,
                                                                                    color: Color(0xFF12232E),
                                                                                  ),
                                                                            iconSize:
                                                                                35.0.sp,
                                                                            onPressed:
                                                                                () {
                                                                              if (!appState.check.contains(snapshot.data[index].id)) {
                                                                                Provider.of<UserProvider>(context, listen: false).addBookmark(snapshot.data[index].id);
                                                                                Provider.of<MyActivityProvider>(context, listen: false).addBookmark(snapshot.data[index].id);

                                                                                /* setState(() {
                                                                                  bookmarks.add(snapshot.data[index].id);
                                                                                });*/
                                                                              } else {
                                                                                Future.delayed(Duration(milliseconds: 150), () {
                                                                                  Provider.of<UserProvider>(context, listen: false).removeBookmark(snapshot.data[index].id);
                                                                                  Provider.of<MyActivityProvider>(context, listen: false).removeBookmark(snapshot.data[index].id);

                                                                                  /*setState(() {
                                                                                    bookmarks.remove(snapshot.data[index].id);
                                                                                  });*/
                                                                                });
                                                                              }
                                                                            },
                                                                          )),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          20.w),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: <
                                                                    Widget>[
                                                                  Column(
                                                                    children: <
                                                                        Widget>[
                                                                      Row(
                                                                        children: <
                                                                            Widget>[
                                                                          const Icon(
                                                                              Icons.title),
                                                                          SizedBox(
                                                                            width:
                                                                                3.w,
                                                                          ),
                                                                          Flexible(
                                                                              child: Text(
                                                                            snapshot.data[index].title,
                                                                            maxLines:
                                                                                1,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            softWrap:
                                                                                false,
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                                                                          ))
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Column(
                                                                    children: <
                                                                        Widget>[
                                                                      Row(
                                                                        children: <
                                                                            Widget>[
                                                                          const Icon(
                                                                              Icons.location_on),
                                                                          SizedBox(
                                                                            width:
                                                                                5.w,
                                                                          ),
                                                                          Flexible(
                                                                              child: InkWell(
                                                                                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => MapScreen(address: snapshot.data[index].location))),
                                                                                  child: Text(
                                                                                    snapshot.data[index].location,
                                                                                    maxLines: 1,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    softWrap: false,
                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                                                                                  )))
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Column(
                                                                    children: <
                                                                        Widget>[
                                                                      Row(
                                                                        children: <
                                                                            Widget>[
                                                                          const Icon(
                                                                              Icons.schedule),
                                                                          SizedBox(
                                                                            width:
                                                                                5.w,
                                                                          ),
                                                                          Flexible(
                                                                              child: Text(
                                                                            snapshot.data[index].startAt,
                                                                            maxLines:
                                                                                1,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            softWrap:
                                                                                false,
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
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
                                    ));
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
            })
        : const LoginScreen();
  }
}
