import 'package:flutter/material.dart';

import 'package:the_eventors/ui/widgets/body_container_details_event_widget.dart';
import 'package:the_eventors/ui/widgets/top_container_details_event_widget.dart';

import 'comments_screen.dart';

class DetailsEventScreen extends StatefulWidget {
  const DetailsEventScreen({
    Key? key,
  }) : super(key: key);

  @override
  _DetailsEventScreenState createState() => _DetailsEventScreenState();
}

class _DetailsEventScreenState extends State<DetailsEventScreen> {
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: const [
            TopOfDetailsEventWidget(),
            BodyOfDetailsEventWidget()
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        child: Row(
          children: <Widget>[
            Container(
              width: 150,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: const Text(
                      'Going',
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side:
                                        const BorderSide(color: Colors.blue))),
                        minimumSize:
                            MaterialStateProperty.all(const Size(150, 50))),
                  ),
                ],
              ),
            ),
            Container(
              width: 170,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: const Text(
                      'Interested',
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(color: Colors.blue))),
                      minimumSize: MaterialStateProperty.all(Size(150, 50)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CommentScreen()));
                    },
                    child: const Icon(
                      Icons.add_comment_sharp,
                      size: 30,
                      color: Colors.black,
                    ),
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(const Size(60, 50)),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(0)),
                      shadowColor: MaterialStateProperty.all(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(color: Colors.blue))),
                      backgroundColor: MaterialStateProperty.all(
                          Colors.white), // <-- Button color
                      overlayColor:
                          MaterialStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.blueAccent; // <-- Splash color
                      }),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
