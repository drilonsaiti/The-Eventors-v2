/*import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:the_eventors/models/dto/CommentResponseDto.dart';

class CommentWidget extends StatefulWidget {
  final List<CommentResponseDto> comments;
  const CommentWidget({Key? key, required this.comments}) : super(key: key);

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    print("WIDGET " + widget.comments.toString());
    return SingleChildScrollView(
        child: Column(children: [
      Container(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
        margin: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color(0xFF12232E)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (int i = 0; i < createCommentsTree().length; i++)
              createCommentsTree()[i]
          ],
        ),
      )
    ]));
  }

  List<CommentTreeWidget<Comment, Comment>> createCommentsTree() {
    List<CommentTreeWidget<Comment, Comment>> commentTree = [];
    for (CommentResponseDto dto in widget.comments) {
      Comment c =
          Comment(avatar: null, userName: dto.username, content: dto.message);
      print(c.content);
      List<Comment> replies = [];
      for (CommentResponseDto dto2 in dto.replies) {
        print(dto2.username);

        replies.add(Comment(
            avatar: null, userName: dto2.username, content: dto2.message));
      }
      commentTree.add(CommentTreeWidget(
        c,
        replies,
        treeThemeData:
            TreeThemeData(lineColor: Color(0xff007CC7), lineWidth: 3),
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
                    color: Color(0xFFEEFBFB),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.userName}',
                      style: Theme.of(context).textTheme.caption?.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${data.content}',
                      style: Theme.of(context).textTheme.caption?.copyWith(
                          fontWeight: FontWeight.w300, color: Colors.black),
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
                    color: Color(0xFFEEFBFB),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.userName}',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${data.content}',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          fontWeight: FontWeight.w300, color: Colors.black),
                    ),
                  ],
                ),
              ),
              DefaultTextStyle(
                style: Theme.of(context).textTheme.caption!.copyWith(
                    color: Color(0xff007CC7), fontWeight: FontWeight.bold),
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
      ));
    }

    return commentTree;
  }
}
*/