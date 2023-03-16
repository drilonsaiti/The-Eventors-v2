import 'dart:convert';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/game_icons.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:ui' as ui;

import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:the_eventors/package/gallery_image/galleryimage.dart';
import 'package:the_eventors/providers/EventProvider.dart';
import 'package:the_eventors/repository/MyActivityRepository.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/Events.dart';
import '../../models/dto/ActivityOfEventDto.dart';
import '../../models/dto/NotificationInfoDto.dart';
import '../../models/dto/UserUsernameDto.dart';
import '../../providers/MyActivityProvider.dart';
import '../../providers/UserProvider.dart';
import '../map_screen.dart';
import '../profile_screen.dart';

class BodyOfDetailsEventWidget extends StatefulWidget {
  final Events event;
  final String check;
  /*final int goingCount;
  final int interestedCount;*/

  const BodyOfDetailsEventWidget({
    Key? key,
    required this.event,
    required this.check,
  }) : super(key: key);

  @override
  State<BodyOfDetailsEventWidget> createState() =>
      _BodyOfDetailsEventWidgetState();
}

class _BodyOfDetailsEventWidgetState extends State<BodyOfDetailsEventWidget> {
  String check = "false";
  bool isLoading = true;
  MyActivityRepository repo = MyActivityRepository();
  ActivityOfEventDto activity = ActivityOfEventDto();
  int going = 0;
  int interested = 0;
  UserUsernameDto user = UserUsernameDto(username: "", profileImage: "");

  @override
  void initState() {
    super.initState();

    Provider.of<EventProvider>(context, listen: false)
        .getActivity(widget.event.id);
    check = widget.check;
    Provider.of<UserProvider>(context, listen: false)
        .findUserssByQuery(widget.event.createdBy);
    // TODO: implement initState
    Future.delayed(const Duration(milliseconds: 550), () async {
      activity = context.read<EventProvider>().activity;
      going = activity.going;
      interested = activity.interested;
      user = context.read<UserProvider>().dto;

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

  String descText =
      "Description Line 1\nDescription Line 2\nDescription Line 3\nDescription Line 4\nDescription Line 5\nDescription Line 6\nDescription Line 7\nDescription Line 8";
  bool descTextShowFlag = false;
  formatDate() {
    List<String> parts = widget.event.startDateTime.split(" ");
    return parts[0].split("-").reversed.join("-") + " " + parts[1];
  }

  @override
  Widget build(BuildContext context) {
    formatDate();
    activity = Provider.of<EventProvider>(context, listen: true).activity;
    Size size = (TextPainter(
            text: TextSpan(
                text: widget.event.description,
                style: TextStyle(color: Color(0xFFEEFBFB))),
            maxLines: 1,
            textScaleFactor: MediaQuery.of(context).textScaleFactor,
            textDirection: ui.TextDirection.ltr)
          ..layout())
        .size;
    return isLoading
        ? const Text("")
        : Container(
            padding: const EdgeInsets.only(left: 15),
            color: const Color(0xFF203647),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) => ProfileScreen(
                                        username: widget.event.createdBy)))
                                .then((value) => setState(() {
                                      isLoading = true;
                                      initState();
                                    }));
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 18, // Image radius
                                backgroundImage:
                                    !user.profileImage.startsWith('/')
                                        ? Image.asset(
                                            'assets/profile_image.png',
                                            height: 50,
                                            width: 50,
                                            fit: BoxFit.cover,
                                          ).image
                                        : Image.memory(
                                                base64Decode(user.profileImage))
                                            .image,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.event.createdBy,
                                style:
                                    const TextStyle(color: Color(0xFFEEFBFB)),
                              )
                            ],
                          )),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          widget.event.title,
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFEEFBFB)),
                        ),
                      ),
                      Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(top: 5),
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => MapScreen(
                                        address: widget.event.location))),
                            child: Row(children: [
                              const Icon(
                                Icons.location_on,
                                color: Color(0xFFEEFBFB),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Flexible(
                                  child: InkWell(
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => MapScreen(
                                                  address:
                                                      widget.event.location))),
                                      child: Text(
                                        widget.event.location,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFEEFBFB),
                                            fontSize: 14.sp),
                                      )))
                            ]),
                          )),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(children: [
                          const Icon(
                            Icons.date_range,
                            color: Color(0xFFEEFBFB),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            widget.event.startDateTime,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: Color(0xFFEEFBFB)),
                          ),
                          SizedBox(
                            width: 75.w,
                          ),
                          const Iconify(
                            GameIcons.duration,
                            color: Color(0xFFEEFBFB),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            widget.event.duration,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: Color(0xFFEEFBFB)),
                          )
                        ]),
                      ),
                      Container(
                          width: 0.95.sw,
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(top: 10, right: 10),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text("People are going",
                                        style: TextStyle(
                                            color: Color(0xFFEEFBFB))),
                                  ],
                                )),
                            SizedBox(
                              height: 45,
                              child: Stack(
                                children: [
                                  for (var i = 0;
                                      i < widget.event.guest.length % 4;
                                      i++)
                                    Positioned(
                                      left: (i * (1 - .4) * 40).toDouble(),
                                      top: 0,
                                      child: (widget.event.going.length % 4) !=
                                              0
                                          ? CircleAvatar(
                                              backgroundColor:
                                                  const Color(0xff007CC7),
                                              backgroundImage: Image.memory(
                                                base64Decode(
                                                    widget.event.going[i]),
                                                height: 300,
                                                width: 300,
                                              ).image,
                                              child: Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xff007CC7),
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            70)),
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                              ),
                                              radius: 22,
                                            )
                                          : const Text(""),
                                    ),
                                  Positioned(
                                      left: (5 * (1 - .4) * 40).toDouble(),
                                      top: 10,
                                      child: Text(
                                          NumberFormat.compact()
                                                  .format(going)
                                                  .toString() +
                                              " Going",
                                          style: TextStyle(
                                              color: Color(0xFFEEFBFB),
                                              fontSize: 10.5.sp))),
                                  Positioned(
                                    left: 0.57.sw,
                                    child: Container(
                                      width: 0.30.sw,
                                      height: 40,
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
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFF1C1C1C)
                                                  .withOpacity(0.2),
                                              spreadRadius: 3,
                                              blurRadius: 4,
                                              offset: const Offset(0, 3),
                                            )
                                          ]),
                                      child: MaterialButton(
                                          onPressed: () {
                                            var checks = "";
                                            if (check != "going") {
                                              Provider.of<EventProvider>(
                                                      context,
                                                      listen: false)
                                                  .addGoing(
                                                      widget.event.id,
                                                      widget.event.createdBy,
                                                      widget.event.title);

                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 250), () {
                                                Provider.of<MyActivityProvider>(
                                                        context,
                                                        listen: false)
                                                    .checkGoing(
                                                        widget.event.id);
                                                checks = Provider.of<
                                                            MyActivityProvider>(
                                                        context,
                                                        listen: false)
                                                    .checkGoingBt;
                                                setState(() {
                                                  going = context
                                                      .read<EventProvider>()
                                                      .activity
                                                      .going;
                                                  interested = context
                                                      .read<EventProvider>()
                                                      .activity
                                                      .interested;
                                                  check = "going";
                                                  going += 1;
                                                });
                                              });
                                              /*Future.delayed(
                                                  const Duration(
                                                      milliseconds: 650), () {
                                                setState(() {
                                                  going = Provider.of<
                                                              EventProvider>(
                                                          context,
                                                          listen: false)
                                                      .activity
                                                      .going;

                                                  interested = Provider.of<
                                                              EventProvider>(
                                                          context,
                                                          listen: false)
                                                      .activity
                                                      .interested;
                                                });
                                              });*/
                                              showDialog<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'Add event to your calendar'),
                                                      content: const Text(
                                                          "This event will be added yo your phone's calendar"),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          style: TextButton
                                                              .styleFrom(
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelLarge,
                                                          ),
                                                          child: const Text(
                                                              'Cancel'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                        TextButton(
                                                          style: TextButton
                                                              .styleFrom(
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelLarge,
                                                          ),
                                                          child:
                                                              const Text('Add'),
                                                          onPressed: () {
                                                            final Event event = Event(
                                                                title: widget
                                                                    .event
                                                                    .title,
                                                                description: widget
                                                                    .event
                                                                    .description,
                                                                location: widget
                                                                    .event
                                                                    .location,
                                                                startDate:
                                                                    DateTime.parse(
                                                                        formatDate()),
                                                                endDate: DateTime
                                                                    .parse(widget
                                                                        .event
                                                                        .endDateTime));
                                                            Add2Calendar
                                                                .addEvent2Cal(
                                                                    event);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            } else {
                                              Provider.of<EventProvider>(
                                                      context,
                                                      listen: false)
                                                  .removeCheck(
                                                      widget.event.id, "going");
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 150), () {
                                                Provider.of<MyActivityProvider>(
                                                        context,
                                                        listen: false)
                                                    .checkGoing(
                                                        widget.event.id);
                                                checks = Provider.of<
                                                            MyActivityProvider>(
                                                        context,
                                                        listen: false)
                                                    .checkGoingBt;
                                              });
                                              setState(() {
                                                going -= 1;
                                              });
                                            }
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 250), () {
                                              Provider.of<EventProvider>(
                                                      context,
                                                      listen: false)
                                                  .getActivity(widget.event.id);
                                            });

                                            setState(() {
                                              check = "false";
                                            });
                                          },
                                          child: Center(
                                              child: check != "going"
                                                  ? Row(children: [
                                                      Icon(
                                                        Icons.edit_calendar,
                                                        color:
                                                            Color(0xFF1C1C1C),
                                                        size: 20.sp,
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      Text(
                                                        "Going",
                                                        style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xFF1C1C1C)),
                                                      )
                                                    ])
                                                  : Row(children: [
                                                      Icon(
                                                        Icons.check,
                                                        color:
                                                            Color(0xFFEEFBFB),
                                                        size: 20.sp,
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      Text(
                                                        "Going",
                                                        style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xFFEEFBFB)),
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
                          padding: const EdgeInsets.only(top: 10, right: 10),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text("People are interested",
                                        style: TextStyle(
                                            color: Color(0xFFEEFBFB))),
                                  ],
                                )),
                            SizedBox(
                              height: 45,
                              child: Stack(
                                children: [
                                  for (var i = 0;
                                      i < widget.event.interested.length % 4;
                                      i++)
                                    Positioned(
                                      left: (i * (1 - .4) * 40).toDouble(),
                                      top: 0,
                                      child: (widget.event.interested.length %
                                                  4) !=
                                              0
                                          ? CircleAvatar(
                                              backgroundColor:
                                                  const Color(0xff007CC7),
                                              backgroundImage: Image.memory(
                                                base64Decode(
                                                    widget.event.interested[i]),
                                                height: 300,
                                                width: 300,
                                              ).image,
                                              child: Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xff007CC7),
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            70)),
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                              ),
                                              radius: 22,
                                            )
                                          : const Text(""),
                                    ),
                                  Positioned(
                                      left: (5 * (1 - .4) * 40).toDouble(),
                                      top: 12,
                                      child: Text(
                                          NumberFormat.compact()
                                                  .format(interested)
                                                  .toString() +
                                              " Interested",
                                          style: TextStyle(
                                              color: Color(0xFFEEFBFB),
                                              fontSize: 10.5.sp))),
                                  Positioned(
                                    left: 0.57.sw,
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
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0xFF1C1C1C)
                                                    .withOpacity(0.2),
                                                spreadRadius: 3,
                                                blurRadius: 4,
                                                offset: const Offset(0, 3),
                                              )
                                            ]),
                                        child: MaterialButton(
                                            onPressed: () {
                                              var checks = "";
                                              if (check != "interested") {
                                                Provider.of<EventProvider>(
                                                        context,
                                                        listen: false)
                                                    .addInterested(
                                                        widget.event.id,
                                                        widget.event.createdBy,
                                                        widget.event.title);
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 250), () {
                                                  Provider.of<MyActivityProvider>(
                                                          context,
                                                          listen: false)
                                                      .checkGoing(
                                                          widget.event.id);
                                                  checks = Provider.of<
                                                              MyActivityProvider>(
                                                          context,
                                                          listen: false)
                                                      .checkGoingBt;
                                                  setState(() {
                                                    print(checks);
                                                    going = context
                                                        .read<EventProvider>()
                                                        .activity
                                                        .going;
                                                    interested = context
                                                        .read<EventProvider>()
                                                        .activity
                                                        .interested;
                                                    check = "interested";
                                                    interested += 1;
                                                  });
                                                });
                                              } else {
                                                Provider.of<EventProvider>(
                                                        context,
                                                        listen: false)
                                                    .removeCheck(
                                                        widget.event.id,
                                                        "interested");
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 150), () {
                                                  Provider.of<MyActivityProvider>(
                                                          context,
                                                          listen: false)
                                                      .checkGoing(
                                                          widget.event.id);
                                                  checks = Provider.of<
                                                              MyActivityProvider>(
                                                          context,
                                                          listen: false)
                                                      .checkGoingBt;
                                                });
                                                setState(() {
                                                  interested -= 1;
                                                });
                                              }
                                              Future.delayed(
                                                  Duration(milliseconds: 250),
                                                  () {
                                                Provider.of<EventProvider>(
                                                        context,
                                                        listen: false)
                                                    .getActivity(
                                                        widget.event.id);
                                              });

                                              /* Future.delayed(
                                                  Duration(milliseconds: 450),
                                                  () {
                                                setState(() {
                                                  interested += 1;

                                                  going -= 1;
                                                });
                                              });*/
                                              setState(() {
                                                check = "false";
                                              });
                                            },
                                            child: Container(
                                                child: check != "interested"
                                                    ? Row(children: [
                                                        Icon(
                                                          Icons
                                                              .star_border_outlined,
                                                          color:
                                                              Color(0xFF1C1C1C),
                                                          size: 20.sp,
                                                        ),
                                                        SizedBox(
                                                          width: 3.w,
                                                        ),
                                                        Text(
                                                          "Interested",
                                                          style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xFF1C1C1C)),
                                                        )
                                                      ])
                                                    : Row(children: [
                                                        Icon(
                                                          Icons.star,
                                                          color:
                                                              Color(0xFFEEFBFB),
                                                          size: 20.sp,
                                                        ),
                                                        SizedBox(
                                                          width: 3.w,
                                                        ),
                                                        Text(
                                                          "Interested",
                                                          style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xFFEEFBFB)),
                                                        )
                                                      ])))),
                                  ),
                                ],
                              ),
                            ),
                          ])),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(top: 10),
                        child: const Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFEEFBFB)),
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
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(top: 10, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Linkify(
                                onOpen: (link) =>
                                    launchUrl(Uri.parse(link.url)),
                                text: widget.event.description,
                                maxLines: descTextShowFlag ? 300 : 5,
                                style: TextStyle(color: Color(0xFFEEFBFB))),
                            if (widget.event.description.isNotEmpty &&
                                size.width > 1000)
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
                        padding: const EdgeInsets.only(top: 10),
                        child: const Text(
                          "Host",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFEEFBFB)),
                        ),
                      ),
                      SizedBox(
                          height: 70,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (var i = 0;
                                    i < widget.event.guest.length;
                                    i++)
                                  Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0x33007CC7),
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            gradient: const LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                  Color(0xFFEEFBFB),
                                                  Color(0xFFEEFBFB),
                                                ]),
                                          ),
                                          padding: const EdgeInsets.all(3.0),
                                          child:
                                              widget.event.guest[i]
                                                      .startsWith("@")
                                                  ? InkWell(
                                                      onTap: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ProfileScreen(
                                                                          username: widget
                                                                              .event
                                                                              .guest[i]
                                                                              .replaceFirst("@", ""),
                                                                        )));
                                                      },
                                                      child: Text(
                                                          widget.event.guest[i],
                                                          style: const TextStyle(
                                                              fontSize: 25,
                                                              color: Color(
                                                                  0xFF1C1C1C))),
                                                    )
                                                  : Text(
                                                      widget.event.guest[i],
                                                      style: const TextStyle(
                                                          fontSize: 25),
                                                    ))),
                              ],
                            ),
                          )),
                      GalleryImage(
                        imageUrls: widget.event.images,
                        numOfShowImages: widget.event.images.length >= 3
                            ? 3
                            : widget.event.images.length,
                      ),
                    ])),
              ],
            ));
  }
}
