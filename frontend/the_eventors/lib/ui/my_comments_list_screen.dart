import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:the_eventors/providers/MyActivityProvider.dart';
import 'package:the_eventors/ui/detail_event_screen.dart';

import '../services/MyActivityRepository.dart';
import 'comments_screen.dart';

class MyCommentListScreen extends StatefulWidget {
  const MyCommentListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MyCommentListScreen> createState() => _MyCommentListScreenState();
}

class _MyCommentListScreenState extends State<MyCommentListScreen> {
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF203647),
        appBar: AppBar(
          backgroundColor: const Color(0xFF203647),
          title: Container(
              child: const Text(
            "Comments",
            style: TextStyle(color: Color(0xFFEEFBFB)),
          )),
        ),
        body: SafeArea(
            child: Container(
                padding: const EdgeInsets.all(10),
                child: FutureBuilder(
                    future: MyActivityRepository().getMyComments(),
                    builder: (context, AsyncSnapshot snapshot) {
                      print(snapshot.hasData);
                      print(snapshot.data);
                      if (snapshot.hasData) {
                        return ListView.separated(
                          padding: const EdgeInsets.only(top: 10),
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Column(children: [
                              ListTile(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                DetailsEventScreen(
                                                    id: snapshot
                                                        .data[index].idEvent)))
                                        .then((value) => setState(() {
                                              isLoading = true;
                                              initState();
                                            }));
                                  },
                                  leading: Image.memory(
                                    base64Decode(
                                        snapshot.data[index].coverImage),
                                    height: 50.0,
                                    width: 50.0,
                                    fit: BoxFit.cover,
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward,
                                    color: Color(0xFFEEFBFB),
                                  ),
                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        Text(
                                          snapshot.data[index].createdBy,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Color(0xFFEEFBFB),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          snapshot.data[index].title,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFFEEFBFB)),
                                        )
                                      ]),
                                      Text(snapshot.data[index].createdEvent,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFFEEFBFB)))
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: ListTile(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    CommentScreen(
                                                      id: snapshot
                                                          .data[index].idEvent,
                                                      username: snapshot
                                                          .data[index]
                                                          .createdBy,
                                                    )))
                                            .then((value) => setState(() {
                                                  isLoading = true;
                                                  initState();
                                                }));
                                      },
                                      leading: CircleAvatar(
                                        child: ClipOval(
                                          child: Image.memory(
                                            base64Decode(snapshot
                                                .data[index].coverImage),
                                            height: 50.0,
                                            width: 50.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      trailing: const Icon(
                                        Icons.arrow_forward,
                                        color: Color(0xFFEEFBFB),
                                      ),
                                      title: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(children: [
                                            Text(
                                              snapshot.data[index].username,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xFFEEFBFB),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              snapshot.data[index].message,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xFFEEFBFB)),
                                            )
                                          ]),
                                          Text(
                                              snapshot
                                                  .data[index].commentCreatedAt,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFFEEFBFB)))
                                        ],
                                      )))
                            ]);
                          },
                          separatorBuilder: (context, index) => const Divider(
                            thickness: 1,
                            height: 1,
                            color: Color(0xFF12232E),
                          ),
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
                    }))));
  }
}
