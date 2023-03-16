import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:provider/provider.dart';
import 'package:the_eventors/repository/UserRepository.dart';
import 'package:the_eventors/ui/login_screen.dart';
import 'package:the_eventors/ui/profile_screen.dart';
import 'package:the_eventors/ui/splash_screen.dart';

import '../providers/UserProvider.dart';

class EditProfileScreen extends StatefulWidget {
  final String fullName;
  final String bio;
  const EditProfileScreen({Key? key, required this.fullName, required this.bio})
      : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String error = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.fullName != "") {
      fullNameController = TextEditingController(text: widget.fullName);
    }
    if (widget.bio != "") {
      bioController = TextEditingController(text: widget.bio);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF203647),
        appBar: AppBar(
          backgroundColor: const Color(0xFF203647),
          title: Padding(
              padding: EdgeInsets.only(left: 0),
              child: Text(
                "Edit profile",
                style: TextStyle(color: Color(0xFFEEFBFB)),
              )),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Form(
                              key: _formKey,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Column(
                                    children: [
                                      TextFormField(
                                        focusNode: FocusNode(),
                                        style: const TextStyle(
                                            color: Color(0xFF12232E)),
                                        cursorColor: const Color(0xFF12232E),
                                        maxLines: 1,
                                        controller: fullNameController,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color(0xFFEEFBFB),
                                          hintText: "Full name",
                                          errorStyle: TextStyle(fontSize: 16),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              width: 10,
                                              color: Colors.white,
                                              style: BorderStyle.none,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              15.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      TextFormField(
                                        focusNode: FocusNode(),
                                        style: const TextStyle(
                                            color: Color(0xFF12232E)),
                                        cursorColor: const Color(0xFF12232E),
                                        minLines: 1,
                                        maxLines: 7,
                                        keyboardType: TextInputType.multiline,
                                        controller: bioController,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color(0xFFEEFBFB),
                                          hintText: "Bio",
                                          errorStyle: TextStyle(fontSize: 16),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              width: 10,
                                              color: Colors.white,
                                              style: BorderStyle.none,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              15.0,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                              Color(0xff4DA8DA),
                                              Color(0xff007CC7),
                                            ],
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(25)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFF1C1C1C)
                                                  .withOpacity(0.2),
                                              spreadRadius: 3,
                                              blurRadius: 4,
                                              offset: const Offset(0, 3),
                                            )
                                          ]),
                                      child: MaterialButton(
                                        onPressed: () {
                                          Provider.of<UserProvider>(context,
                                                  listen: false)
                                              .updateProfile(
                                                  fullNameController.text,
                                                  bioController.text);

                                          Future.delayed(Duration(seconds: 1),
                                              () {
                                            Navigator.pushReplacement(context,
                                                MaterialPageRoute(builder:
                                                    (BuildContext context) {
                                              return ProfileScreen(
                                                username: "",
                                              );
                                            }));
                                          });
                                        },
                                        child: Center(
                                          child: Text(
                                            "Save",
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFEEFBFB)),
                                          ),
                                        ),
                                      )),
                                ],
                              ))
                        ])))));
  }
}
