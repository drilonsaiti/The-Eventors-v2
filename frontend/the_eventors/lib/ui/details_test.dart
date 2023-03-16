/*import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:readmore/readmore.dart';
import 'package:the_eventors/models/Events.dart';
import 'package:the_eventors/providers/MyActivityProvider.dart';
import 'package:the_eventors/ui/profile_screen.dart';
import 'package:the_eventors/ui/widgets/body_container_details_event_widget.dart';
import '../models/Report.dart';
import '../package/gallery_image/galleryimage.dart';
import '../providers/EventProvider.dart';
import '../providers/ReportProvider.dart';
import '../providers/UserProvider.dart';
import 'activity_per_events_screen.dart';
import 'comments_screen.dart';
import 'map_screen.dart';

class DetailTest extends StatefulWidget {
  final int? id;
  const DetailTest({Key? key, required this.id}) : super(key: key);

  @override
  _DetailTestState createState() => _DetailTestState();
}

class _DetailTestState extends State<DetailTest> {
  int index = 0;
  bool isLoading = true;
  Events event = Events(images: [], going: [], interested: [], guest: []);

  String reportType = "";
  List<Report> reportTypes = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<EventProvider>(context, listen: false).getEventById(widget.id!);

    Provider.of<ReportProvider>(context, listen: false).getReportTypes();
    Future.delayed(const Duration(seconds: 2), () async {
      event = context.read<EventProvider>().event;

      reportTypes = context.read<ReportProvider>().reports;

      setState(() {
        isLoading = false;
      });
    });
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
                  body: isLoading
                      ? Container(
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator())
                      : ListView(
                          children: [
                            Stack(children: [
                              if (!isLoading)
                                Container(
                                  constraints: const BoxConstraints(
                                      maxHeight: 310, minHeight: 310),
                                  child: Image.memory(
                                    base64Decode(event.coverImage),
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
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context, true);
                                                },
                                                child: const Icon(
                                                  Icons.arrow_back,
                                                  color: Color(0xFF12232E),
                                                ),
                                                style: ButtonStyle(
                                                  shape:
                                                      MaterialStateProperty.all(
                                                          const CircleBorder()),
                                                  fixedSize:
                                                      MaterialStateProperty.all(
                                                          const Size(20, 20)),
                                                  padding:
                                                      MaterialStateProperty.all(
                                                          const EdgeInsets.all(
                                                              0)),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          const Color(
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
                                                        const EdgeInsets.only(
                                                            top: 10,
                                                            bottom: 10),
                                                    child: ElevatedButton(
                                                      onPressed: () {},
                                                      child: const Icon(
                                                        Icons.share,
                                                        color:
                                                            Color(0xFF12232E),
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
                                                            MaterialStateProperty.all(
                                                                const EdgeInsets
                                                                    .all(0)),
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(const Color(
                                                                    0xFFEEFBFB)), // <-- Button color
                                                      ),
                                                    )),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10,
                                                            bottom: 10,
                                                            right: 13,
                                                            left: 13),
                                                    child:
                                                        PopupMenuButton<Report>(
                                                            itemBuilder:
                                                                (context) => [
                                                                      for (int i =
                                                                              0;
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
                                                            child: Container(
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
                                                                size: 35,
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
                                  left: true
                                      ? MediaQuery.of(context).size.width - 210
                                      : MediaQuery.of(context).size.width - 129,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        if (true)
                                          Padding(
                                              padding: const EdgeInsets.only(
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
                                                            isLoading = true;
                                                            initState();
                                                          }));
                                                },
                                                child: Text(
                                                  "Activity",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Color(0xFF12232E),
                                                      fontSize: 14.sp),
                                                ),
                                                style: ButtonStyle(
                                                  fixedSize:
                                                      MaterialStateProperty.all(
                                                          const Size(80, 30)),
                                                  padding:
                                                      MaterialStateProperty.all(
                                                          const EdgeInsets.all(
                                                              0)),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          const Color(
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
                                                                    .id!)))
                                                    .then(
                                                        (value) => setState(() {
                                                              isLoading = true;
                                                              initState();
                                                            }));
                                                ;
                                              },
                                              child: const Icon(
                                                Icons.comment_outlined,
                                                color: Color(0xFF12232E),
                                              ),
                                              style: ButtonStyle(
                                                shape:
                                                    MaterialStateProperty.all(
                                                        const CircleBorder()),
                                                fixedSize:
                                                    MaterialStateProperty.all(
                                                        const Size(20, 20)),
                                                padding:
                                                    MaterialStateProperty.all(
                                                        const EdgeInsets.all(
                                                            0)),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        const Color(
                                                            0xFFEEFBFB)), // <-- Button color
                                              ),
                                            )),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              child: true
                                                  ? const Icon(
                                                      Icons
                                                          .bookmark_add_outlined,
                                                      color: Color(0xFF12232E),
                                                    )
                                                  : const Icon(
                                                      Icons.bookmark_add,
                                                      color: Color(0xFF12232E),
                                                    ),
                                              style: ButtonStyle(
                                                shape:
                                                    MaterialStateProperty.all(
                                                        const CircleBorder()),
                                                fixedSize:
                                                    MaterialStateProperty.all(
                                                        const Size(20, 20)),
                                                padding:
                                                    MaterialStateProperty.all(
                                                        const EdgeInsets.all(
                                                            0)),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        const Color(
                                                            0xFFEEFBFB)), // <-- Button color
                                              ),
                                            )),
                                      ])),
                              Positioned(
                                  top: 271,
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF203647),
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(60),
                                            topRight: Radius.circular(60)),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.8),
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
                            Container(
                                padding: const EdgeInsets.only(left: 15),
                                color: const Color(0xFF203647),
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProfileScreen(
                                                                    username: event
                                                                        .createdBy)))
                                                        .then((value) =>
                                                            setState(() {
                                                              isLoading = true;
                                                              initState();
                                                            }));
                                                  },
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                          radius:
                                                              18, // Image radius
                                                          backgroundImage:
                                                              Image.asset(
                                                            'assets/profile_image.png',
                                                            height: 50,
                                                            width: 50,
                                                            fit: BoxFit.cover,
                                                          ).image),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        event.createdBy,
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xFFEEFBFB)),
                                                      )
                                                    ],
                                                  )),
                                              Container(
                                                alignment: Alignment.topLeft,
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Text(
                                                  event.title,
                                                  style: const TextStyle(
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFFEEFBFB)),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.topLeft,
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Row(children: [
                                                  const Icon(
                                                    Icons.date_range,
                                                    color: Color(0xFFEEFBFB),
                                                  ),
                                                  Text(
                                                    event.startDateTime,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFFEEFBFB)),
                                                  )
                                                ]),
                                              ),
                                              Container(
                                                  alignment: Alignment.topLeft,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5),
                                                  child: InkWell(
                                                    onTap: () => Navigator.of(
                                                            context)
                                                        .push(MaterialPageRoute(
                                                            builder: (context) =>
                                                                MapScreen(
                                                                    address: event
                                                                        .location))),
                                                    child: Row(children: [
                                                      const Icon(
                                                        Icons.location_on,
                                                        color:
                                                            Color(0xFFEEFBFB),
                                                      ),
                                                      Text(event.location,
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0xFFEEFBFB)))
                                                    ]),
                                                  )),
                                              Container(
                                                  width: 0.95.sw,
                                                  alignment: Alignment.topLeft,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10, right: 10),
                                                  child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 5),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: const [
                                                                Text(
                                                                    "People are going",
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0xFFEEFBFB))),
                                                              ],
                                                            )),
                                                        SizedBox(
                                                          height: 45,
                                                          child: Stack(
                                                            children: [
                                                              for (var i = 0;
                                                                  i <
                                                                      event.guest
                                                                              .length %
                                                                          4;
                                                                  i++)
                                                                Positioned(
                                                                  left: (i *
                                                                          (1 -
                                                                              .4) *
                                                                          40)
                                                                      .toDouble(),
                                                                  top: 0,
                                                                  child: (event.going.length %
                                                                              4) !=
                                                                          0
                                                                      ? CircleAvatar(
                                                                          backgroundColor:
                                                                              const Color(0xff007CC7),
                                                                          backgroundImage:
                                                                              Image.memory(
                                                                            base64Decode(event.going[i]),
                                                                            height:
                                                                                300,
                                                                            width:
                                                                                300,
                                                                          ).image,
                                                                          child:
                                                                              Container(
                                                                            clipBehavior:
                                                                                Clip.antiAlias,
                                                                            decoration:
                                                                                BoxDecoration(border: Border.all(color: const Color(0xff007CC7), width: 2), borderRadius: BorderRadius.circular(70)),
                                                                            padding:
                                                                                const EdgeInsets.all(5.0),
                                                                          ),
                                                                          radius:
                                                                              22,
                                                                        )
                                                                      : const Text(
                                                                          ""),
                                                                ),
                                                              Positioned(
                                                                  left: (5 *
                                                                          (1 -
                                                                              .4) *
                                                                          40)
                                                                      .toDouble(),
                                                                  top: 10,
                                                                  child: Text(
                                                                      "0 Going",
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0xFFEEFBFB),
                                                                          fontSize:
                                                                              9.sp))),
                                                              Positioned(
                                                                left: 0.57.sw,
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      0.35.sw,
                                                                  height: 40,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          gradient:
                                                                              LinearGradient(
                                                                            begin:
                                                                                Alignment.topRight,
                                                                            end:
                                                                                Alignment.bottomLeft,
                                                                            colors: false
                                                                                ? const [
                                                                                    Color(0xff4DA8DA),
                                                                                    Color(0xff007CC7),
                                                                                  ]
                                                                                : const [
                                                                                    Color(0xFFEEFBFB),
                                                                                    Color(0xFFEEFBFB),
                                                                                  ],
                                                                          ),
                                                                          borderRadius:
                                                                              const BorderRadius.all(Radius.circular(10)),
                                                                          boxShadow: [
                                                                        BoxShadow(
                                                                          color:
                                                                              const Color(0xFF1C1C1C).withOpacity(0.2),
                                                                          spreadRadius:
                                                                              3,
                                                                          blurRadius:
                                                                              4,
                                                                          offset: const Offset(
                                                                              0,
                                                                              3),
                                                                        )
                                                                      ]),
                                                                  child: MaterialButton(
                                                                      onPressed: () {},
                                                                      child: Center(
                                                                          child: false
                                                                              ? Row(children: [
                                                                                  Icon(
                                                                                    Icons.edit_calendar,
                                                                                    color: Color(0xFF1C1C1C),
                                                                                    size: 20.sp,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 3.w,
                                                                                  ),
                                                                                  Text(
                                                                                    "Going",
                                                                                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xFF1C1C1C)),
                                                                                  )
                                                                                ])
                                                                              : Row(children: [
                                                                                  Icon(
                                                                                    Icons.check,
                                                                                    color: Color(0xFFEEFBFB),
                                                                                    size: 20.sp,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 5.w,
                                                                                  ),
                                                                                  Text(
                                                                                    "Going",
                                                                                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xFFEEFBFB)),
                                                                                  )
                                                                                ]))),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ])),
                                              Container(
                                                  width: 0.95.sw,
                                                  alignment: Alignment.topLeft,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10, right: 10),
                                                  child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 5),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: const [
                                                                Text(
                                                                    "People are interested",
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0xFFEEFBFB))),
                                                              ],
                                                            )),
                                                        SizedBox(
                                                          height: 45,
                                                          child: Stack(
                                                            children: [
                                                              for (var i = 0;
                                                                  i < 0 % 4;
                                                                  i++)
                                                                Positioned(
                                                                  left: (i *
                                                                          (1 -
                                                                              .4) *
                                                                          40)
                                                                      .toDouble(),
                                                                  top: 0,
                                                                  child: (event.interested.length %
                                                                              4) !=
                                                                          0
                                                                      ? CircleAvatar(
                                                                          backgroundColor:
                                                                              const Color(0xff007CC7),
                                                                          backgroundImage:
                                                                              Image.memory(
                                                                            base64Decode(event.interested[i]),
                                                                            height:
                                                                                300,
                                                                            width:
                                                                                300,
                                                                          ).image,
                                                                          child:
                                                                              Container(
                                                                            clipBehavior:
                                                                                Clip.antiAlias,
                                                                            decoration:
                                                                                BoxDecoration(border: Border.all(color: const Color(0xff007CC7), width: 2), borderRadius: BorderRadius.circular(70)),
                                                                            padding:
                                                                                const EdgeInsets.all(5.0),
                                                                          ),
                                                                          radius:
                                                                              22,
                                                                        )
                                                                      : const Text(
                                                                          ""),
                                                                ),
                                                              Positioned(
                                                                  left: (5 *
                                                                          (1 -
                                                                              .4) *
                                                                          40)
                                                                      .toDouble(),
                                                                  top: 12,
                                                                  child: Text(
                                                                      "0 Interested",
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0xFFEEFBFB),
                                                                          fontSize:
                                                                              9.sp))),
                                                              Positioned(
                                                                left: 0.57.sw,
                                                                child: Container(
                                                                    width: 0.35.sw,
                                                                    height: 40,
                                                                    decoration: BoxDecoration(
                                                                        gradient: LinearGradient(
                                                                          begin:
                                                                              Alignment.topRight,
                                                                          end: Alignment
                                                                              .bottomLeft,
                                                                          colors: true
                                                                              ? const [
                                                                                  Color(0xff4DA8DA),
                                                                                  Color(0xff007CC7),
                                                                                ]
                                                                              : const [
                                                                                  Color(0xFFEEFBFB),
                                                                                  Color(0xFFEEFBFB),
                                                                                ],
                                                                        ),
                                                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                const Color(0xFF1C1C1C).withOpacity(0.2),
                                                                            spreadRadius:
                                                                                3,
                                                                            blurRadius:
                                                                                4,
                                                                            offset:
                                                                                const Offset(0, 3),
                                                                          )
                                                                        ]),
                                                                    child: MaterialButton(
                                                                        onPressed: () {},
                                                                        child: Container(
                                                                            child: true
                                                                                ? Row(children: [
                                                                                    Icon(
                                                                                      Icons.star_border_outlined,
                                                                                      color: Color(0xFF1C1C1C),
                                                                                      size: 20.sp,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 3.w,
                                                                                    ),
                                                                                    Text(
                                                                                      "Interested",
                                                                                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Color(0xFF1C1C1C)),
                                                                                    )
                                                                                  ])
                                                                                : Row(children: [
                                                                                    Icon(
                                                                                      Icons.star,
                                                                                      color: Color(0xFFEEFBFB),
                                                                                      size: 20.sp,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 3.w,
                                                                                    ),
                                                                                    Text(
                                                                                      "Interested",
                                                                                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Color(0xFFEEFBFB)),
                                                                                    )
                                                                                  ])))),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ])),
                                              Container(
                                                alignment: Alignment.topLeft,
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: const Text(
                                                  "Description",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFFEEFBFB)),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.topLeft,
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: ReadMoreText(
                                                  event.description,
                                                  trimLines: 5,
                                                  colorClickableText:
                                                      Colors.pink,
                                                  style: const TextStyle(
                                                      color: Color(0xFFEEFBFB)),
                                                  trimMode: TrimMode.Line,
                                                  trimCollapsedText:
                                                      ' Show more',
                                                  trimExpandedText:
                                                      ' Show less',
                                                  moreStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xff007CC7)),
                                                  lessStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xff007CC7)),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Divider(
                                                height: 2,
                                                thickness: 1,
                                                color: Colors.grey,
                                              ),
                                              Container(
                                                alignment: Alignment.topLeft,
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: const Text(
                                                  "Host",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFFEEFBFB)),
                                                ),
                                              ),
                                              SizedBox(
                                                  height: 70,
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      children: [
                                                        for (var i = 0;
                                                            i <
                                                                event.guest
                                                                    .length;
                                                            i++)
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          10),
                                                              child: Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: const Color(
                                                                            0x33007CC7),
                                                                        width:
                                                                            1),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    gradient: const LinearGradient(
                                                                        begin: Alignment
                                                                            .topRight,
                                                                        end: Alignment
                                                                            .bottomLeft,
                                                                        colors: [
                                                                          Color(
                                                                              0xFFEEFBFB),
                                                                          Color(
                                                                              0xFFEEFBFB),
                                                                        ]),
                                                                  ),
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          3.0),
                                                                  child: event
                                                                          .guest[
                                                                              i]
                                                                          .startsWith(
                                                                              "@")
                                                                      ? InkWell(
                                                                          child: Text(
                                                                              event.guest[i],
                                                                              style: const TextStyle(fontSize: 25, color: Color(0xFF1C1C1C))),
                                                                        )
                                                                      : Text(
                                                                          event.guest[
                                                                              i],
                                                                          style:
                                                                              const TextStyle(fontSize: 25),
                                                                        ))),
                                                      ],
                                                    ),
                                                  )),
                                              GalleryImage(
                                                imageUrls: event.images,
                                                numOfShowImages:
                                                    event.images.length >= 3
                                                        ? 3
                                                        : event.images.length,
                                              ),
                                            ])),
                                  ],
                                ))
                          ],
                        ),
                ),
              );
            },
          );
        });
  }
}
*/