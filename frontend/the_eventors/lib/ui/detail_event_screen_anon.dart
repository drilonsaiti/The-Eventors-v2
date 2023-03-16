import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/game_icons.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/models/Events.dart';

import 'package:url_launcher/url_launcher.dart';
import '../models/Report.dart';
import '../package/gallery_image/galleryimage.dart';
import '../providers/EventProvider.dart';

class DetailsEventScreenAnon extends StatefulWidget {
  final int? id;
  const DetailsEventScreenAnon({Key? key, required this.id}) : super(key: key);

  @override
  _DetailsEventScreenAnonState createState() => _DetailsEventScreenAnonState();
}

enum PopupMenuAction {
  edit,
  remove,
}

class _DetailsEventScreenAnonState extends State<DetailsEventScreenAnon> {
  int index = 0;
  bool isLoading = true;
  String check = "";
  Events event = Events(images: [], going: [], interested: [], guest: []);
  String username = "";
  String checkBookmark = "false";
  String reportType = "";
  List<Report> reportTypes = [];
  String text =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  var key = UniqueKey();
  var eventFuture;
  bool descTextShowFlag = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("WIDGET IDDD");
    Provider.of<EventProvider>(context, listen: false).getEventById(widget.id!);
    //Provider.of<EventProvider>(context, listen: false).getComments(id!);
    Future.delayed(Duration(seconds: 3), () {
      event = context.read<EventProvider>().event;

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
    print("EVENT");
    print(event.category);

    return isLoading
        ? Text("")
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF203647)),
            builder: (context, child) {
              return GetPlatform.isMobile
                  ? ScreenUtilInit(
                      designSize: const Size(360, 690),
                      minTextAdapt: true,
                      splitScreenMode: true,
                      builder: (context, child) {
                        return SafeArea(
                            child: Scaffold(
                                backgroundColor: const Color(0xFF203647),
                                body: ListView(
                                  children: [
                                    Stack(children: [
                                      Container(
                                        constraints: const BoxConstraints(
                                            maxHeight: 310, minHeight: 310),
                                        child: Image.memory(
                                          base64Decode(event!.coverImage),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                          top: 271,
                                          child: ConstrainedBox(
                                            constraints: const BoxConstraints(),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF203647),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(60),
                                                        topRight:
                                                            Radius.circular(
                                                                60)),
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
                                                padding:
                                                    const EdgeInsets.all(20),
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
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        color: const Color(0xFF203647),
                                        child: Column(
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      InkWell(
                                                          onTap: () {},
                                                          child: Row(
                                                            children: [
                                                              CircleAvatar(
                                                                  radius:
                                                                      18, // Image radius
                                                                  backgroundImage:
                                                                      Image
                                                                          .asset(
                                                                    'assets/profile_image.png',
                                                                    height: 50,
                                                                    width: 50,
                                                                    fit: BoxFit
                                                                        .cover,
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
                                                        alignment:
                                                            Alignment.topLeft,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5),
                                                        child: Text(
                                                          event.title,
                                                          style: const TextStyle(
                                                              fontSize: 30,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xFFEEFBFB)),
                                                        ),
                                                      ),
                                                      Container(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 5),
                                                          child: InkWell(
                                                            child:
                                                                Row(children: [
                                                              const Icon(
                                                                Icons
                                                                    .location_on,
                                                                color: Color(
                                                                    0xFFEEFBFB),
                                                              ),
                                                              SizedBox(
                                                                width: 5.w,
                                                              ),
                                                              Flexible(
                                                                  child: InkWell(
                                                                      child: Text(
                                                                event.location,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                softWrap: false,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color(
                                                                        0xFFEEFBFB),
                                                                    fontSize:
                                                                        14.sp),
                                                              )))
                                                            ]),
                                                          )),
                                                      Container(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5),
                                                        child: Row(children: [
                                                          const Icon(
                                                            Icons.date_range,
                                                            color: Color(
                                                                0xFFEEFBFB),
                                                          ),
                                                          SizedBox(
                                                            width: 5.w,
                                                          ),
                                                          Text(
                                                            event.startDateTime,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            softWrap: false,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14.sp,
                                                                color: Color(
                                                                    0xFFEEFBFB)),
                                                          ),
                                                          SizedBox(
                                                            width: 75.w,
                                                          ),
                                                          const Iconify(
                                                            GameIcons.duration,
                                                            color: Color(
                                                                0xFFEEFBFB),
                                                          ),
                                                          SizedBox(
                                                            width: 5.w,
                                                          ),
                                                          Text(
                                                            event.duration,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            softWrap: false,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14.sp,
                                                                color: Color(
                                                                    0xFFEEFBFB)),
                                                          )
                                                        ]),
                                                      ),
                                                      Container(
                                                          width: 0.95.sw,
                                                          alignment:
                                                              Alignment.topLeft,
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10,
                                                                  right: 10),
                                                          child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            5),
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
                                                                            style:
                                                                                TextStyle(color: Color(0xFFEEFBFB))),
                                                                      ],
                                                                    )),
                                                                SizedBox(
                                                                  height: 45,
                                                                  child: Stack(
                                                                    children: [
                                                                      for (var i =
                                                                              0;
                                                                          i < event.guest.length % 4;
                                                                          i++)
                                                                        Positioned(
                                                                          left:
                                                                              (i * (1 - .4) * 40).toDouble(),
                                                                          top:
                                                                              0,
                                                                          child: (event.going.length % 4) != 0
                                                                              ? CircleAvatar(
                                                                                  backgroundColor: const Color(0xff007CC7),
                                                                                  backgroundImage: Image.memory(
                                                                                    base64Decode(event.going[i]),
                                                                                    height: 300,
                                                                                    width: 300,
                                                                                  ).image,
                                                                                  child: Container(
                                                                                    clipBehavior: Clip.antiAlias,
                                                                                    decoration: BoxDecoration(border: Border.all(color: const Color(0xff007CC7), width: 2), borderRadius: BorderRadius.circular(70)),
                                                                                    padding: const EdgeInsets.all(5.0),
                                                                                  ),
                                                                                  radius: 22,
                                                                                )
                                                                              : const Text(""),
                                                                        ),
                                                                      Positioned(
                                                                          left: (5 * (1 - .4) * 40)
                                                                              .toDouble(),
                                                                          top:
                                                                              10,
                                                                          child: Text(
                                                                              "0" + " Going",
                                                                              style: TextStyle(color: Color(0xFFEEFBFB), fontSize: 10.5.sp))),
                                                                      Positioned(
                                                                        left: 0.57
                                                                            .sw,
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              0.30.sw,
                                                                          height:
                                                                              40,
                                                                          decoration: BoxDecoration(
                                                                              gradient: LinearGradient(
                                                                                begin: Alignment.topRight,
                                                                                end: Alignment.bottomLeft,
                                                                                colors: check == "going"
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
                                                                                  color: const Color(0xFF1C1C1C).withOpacity(0.2),
                                                                                  spreadRadius: 3,
                                                                                  blurRadius: 4,
                                                                                  offset: const Offset(0, 3),
                                                                                )
                                                                              ]),
                                                                          child: MaterialButton(
                                                                              onPressed: () {},
                                                                              child: Center(
                                                                                  child: Row(children: [
                                                                                Icon(
                                                                                  Icons.edit_calendar,
                                                                                  color: Color(0xFF1C1C1C),
                                                                                  size: 20.sp,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5.w,
                                                                                ),
                                                                                Text(
                                                                                  "Going",
                                                                                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xFF1C1C1C)),
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
                                                          alignment:
                                                              Alignment.topLeft,
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10,
                                                                  right: 10),
                                                          child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            5),
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
                                                                            style:
                                                                                TextStyle(color: Color(0xFFEEFBFB))),
                                                                      ],
                                                                    )),
                                                                SizedBox(
                                                                  height: 45,
                                                                  child: Stack(
                                                                    children: [
                                                                      for (var i =
                                                                              0;
                                                                          i < event.interested.length % 4;
                                                                          i++)
                                                                        Positioned(
                                                                          left:
                                                                              (i * (1 - .4) * 40).toDouble(),
                                                                          top:
                                                                              0,
                                                                          child: (event.interested.length % 4) != 0
                                                                              ? CircleAvatar(
                                                                                  backgroundColor: const Color(0xff007CC7),
                                                                                  backgroundImage: Image.memory(
                                                                                    base64Decode(event.interested[i]),
                                                                                    height: 300,
                                                                                    width: 300,
                                                                                  ).image,
                                                                                  child: Container(
                                                                                    clipBehavior: Clip.antiAlias,
                                                                                    decoration: BoxDecoration(border: Border.all(color: const Color(0xff007CC7), width: 2), borderRadius: BorderRadius.circular(70)),
                                                                                    padding: const EdgeInsets.all(5.0),
                                                                                  ),
                                                                                  radius: 22,
                                                                                )
                                                                              : const Text(""),
                                                                        ),
                                                                      Positioned(
                                                                          left: (5 * (1 - .4) * 40)
                                                                              .toDouble(),
                                                                          top:
                                                                              12,
                                                                          child: Text(
                                                                              '0' + " Interested",
                                                                              style: TextStyle(color: Color(0xFFEEFBFB), fontSize: 10.5.sp))),
                                                                      Positioned(
                                                                        left: 0.57
                                                                            .sw,
                                                                        child: Container(
                                                                            width: 0.35.sw,
                                                                            height: 40,
                                                                            decoration: BoxDecoration(
                                                                                gradient: LinearGradient(
                                                                                  begin: Alignment.topRight,
                                                                                  end: Alignment.bottomLeft,
                                                                                  colors: check == "interested"
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
                                                                                    color: const Color(0xFF1C1C1C).withOpacity(0.2),
                                                                                    spreadRadius: 3,
                                                                                    blurRadius: 4,
                                                                                    offset: const Offset(0, 3),
                                                                                  )
                                                                                ]),
                                                                            child: MaterialButton(
                                                                                onPressed: () {},
                                                                                child: Container(
                                                                                    child: Row(children: [
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
                                                                                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xFF1C1C1C)),
                                                                                  )
                                                                                ])))),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ])),
                                                      Container(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 10),
                                                        child: const Text(
                                                          "Description",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xFFEEFBFB)),
                                                        ),
                                                      ),
                                                      /*ReadMoreText(
                                "Data with " + "www.example.com" + "",
                                trimLines: 5,
                                colorClickableText: Colors.pink,
                                style: TextStyle(color: Color(0xFFEEFBFB)),
                                trimMode: TrimMode.Line,
                                trimCollapsedText: ' Show more',
                                trimExpandedText: ' Show less',
                                moreStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff007CC7)),
                                lessStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff007CC7)),
                              ), */
                                                      Container(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 10,
                                                                right: 15),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Linkify(
                                                                onOpen: (link) =>
                                                                    launchUrl(Uri
                                                                        .parse(link
                                                                            .url)),
                                                                text:
                                                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                                                maxLines:
                                                                    descTextShowFlag
                                                                        ? 300
                                                                        : 5,
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xFFEEFBFB))),
                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  descTextShowFlag =
                                                                      !descTextShowFlag;
                                                                });
                                                              },
                                                              child: Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              10),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: <
                                                                        Widget>[
                                                                      descTextShowFlag
                                                                          ? Text(
                                                                              "Show Less",
                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff007CC7)),
                                                                            )
                                                                          : Text(
                                                                              "Show More",
                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff007CC7)))
                                                                    ],
                                                                  )),
                                                            ),
                                                          ],
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
                                                        alignment:
                                                            Alignment.topLeft,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 10),
                                                        child: const Text(
                                                          "Host",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xFFEEFBFB)),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height: 70,
                                                          child:
                                                              SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            child: Row(
                                                              children: [
                                                                for (var i = 0;
                                                                    i <
                                                                        event
                                                                            .guest
                                                                            .length;
                                                                    i++)
                                                                  Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              10),
                                                                      child: Container(
                                                                          decoration: BoxDecoration(
                                                                            border:
                                                                                Border.all(color: const Color(0x33007CC7), width: 1),
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            gradient:
                                                                                const LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [
                                                                              Color(0xFFEEFBFB),
                                                                              Color(0xFFEEFBFB),
                                                                            ]),
                                                                          ),
                                                                          padding: const EdgeInsets.all(3.0),
                                                                          child: Text(
                                                                            event.guest[i],
                                                                            style:
                                                                                const TextStyle(fontSize: 25),
                                                                          ))),
                                                              ],
                                                            ),
                                                          )),
                                                      GalleryImage(
                                                        imageUrls: event.images,
                                                        numOfShowImages: event
                                                                    .images
                                                                    .length >=
                                                                3
                                                            ? 3
                                                            : event
                                                                .images.length,
                                                      ),
                                                    ])),
                                          ],
                                        ))
                                  ],
                                )));
                      },
                    )
                  : Scaffold(
                      backgroundColor: const Color(0xFF203647),
                      body: Container(
                          alignment: Alignment.center,
                          child: SafeArea(
                              child: Container(
                                  alignment: Alignment.center,
                                  child: LayoutBuilder(
                                      builder: (context, constraints) {
                                    final span = TextSpan(
                                        text: text, style: TextStyle());
                                    final tp = TextPainter(
                                        text: span,
                                        maxLines: 5,
                                        textDirection: TextDirection.ltr);
                                    ;
                                    tp.layout(maxWidth: constraints.maxWidth);
                                    final numLines =
                                        tp.computeLineMetrics().length;
                                    print("NUM OF LINES");
                                    print(numLines);
                                    return ListView(
                                      shrinkWrap: true,
                                      children: [
                                        Container(
                                            alignment: Alignment.center,
                                            child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Container(
                                                    constraints:
                                                        const BoxConstraints(
                                                            maxHeight: 310,
                                                            minHeight: 310),
                                                    child: Image.memory(
                                                      base64Decode(
                                                          event!.coverImage),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Positioned(
                                                      top: 271,
                                                      child: ConstrainedBox(
                                                        constraints:
                                                            const BoxConstraints(),
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFF203647),
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        60),
                                                                topRight: Radius
                                                                    .circular(
                                                                        60)),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.8),
                                                                spreadRadius: 5,
                                                                blurRadius: 7,
                                                                offset: const Offset(
                                                                    0,
                                                                    3), // changes position of shadow
                                                              ),
                                                            ],
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            child: Container(
                                                              child: Column(
                                                                children: const [],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ))
                                                ])),
                                        Center(
                                            child: Container(
                                                width: 700,
                                                alignment: Alignment.center,
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                color: const Color(0xFF203647),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 10),
                                                        child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              InkWell(
                                                                  onTap: () {},
                                                                  child: Row(
                                                                    children: [
                                                                      CircleAvatar(
                                                                          radius:
                                                                              18, // Image radius
                                                                          backgroundImage:
                                                                              Image.asset(
                                                                            'assets/profile_image.png',
                                                                            height:
                                                                                50,
                                                                            width:
                                                                                50,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ).image),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        event
                                                                            .createdBy,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Color(0xFFEEFBFB)),
                                                                      )
                                                                    ],
                                                                  )),
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 5),
                                                                child: Text(
                                                                  event.title,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          30,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color(
                                                                          0xFFEEFBFB)),
                                                                ),
                                                              ),
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 5),
                                                                  child:
                                                                      InkWell(
                                                                    onTap:
                                                                        () {},
                                                                    child: Row(
                                                                        children: [
                                                                          const Icon(
                                                                            Icons.location_on,
                                                                            color:
                                                                                Color(0xFFEEFBFB),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          Flexible(
                                                                              child: InkWell(
                                                                                  child: Text(
                                                                            event.location,
                                                                            maxLines:
                                                                                1,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            softWrap:
                                                                                false,
                                                                            style: TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Color(0xFFEEFBFB),
                                                                                fontSize: 14),
                                                                          )))
                                                                        ]),
                                                                  )),
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 5),
                                                                child: Row(
                                                                    children: [
                                                                      const Icon(
                                                                        Icons
                                                                            .date_range,
                                                                        color: Color(
                                                                            0xFFEEFBFB),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        event
                                                                            .startDateTime,
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        softWrap:
                                                                            false,
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Color(0xFFEEFBFB)),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            75,
                                                                      ),
                                                                      const Iconify(
                                                                        GameIcons
                                                                            .duration,
                                                                        color: Color(
                                                                            0xFFEEFBFB),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        event
                                                                            .duration,
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        softWrap:
                                                                            false,
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Color(0xFFEEFBFB)),
                                                                      )
                                                                    ]),
                                                              ),
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 10,
                                                                      right:
                                                                          10),
                                                                  child: Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(bottom: 5),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: const [
                                                                                Text("People are going", style: TextStyle(color: Color(0xFFEEFBFB))),
                                                                              ],
                                                                            )),
                                                                        SizedBox(
                                                                          height:
                                                                              45,
                                                                          child:
                                                                              Stack(
                                                                            children: [
                                                                              for (var i = 0; i < event.guest.length % 4; i++)
                                                                                Positioned(
                                                                                  left: (i * (1 - .4) * 40).toDouble(),
                                                                                  top: 0,
                                                                                  child: (event.going.length % 4) != 0
                                                                                      ? CircleAvatar(
                                                                                          backgroundColor: const Color(0xff007CC7),
                                                                                          backgroundImage: Image.memory(
                                                                                            base64Decode(event.going[i]),
                                                                                            height: 300,
                                                                                            width: 300,
                                                                                          ).image,
                                                                                          child: Container(
                                                                                            clipBehavior: Clip.antiAlias,
                                                                                            decoration: BoxDecoration(border: Border.all(color: const Color(0xff007CC7), width: 2), borderRadius: BorderRadius.circular(70)),
                                                                                            padding: const EdgeInsets.all(5.0),
                                                                                          ),
                                                                                          radius: 22,
                                                                                        )
                                                                                      : const Text(""),
                                                                                ),
                                                                              Positioned(left: (5 * (1 - .4) * 40).toDouble(), top: 10, child: Text("0" + " Going", style: TextStyle(color: Color(0xFFEEFBFB), fontSize: 10.5))),
                                                                              Positioned(
                                                                                child: Container(
                                                                                  width: 100,
                                                                                  height: 40,
                                                                                  decoration: BoxDecoration(
                                                                                      gradient: LinearGradient(
                                                                                        begin: Alignment.topRight,
                                                                                        end: Alignment.bottomLeft,
                                                                                        colors: const [
                                                                                          Color(0xFFEEFBFB),
                                                                                          Color(0xFFEEFBFB),
                                                                                        ],
                                                                                      ),
                                                                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                                      boxShadow: [
                                                                                        BoxShadow(
                                                                                          color: const Color(0xFF1C1C1C).withOpacity(0.2),
                                                                                          spreadRadius: 3,
                                                                                          blurRadius: 4,
                                                                                          offset: const Offset(0, 3),
                                                                                        )
                                                                                      ]),
                                                                                  child: MaterialButton(
                                                                                      onPressed: () {},
                                                                                      child: Center(
                                                                                          child: Row(children: [
                                                                                        Icon(
                                                                                          Icons.edit_calendar,
                                                                                          color: Color(0xFF1C1C1C),
                                                                                          size: 20,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 5,
                                                                                        ),
                                                                                        Text(
                                                                                          "Going",
                                                                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1C1C1C)),
                                                                                        )
                                                                                      ]))),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ])),
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 10,
                                                                      right:
                                                                          10),
                                                                  child: Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(bottom: 5),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: const [
                                                                                Text("People are interested", style: TextStyle(color: Color(0xFFEEFBFB))),
                                                                              ],
                                                                            )),
                                                                        SizedBox(
                                                                          height:
                                                                              45,
                                                                          child:
                                                                              Stack(
                                                                            children: [
                                                                              for (var i = 0; i < event.interested.length % 4; i++)
                                                                                Positioned(
                                                                                  left: (i * (1 - .4) * 40).toDouble(),
                                                                                  top: 0,
                                                                                  child: (event.interested.length % 4) != 0
                                                                                      ? CircleAvatar(
                                                                                          backgroundColor: const Color(0xff007CC7),
                                                                                          backgroundImage: Image.memory(
                                                                                            base64Decode(event.interested[i]),
                                                                                            height: 300,
                                                                                            width: 300,
                                                                                          ).image,
                                                                                          child: Container(
                                                                                            clipBehavior: Clip.antiAlias,
                                                                                            decoration: BoxDecoration(border: Border.all(color: const Color(0xff007CC7), width: 2), borderRadius: BorderRadius.circular(70)),
                                                                                            padding: const EdgeInsets.all(5.0),
                                                                                          ),
                                                                                          radius: 22,
                                                                                        )
                                                                                      : const Text(""),
                                                                                ),
                                                                              Positioned(left: (5 * (1 - .4) * 40).toDouble(), top: 12, child: Text("0" + " Interested", style: TextStyle(color: Color(0xFFEEFBFB), fontSize: 10.5))),
                                                                              Positioned(
                                                                                child: Container(
                                                                                    width: 100,
                                                                                    height: 40,
                                                                                    decoration: BoxDecoration(
                                                                                        gradient: LinearGradient(
                                                                                          begin: Alignment.topRight,
                                                                                          end: Alignment.bottomLeft,
                                                                                          colors: const [
                                                                                            Color(0xFFEEFBFB),
                                                                                            Color(0xFFEEFBFB),
                                                                                          ],
                                                                                        ),
                                                                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                                        boxShadow: [
                                                                                          BoxShadow(
                                                                                            color: const Color(0xFF1C1C1C).withOpacity(0.2),
                                                                                            spreadRadius: 3,
                                                                                            blurRadius: 4,
                                                                                            offset: const Offset(0, 3),
                                                                                          )
                                                                                        ]),
                                                                                    child: MaterialButton(
                                                                                        onPressed: () {},
                                                                                        child: Container(
                                                                                            child: Row(children: [
                                                                                          Icon(
                                                                                            Icons.star_border_outlined,
                                                                                            color: Color(0xFF1C1C1C),
                                                                                            size: 20,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 3,
                                                                                          ),
                                                                                          Text(
                                                                                            "Interested",
                                                                                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1C1C1C)),
                                                                                          )
                                                                                        ])))),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ])),
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            10),
                                                                child:
                                                                    const Text(
                                                                  "Description",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color(
                                                                          0xFFEEFBFB)),
                                                                ),
                                                              ),
                                                              /*ReadMoreText(
                                "Data with " + "www.example.com" + "",
                                trimLines: 5,
                                colorClickableText: Colors.pink,
                                style: TextStyle(color: Color(0xFFEEFBFB)),
                                trimMode: TrimMode.Line,
                                trimCollapsedText: ' Show more',
                                trimExpandedText: ' Show less',
                                moreStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff007CC7)),
                                lessStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff007CC7)),
                              ), */
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 10,
                                                                        right:
                                                                            15),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Linkify(
                                                                        onOpen: (link) =>
                                                                            launchUrl(Uri.parse(link
                                                                                .url)),
                                                                        text:
                                                                            text,
                                                                        maxLines: descTextShowFlag
                                                                            ? 300
                                                                            : 5,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Color(0xFFEEFBFB))),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          descTextShowFlag =
                                                                              !descTextShowFlag;
                                                                        });
                                                                      },
                                                                      child: numLines + 1 >=
                                                                              5
                                                                          ? Padding(
                                                                              padding: EdgeInsets.only(right: 10),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                children: <Widget>[
                                                                                  descTextShowFlag
                                                                                      ? Text(
                                                                                          "Show Less",
                                                                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff007CC7)),
                                                                                        )
                                                                                      : Text("Show More", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff007CC7)))
                                                                                ],
                                                                              ))
                                                                          : Text(""),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              const Divider(
                                                                height: 2,
                                                                thickness: 1,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            10),
                                                                child:
                                                                    const Text(
                                                                  "Host",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color(
                                                                          0xFFEEFBFB)),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 70,
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    child: Row(
                                                                      children: [
                                                                        for (var i =
                                                                                0;
                                                                            i < event.guest.length;
                                                                            i++)
                                                                          Padding(
                                                                              padding: const EdgeInsets.only(right: 10),
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(
                                                                                    border: Border.all(color: const Color(0x33007CC7), width: 1),
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                    gradient: const LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [
                                                                                      Color(0xFFEEFBFB),
                                                                                      Color(0xFFEEFBFB),
                                                                                    ]),
                                                                                  ),
                                                                                  padding: const EdgeInsets.all(3.0),
                                                                                  child: event.guest[i].startsWith("@")
                                                                                      ? InkWell(
                                                                                          onTap: () {},
                                                                                          child: Text(event.guest[i], style: const TextStyle(fontSize: 25, color: Color(0xFF1C1C1C))),
                                                                                        )
                                                                                      : Text(
                                                                                          event.guest[i],
                                                                                          style: const TextStyle(fontSize: 25),
                                                                                        ))),
                                                                      ],
                                                                    ),
                                                                  )),
                                                              GalleryImage(
                                                                imageUrls: event
                                                                    .images,
                                                                numOfShowImages: event
                                                                            .images
                                                                            .length >=
                                                                        3
                                                                    ? 3
                                                                    : event
                                                                        .images
                                                                        .length,
                                                              ),
                                                            ])),
                                                  ],
                                                )))
                                      ],
                                    );
                                  })))),
                    );
            });
  }
}
