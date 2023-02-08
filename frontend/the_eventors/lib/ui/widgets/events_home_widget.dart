import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/providers/EventProvider.dart';

import '../../models/Events.dart';

class EventHomeWidget extends StatefulWidget {
  final ThemeData theme;
  const EventHomeWidget({Key? key, required this.theme}) : super(key: key);

  @override
  State<EventHomeWidget> createState() => _EventHomeWidget();
}

class _EventHomeWidget extends State<EventHomeWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      Provider.of<EventProvider>(context, listen: false).getEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    return Consumer<EventProvider>(
        builder: (BuildContext context, EventProvider mainProvider, _) {
      return Container(
          height: MediaQuery.of(context).size.height,
          padding: const  EdgeInsets.only(bottom: 80),
          child: ListView.builder(
              padding: const  EdgeInsets.only(top: 10),
              scrollDirection: Axis.vertical,
              itemCount: events.length,
              itemBuilder: (context, index) {
                return Container(
                  clipBehavior: Clip.hardEdge,
                  margin: const  EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.transparent, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                     const  Padding(
                        padding:  EdgeInsets.all(10),
                        child: Text("admin"),
                      ),
                      Container(
                        height: 200,
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://images.unsplash.com/photo-1589894404892-7310b92ea7a2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2574&q=80",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(events[index].title,
                                    style: widget.theme.textTheme.titleMedium),
                               const  SizedBox(
                                  height: 5,
                                ),
                                Text(events[index].location,
                                    style: widget.theme.textTheme.bodyMedium),
                                const SizedBox(
                                  height: 8,
                                ),
                              ])),
                    ],
                  ),
                );
              }));
    });
  }
}
