import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:the_eventors/models/Events.dart';
import 'package:the_eventors/models/dto/MyEventResponseDto.dart';
import 'package:the_eventors/providers/ActivityProvider.dart';
import 'package:the_eventors/providers/MyActivityProvider.dart';
import 'package:the_eventors/repository/EventRepository.dart';
import 'package:the_eventors/ui/home_screen.dart';
import 'package:the_eventors/ui/multi_edit_form_screen.dart';
import 'package:the_eventors/ui/widgets/body_container_details_event_widget.dart';
import '../models/Report.dart';
import '../providers/EventProvider.dart';
import '../providers/ReportProvider.dart';
import '../providers/UserProvider.dart';
import 'activity_per_events_screen.dart';
import 'comments_screen.dart';
import 'multi_step_form_screen.dart';

class DetailsEventScreen extends StatefulWidget {
  final int? id;
  const DetailsEventScreen({Key? key, required this.id}) : super(key: key);

  @override
  _DetailsEventScreenState createState() => _DetailsEventScreenState();
}

enum PopupMenuAction {
  edit,
  remove,
}

class _DetailsEventScreenState extends State<DetailsEventScreen> {
  int index = 0;
  bool isLoading = true;
  String check = "";
  Events event = Events(images: [], going: [], interested: [], guest: []);
  String username = "";
  String checkBookmark = "false";
  String reportType = "";
  List<Report> reportTypes = [];
  var key = UniqueKey();
  var eventFuture;

  @override
  void initState() {
    Provider.of<MyActivityProvider>(context, listen: false).getMyGoingEvents();
    Provider.of<EventProvider>(context, listen: false).getActivity(widget.id!);
    // TODO: implement initState
    super.initState();
    Provider.of<EventProvider>(context, listen: false).getEventById(widget.id!);
    Provider.of<EventProvider>(context, listen: false).getComments(widget.id!);
    Provider.of<MyActivityProvider>(context, listen: false)
        .checkGoing(widget.id!);
    Provider.of<UserProvider>(context, listen: false).checkBookmark(widget.id!);
    Provider.of<ReportProvider>(context, listen: false).getReportTypes();
    Provider.of<UserProvider>(context, listen: false).getUsername();

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
                      body: FutureBuilder(
                        future: EventRepository().getEventById(widget.id!),
                        builder: (context, AsyncSnapshot<Events?> snapshot) {
                          checkBookmark = context.read<UserProvider>().checkBM;
                          reportTypes = context.read<ReportProvider>().reports;
                          check =
                              context.read<MyActivityProvider>().checkGoingBt;
                          username = context.read<UserProvider>().username;
                          if (snapshot.hasData) {
                            return ListView(
                              children: [
                                Stack(children: [
                                  Container(
                                    constraints: const BoxConstraints(
                                        maxHeight: 310, minHeight: 310),
                                    child: Image.memory(
                                      base64Decode(snapshot.data!.coverImage),
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, true);
                                                    },
                                                    child: Icon(
                                                      Icons.arrow_back,
                                                      size: 25.sp,
                                                      color: Color(0xFF12232E),
                                                    ),
                                                    style: ButtonStyle(
                                                      shape: MaterialStateProperty
                                                          .all(
                                                              const CircleBorder()),
                                                      fixedSize:
                                                          MaterialStateProperty
                                                              .all(const Size(
                                                                  20, 20)),
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(
                                                                  const EdgeInsets
                                                                      .all(0)),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(const Color(
                                                                  0xFFEEFBFB)), // <-- Button color
                                                    ),
                                                  )),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 10,
                                                                bottom: 10),
                                                        child: ElevatedButton(
                                                          onPressed: () async {
                                                            await FlutterShare.share(
                                                                title: snapshot
                                                                    .data!
                                                                    .title,
                                                                text: snapshot
                                                                        .data!
                                                                        .title +
                                                                    "\n" +
                                                                    snapshot
                                                                        .data!
                                                                        .startDateTime +
                                                                    "\n" +
                                                                    snapshot
                                                                        .data!
                                                                        .category,
                                                                linkUrl:
                                                                    '192.168.1.8:9090/#/details/${snapshot.data!.id}',
                                                                chooserTitle:
                                                                    'Example Chooser Title');
                                                          },
                                                          child: Icon(
                                                            Icons.share,
                                                            size: 25.sp,
                                                            color: Color(
                                                                0xFF12232E),
                                                          ),
                                                          style: ButtonStyle(
                                                            shape: MaterialStateProperty
                                                                .all(
                                                                    const CircleBorder()),
                                                            fixedSize:
                                                                MaterialStateProperty
                                                                    .all(const Size(
                                                                        20,
                                                                        20)),
                                                            padding: MaterialStateProperty.all(
                                                                const EdgeInsets
                                                                    .all(0)),
                                                            backgroundColor:
                                                                MaterialStateProperty.all(
                                                                    const Color(
                                                                        0xFFEEFBFB)), // <-- Button color
                                                          ),
                                                        )),
                                                    snapshot.data!.createdBy ==
                                                            username
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10,
                                                                    bottom: 10,
                                                                    right: 13,
                                                                    left: 13),
                                                            child: PopupMenuButton<
                                                                    PopupMenuAction>(
                                                                itemBuilder:
                                                                    (context) =>
                                                                        [
                                                                          PopupMenuItem(
                                                                              onTap: () {},
                                                                              value: PopupMenuAction.edit,
                                                                              child: ListTile(
                                                                                  onTap: () {
                                                                                    Navigator.pop(context);
                                                                                    Navigator.of(context)
                                                                                        .push(MaterialPageRoute(
                                                                                            builder: (context) => MultiEditFormScreen(
                                                                                                  event: snapshot.data!,
                                                                                                )))
                                                                                        .then((value) => setState(() {
                                                                                              initState();
                                                                                            }));
                                                                                  },
                                                                                  leading: Icon(
                                                                                    Icons.edit,
                                                                                    color: Color(0xFF007CC7),
                                                                                  ),
                                                                                  title: Text("Edit"))),
                                                                          PopupMenuItem(
                                                                              value: PopupMenuAction.remove,
                                                                              onTap: () {
                                                                                var undo = false;
                                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                    backgroundColor: const Color(0xFFEEFBFB),
                                                                                    action: SnackBarAction(
                                                                                        label: "Undo",
                                                                                        onPressed: () {
                                                                                          undo = true;
                                                                                        }),
                                                                                    content: Row(
                                                                                      children: const [
                                                                                        Icon(Icons.check_circle, color: Color(0xFF12232E)),
                                                                                        SizedBox(
                                                                                          width: 5,
                                                                                        ),
                                                                                        Text(
                                                                                          "Event has been deleted",
                                                                                          style: TextStyle(color: Color(0xFF12232E), fontSize: 14),
                                                                                        ),
                                                                                      ],
                                                                                    )));

                                                                                Future.delayed(Duration(seconds: 3), () {
                                                                                  if (undo) {
                                                                                    //remove event
                                                                                    Navigator.pop(context);
                                                                                  } else {
                                                                                    Provider.of<EventProvider>(context, listen: false).deleteEvent(widget.id);
                                                                                    Navigator.pop(context, true);
                                                                                  }
                                                                                });
                                                                              },
                                                                              child: ListTile(leading: Icon(Icons.delete, color: Colors.redAccent), title: Text("Delete"))),
                                                                        ],
                                                                child:
                                                                    Container(
                                                                  height: 48,
                                                                  width: 38,
                                                                  decoration:
                                                                      new BoxDecoration(
                                                                    color: Color(
                                                                        0xFFEEFBFB),
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Icon(
                                                                    Icons
                                                                        .more_vert,
                                                                    size: 35.sp,
                                                                    color: Color(
                                                                        0xFF12232E),
                                                                  ),
                                                                )))
                                                        : Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10,
                                                                    bottom: 10,
                                                                    right: 13,
                                                                    left: 13),
                                                            child: PopupMenuButton<
                                                                    Report>(
                                                                itemBuilder:
                                                                    (context) =>
                                                                        [
                                                                          for (int i = 0;
                                                                              i < reportTypes.length;
                                                                              i++)
                                                                            PopupMenuItem(
                                                                                onTap: () {
                                                                                  Provider.of<ReportProvider>(context, listen: false).addReportEvent(widget.id!, reportTypes[i].name);
                                                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                      backgroundColor: const Color(0xFFEEFBFB),
                                                                                      content: Row(
                                                                                        children: const [
                                                                                          Icon(Icons.check_circle, color: Color(0xFF12232E)),
                                                                                          SizedBox(
                                                                                            width: 5,
                                                                                          ),
                                                                                          Text(
                                                                                            "Report is recived.Thanks for letting us know",
                                                                                            style: TextStyle(color: Color(0xFF12232E), fontSize: 14),
                                                                                          ),
                                                                                        ],
                                                                                      )));
                                                                                },
                                                                                child: Text(reportTypes[i].name))
                                                                        ],
                                                                child:
                                                                    Container(
                                                                  height: 48,
                                                                  width: 38,
                                                                  decoration:
                                                                      new BoxDecoration(
                                                                    color: Color(
                                                                        0xFFEEFBFB),
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Icon(
                                                                    Icons
                                                                        .report_outlined,
                                                                    size: 35.sp,
                                                                    color: Color(
                                                                        0xFF12232E),
                                                                  ),
                                                                ))),
                                                  ])
                                            ],
                                          ),
                                        ],
                                      )),
                                  Positioned(
                                      top: 200,
                                      left: snapshot.data!.createdBy == username
                                          ? MediaQuery.of(context).size.width -
                                              210
                                          : MediaQuery.of(context).size.width -
                                              129,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            if (snapshot.data!.createdBy ==
                                                username)
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10, bottom: 10),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .push(MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ActivityPerEventScreen(
                                                                      id: widget
                                                                          .id!)))
                                                          .then((value) =>
                                                              setState(() {
                                                                isLoading =
                                                                    true;
                                                                initState();
                                                              }));
                                                    },
                                                    child: Text(
                                                      "Activity",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF12232E),
                                                          fontSize: 14.sp),
                                                    ),
                                                    style: ButtonStyle(
                                                      fixedSize:
                                                          MaterialStateProperty
                                                              .all(const Size(
                                                                  80, 30)),
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(
                                                                  const EdgeInsets
                                                                      .all(0)),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(const Color(
                                                                  0xFFEEFBFB)), // <-- Button color
                                                    ),
                                                  )),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                            builder: (context) =>
                                                                CommentScreen(
                                                                  id: widget
                                                                      .id!,
                                                                  username: snapshot
                                                                      .data!
                                                                      .createdBy,
                                                                )))
                                                        .then((value) =>
                                                            setState(() {
                                                              isLoading = true;
                                                              initState();
                                                            }));
                                                    ;
                                                  },
                                                  child: Icon(
                                                    Icons.comment_outlined,
                                                    size: 25.sp,
                                                    color: Color(0xFF12232E),
                                                  ),
                                                  style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .all(
                                                            const CircleBorder()),
                                                    fixedSize:
                                                        MaterialStateProperty
                                                            .all(const Size(
                                                                20, 20)),
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(
                                                                const EdgeInsets
                                                                    .all(0)),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(const Color(
                                                                0xFFEEFBFB)), // <-- Button color
                                                  ),
                                                )),
                                            ChangeNotifierProvider(
                                                create: (_) =>
                                                    MyActivityProvider(),
                                                child: Consumer<
                                                    MyActivityProvider>(
                                                  builder: (context, appState,
                                                          _) =>
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 10,
                                                                  bottom: 10),
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              if (!appState
                                                                  .check
                                                                  .contains(
                                                                      snapshot
                                                                          .data!
                                                                          .id)) {
                                                                Provider.of<UserProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .addBookmark(
                                                                        snapshot
                                                                            .data!
                                                                            .id);
                                                                Provider.of<MyActivityProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .addBookmark(
                                                                        snapshot
                                                                            .data!
                                                                            .id);

                                                                /* setState(() {
                                                                                  bookmarks.add(snapshot.data[index].id);
                                                                                });*/
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
                                                                          .data!
                                                                          .id);
                                                                  Provider.of<MyActivityProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .removeBookmark(snapshot
                                                                          .data!
                                                                          .id);

                                                                  /*setState(() {
                                                                                    bookmarks.remove(snapshot.data[index].id);
                                                                                  });*/
                                                                });
                                                              }
                                                            },
                                                            child: !appState
                                                                    .check
                                                                    .contains(
                                                                        snapshot
                                                                            .data!
                                                                            .id)
                                                                ? Icon(
                                                                    Icons
                                                                        .bookmark_add_outlined,
                                                                    size: 25.sp,
                                                                    color: Color(
                                                                        0xFF12232E),
                                                                  )
                                                                : Icon(
                                                                    Icons
                                                                        .bookmark_add,
                                                                    size: 25.sp,
                                                                    color: Color(
                                                                        0xFF12232E),
                                                                  ),
                                                            style: ButtonStyle(
                                                              shape: MaterialStateProperty
                                                                  .all(
                                                                      const CircleBorder()),
                                                              fixedSize:
                                                                  MaterialStateProperty.all(
                                                                      const Size(
                                                                          20,
                                                                          20)),
                                                              padding: MaterialStateProperty.all(
                                                                  const EdgeInsets
                                                                      .all(0)),
                                                              backgroundColor:
                                                                  MaterialStateProperty.all(
                                                                      const Color(
                                                                          0xFFEEFBFB)), // <-- Button color
                                                            ),
                                                          )),
                                                ))
                                          ])),
                                  Positioned(
                                      top: 271,
                                      child: ConstrainedBox(
                                        constraints: const BoxConstraints(),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF203647),
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(60),
                                                    topRight:
                                                        Radius.circular(60)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.8),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: const Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Container(
                                              child: Column(
                                                children: const [],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                                ]),
                                BodyOfDetailsEventWidget(
                                  event: snapshot.data!,
                                  check: check,
                                )
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Text(
                                "We're sorry, but error happening $snapshot.error");
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF007CC7),
                              ),
                            );
                          }
                        },
                      )),
                );
              },
            );
          });
    }
  }

