import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/providers/UserProvider.dart';
import '../home_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _passwordVisible = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String error = "";

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width.toString());
    print(MediaQuery.of(context).size.width.toString());

    return Column(
      children: <Widget>[
        Container(
            child: Text(
          "Welcome to",
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
              fontSize: 45.sp,
              color: Color(0xff4DA8DA),
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              height: 0.1.h),
        )),
        SizedBox(
          height: 1.6.h,
        ),
        Text(
          "Please login to continue",
          style: TextStyle(
              fontSize: 20.sp, color: Color(0xff4DA8DA), height: 0.1.h),
        ),
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
                        hintText: "@username",
                        suffixIcon: Icon(Icons.show_chart),
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          color: Color(0x4012232E),
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none)),
                        filled: true,
                        fillColor: const Color(0xFFEEFBFB),
                        errorStyle: TextStyle(fontSize: 16.sp),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 0)),
                  ),
                  if (error != null)
                    if (error.startsWith("User"))
                      Container(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          margin: EdgeInsets.only(
                              right:
                                  (MediaQuery.of(context).size.width * 0.3).w),
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
                          Icons.visibility_off,
                          color: Colors.red,
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
                  if (error != null)
                    if (error.startsWith("Pass"))
                      Container(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          margin: EdgeInsets.only(
                              right:
                                  (MediaQuery.of(context).size.width * 0.3).w),
                          child: Text(
                            error,
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w400),
                          )),
                ])),
        SizedBox(
          height: 2.4.h,
        ),
        Container(
            height: 5.5.h,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
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
                if (_formKey.currentState!.validate()) {
                  print(passwordController.text);
                  Provider.of<UserProvider>(context, listen: false)
                      .login(usernameController.text, passwordController.text);
                  Future.delayed(Duration(milliseconds: 500), () {
                    setState(() {
                      if (context.read<UserProvider>().error != "")
                        error = context.read<UserProvider>().error;
                    });
                    print(error);
                    if (error == null) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                    }
                  });
                }
              },
              child: Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFEEFBFB)),
                ),
              ),
            )),
        SizedBox(
          height: 1.6.h,
        ),
        Text(
          "Forgot password?",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Color(0xff4DA8DA),
            height: 0.2.h,
          ),
        ),
      ],
    );
  }
}
