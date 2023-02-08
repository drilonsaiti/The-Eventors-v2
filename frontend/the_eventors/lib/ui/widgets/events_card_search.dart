import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/providers/EventProvider.dart';

class EventCardSearch extends StatefulWidget {
  const EventCardSearch({Key? key}) : super(key: key);

  @override
  State<EventCardSearch> createState() => _EventCardSearchState();
}

class _EventCardSearchState extends State<EventCardSearch> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      Provider.of<EventProvider>(context, listen: false).getEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    final theme = Theme.of(context);
    return Container(
      height: 250,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16),
        scrollDirection: Axis.horizontal,
        itemCount: events.length - 4,
        itemBuilder: (context, index) {
          return AspectRatio(
            aspectRatio: 1,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey.shade200, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
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
                                style: theme.textTheme.titleMedium),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(events[index].location,
                                style: theme.textTheme.bodyMedium),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(events[index].startDateTime,
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
