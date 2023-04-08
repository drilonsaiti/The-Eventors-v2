import 'dart:convert';

import 'package:comment_box/comment/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_eventors/models/dto/CommentResponseDto.dart';
import 'package:the_eventors/models/dto/UserUsernameDto.dart';
import 'package:the_eventors/providers/EventProvider.dart';
import 'package:the_eventors/providers/UserProvider.dart';
import '../services/CheckInternetAndLogin.dart';
import 'package:connectivity/connectivity.dart';

import '../models/Comment.dart';
import 'multi_step_form_screen.dart';

class CommentScreen extends StatefulWidget {
  final int id;
  final String username;

  const CommentScreen({Key? key, required this.id, required this.username})
      : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List<CommentResponseDto> comments = [];
  bool isLoading = true;
  bool reply = false;
  int commentId = 0;
  String replyUsername = "";
  UserUsernameDto user = UserUsernameDto(username: "", profileImage: "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<EventProvider>(context, listen: false).getComments(widget.id);
    Provider.of<UserProvider>(context, listen: false).getUser();
    Future.delayed(const Duration(milliseconds: 1000), () async {
      comments = context.read<EventProvider>().comments;
      user = context.read<UserProvider>().dto;

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    comments = Provider.of<EventProvider>(context).comments;
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: isLoading
            ? null
            : Scaffold(
                backgroundColor: const Color(0xFF12232E),
                appBar: AppBar(
                  iconTheme: const IconThemeData(color: Color(0xFFEEFBFB)),
                  automaticallyImplyLeading: false,
                  title: Row(children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 0),
                      child: Text(
                        "Comments",
                        style: TextStyle(color: Color(0xFFEEFBFB)),
                      ),
                    ),
                  ]),
                  backgroundColor: const Color(0xFF12232E),
                ),
                body: Container(
                  decoration: const BoxDecoration(color: Color(0xFF12232E)),
                  child: CommentBox(
                    child: SingleChildScrollView(
                        child: Column(children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10, top: 10),
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0xFF12232E)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            for (int i = 0;
                                i < createCommentsTree().length;
                                i++)
                              createCommentsTree()[i]
                          ],
                        ),
                      )
                    ])),
                    header: reply
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Reply to @$replyUsername',
                                style: const TextStyle(
                                    color: Color(0xFFEEFBFB), fontSize: 18),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      reply = false;
                                      replyUsername = "";
                                      commentId = 0;
                                    });
                                  },
                                  icon: const Icon(Icons.cancel_sharp,
                                      color: Color(0xFFEEFBFB)))
                            ],
                          )
                        : null,
                    sendWidget: const Icon(
                      Icons.send,
                      color: Color(0xff007CC7),
                    ),
                    userImage: CommentBox.commentImageParser(
                        imageURLorPath: !user.profileImage.startsWith('/')
                            ? Image.asset(
                                'assets/profile_image.png',
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ).image
                            : Image.memory(base64Decode(user.profileImage))
                                .image),
                    labelText: "Write a comment",
                    focusNode: FocusScope.of(context).focusedChild,
                    withBorder: true,
                    sendButtonMethod: () {
                      if (formKey.currentState!.validate()) {
                        if (reply) {
                          Provider.of<EventProvider>(context, listen: false)
                              .addReply(commentController.text, widget.id,
                                  commentId, replyUsername);
                          setState(() {
                            reply = false;
                            replyUsername = "";
                            commentId = 0;
                          });
                        } else {
                          Provider.of<EventProvider>(context, listen: false)
                              .addComment(commentController.text, widget.id,
                                  widget.username);
                        }
                        Future.delayed(const Duration(milliseconds: 2000), () {
                          Provider.of<EventProvider>(context, listen: false)
                              .getComments(widget.id);
                        });
                        setState(() {
                          comments =
                              Provider.of<EventProvider>(context, listen: false)
                                  .comments;
                        });
                        commentController.clear();
                        FocusScope.of(context).unfocus();
                      } else {
                        print("Not validated");
                      }
                    },
                    formKey: formKey,
                    commentController: commentController,
                    errorText: "Comment cannot be blank",
                    backgroundColor: const Color(0xFFEEFBFB),
                    textColor: const Color(0xFFEEFBFB),
                  ),
                ),
              ));
  }

  List<CommentTreeWidget<Comment, Comment>> createCommentsTree() {
    List<CommentTreeWidget<Comment, Comment>> commentTree = [];
    for (CommentResponseDto dto in comments) {
      Comment c = Comment(
          avatar: dto.profileImage,
          userName: dto.username,
          content: dto.message,
          idComment: dto.id);
      List<Comment> replies = [];
      for (CommentResponseDto dto2 in dto.replies) {
        replies.add(Comment(
            avatar: dto2.profileImage,
            userName: dto2.username,
            content: dto2.message,
            idComment: dto2.id));
      }
      commentTree.add(CommentTreeWidget(
        c,
        replies,
        treeThemeData:
            const TreeThemeData(lineColor: Color(0xff007CC7), lineWidth: 3),
        avatarRoot: (context, data) => PreferredSize(
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xff007CC7),
            backgroundImage: data.avatar.startsWith("/")
                ? Image.memory(base64Decode(data.avatar)).image
                : Image.asset(
                    'assets/profile_image.png',
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ).image,
          ),
          preferredSize: Size.fromRadius(18),
        ),
        avatarChild: (context, data) => PreferredSize(
          child: CircleAvatar(
            radius: 12,
            backgroundColor: Color(0xff007CC7),
            backgroundImage: data.avatar.startsWith("/")
                ? Image.memory(base64Decode(data.avatar)).image
                : Image.asset(
                    'assets/profile_image.png',
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ).image,
          ),
          preferredSize: Size.fromRadius(12),
        ),
        contentChild: (context, data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                    color: const Color(0xFFEEFBFB),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${data.userName}',
                        style: const TextStyle(
                            color: Color(0xFF203647), fontSize: 15)),
                    const SizedBox(
                      height: 4,
                    ),
                    Text('${data.content}',
                        style: const TextStyle(
                            color: Color(0xFF203647), fontSize: 15)),
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
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                    color: Color(0xFFEEFBFB),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${data.userName}',
                        style: const TextStyle(
                            color: Color(0xFF203647), fontSize: 15)),
                    const SizedBox(
                      height: 4,
                    ),
                    Text('${data.content}',
                        style: const TextStyle(
                            color: Color(0xFF203647), fontSize: 15)),
                  ],
                ),
              ),
              DefaultTextStyle(
                style: Theme.of(context).textTheme.caption!.copyWith(
                    color: const Color(0xff007CC7),
                    fontWeight: FontWeight.bold),
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            reply = true;
                            replyUsername = data.userName;
                            commentId = data.idComment;
                          });
                        },
                        child: const Text(
                          "Reply",
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
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
