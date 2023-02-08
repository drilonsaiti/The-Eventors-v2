import 'package:flutter/material.dart';
import 'package:the_eventors/providers/UserProvider.dart';
import 'package:the_eventors/ui/detail_event_screen.dart';
import 'package:the_eventors/ui/details_event_screen.dart';
import 'package:the_eventors/ui/search_events_screen.dart';

import '../details.dart';
import '../home_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Welcome to",
          style: TextStyle(
            fontSize: 30,
            color: Color(0xff4DA8DA),
            height: 2,
          ),
        ),
        const Text(
          "The eventors",
          style: TextStyle(
              fontSize: 45,
              color: Color(0xff4DA8DA),
              height: 1,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),
        ),
        const Text(
          "Please login to continue",
          style: TextStyle(fontSize: 20, color: Color(0xff4DA8DA), height: 1),
        ),
        const SizedBox(
          height: 16,
        ),
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
              hintText: "@username",
              hintStyle: const TextStyle(
                fontSize: 16,
                color: Color(0x4012232E),
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none)),
              filled: true,
              fillColor: const Color(0xFFEEFBFB),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 0)),
        ),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          style: const TextStyle(color: Color(0xFF12232E)),
          cursorColor: const Color(0xFF12232E),
          controller: passwordController,
          validator: (String? value) {
            if (value!.isEmpty) {
              return "Please enter your username";
            }
          },
          obscureText: true,
          decoration: InputDecoration(
              hintText: "Password",
              hintStyle: const TextStyle(
                fontSize: 16,
                color: Color(0x4012232E),
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none)),
              filled: true,
              fillColor: const Color(0xFFEEFBFB),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 0)),
        ),
        const SizedBox(
          height: 24,
        ),
        Container(
            height: 40,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xff4DA8DA),
                    Color(0xff007CC7),
                  ],
                ),
                borderRadius: const BorderRadius.all(Radius.circular(25)),
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
                UserProvider()
                    .login(usernameController.text, passwordController.text);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
              },
              child: const Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFEEFBFB)),
                ),
              ),
            )),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Forgot password?",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xff4DA8DA),
            height: 1,
          ),
        ),
      ],
    );
  }
}
