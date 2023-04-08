import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:provider/provider.dart';
import 'package:the_eventors/ui/forgot_pass.dart';
import 'package:the_eventors/ui/profile_screen.dart';

import '../providers/UserProvider.dart';

class ChangeScreen extends StatefulWidget {
  final String change;
  const ChangeScreen({Key? key, required this.change}) : super(key: key);

  @override
  State<ChangeScreen> createState() => _ChangeScreenState();
}

class _ChangeScreenState extends State<ChangeScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  TextEditingController optController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  String username = "";
  String email = "";

  final _formKey = GlobalKey<FormState>();
  String error = "";
  bool isLoading = true;
  bool _passwordVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UserProvider>(context, listen: false).getUsername();
    if (widget.change.contains("email")) {
      Provider.of<UserProvider>(context, listen: false).getEmail();
    }
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        username = context.read<UserProvider>().username;
        if (widget.change.contains("email")) {
          email = context.read<UserProvider>().email;
        }
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
    return isLoading
        ? Text("")
        : Scaffold(
            backgroundColor: const Color(0xFF203647),
            appBar: AppBar(
              backgroundColor: const Color(0xFF203647),
              title: Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: Text(
                    "Change " + widget.change,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      if (widget.change == "username")
                                        Column(
                                          children: [
                                            TextFormField(
                                              style: const TextStyle(
                                                  color: Color(0xFF12232E)),
                                              cursorColor:
                                                  const Color(0xFF12232E),
                                              controller: usernameController,
                                              validator: (String? value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter your new username";
                                                }
                                              },
                                              decoration: InputDecoration(
                                                  hintText: "new @username",
                                                  hintStyle: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0x4012232E),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 0,
                                                              style: BorderStyle
                                                                  .none)),
                                                  filled: true,
                                                  fillColor:
                                                      const Color(0xFFEEFBFB),
                                                  errorStyle:
                                                      TextStyle(fontSize: 16),
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16,
                                                          vertical: 0)),
                                            ),
                                            if (error != null)
                                              if (error.startsWith("User"))
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    margin: EdgeInsets.only(
                                                        right: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.3),
                                                    child: Text(
                                                      error,
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            TextFormField(
                                              style: const TextStyle(
                                                  color: Color(0xFF12232E)),
                                              cursorColor:
                                                  const Color(0xFF12232E),
                                              controller: passwordController,
                                              validator: (String? value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter your password";
                                                }
                                              },
                                              obscureText: !_passwordVisible,
                                              decoration: InputDecoration(
                                                  hintText: "Password",
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      // Based on passwordVisible state choose the icon
                                                      _passwordVisible
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
                                                      color: Color(0xFF12232E),
                                                    ),
                                                    onPressed: () {
                                                      // Update the state i.e. toogle the state of passwordVisible variable
                                                      setState(() {
                                                        _passwordVisible =
                                                            !_passwordVisible;
                                                      });
                                                    },
                                                  ),
                                                  hintStyle: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0x4012232E),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 0,
                                                              style: BorderStyle
                                                                  .none)),
                                                  filled: true,
                                                  fillColor:
                                                      const Color(0xFFEEFBFB),
                                                  errorStyle:
                                                      TextStyle(fontSize: 16),
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16,
                                                          vertical: 0)),
                                            ),
                                            if (error != null)
                                              if (error.startsWith("Pass"))
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    margin: EdgeInsets.only(
                                                        right: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.3),
                                                    child: Text(
                                                      error,
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )),
                                          ],
                                        ),
                                      if (widget.change == "email")
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Your email: ",
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      color: Color(0xFFEEFBFB)),
                                                ),
                                                Expanded(
                                                    child: Text(email,
                                                        softWrap: true,
                                                        maxLines: 3,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFFEEFBFB),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)))
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            TextFormField(
                                              style: const TextStyle(
                                                  color: Color(0xFF12232E)),
                                              cursorColor:
                                                  const Color(0xFF12232E),
                                              controller: usernameController,
                                              validator: (String? value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter your new email";
                                                } else if (value.isNotEmpty) {
                                                  final bool emailValid = RegExp(
                                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                      .hasMatch(value);
                                                  if (!emailValid) {
                                                    return "Please enter valid e-mail";
                                                  }
                                                }
                                              },
                                              decoration: InputDecoration(
                                                  hintText: "new email",
                                                  hintStyle: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0x4012232E),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 0,
                                                              style: BorderStyle
                                                                  .none)),
                                                  filled: true,
                                                  fillColor:
                                                      const Color(0xFFEEFBFB),
                                                  errorStyle:
                                                      TextStyle(fontSize: 16),
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16,
                                                          vertical: 0)),
                                            ),
                                            if (error != null)
                                              if (error.startsWith("User"))
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    margin: EdgeInsets.only(
                                                        right: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.3),
                                                    child: Text(
                                                      error,
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            TextFormField(
                                              style: const TextStyle(
                                                  color: Color(0xFF12232E)),
                                              cursorColor:
                                                  const Color(0xFF12232E),
                                              controller: passwordController,
                                              validator: (String? value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter your password";
                                                }
                                              },
                                              obscureText: !_passwordVisible,
                                              decoration: InputDecoration(
                                                  hintText: "Password",
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      // Based on passwordVisible state choose the icon
                                                      _passwordVisible
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
                                                      color: Color(0xFF12232E),
                                                    ),
                                                    onPressed: () {
                                                      // Update the state i.e. toogle the state of passwordVisible variable
                                                      setState(() {
                                                        _passwordVisible =
                                                            !_passwordVisible;
                                                      });
                                                    },
                                                  ),
                                                  hintStyle: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0x4012232E),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 0,
                                                              style: BorderStyle
                                                                  .none)),
                                                  filled: true,
                                                  fillColor:
                                                      const Color(0xFFEEFBFB),
                                                  errorStyle:
                                                      TextStyle(fontSize: 16),
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16,
                                                          vertical: 0)),
                                            ),
                                            if (error != null)
                                              if (error.startsWith("Pass"))
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    margin: EdgeInsets.only(
                                                        right: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.3),
                                                    child: Text(
                                                      error,
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )),
                                          ],
                                        ),
                                      if (widget.change == "password")
                                        Column(
                                          children: [
                                            TextFormField(
                                              style: const TextStyle(
                                                  color: Color(0xFF12232E)),
                                              cursorColor:
                                                  const Color(0xFF12232E),
                                              controller: oldPasswordController,
                                              validator: (String? value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter your old password";
                                                }
                                              },
                                              obscureText: !_passwordVisible,
                                              decoration: InputDecoration(
                                                  hintText: "Old password",
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      // Based on passwordVisible state choose the icon
                                                      _passwordVisible
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
                                                      color: Color(0xFF12232E),
                                                    ),
                                                    onPressed: () {
                                                      // Update the state i.e. toogle the state of passwordVisible variable
                                                      setState(() {
                                                        _passwordVisible =
                                                            !_passwordVisible;
                                                      });
                                                    },
                                                  ),
                                                  hintStyle: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0x4012232E),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 0,
                                                              style: BorderStyle
                                                                  .none)),
                                                  filled: true,
                                                  fillColor:
                                                      const Color(0xFFEEFBFB),
                                                  errorStyle:
                                                      TextStyle(fontSize: 16),
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16,
                                                          vertical: 0)),
                                            ),
                                            if (error != null)
                                              if (error.startsWith("Pass"))
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    margin: EdgeInsets.only(
                                                        right: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.3),
                                                    child: Text(
                                                      error,
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            TextFormField(
                                              style: const TextStyle(
                                                  color: Color(0xFF12232E)),
                                              cursorColor:
                                                  const Color(0xFF12232E),
                                              controller: passwordController,
                                              validator: (String? value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter your new password";
                                                }
                                              },
                                              obscureText: !_passwordVisible,
                                              decoration: InputDecoration(
                                                  hintText: "New password",
                                                  hintStyle: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0x4012232E),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 0,
                                                              style: BorderStyle
                                                                  .none)),
                                                  filled: true,
                                                  fillColor:
                                                      const Color(0xFFEEFBFB),
                                                  errorStyle:
                                                      TextStyle(fontSize: 16),
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16,
                                                          vertical: 0)),
                                            ),
                                            if (error != null)
                                              if (error.startsWith("Pass"))
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    margin: EdgeInsets.only(
                                                        right: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.3),
                                                    child: Text(
                                                      error,
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            TextFormField(
                                              style: const TextStyle(
                                                  color: Color(0xFF12232E)),
                                              cursorColor:
                                                  const Color(0xFF12232E),
                                              controller:
                                                  repeatPasswordController,
                                              validator: (String? value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter your new repeat password";
                                                }
                                              },
                                              obscureText: !_passwordVisible,
                                              decoration: InputDecoration(
                                                hintText: 'Repeat new password',
                                                hintStyle: const TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0x4012232E),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: const BorderSide(
                                                    width: 0,
                                                    style: BorderStyle.none,
                                                  ),
                                                ),
                                                filled: true,
                                                fillColor:
                                                    const Color(0xFFEEFBFB),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 0),
                                              ),
                                            ),
                                            if (error != null)
                                              if (error.startsWith("Pass"))
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    margin: EdgeInsets.only(
                                                        right: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.3),
                                                    child: Text(
                                                      error,
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )),
                                          ],
                                        )
                                    ])),
                            const SizedBox(
                              height: 24,
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
                                    if (_formKey.currentState!.validate()) {
                                      print(passwordController.text);
                                      if (widget.change == "password") {
                                        Provider.of<UserProvider>(context,
                                                listen: false)
                                            .changePassword(
                                                oldPasswordController.text,
                                                passwordController.text,
                                                repeatPasswordController.text,
                                                username);
                                        setState(() {
                                          error = context
                                              .read<UserProvider>()
                                              .error;
                                        });
                                      } else if (widget.change == "username") {
                                        Provider.of<UserProvider>(context,
                                                listen: false)
                                            .changeUsername(
                                                passwordController.text,
                                                usernameController.text);
                                        setState(() {
                                          error = context
                                              .read<UserProvider>()
                                              .error;
                                        });
                                      } else if (widget.change == "email") {
                                        Provider.of<UserProvider>(context,
                                                listen: false)
                                            .sendVerification("");

                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              String contentText =
                                                  "Content of Dialog";
                                              return StatefulBuilder(
                                                  builder: (context, setState) {
                                                return AlertDialog(
                                                  title:
                                                      Text("Verification code"),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        "Please enter the OTP sent on your email",
                                                      ),
                                                      PinCodeFields(
                                                        length: 4,
                                                        controller:
                                                            optController,
                                                        fieldHeight: 50,
                                                        focusNode: FocusNode(),
                                                        onComplete: (result) {
                                                          // Your logic with code
                                                          print(result);
                                                        },
                                                      ),
                                                      if (error != null)
                                                        Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 5,
                                                                    bottom: 5),
                                                            margin: EdgeInsets.only(
                                                                right: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.05),
                                                            child: Text(
                                                              error,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            )),
                                                      Container(
                                                          height: 32,
                                                          width: 140,
                                                          decoration:
                                                              BoxDecoration(
                                                                  gradient:
                                                                      const LinearGradient(
                                                                    begin: Alignment
                                                                        .topRight,
                                                                    end: Alignment
                                                                        .bottomLeft,
                                                                    colors: [
                                                                      Color(
                                                                          0xff4DA8DA),
                                                                      Color(
                                                                          0xff007CC7),
                                                                    ],
                                                                  ),
                                                                  borderRadius: const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          25)),
                                                                  boxShadow: [
                                                                BoxShadow(
                                                                  color: const Color(
                                                                          0xFF1C1C1C)
                                                                      .withOpacity(
                                                                          0.2),
                                                                  spreadRadius:
                                                                      3,
                                                                  blurRadius: 4,
                                                                  offset:
                                                                      const Offset(
                                                                          0, 3),
                                                                )
                                                              ]),
                                                          child: MaterialButton(
                                                            onPressed: () {
                                                              Provider.of<UserProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .sendVerification(
                                                                      "");
                                                            },
                                                            child: Center(
                                                              child: Text(
                                                                "Resend OTP",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color(
                                                                        0xFFEEFBFB)),
                                                              ),
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .labelLarge,
                                                      ),
                                                      child: const Text(
                                                        'Cancel',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff007CC7)),
                                                      ),
                                                      onPressed: () {
                                                        optController =
                                                            TextEditingController();
                                                        setState(
                                                          () {
                                                            error = "";
                                                          },
                                                        );
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          textStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelLarge,
                                                        ),
                                                        child: const Text(
                                                          'Confirm',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff007CC7)),
                                                        ),
                                                        onPressed: () {
                                                          var err = "";
                                                          print("ERROR");
                                                          Provider.of<UserProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .changeEmail(
                                                                  usernameController
                                                                      .text,
                                                                  passwordController
                                                                      .text,
                                                                  optController
                                                                      .text);
                                                          Future.delayed(
                                                              Duration(
                                                                  milliseconds:
                                                                      500), () {
                                                            setState(() {
                                                              error = context
                                                                  .read<
                                                                      UserProvider>()
                                                                  .error;
                                                            });
                                                          });

                                                          if (error == null) {
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ProfileScreen(
                                                                              username: username,
                                                                            )));
                                                          }

                                                          /*Future.delayed(
                                                          Duration(
                                                              milliseconds:
                                                                  450), () {
                                                        setState(() {
                                                          error = context
                                                              .read<
                                                                  UserProvider>()
                                                              .error;
                                                        });
                                                      });
                                                      print(
                                                          "ERROR ERROR ERROR");
                                                      print(error);

                                                      if (error != null &&
                                                          !error.startsWith(
                                                              "Verification")) {
                                                        Navigator.of(context)
                                                            .pop();
                                                        setState(() {
                                                          error = context
                                                              .read<
                                                                  UserProvider>()
                                                              .error;
                                                        });
                                                      } else if (error !=
                                                              null &&
                                                          error.startsWith(
                                                              "Verification")) {}
                                                    },*/
                                                        }),
                                                  ],
                                                );
                                              });
                                            });
                                        /*Future.delayed(Duration(milliseconds: 650), () {
                    setState(() {
                      if (context.read<UserProvider>().error != "")
                        error = context.read<UserProvider>().error;
                    });
                    print(error);
                    if (error == null) {
                     
                    }
                  });*/
                                      }
                                    }
                                  },
                                  child: Center(
                                    child: InkWell(
                                        onTap: () => Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ProfileScreen(
                                                      username: "",
                                                    ))),
                                        child: Text(
                                          "Change " + widget.change,
                                          style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFEEFBFB)),
                                        )),
                                  ),
                                )),
                            const SizedBox(
                              height: 16,
                            ),
                            InkWell(
                                child: const Text(
                                  "Forgot password?",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff4DA8DA),
                                    height: 1,
                                  ),
                                ),
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPasswordScreen()))),
                          ],
                        )))));
  }
}
