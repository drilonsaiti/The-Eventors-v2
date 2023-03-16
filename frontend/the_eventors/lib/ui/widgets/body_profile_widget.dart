import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/providers/MyActivityProvider.dart';

import '../../providers/EventProvider.dart';
import '../../providers/UserProvider.dart';
import '../detail_event_screen.dart';

class BodyProfileWidget extends StatefulWidget {
  final String username;
  const BodyProfileWidget({Key? key, required this.username}) : super(key: key);

  @override
  State<BodyProfileWidget> createState() => _BodyProfileWidgetState();
}

class _BodyProfileWidgetState extends State<BodyProfileWidget> {
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.username != "") {
      Provider.of<MyActivityProvider>(context, listen: false)
          .getMyEventsByUser(widget.username);
      Provider.of<MyActivityProvider>(context, listen: false)
          .getActivityProfileByUser(widget.username);
    } else {
      Provider.of<MyActivityProvider>(context, listen: false).getMyEvents();
      Provider.of<MyActivityProvider>(context, listen: false)
          .getActivityProfile();
    }

    Future.delayed(Duration(milliseconds: 200), () {
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
    return isLoading
        ? Text("")
        : SafeArea(
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            Material(
                              color: const Color(0xFF203647),
                              elevation: 0,
                              child: TabBar(
                                unselectedLabelColor: const Color(0xCCEEFBFB),
                                indicatorSize: TabBarIndicatorSize.label,
                                indicatorColor: const Color(0xFFEEFBFB),
                                tabs: [
                                  const Tab(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Events",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          )),
                                    ),
                                  ),
                                  Tab(
                                      child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: Color(0xFF203647),
                                            width: 1)),
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: Text("Activity",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          )),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width,
                                child: TabBarView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  children: [
                                    Consumer<MyActivityProvider>(
                                        builder: (context, data, child) {
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          scrollDirection: Axis.vertical,
                                          itemCount: data.myEvents.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                                onTap: () => Navigator.of(
                                                        context)
                                                    .push(MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailsEventScreen(
                                                                id: data
                                                                    .myEvents[
                                                                        index]
                                                                    .id))),
                                                leading: Image.memory(
                                                  base64Decode(
                                                    data.myEvents[index]
                                                        .coverImage,
                                                  ),
                                                  width: 60,
                                                  height: 60,
                                                  fit: BoxFit.cover,
                                                ),
                                                title: Text(
                                                  data.myEvents[index].title,
                                                  style: TextStyle(
                                                      color: Color(0xFFEEFBFB)),
                                                ),
                                                trailing: const Icon(
                                                  Icons.arrow_forward,
                                                  color: Color(0xFFEEFBFB),
                                                ),
                                                subtitle: Text(
                                                    data.myEvents[index].timeAt,
                                                    style: const TextStyle(
                                                        color: Color(
                                                            0xFFEEFBFB))));
                                          });
                                    }),
                                    Consumer<MyActivityProvider>(
                                        builder: (context, data, child) {
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              data.activityProfile.length,
                                          itemBuilder: (context, index) {
                                            return Column(children: [
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.star,
                                                          color: Color(
                                                              0xFFEEFBFB)),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                          data
                                                                  .activityProfile[
                                                                      index]
                                                                  .status +
                                                              " to event",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFFEEFBFB))),
                                                    ],
                                                  )),
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 25),
                                                  child: ListTile(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(MaterialPageRoute(
                                                                builder: (context) =>
                                                                    DetailsEventScreen(
                                                                        id: data
                                                                            .activityProfile[
                                                                                index]
                                                                            .id)))
                                                            .then((value) =>
                                                                setState(() {
                                                                  isLoading =
                                                                      true;
                                                                  initState();
                                                                }));
                                                      },
                                                      leading: Image.memory(
                                                        base64Decode(
                                                          data
                                                              .activityProfile[
                                                                  index]
                                                              .coverImage,
                                                        ),
                                                        width: 60,
                                                        height: 60,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      title: Text(
                                                        data
                                                            .activityProfile[
                                                                index]
                                                            .title,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFFEEFBFB)),
                                                      ),
                                                      trailing: const Icon(
                                                        Icons.arrow_forward,
                                                        color:
                                                            Color(0xFFEEFBFB),
                                                      ),
                                                      subtitle: Text(
                                                          data
                                                              .activityProfile[
                                                                  index]
                                                              .startDateTime,
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0xFFEEFBFB)))))
                                            ]);
                                          });
                                    }),
                                  ],
                                )),
                          ],
                        )))),
          );
  }
}
