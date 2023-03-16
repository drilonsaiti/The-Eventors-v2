import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'my_activity_details_screen.dart';
import 'my_comments_list_screen.dart';

class MyActivityListScreen extends StatefulWidget {
  const MyActivityListScreen({Key? key}) : super(key: key);

  @override
  State<MyActivityListScreen> createState() => _MyActivityListScreenState();
}

class _MyActivityListScreenState extends State<MyActivityListScreen> {
  List<String> list = [
    "My events",
    "My going events",
    "My interested events",
    "Comments",
    "Bookmarks"
  ];
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
          title: Padding(
              padding: EdgeInsets.only(left: 0),
              child: const Text(
                "My activity",
                style: TextStyle(color: Color(0xFFEEFBFB)),
              )),
        ),
        body: SafeArea(
            child: Container(
          padding: const EdgeInsets.all(10),
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 10),
            scrollDirection: Axis.vertical,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return ListTile(
                  onTap: () {
                    if (list[index] == "Comments") {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) =>
                                  const MyCommentListScreen()))
                          .then((value) => setState(() {
                                initState();
                              }));
                      ;
                    } else {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => MyActivityDetailsScreen(
                                    activity: list[index],
                                  )))
                          .then((value) => setState(() {
                                initState();
                              }));
                    }
                  },
                  trailing: const Icon(
                    Icons.arrow_forward,
                    color: Color(0xFFEEFBFB),
                  ),
                  title: Text(list[index],
                      style: const TextStyle(
                        color: Color(0xFFEEFBFB),
                      )));
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
