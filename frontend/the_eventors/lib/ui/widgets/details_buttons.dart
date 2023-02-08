import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/ui/widgets/tab_widget.dart';

import '../../providers/EventProvider.dart';
import '../../providers/UserProvider.dart';

class DetailsButton extends StatelessWidget {
  const DetailsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 1),
        child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Material(
                  elevation: 0,
                  child: TabBar(
                    unselectedLabelColor: Colors.blueAccent,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.blueAccent),
                    tabs: const [
                      TabWidget(title: "Details"),
                      TabWidget(title: "Photos"),
                      TabWidget(title: "Comments")
                    ],
                  ),
                ),
                /*SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    child: TabBarView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        Padding(
                            padding: EdgeInsets.only(bottom: 0),
                            child: Row(
                              children: const [
                                CircleAvatar(
                                  radius: 28, // Image radius
                                  backgroundImage: NetworkImage(
                                    "https://images.unsplash.com/photo-1589894404892-7310b92ea7a2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2574&q=80",
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("admin")
                              ],
                            )),
                        Consumer<UserProvider>(builder: (context, data, child) {
                          return ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 10),
                              scrollDirection: Axis.vertical,
                              itemCount: data.findUsername.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    title: Text(
                                        data.findUsername[index].username));
                              });
                        }),
                        Consumer<EventProvider>(
                            builder: (context, data, child) {
                          return ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 10),
                              scrollDirection: Axis.vertical,
                              itemCount: data.findEvents.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    title: Text(data.findEvents[index].title));
                              });
                        }),
                      ],
                    )),*/
              ],
            )));
  }
}
