import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/models/Category.dart';
import 'package:the_eventors/ui/multi_step_form_screen.dart';
import 'package:the_eventors/ui/widgets/category_widget.dart';
import 'package:the_eventors/ui/widgets/events_home_widget.dart';
import 'package:the_eventors/ui/widgets/events_widget.dart';
import 'package:the_eventors/ui/widgets/top_home_background.dart';
import 'package:the_eventors/ui/widgets/top_home_widget.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/Events.dart';
import '../providers/EventProvider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () async {
      Provider.of<EventProvider>(context, listen: false).getEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;

    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFF007CC7),
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'The eventors',
                  style: TextStyle(fontSize: 32.0, color: Color(0xff007CC7)),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 35.0,
                      child: IconButton(
                        icon: const Icon(Icons.add),
                        color: Color(0xff007CC7),
                        iconSize: 30.0,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MultiStepFormPage()));
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            height: 5,
            thickness: 1,
            color: Color(0xff007CC7),
          ),
          for (Events e in events) _buildPost(e)
        ],
      ),
    ));
  }
}

Widget _buildPost(Events e) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    child: Container(
      width: double.infinity,
      height: 525.0,
      decoration: BoxDecoration(
        color: Color(0xFFEEFBFB),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          offset: Offset(0, 5),
                          blurRadius: 8.0,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      child: ClipOval(
                        child: CachedNetworkImage(
                          height: 50.0,
                          width: 50.0,
                          imageUrl:
                              "https://images.unsplash.com/photo-1589894404892-7310b92ea7a2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2574&q=80",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    'drilon',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text('5min'),
                  trailing: IconButton(
                    icon: Icon(Icons.more_horiz),
                    color: Colors.black,
                    onPressed: () => print('More'),
                  ),
                ),
                InkWell(
                  onDoubleTap: () => print('Like post'),
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(left: 10.0, right: 10),
                    width: double.infinity,
                    height: 300.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          offset: Offset(0, 5),
                          blurRadius: 8.0,
                        ),
                      ],
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://images.unsplash.com/photo-1589894404892-7310b92ea7a2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2574&q=80",
                        ),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.share),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.bookmark_border),
                        iconSize: 30.0,
                        onPressed: () => print('Save post'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.title),
                              SizedBox(
                                width: 4,
                              ),
                              Flexible(
                                  child: Text(
                                e.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ))
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.location_on),
                              SizedBox(
                                width: 4,
                              ),
                              Flexible(
                                  child: Text(
                                e.location,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ))
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.schedule),
                              SizedBox(
                                width: 4,
                              ),
                              Flexible(
                                  child: Text(
                                e.startDateTime,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ))
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
