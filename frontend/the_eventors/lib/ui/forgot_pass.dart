import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:provider/provider.dart';
import 'package:the_eventors/repository/UserRepository.dart';
import 'package:the_eventors/ui/login_screen.dart';
import 'package:the_eventors/ui/profile_screen.dart';
import 'package:the_eventors/ui/splash_screen.dart';

import '../providers/UserProvider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  TextEditingController optController = TextEditingController();
  bool _passwordVisible = false;

  final _formKey = GlobalKey<FormState>();
  String error = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                "Forgot password ",
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
                                    Column(
                                      children: [
                                        TextFormField(
                                          style: const TextStyle(
                                              color: Color(0xFF12232E)),
                                          cursorColor: const Color(0xFF12232E),
                                          controller: emailController,
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return "Please enter your email";
                                            }
                                          },
                                          decoration: InputDecoration(
                                              hintText: "Email",
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
                                                      style: BorderStyle.none)),
                                              filled: true,
                                              fillColor:
                                                  const Color(0xFFEEFBFB),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 0)),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Column(
                                          children: [
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
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16,
                                                          vertical: 0)),
                                            ),
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
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(25)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        const Color(0xFF1C1C1C)
                                                            .withOpacity(0.2),
                                                    spreadRadius: 3,
                                                    blurRadius: 4,
                                                    offset: const Offset(0, 3),
                                                  )
                                                ]),
                                            child: MaterialButton(
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  Provider.of<UserProvider>(
                                                          context,
                                                          listen: false)
                                                      .sendVerification(
                                                          emailController.text);

                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        String contentText =
                                                            "Content of Dialog";
                                                        return StatefulBuilder(
                                                            builder: (context,
                                                                setState) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                "Verification code"),
                                                            content: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(
                                                                  "Please enter the OTP sent on your email",
                                                                ),
                                                                PinCodeFields(
                                                                  length: 4,
                                                                  controller:
                                                                      optController,
                                                                  fieldHeight:
                                                                      50,
                                                                  focusNode:
                                                                      FocusNode(),
                                                                  onComplete:
                                                                      (result) {
                                                                    // Your logic with code
                                                                    print(
                                                                        result);
                                                                  },
                                                                ),
                                                                if (error !=
                                                                    null)
                                                                  Container(
                                                                      padding: EdgeInsets.only(
                                                                          top:
                                                                              5,
                                                                          bottom:
                                                                              5),
                                                                      margin: EdgeInsets.only(
                                                                          right: MediaQuery.of(context).size.width *
                                                                              0.05),
                                                                      child:
                                                                          Text(
                                                                        error,
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .red,
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w400),
                                                                      )),
                                                                Container(
                                                                    height: 32,
                                                                    width: 140,
                                                                    decoration: BoxDecoration(
                                                                        gradient: const LinearGradient(
                                                                          begin:
                                                                              Alignment.topRight,
                                                                          end: Alignment
                                                                              .bottomLeft,
                                                                          colors: [
                                                                            Color(0xff4DA8DA),
                                                                            Color(0xff007CC7),
                                                                          ],
                                                                        ),
                                                                        borderRadius: const BorderRadius.all(Radius.circular(25)),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                const Color(0xFF1C1C1C).withOpacity(0.2),
                                                                            spreadRadius:
                                                                                3,
                                                                            blurRadius:
                                                                                4,
                                                                            offset:
                                                                                const Offset(0, 3),
                                                                          )
                                                                        ]),
                                                                    child: MaterialButton(
                                                                      onPressed:
                                                                          () {
                                                                        Provider.of<UserProvider>(context,
                                                                                listen: false)
                                                                            .sendVerification("");
                                                                      },
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          "Resend OTP",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Color(0xFFEEFBFB)),
                                                                        ),
                                                                      ),
                                                                    )),
                                                              ],
                                                            ),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  textStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .labelLarge,
                                                                ),
                                                                child:
                                                                    const Text(
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
                                                                      error =
                                                                          "";
                                                                    },
                                                                  );
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                              TextButton(
                                                                  style: TextButton
                                                                      .styleFrom(
                                                                    textStyle: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .labelLarge,
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                    'Confirm',
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0xff007CC7)),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    print(emailController
                                                                        .text);
                                                                    Provider.of<UserProvider>(context, listen: false).forgotPassword(
                                                                        emailController
                                                                            .text,
                                                                        passwordController
                                                                            .text,
                                                                        repeatPasswordController
                                                                            .text,
                                                                        optController
                                                                            .text);
                                                                    Future.delayed(
                                                                        Duration(
                                                                            milliseconds:
                                                                                500),
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        error = context
                                                                            .read<UserProvider>()
                                                                            .error;
                                                                      });
                                                                    });

                                                                    if (error ==
                                                                        null) {
                                                                      optController =
                                                                          TextEditingController();
                                                                      Future.delayed(
                                                                          Duration(
                                                                              milliseconds: 700),
                                                                          () {
                                                                        Navigator.of(context).push(MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                LoginScreen()));
                                                                      });
                                                                    }
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
                                              },
                                              child: Center(
                                                child: Text(
                                                  "Change password",
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFFEEFBFB)),
                                                ),
                                              ),
                                            )),
                                      ],
                                    )
                                  ]))
                        ])))));
  }
}
