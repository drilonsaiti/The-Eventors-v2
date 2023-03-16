import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/providers/EventProvider.dart';

import '../../models/Events.dart';
import '../detail_event_screen.dart';

class EventCardSearch extends StatefulWidget {
  final List<dynamic> events;
  const EventCardSearch({Key? key, required this.events}) : super(key: key);

  @override
  State<EventCardSearch> createState() => _EventCardSearchState();
}

class _EventCardSearchState extends State<EventCardSearch> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<EventProvider>(context, listen: false).getEvents();

    Future.delayed(Duration(milliseconds: 200), () async {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    print(widget.events.length);

    return Container(
      height: 250,
      child: widget.events.length == 0
          ? Center(
              child: Text(
                "No data rigt now",
                style: TextStyle(color: Color(0xFFEEFBFB)),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(left: 16),
              scrollDirection: Axis.horizontal,
              itemCount: widget.events.length,
              itemBuilder: (context, index) {
                return AspectRatio(
                  aspectRatio: 1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => DetailsEventScreen(
                                  id: widget.events[index].id)))
                          .then((value) => setState(() {
                                initState();
                              }));
                    },
                    child: Container(
                        clipBehavior: Clip.hardEdge,
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xFFEEFBFB),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              child: Image.memory(
                                base64Decode(widget.events[index].coverImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.events[index].title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: theme.textTheme.titleMedium),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(widget.events[index].location,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: theme.textTheme.bodyMedium),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(widget.events[index].startDateTime,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: theme.textTheme.bodyMedium),
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                );
              },
            ),
    );
  }
}
