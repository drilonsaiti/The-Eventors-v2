import 'dart:convert';
import 'package:badges/badges.dart' as badges;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/providers/EventProvider.dart';
import 'package:the_eventors/providers/UserProvider.dart';
import 'package:the_eventors/ui/detail_event_screen.dart';
import 'package:the_eventors/ui/profile_screen.dart';
import '../repository/MyActivityRepository.dart';

import 'all_near_events_map_screen.dart';
import 'home_screen.dart';
import 'notifications_list_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();
  late String _searchText;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      Provider.of<UserProvider>(context, listen: false)
          .findUserssByQuery(controller.text);
      Provider.of<EventProvider>(context, listen: false)
          .findEventsByQuery(controller.text);
    });
    controller.addListener(() {
      setState(() {
        _searchText = controller.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool notifications = false;
    MyActivityRepository()
        .checkNoReadNotifications()
        .then((value) => notifications = value);
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: Color(0xFF203647),
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            },
                            icon: Icon(Icons.home_outlined),
                            color: Color(0xFFEEFBFB),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Ionicons.search),
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
                                  child: Icon(Icons.notifications_outlined),
                                ),
                              if (notifications) Icon(Icons.notifications)
                            ]),
                          ),
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
              resizeToAvoidBottomInset: false,
              body: Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SafeArea(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                        Row(
                          children: [
                            Flexible(
                                child: SizedBox(
                                    height: 70,
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, top: 16, bottom: 16),
                                        child: TextField(
                                          clipBehavior: Clip.hardEdge,
                                          controller: controller,
                                          onChanged: (value) {
                                            print(value);
                                            Provider.of<EventProvider>(context,
                                                    listen: false)
                                                .findEventsByQuery(value);
                                            Provider.of<UserProvider>(context,
                                                    listen: false)
                                                .findUserssByQuery(value);
                                          },
                                          minLines: 1,
                                          maxLines: 1,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    top: 10, left: 10),
                                            filled: true,
                                            fillColor: Color(0xFFEEFBFB),
                                            hintText: "Search",
                                            border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                width: 10,
                                                color: Color(0xFFEEFBFB),
                                                style: BorderStyle.none,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                8.0,
                                              ),
                                            ),
                                          ),
                                        )))),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 5, top: 20, bottom: 20, right: 16),
                                child: InkWell(
                                  child: Text(
                                    "Cancel",
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 20, color: Color(0xFFEEFBFB)),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                                padding: const EdgeInsets.only(top: 1),
                                child: DefaultTabController(
                                    length: 2,
                                    child: Column(
                                      children: [
                                        Material(
                                          color: Color(0xFF203647),
                                          elevation: 0,
                                          child: TabBar(
                                            unselectedLabelColor:
                                                Color(0xFFEEFBFB),
                                            indicatorSize:
                                                TabBarIndicatorSize.label,
                                            indicator: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              gradient: LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                  Color(0xff4DA8DA),
                                                  Color(0xff007CC7),
                                                ],
                                              ),
                                            ),
                                            tabs: [
                                              Tab(
                                                  child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    border: Border.all(
                                                        color:
                                                            Color(0xff007CC7),
                                                        width: 1)),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text("Events"),
                                                ),
                                              )),
                                              Tab(
                                                  child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    border: Border.all(
                                                        color:
                                                            Color(0xff007CC7),
                                                        width: 1)),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text("Users"),
                                                ),
                                              ))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: TabBarView(
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(),
                                              children: [
                                                Consumer<EventProvider>(builder:
                                                    (context, data, child) {
                                                  return ListView.builder(
                                                      shrinkWrap: true,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10),
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount: data
                                                          .findEvents.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return ListTile(
                                                          onTap: () => Navigator
                                                                  .of(context)
                                                              .push(MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      DetailsEventScreen(
                                                                          id: data
                                                                              .findEvents[index]
                                                                              .id))),
                                                          title: Text(
                                                            data
                                                                .findEvents[
                                                                    index]
                                                                .title,
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFFEEFBFB)),
                                                          ),
                                                        );
                                                      });
                                                }),
                                                Consumer<UserProvider>(builder:
                                                    (context, data, child) {
                                                  return ListView.builder(
                                                      shrinkWrap: true,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10),
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount: data
                                                          .findUsername.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return ListTile(
                                                            onTap: () => Navigator
                                                                    .of(context)
                                                                .push(MaterialPageRoute(
                                                                    builder: (context) => ProfileScreen(
                                                                        username: data
                                                                            .findUsername[
                                                                                index]
                                                                            .username))),
                                                            leading:
                                                                CircleAvatar(
                                                              child: ClipOval(
                                                                  child: !data
                                                                          .findUsername[
                                                                              index]
                                                                          .profileImage
                                                                          .startsWith(
                                                                              '/')
                                                                      ? Image
                                                                          .asset(
                                                                          'assets/profile_image.png',
                                                                          height:
                                                                              50,
                                                                          width:
                                                                              50,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        )
                                                                      : Image
                                                                          .memory(
                                                                          base64Decode(
                                                                            data.findUsername[index].profileImage,
                                                                          ),
                                                                          height:
                                                                              50,
                                                                          width:
                                                                              50,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        )),
                                                            ),
                                                            title: Text(
                                                                data
                                                                    .findUsername[
                                                                        index]
                                                                    .username,
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xFFEEFBFB),
                                                                )));
                                                      });
                                                }),
                                              ],
                                            )),
                                      ],
                                    )))),
                      ]))),
            )));
  }
}
