import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/models/dto/MyEventResponseDto.dart';
import 'package:the_eventors/providers/MyActivityProvider.dart';
import 'package:the_eventors/ui/detail_event_screen.dart';
import '../services/CheckInternetAndLogin.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';

class MyActivityDetailsScreen extends StatefulWidget {
  final String activity;
  const MyActivityDetailsScreen({Key? key, required this.activity})
      : super(key: key);

  @override
  State<MyActivityDetailsScreen> createState() =>
      _MyActivityDetailsScreenState();
}

class _MyActivityDetailsScreenState extends State<MyActivityDetailsScreen> {
  List<MyEventResponseDto> events = [];
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switch (widget.activity) {
      case "My events":
        Provider.of<MyActivityProvider>(context, listen: false).getMyEvents();
        break;
      case "My going events":
        Provider.of<MyActivityProvider>(context, listen: false)
            .getMyGoingEvents();
        break;
      case "My interested events":
        Provider.of<MyActivityProvider>(context, listen: false)
            .getMyInterestedEvents();
        break;
      case "Bookmarks":
        Provider.of<MyActivityProvider>(context, listen: false)
            .getMyBookmarks();
        break;
      default:
    }
    Future.delayed(const Duration(milliseconds: 1000), () async {
      switch (widget.activity) {
        case "My events":
          events = context.read<MyActivityProvider>().myEvents;
          break;
        case "My going events":
          events = context.read<MyActivityProvider>().myGoing;
          break;
        case "My interested events":
          events = context.read<MyActivityProvider>().myInterested;
          break;
        case "Bookmarks":
          events = context.read<MyActivityProvider>().myBookmarks;
          break;
        default:
      }

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  bool get mounted => super.mounted;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(events);
    return Scaffold(
        backgroundColor: const Color(0xFF203647),
        appBar: AppBar(
          backgroundColor: Color(0xFF203647),
          title: Container(
              child: Text(
            widget.activity,
            style: TextStyle(color: const Color(0xFFEEFBFB), fontSize: 16.sp),
          )),
        ),
        body: SafeArea(
            child: isLoading
                ? Container()
                : Container(
                    padding: const EdgeInsets.all(10),
                    child: ListView.separated(
                      padding: const EdgeInsets.only(top: 10),
                      scrollDirection: Axis.vertical,
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) => DetailsEventScreen(
                                          id: events[index].id)))
                                  .then((value) => setState(() {
                                        isLoading = true;
                                        initState();
                                      }));
                            },
                            leading: Image.memory(
                              base64Decode(events[index].coverImage),
                              height: 50.0,
                              width: 50.0,
                              fit: BoxFit.cover,
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward,
                              color: Color(0xFFEEFBFB),
                            ),
                            subtitle: Text(events[index].timeAt,
                                style:
                                    const TextStyle(color: Color(0xFFEEFBFB))),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Text(
                                    events[index].createdBy,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFFEEFBFB),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    events[index].title,
                                    style: const TextStyle(
                                        fontSize: 16, color: Color(0xFFEEFBFB)),
                                  )
                                ]),
                              ],
                            ));
                      },
                      separatorBuilder: (context, index) => const Divider(
                        thickness: 1,
                        height: 1,
                        color: Color(0xFF12232E),
                      ),
                    ),
                  )));
  }
}
