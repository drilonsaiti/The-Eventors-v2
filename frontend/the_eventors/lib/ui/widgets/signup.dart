import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:the_eventors/models/dto/RegisterDto.dart';
import 'package:the_eventors/ui/login_screen.dart';

import '../../providers/UserProvider.dart';
import '../home_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _passwordVisible = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String error = "";
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              child: Text(
            "Sign up with",
            style: TextStyle(
              fontSize: 30.sp,
              color: Color(0xff4DA8DA),
              height: 0.2.h,
            ),
          )),
          Container(
              child: Text(
            "The eventors",
            style: TextStyle(
                fontSize: 35.sp,
                color: Color(0xff4DA8DA),
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                height: 0.1.h),
          )),
          SizedBox(
            height: 1.6.h,
          ),
          Form(
              key: _formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    style: const TextStyle(color: Color(0xFF12232E)),
                    cursorColor: const Color(0xFF12232E),
                    controller: usernameController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please enter your username";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: '@username',
                      hintStyle: TextStyle(
                        fontSize: 16.sp,
                        color: Color(0x4012232E),
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFEEFBFB),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                    ),
                  ),
                  if (error != null)
                    if (error.startsWith("User"))
                      Container(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          margin: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.3),
                          child: Text(
                            error,
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w400),
                          )),
                  SizedBox(
                    height: 1.6.h,
                  ),
                  TextFormField(
                    style: const TextStyle(color: Color(0xFF12232E)),
                    cursorColor: const Color(0xFF12232E),
                    controller: passwordController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      } else if (value.isNotEmpty && value.length < 8) {
                        return "Please enter password with length\nof 8 characters";
                      }
                    },
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color(0xFF12232E),
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      hintStyle: TextStyle(
                        fontSize: 16.sp,
                        color: Color(0x4012232E),
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFEEFBFB),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                    ),
                  ),
                  SizedBox(
                    height: 1.6.h,
                  ),
                  TextFormField(
                    style: const TextStyle(color: Color(0xFF12232E)),
                    cursorColor: const Color(0xFF12232E),
                    controller: repeatPasswordController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      } else if (value.isNotEmpty && value.length < 8 ||
                          !value.contains(passwordController.text)) {
                        return "Password doesn't match";
                      }
                    },
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      hintText: 'Repeat password',
                      hintStyle: TextStyle(
                        fontSize: 16.sp,
                        color: Color(0x4012232E),
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFEEFBFB),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                    ),
                  ),
                  if (error != null)
                    if (error.startsWith("Pass"))
                      Container(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          margin: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.3),
                          child: Text(
                            error,
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w400),
                          )),
                  SizedBox(
                    height: 1.6.h,
                  ),
                  TextFormField(
                    style: const TextStyle(color: Color(0xFF12232E)),
                    cursorColor: const Color(0xFF12232E),
                    controller: emailController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please enter your e-mail";
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
                      hintText: 'E-mail',
                      hintStyle: TextStyle(
                        fontSize: 16.sp,
                        color: Color(0x4012232E),
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFEEFBFB),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                    ),
                  ),
                  if (error != null)
                    if (error.startsWith("User with email:"))
                      Container(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          margin: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.3),
                          child: Text(
                            error,
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w400),
                          )),
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
                            Radius.circular(25),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF1C1C1C).withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 4,
                              offset: const Offset(0, 3),
                            )
                          ]),
                      child: MaterialButton(
                        onPressed: () {
                          print("OUTSIDE");
                          if (_formKey.currentState!.validate()) {
                            print("INTSIDE 1");

                            if (_formKey.currentState!.validate()) {
                              print("INTSIDE 2");

                              final RegisterDto registerDto = RegisterDto(
                                  username: usernameController.text,
                                  password: passwordController.text,
                                  repeatPassword: repeatPasswordController.text,
                                  email: emailController.text);
                              FocusManager.instance.primaryFocus?.unfocus();

                              Provider.of<UserProvider>(context, listen: false)
                                  .register(registerDto);
                              Future.delayed(Duration(milliseconds: 1200), () {
                                setState(() {
                                  if (context.read<UserProvider>().error != "")
                                    error = context.read<UserProvider>().error;
                                });
                                print(error);
                                if (error == null) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                                }
                              });
                            }
                          }
                        },
                        child: Center(
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFEEFBFB),
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ))
        ]);
  }
}
