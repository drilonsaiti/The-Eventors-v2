import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TabWidget extends StatefulWidget {
  final String title;
  const TabWidget({Key? key, required this.title}) : super(key: key);

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  @override
  Widget build(BuildContext context) {
    return Tab(
        child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.blueAccent, width: 1)),
      child: Align(
        alignment: Alignment.center,
        child: Text(widget.title),
      ),
    ));
  }
}
