import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:the_eventors/ui/widgets/details_app_bar.dart';
import 'package:the_eventors/ui/widgets/details_buttons.dart';

class DetailEvent extends StatefulWidget {
  const DetailEvent({Key? key}) : super(key: key);

  @override
  State<DetailEvent> createState() => _DetailEventState();
}

class _DetailEventState extends State<DetailEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: <Widget>[
          SafeArea(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Stack(children: [
                SizedBox(
                  height: 320,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://images.unsplash.com/photo-1589894404892-7310b92ea7a2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2574&q=80",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 200,
                ),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                Text("Hey"),
                /*Column(children: [
            Column(
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [Container()],
                    ),
                  ),
                ))
              ],
            )
          ])*/
              ]),
            ),
          )
        ]));
  }
}
