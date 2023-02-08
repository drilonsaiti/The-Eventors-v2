import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/models/dto/RegisterDto.dart';
import 'package:the_eventors/ui/login_screen.dart';

import '../../providers/UserProvider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Sign up with",
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
            fontWeight: FontWeight.bold,
            color: Color(0xff4DA8DA),
            letterSpacing: 2,
            height: 1,
          ),
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
            hintText: '@username',
            hintStyle: const TextStyle(
              fontSize: 16,
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
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
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
              return "Please enter your password";
            }
          },
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: const TextStyle(
              fontSize: 16,
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
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        TextFormField(
          style: const TextStyle(color: Color(0xFF12232E)),
          cursorColor: const Color(0xFF12232E),
          controller: repeatPasswordController,
          validator: (String? value) {
            if (value!.isEmpty) {
              return "Please enter your password";
            }
          },
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Repeat password',
            hintStyle: const TextStyle(
              fontSize: 16,
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
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        TextFormField(
          style: const TextStyle(color: Color(0xFF12232E)),
          cursorColor: const Color(0xFF12232E),
          controller: nameController,
          validator: (String? value) {
            if (value!.isEmpty) {
              return "Please enter your name";
            }
          },
          decoration: InputDecoration(
            hintText: 'Name',
            hintStyle: const TextStyle(
              fontSize: 16,
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
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        TextFormField(
          style: const TextStyle(color: Color(0xFF12232E)),
          cursorColor: const Color(0xFF12232E),
          controller: surnameController,
          validator: (String? value) {
            if (value!.isEmpty) {
              return "Please enter your surname";
            }
          },
          decoration: InputDecoration(
            hintText: 'Surname',
            hintStyle: const TextStyle(
              fontSize: 16,
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
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
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
                final RegisterDto registerDto = RegisterDto(
                    username: usernameController.text,
                    password: passwordController.text,
                    repeatPassword: repeatPasswordController.text,
                    name: nameController.text,
                    surname: surnameController.text,
                    role: "ROLE_USER");
                Provider.of<UserProvider>(context, listen: false)
                    .register(registerDto);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
              },
              child: const Center(
                child: Text(
                  "SIGN UP",
                  style: TextStyle(
                    fontSize: 24,
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
    );
  }
}
