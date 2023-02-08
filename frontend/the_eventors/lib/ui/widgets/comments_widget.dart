import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({Key? key}) : super(key: key);

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  List<Comment> comment = [
    Comment(
        avatar: 'null',
        userName: 'drilon',
        content: 'A Dart template generator which helps teams'),
    Comment(
        avatar: 'null',
        userName: 'blend',
        content: 'A Dart template generator which helps teams'),
    Comment(
        avatar: 'null',
        userName: 'blend',
        content: 'A Dart template generator which helps teams'),
    Comment(
        avatar: 'null',
        userName: 'blend',
        content: 'A Dart template generator which helps teams'),
    Comment(
        avatar: 'null',
        userName: 'drilon',
        content: 'A Dart template generator which helps teams'),
    Comment(
        avatar: 'null',
        userName: 'blend',
        content: 'A Dart template generator which helps teams'),
    Comment(
        avatar: 'null',
        userName: 'blend',
        content: 'A Dart template generator which helps teams'),
    Comment(
        avatar: 'null',
        userName: 'blend',
        content: 'A Dart template generator which helps teams')
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Container(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
        margin: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommentTreeWidget<Comment, Comment>(
              Comment(
                  avatar: 'null',
                  userName: 'null',
                  content: 'felangel made felangel/cubit_and_beyond public '),
              comment,
              treeThemeData:
                  TreeThemeData(lineColor: Colors.blue[500]!, lineWidth: 3),
              avatarRoot: (context, data) => PreferredSize(
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey,
                  backgroundImage: AssetImage('assets/avatar_2.png'),
                ),
                preferredSize: Size.fromRadius(18),
              ),
              avatarChild: (context, data) => PreferredSize(
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.grey,
                  backgroundImage: AssetImage('assets/avatar_1.png'),
                ),
                preferredSize: Size.fromRadius(12),
              ),
              contentChild: (context, data) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'drilon',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            '${data.content}',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              contentRoot: (context, data) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'dangngocduc',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            '${data.content}',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    DefaultTextStyle(
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.grey[700], fontWeight: FontWeight.bold),
                      child: Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text('Reply'),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ],
        ),
      )
    ]));
  }
}
