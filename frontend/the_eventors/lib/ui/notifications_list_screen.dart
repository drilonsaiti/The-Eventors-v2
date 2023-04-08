import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:the_eventors/ui/profile_screen.dart';
import 'package:the_eventors/ui/search_events_screen.dart';

import '../models/Notifications.dart';
import '../services/MyActivityRepository.dart';
import 'all_near_events_map_screen.dart';
import 'detail_event_screen.dart';
import 'home_screen.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationListScreen> createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  late Future<List<Notifications>> notifications;

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifications = MyActivityRepository().getNotificatons();
    //Provider.of<MyActivityProvider>(context, listen: false).readNotifications();
  }

  @override
  Widget build(BuildContext context) {
    MyActivityRepository().readNotification();

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

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return ScreenUtilInit(
              designSize: const Size(350, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return SafeArea(
                    child: Scaffold(
                        appBar: AppBar(
                            title: Text("Notifications"),
                            backgroundColor: Color(0xFF203647),
                            automaticallyImplyLeading: false),
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
                                          _scrollController.animateTo(
                                              _scrollController
                                                  .position.minScrollExtent,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.fastOutSlowIn);
                                        },
                                        icon: Icon(Icons.notifications),
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
                                        icon: Icon(Icons.person_outlined),
                                        color: Color(0xFFEEFBFB)),
                                  ],
                                ))),
                        backgroundColor: Color(0xFF203647),
                        body: FutureBuilder(
                            future: notifications,
                            builder: (context, AsyncSnapshot snapshot) {
                              print("DATA");
                              print(snapshot.data);
                              return SmartRefresher(
                                  header: const WaterDropMaterialHeader(),
                                  controller: _refreshController,
                                  onRefresh: _onRefresh,
                                  onLoading: _onLoading,
                                  child: ListView.builder(
                                    controller: _scrollController,
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(top: 10),
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data == null
                                        ? 0
                                        : snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      print("HAS DATA");
                                      print(snapshot.data[index].title);

                                      if (snapshot.hasData) {
                                        return ListTile(
                                            onTap: () => {
                                                  if (snapshot.data[index]
                                                              .types ==
                                                          "GOING" ||
                                                      snapshot.data[index]
                                                              .types ==
                                                          "INTERESTED")
                                                    {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DetailsEventScreen(
                                                                      id: snapshot
                                                                          .data[
                                                                              index]
                                                                          .idEvent)))
                                                    }
                                                },
                                            title: Text(
                                              snapshot.data[index]!.fromUser +
                                                  snapshot.data[index].message,
                                              style: TextStyle(
                                                  color: Color(0xFFEEFBFB)),
                                            ),
                                            trailing: const Icon(
                                              Icons.arrow_forward,
                                              color: Color(0xFFEEFBFB),
                                            ),
                                            subtitle: Text(
                                                snapshot.data[index]!.createAt,
                                                style: const TextStyle(
                                                    color: Color(0xFFEEFBFB))));
                                      } else if (snapshot.hasError) {
                                        return Text(
                                            ' error: ${snapshot.error.toString()}');
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            color: Color(0xFF007CC7),
                                          ),
                                        );
                                      }
                                    },
                                  ));
                            })));
              });
        });
  }
}
