import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:the_eventors/ui/widgets/comments_widget.dart';

import 'multi_step_form_screen.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back)),
                  const Text(
                    'Comments',
                    style: TextStyle(fontSize: 32.0, color: Colors.blueAccent),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        //width: 35.0,
                        padding: EdgeInsets.only(right: 10),
                        child: IconButton(
                          icon: const Icon(Icons.share),
                          iconSize: 30.0,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const MultiStepFormPage()));
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Expanded(child: CommentWidget()),
              SizedBox(
                  height: 90,
                  child: Expanded(
                      child: Container(
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(color: Colors.white),
                    child: CommentBox(
                      child: Text(
                        "Reply to drilon",
                        style: TextStyle(color: Colors.black),
                      ),
                      header: null,
                      sendWidget: Icon(
                        Icons.send,
                        color: Colors.blueAccent,
                      ),
                      userImage: CommentBox.commentImageParser(
                        imageURLorPath:
                            "https://images.unsplash.com/photo-1589894404892-7310b92ea7a2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2574&q=80",
                      ),
                      labelText: "Write a comment",
                      focusNode: FocusScope.of(context).focusedChild,
                      withBorder: true,
                      sendButtonMethod: () {
                        if (formKey.currentState!.validate()) {
                          print(commentController.text);
                          setState(() {
                            var value = {
                              'name': 'New User',
                              'pic':
                                  'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
                              'message': commentController.text,
                              'date': '2021-01-01 12:00:00'
                            };
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
                      backgroundColor: Colors.black,
                      textColor: Colors.black,
                    ),
                  ))),
            ],
          ),
        ));
  }
}
