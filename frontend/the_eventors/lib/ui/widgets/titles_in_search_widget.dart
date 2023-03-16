import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../list_events_by_selected.dart';

class TitleSearchWidget extends StatelessWidget {
  final String title;
  final ThemeData theme;
  const TitleSearchWidget({Key? key, required this.title, required this.theme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600, color: Color(0xFFEEFBFB)),
          ),
          Icon(
            Icons.arrow_right,
            size: 40,
            color: Color(0xFFEEFBFB),
          ),
        ],
      ),
    );
  }
}
